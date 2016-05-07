//
//  ViewController.swift
//  PYLAdvertCarouselLabel
//
//  Created by 林涛 on 16/5/6.
//  Copyright © 2016年 林涛. All rights reserved.
//

import UIKit

class ViewController: UIViewController,PYLAdvertCarouselLabelDelegate {

    
    @IBOutlet weak var carouselLabel: PYLAdvertCarouselLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        carouselLabel.settings.style.labelColor = UIColor.greenColor()
        carouselLabel.settings.style.textAlignment = .Center
        carouselLabel.titles = ["Hello","Welcome to Swift"]
        carouselLabel.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func startScroll(sender: AnyObject) {
        carouselLabel.startScorll()
    }

    @IBAction func stopScroll(sender: AnyObject) {
        carouselLabel.stopScorll()
    }
    
    func advertCarouselLabel(label:PYLAdvertCarouselLabel,didTapadvertIndex:Int) {
        print(didTapadvertIndex)
    }
    
}

