//
//  PYLAdvertCarouselLabel.swift
//  PYLAdvertCarouselLabel
//
//  Created by 林涛 on 16/5/6.
//  Copyright © 2016年 林涛. All rights reserved.
//

import UIKit

protocol PYLAdvertCarouselLabelDelegate: NSObjectProtocol {
    func advertCarouselLabel(label:PYLAdvertCarouselLabel,didTapadvertIndex:Int)
}

public struct PYLAdvertCarouselLabelSettings {
    
    public struct Style {
        public var labelFont: UIFont?
        public var labelColor:UIColor?
       
        public var textAlignment:NSTextAlignment = .Left
        public var haveTouchEvent:Bool = false
        public var labelBarLeftContentInset: CGFloat = 8
    }
    
    public var style = Style()
}

class PYLAdvertCarouselLabel: UIView {
    
    var settings = PYLAdvertCarouselLabelSettings()
    var index = 0
    
    lazy private var oneLabel: UILabel = { [unowned self] in
        let label = UILabel()
        label.font = self.settings.style.labelFont
        label.textColor = self.settings.style.labelColor
        label.textAlignment = self.settings.style.textAlignment
        label.frame = CGRect(x: self.settings.style.labelBarLeftContentInset, y: 0, width: self.bounds.size.width, height: self.bounds.size.height)
        return label
        }()
    lazy private var twoLabel:UILabel = {[unowned self] in
        let label = UILabel()
        label.font = self.settings.style.labelFont
        label.textColor = self.settings.style.labelColor
        label.textAlignment = self.settings.style.textAlignment
        label.frame = CGRect(x: self.settings.style.labelBarLeftContentInset, y: self.bounds.size.height, width: self.bounds.size.width, height: self.bounds.size.height)

        return label
    }()
    
    private var timer:NSTimer?

    var titles:[String]  {
        didSet {
            setup()
        }
    }
    
    weak var delegate:PYLAdvertCarouselLabelDelegate? {
        didSet{
            let tapGestureRecognizer1 = UITapGestureRecognizer(target: self, action: #selector(PYLAdvertCarouselLabel.labelTap(_:)))
            oneLabel.addGestureRecognizer(tapGestureRecognizer1)
            oneLabel.userInteractionEnabled = true
            
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(PYLAdvertCarouselLabel.labelTap(_:)))
            twoLabel.userInteractionEnabled = true
            twoLabel.addGestureRecognizer(tapGestureRecognizer)
        }
    }
    
    func labelTap(tapGestureRecognizer:UITapGestureRecognizer) {
        let tapView = tapGestureRecognizer.view
        delegate?.advertCarouselLabel(self, didTapadvertIndex: tapView!.tag)
    }
    
    init(frame: CGRect,aTitles:[String]) {
            titles = aTitles
            super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        titles = []
        super.init(coder: aDecoder)
    }
    
    func setup() {
        guard !titles.isEmpty else {
            return
        }
        
        clipsToBounds = true
        addSubview(oneLabel)
        addSubview(twoLabel)
        oneLabel.text = titles.first
    }
    
    func scorllLabel() {
        if titles.count <= 1 {
            timer?.invalidate()
            return
        }
        
        var currentLabel:UILabel?
        var hidenLable:UILabel?
        
        
        for obj in subviews {
            if obj is UILabel {
                let label = obj as! UILabel
                if label.text == titles[index] {
                    label.tag = index
                    currentLabel = label
                } else {
                    hidenLable = label
                }
            }
        }
        
        if index != titles.count - 1 {
            index += 1
        } else {
            index = 0
        }
        
        hidenLable?.text = titles[index]
        hidenLable?.tag = index
        let height = bounds.size.height
        let width = bounds.size.width
        
        UIView.animateWithDuration(1, animations: {
            hidenLable?.frame = CGRect(x: self.settings.style.labelBarLeftContentInset, y: 0, width: width, height: height)
            currentLabel?.frame = CGRect(x: self.settings.style.labelBarLeftContentInset, y: -height, width: width, height: height)
        }) { (finish:Bool) in
            currentLabel?.frame = CGRect(x: self.settings.style.labelBarLeftContentInset, y: height, width: width, height: height)
        }
    }
    
    func startScorll() {
        
        guard timer == nil else{
            return
        }
        
        timer = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: #selector(PYLAdvertCarouselLabel.scorllLabel), userInfo: self, repeats: true)
    }
    
    func stopScorll(){
        timer?.invalidate()
        timer = nil
    }
}
