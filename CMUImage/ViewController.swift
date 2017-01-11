//
//  ViewController.swift
//  CMUImage
//
//  Created by Camo_u on 2017. 1. 11..
//  Copyright © 2017년 Camo_u. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        imageView1.loadImage(fromURL: "http://www.hdwallpaperspulse.com/wp-content/uploads/2013/06/high-quality-high-resolution-nature-scene-hd-wallpaper-for-windows-7-background.jpg")
        imageView2.loadImage(fromURL: "http://hdimages.org/wp-content/uploads/2016/11/high-resolution-imges-HD10.jpg")
    }

    @IBAction func onLoad(_ sender: UIButton) {
//        imageView1.loadImage(fromURL: "http://www.hdwallpaperspulse.com/wp-content/uploads/2013/06/high-quality-high-resolution-nature-scene-hd-wallpaper-for-windows-7-background.jpg")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

