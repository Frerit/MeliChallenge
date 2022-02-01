//
//  CustomUIElements.swift
//  MeliChallenge
//
//  Created by Julian Perez on 31/01/22.
//

import Foundation
import UIKit

// MARK: - UI Elements
func setUpStatusBar(backgroundColor: UIColor?) {
   
   if #available(iOS 13.0, *) {
       var statusBarView: UIView
       let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
       statusBarView = UIView(frame: window?.windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero)
       statusBarView.backgroundColor = backgroundColor
       if statusBarView.isHidden {
           UIView.transition(with: statusBarView, duration: 0.3,
                             options: .transitionCrossDissolve,
                             animations: {
                               statusBarView.isHidden = false
                               UIApplication.shared.keyWindow?.addSubview(statusBarView)
                             },
                             completion: nil)
       } else {
           UIView.transition(with: statusBarView, duration: 0.3,
                             options: .transitionCrossDissolve,
                             animations: {
                               UIApplication.shared.keyWindow?.addSubview(statusBarView)
                             },
                             completion: nil)
       }
   } else {
       guard let statusBarView = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView else { return }
       if statusBarView.isHidden {
           UIView.transition(with: statusBarView, duration: 0.3,
                             options: .transitionCrossDissolve,
                             animations: {
                               statusBarView.isHidden = false
                               statusBarView.backgroundColor = backgroundColor
                             },
                             completion: nil)
       } else {
           UIView.transition(with: statusBarView, duration: 0.3,
                             options: .transitionCrossDissolve,
                             animations: { statusBarView.backgroundColor = backgroundColor },
                             completion: nil)
       }
   }
}

func getCurrenciValue(_ price: Double) -> String{
   let numberFormatter = NumberFormatter()
       numberFormatter.groupingSeparator = "."
       numberFormatter.groupingSize = 3
       numberFormatter.usesGroupingSeparator = true
       numberFormatter.decimalSeparator = ","
       numberFormatter.numberStyle = .decimal
       numberFormatter.maximumFractionDigits = 2
   return numberFormatter.string(from: price as NSNumber)!
}


// MARK: - @IBInspectable variables
@IBDesignable class CustomView: UIView {
   
   @IBInspectable var cornerRadius: CGFloat {
       get { return self.layer.cornerRadius }
       set { self.layer.cornerRadius = newValue }
   }
   
   @IBInspectable var topLeft: Bool {
       get { return self.layer.maskedCorners.contains(.layerMinXMinYCorner) }
       set { addCornerMask(newValue, cornerMask: .layerMinXMinYCorner) }
   }

   @IBInspectable var topRight: Bool {
       get { return self.layer.maskedCorners.contains(.layerMaxXMinYCorner) }
       set { addCornerMask(newValue, cornerMask: .layerMaxXMinYCorner) }
   }

   @IBInspectable var bottomLeft: Bool {
       get { return self.layer.maskedCorners.contains(.layerMinXMaxYCorner) }
       set { addCornerMask(newValue, cornerMask: .layerMinXMaxYCorner) }
   }

   @IBInspectable var bottomRight: Bool {
       get { return self.layer.maskedCorners.contains(.layerMaxXMaxYCorner) }
       set { addCornerMask(newValue, cornerMask: .layerMaxXMaxYCorner) }
   }
   
   @IBInspectable var borderWidth: CGFloat {
       get { return self.layer.borderWidth }
       set { self.layer.borderWidth = newValue }
   }
   
   @IBInspectable var borderColor: UIColor? {
       get { return self.layer.borderColor != nil ? UIColor(cgColor: self.layer.borderColor!) : nil }
       set { self.layer.borderColor = newValue?.cgColor }
   }
   
   @IBInspectable var shadowOffset: CGSize {
       get { return self.layer.shadowOffset }
       set { self.layer.shadowOffset = newValue }
   }
   
   @IBInspectable var shadowColor: UIColor? {
       get { return self.layer.shadowColor != nil ? UIColor(cgColor: self.layer.shadowColor!) : nil }
       set { self.layer.shadowColor = newValue?.cgColor }
   }
   
   @IBInspectable var shadowOpacity: Float {
       get { return self.layer.shadowOpacity }
       set { self.layer.shadowOpacity = newValue }
   }
   
   @IBInspectable var shadowRadius: CGFloat {
       get { return self.layer.shadowRadius }
       set { self.layer.shadowRadius = newValue }
   }
}

// MARK: - Setup
extension CustomView {
   
   override func prepareForInterfaceBuilder() {
       super.prepareForInterfaceBuilder()
   }
   
   override class func awakeFromNib() {
       super.awakeFromNib()
   }
   
   private func addCornerMask(_ add: Bool, cornerMask: CACornerMask) {
       if add {
           self.layer.maskedCorners.insert(cornerMask)
       } else {
           self.layer.maskedCorners.remove(cornerMask)
       }
   }
}


