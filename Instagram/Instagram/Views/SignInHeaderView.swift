//
//  SignInHeaderViewController.swift
//  Instagram
//
//  Created by Obed Garcia on 30/10/21.
//

import UIKit

class SignInHeaderView: UIView {
    private var gradientLayer: CALayer?
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "textlogo")
        imageView.contentMode = .scaleAspectFit
        return imageView
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
        
        createGradient()
        addSubview(imageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer?.frame = layer.bounds
        
        imageView.frame = CGRect(x: width/4, y: 20, width: width/2, height: height-40)
    }
    
    private func createGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.systemBlue.cgColor, UIColor.systemPink.cgColor]
        gradientLayer.frame = layer.bounds
        layer.addSublayer(gradientLayer)
        self.gradientLayer = gradientLayer
    }
    


}
