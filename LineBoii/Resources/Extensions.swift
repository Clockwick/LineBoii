//
//  Extensions.swift
//  LineBoii
//
//  Created by Paratthakorn Sribunyong on 25/7/2564 BE.
//

import Foundation
import UIKit



extension UIButton {
    func alignVertical(spacing: CGFloat = 6.0) {
        guard let imageSize = imageView?.image?.size,
              let text = titleLabel?.text,
              let font = titleLabel?.font
        else { return }
        
        titleEdgeInsets = UIEdgeInsets(
            top: 0.0,
            left: -imageSize.width,
            bottom: -(imageSize.height + spacing),
            right: 0.0
        )
        
        let titleSize = text.size(withAttributes: [.font: font])
        imageEdgeInsets = UIEdgeInsets(
            top: -(titleSize.height + spacing),
            left: 0.0,
            bottom: 0.0,
            right: -titleSize.width
        )
        
        let edgeOffset = abs(titleSize.height - imageSize.height) / 2.0
        contentEdgeInsets = UIEdgeInsets(
            top: edgeOffset,
            left: 0.0,
            bottom: edgeOffset,
            right: 0.0
        )
    }
    func alignHorizontal() {

        guard let imageSize = imageView?.image?.size,
              let text = titleLabel?.text,
              let font = titleLabel?.font
        else { return }
        let titleSize = text.size(withAttributes: [.font: font])
        
        imageEdgeInsets = UIEdgeInsets(top: imageEdgeInsets.top, left: bounds.size.width/2 - imageSize.width/2, bottom: imageEdgeInsets.bottom, right: 0)
        titleEdgeInsets = UIEdgeInsets(top: titleEdgeInsets.top, left: -imageSize.width + bounds.size.width/2 - titleSize.width/2, bottom: titleEdgeInsets.bottom, right: 0)
    }
}

extension UILabel{
    public var requiredHeight: CGFloat {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: frame.width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        label.attributedText = attributedText
        label.sizeToFit()
        return label.frame.height
    }
}
extension UIColor {
    static var darkGreen: UIColor {
        return UIColor.init(red: 25/255, green: 97/255, blue: 43/255, alpha: 1)
    }
}
extension UIView {
    var width: CGFloat {
        return frame.size.width
    }
    var height: CGFloat {
        return frame.size.height
    }
    var top: CGFloat {
        return frame.origin.y
    }
    var right: CGFloat {
        return frame.origin.x + width
    }
    var bottom: CGFloat {
        return frame.origin.y + height
    }
    var left: CGFloat {
        return frame.origin.x
    }
    
    
    
}

extension UIView {
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    func addBorders(edges: UIRectEdge,
                    color: UIColor,
                    inset: CGFloat = 0.0,
                    thickness: CGFloat = 1.0) -> [UIView] {
        
        var borders = [UIView]()
        
        @discardableResult
        func addBorder(formats: String...) -> UIView {
            let border = UIView(frame: .zero)
            border.backgroundColor = color
            border.translatesAutoresizingMaskIntoConstraints = false
            addSubview(border)
            addConstraints(formats.flatMap {
                            NSLayoutConstraint.constraints(withVisualFormat: $0,
                                                           options: [],
                                                           metrics: ["inset": inset, "thickness": thickness],
                                                           views: ["border": border]) })
            borders.append(border)
            return border
        }
        
        
        if edges.contains(.top) || edges.contains(.all) {
            addBorder(formats: "V:|-0-[border(==thickness)]", "H:|-inset-[border]-inset-|")
        }
        
        if edges.contains(.bottom) || edges.contains(.all) {
            addBorder(formats: "V:[border(==thickness)]-0-|", "H:|-inset-[border]-inset-|")
        }
        
        if edges.contains(.left) || edges.contains(.all) {
            addBorder(formats: "V:|-inset-[border]-inset-|", "H:|-0-[border(==thickness)]")
        }
        
        if edges.contains(.right) || edges.contains(.all) {
            addBorder(formats: "V:|-inset-[border]-inset-|", "H:[border(==thickness)]-0-|")
        }
        
        return borders
    }
}


extension DateFormatter {
    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        return dateFormatter
    }()
    
    static let displayDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter
    }()
}

extension String {
    static func formattedDate(string: String) -> String {
        guard let date = DateFormatter.dateFormatter.date(from: string) else {
            return string
        }
        return DateFormatter.displayDateFormatter.string(from: date)
    }
}


extension Notification.Name {
    static let filterChangeNotification = Notification.Name("filterChangeNotification")
    static let isOpenNotification = Notification.Name("isOpenNotification")
    static let isAllowCreditCardNotification = Notification.Name("isAllowCreditCardNotification")
    static let isPromotionNotification = Notification.Name("isPromotionNotification")
    static let isPickableNotification = Notification.Name("isPickableNotification")
    static let priceLevelNotification = Notification.Name("priceLevelNotification")
    static let foodTypeNotification = Notification.Name("foodTypeNotification")
    static let clearFilterAllNotification = Notification.Name("clearFilterAllNotification")
}
