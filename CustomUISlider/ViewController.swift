//
//  ViewController.swift
//  CustomUISlider
//
//  Created by mak on 24.11.2017.
//  Copyright © 2017 Sergei Armodin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	
	@IBOutlet weak var slider: UISlider!
	
	
	override func viewDidLoad() {
		super.viewDidLoad()

	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
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

