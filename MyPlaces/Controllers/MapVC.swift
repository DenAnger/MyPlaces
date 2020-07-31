//
//  MapVC.swift
//  MyPlaces
//
//  Created by Denis Abramov on 27.07.2020.
//  Copyright © 2020 Denis Abramov. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

protocol MapVCDelegate {
    func getAddress(_ address: String?)
}

class MapVC: UIViewController {

    @IBOutlet var mapView: MKMapView!
    @IBOutlet var addressLabel: UILabel!
    @IBOutlet var mapPinImage: UIButton!
    @IBOutlet var doneButton: UIButton!
    @IBOutlet var goButton: UIButton!
    
    let mapManager = MapManager()
    var mapVCDelegate: MapVCDelegate?
    var place = Place()
    
    let annotationIdentifier = "annotationIdentifier"
    var incomeSegueIdentifier = ""
    var previousLocation: CLLocation? {
        didSet {
            mapManager.startTrackingUserLocation(
                for: mapView,
                and: previousLocation
            ) { (currentLocation) in
                self.previousLocation = currentLocation
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    self.mapManager.showUserLocation(mapView: self.mapView)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addressLabel.text = ""
        mapView.delegate = self
        setupMapView()
    }
    
    private func setupMapView() {
        goButton.isHidden = true
        
        mapManager.checkLocationServices(
            mapView: mapView,
            segueIdentifier: incomeSegueIdentifier
        ) {
            mapManager.locationManager.delegate = self
        }
        
        if incomeSegueIdentifier == "showPlace" {
            mapManager.setupPlacemark(place: place, mapView: mapView)
            mapPinImage.isHidden = true
            addressLabel.isHidden = true
            doneButton.isHidden = true
            goButton.isHidden = false
        }
    }
        
    @IBAction func closeVC(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func centerUserLocation(_ sender: Any) {
        mapManager.showUserLocation(mapView: mapView)
    }
    
    @IBAction func doneButtonPressed(_ sender: Any) {
        mapVCDelegate?.getAddress(addressLabel.text)
        dismiss(animated: true)
    }
    
    @IBAction func goButtonPressed(_ sender: Any) {
        mapManager.getDirections(for: mapView) { (location) in
            self.previousLocation = location
        }
    }
}

extension MapVC: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView,
                 viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else {
            return nil
        }
        
        var annotationView = mapView.dequeueReusableAnnotationView(
            withIdentifier: annotationIdentifier
            ) as? MKPinAnnotationView
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(
                annotation: annotation,
                reuseIdentifier: annotationIdentifier
            )
            annotationView?.canShowCallout = true
        }
        
        if let imageData = place.imageData {
            let imageView = UIImageView(frame: CGRect(x: 0,
                                                      y: 0,
                                                      width: 50,
                                                      height: 50))
            imageView.layer.cornerRadius = 10
            imageView.clipsToBounds = true
            imageView.image = UIImage(data: imageData)
            annotationView?.rightCalloutAccessoryView = imageView
        }
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
        let center = mapManager.getCenterLocation(for: mapView)
        let geocoder = CLGeocoder()
        
        if incomeSegueIdentifier == "showPlace" && previousLocation != nil {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.mapManager.showUserLocation(mapView: self.mapView)
            }
        }
        
        geocoder.cancelGeocode()
        
        geocoder.reverseGeocodeLocation(center) { (placemarks, error) in
            
            if let error = error {
                print(error)
                return
            }
            guard let placemarks = placemarks else {
                return
            }
            let placemark = placemarks.first
            let streetName = placemark?.thoroughfare
            let buildNumber = placemark?.subThoroughfare
            
            DispatchQueue.main.async {
                
                if streetName != nil && buildNumber != nil {
                    self.addressLabel.text = "\(streetName!), \(buildNumber!)"
                } else if streetName != nil {
                    self.addressLabel.text = "\(streetName!)"
                } else {
                    self.addressLabel.text = ""
                }
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay as! MKPolyline)
        renderer.strokeColor = .blue
        
        return renderer
    }
}

extension MapVC: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager,
                         didChangeAuthorization status: CLAuthorizationStatus) {
        mapManager.checkLocationAuthorization(
            mapView: mapView,
            segueIdentifier: incomeSegueIdentifier
        )
    }
}
