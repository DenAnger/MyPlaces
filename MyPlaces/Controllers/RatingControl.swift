//
//  RatingControl.swift
//  MyPlaces
//
//  Created by Denis Abramov on 25.07.2020.
//  Copyright © 2020 Denis Abramov. All rights reserved.
//

import UIKit

@IBDesignable class RatingControl: UIStackView {
    
    @IBInspectable var starSize = CGSize(width: 45, height: 45) {
        didSet {
            setupButtons()
        }
    }
    @IBInspectable var starCount = 5 {
        didSet {
            setupButtons()
        }
    }
    
    var rating = 0
    
    private var ratingButtons = [UIButton]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtons()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupButtons()
    }
    
    @objc func ratingButtonTapped(button: UIButton) {
        print("Button pressed")
    }
    
    private func setupButtons() {
        
        for button in ratingButtons {
            removeArrangedSubview(button)
            removeFromSuperview()
        }
        ratingButtons.removeAll()
        
        for _ in 0..<starCount {
            let button = UIButton()
            button.backgroundColor = .red
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
            button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
            button.addTarget(self,
                             action: #selector(ratingButtonTapped(button:)),
                             for: .touchUpInside)
            addArrangedSubview(button)
            ratingButtons.append(button)
        }
    }
}
