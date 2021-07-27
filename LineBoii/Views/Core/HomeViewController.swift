//
//  HomeViewController.swift
//  LineBoii
//
//  Created by Paratthakorn Sribunyong on 25/7/2564 BE.
//

import UIKit

class HomeViewController: UIViewController {
    
    private let helloText: UILabel = {
        let label = UILabel()
        label.text = "สวัสดี"
        label.font = UIFont(name: "supermarket", size: 20)
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 0
        label.textColor = .white
        return label
    }()
    
    private let helpText: UILabel = {
        let label = UILabel()
        label.text = "วันนี้มีอะไรให้เราช่วยไหม?"
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 0
        label.textColor = .white
        label.font = UIFont(name: "supermarket", size: 24)
        return label
    }()
    
    private let deliveryButton: UIButton = UIButton()
    
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        createGradientBackground()
        view.addSubview(helloText)
        view.addSubview(helpText)
        initButton()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        helloText.frame = CGRect(x: 10, y: view.safeAreaInsets.top + 40, width: 50, height: 30)
        helpText.frame = CGRect(x: 10, y: helloText.bottom + 10, width: view.width / 2, height: 30)
        deliveryButton.frame = CGRect(x: 10, y: helpText.bottom + 15 , width: view.width - 20, height: 100)
        
    }
    
    private func createGradientBackground() {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: view.width, height: view.height * 0.4))
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 30
        
        let gradient = CAGradientLayer()
        gradient.frame = imageView.bounds
        gradient.colors = [
            UIColor.init(red: 15/255, green: 171/255, blue: 116/255, alpha: 1).cgColor,
            UIColor.init(red: 85/255, green: 230/255, blue: 179/255, alpha: 1).cgColor
        ]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        
        imageView.layer.insertSublayer(gradient, at: 0)
        view.addSubview(imageView)
    }
    
    private func initButton() {
        
        let imageView = UIImageView()
        // Elevation
        let button = addButtonElevation(button: deliveryButton)
        
        button.backgroundColor = .white
        button.titleLabel?.font = UIFont(name: "supermarket", size: 24)
        button.setTitleColor(.label, for: .normal)
        button.setTitle("Delivery", for: .normal)
        button.semanticContentAttribute = .forceRightToLeft
        button.layer.masksToBounds = false
        button.layer.cornerRadius = 10
        
        guard let image = UIImage(named: "delivery.png") else {
            return
        }
        
        let resizedImage = resizeImage(image: image, targetSize: CGSize(width: 100, height: 100))
        
        imageView.image = resizedImage
        imageView.contentMode = .scaleAspectFill
        
        button.setImage(imageView.image, for: .normal)
        
        view.addSubview(button)
    }
    
    private func addButtonElevation(button: UIButton) -> UIButton {
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        button.layer.shadowOffset = CGSize(width: 1, height: 1)
        button.layer.shadowOpacity = 1.0
        button.layer.shadowRadius = 2.0
        return button
    }
    
    
    
    private func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage? {
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(origin: .zero, size: newSize)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }

}



