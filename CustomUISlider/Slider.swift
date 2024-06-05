//
//  Slider.swift
//  CustomUISlider
//
//  Created by mak on 24.11.2017.
//  Copyright © 2017 Sergei Armodin. All rights reserved.
//

import UIKit

class Slider: UISlider {
	
	/// Big position image view
	var bigImage = UIImageView()
	
	/// Small indicator counted size
	var indicatorSize: CGSize? = nil
	
	override var isHighlighted: Bool {
		didSet {
			// avoid situation when indicator size didn't count yet
			guard indicatorSize != nil else { return }
			
			UIView.animate(withDuration: 0.3) { [weak self] in
				guard let self else { return }
				if isHighlighted == true {
					bigImage.transform = CGAffineTransform(scaleX: 2, y: 2)
				} else {
					bigImage.transform = CGAffineTransform(scaleX: 1, y: 1)
				}
			}
		}
	}
	
	override func awakeFromNib() {
		super.awakeFromNib()
		
		let positionImage = UIImage.circle(diameter: 30, color: UIColor.blue)
		setThumbImage(positionImage, for: .normal)
		
		let positionImageBig = UIImage.circle(diameter: 60, color: UIColor.blue)
		bigImage.contentMode = .scaleAspectFit
		bigImage.clipsToBounds = false
		bigImage.image = positionImageBig
		
		addSubview(bigImage)
		
		bringSubviewToFront(bigImage)
	}
	
	override func thumbRect(forBounds bounds: CGRect, trackRect rect: CGRect, value: Float) -> CGRect {
		let unadjustedThumbrect = super.thumbRect(forBounds: bounds, trackRect: rect, value: value)

		let origin = unadjustedThumbrect.origin
		let size = unadjustedThumbrect.size

		if indicatorSize == nil && unadjustedThumbrect.size.width > 0 {
			bigImage.frame = unadjustedThumbrect
			indicatorSize = size
		}

		let bigImageSize = self.bigImage.frame.size

		bigImage.frame.origin = CGPoint(
			x: origin.x - (bigImageSize.width/2 - size.width/2),
			y: origin.y - (bigImageSize.height/2 - size.height/2)
		)

		bringSubviewToFront(bigImage)

		return unadjustedThumbrect
	}
}

extension UIImage {
	class func circle(diameter: CGFloat, color: UIColor) -> UIImage {
		UIGraphicsBeginImageContextWithOptions(CGSize(width: diameter, height: diameter), false, 0)
		let ctx = UIGraphicsGetCurrentContext()
		ctx!.saveGState()

		let rect = CGRect(x: 0, y: 0, width: diameter, height: diameter)
		ctx!.setFillColor(color.cgColor)
		ctx!.fillEllipse(in: rect)

		ctx!.restoreGState()
		let img = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()

		return img!
	}
}
