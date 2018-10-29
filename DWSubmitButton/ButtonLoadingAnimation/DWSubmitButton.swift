//
//  DWSubmitButton.swift
//  ButtonLoadingAnimation
//
//  Created by MUKUL on 29/10/18.
//  Copyright © 2018 CoderWork. All rights reserved.
//

import UIKit

class DWSubmitButton: UIButton {
    
    private var sLayer:CAShapeLayer!
    var myCurrentProgr:CGFloat = 0.0
    var delegate:DWButtonDelegates!
    var updatingDefaultProgressUntilDone:Bool = false {
        didSet{
            self.updateDummyProgressUntilDone(isUpdating: updatingDefaultProgressUntilDone)
        }
    }
    
    var completeDefaultProgress:Bool =  false {
        didSet{
            self.completeAllProgress()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.addTarget(self, action: #selector(submitButtonAction(sender:)), for: .touchUpInside)
    }
    
    @IBInspectable var progressWidth:CGFloat = 3.0 {
        didSet{
            if sLayer != nil {
                sLayer.lineWidth = progressWidth
            }
        }
    }
    
    var progress:CGFloat = 0.0 {
        didSet{
            if sLayer != nil {
                self.updateStroke(currentProgress: progress)
            }
        }
    }
    
    @IBInspectable  var progressColor:UIColor = .green{
        didSet{
            if sLayer != nil {
                sLayer.strokeColor = progressColor.cgColor
            }
        }
    }
    
    @objc func submitButtonAction(sender:UIButton) {
        UIView.animate(withDuration: 0.5, animations: {
            self.frame =  CGRect(x: ((self.superview?.center.x)! - 10), y: self.frame.origin.y, width: self.frame.size.height, height: self.frame.size.height)
            self.layer.cornerRadius = self.frame.size.height / 2
        }) { (comp) in
            self.addLayer()
            if self.delegate != nil {
                self.delegate.selectedItemActionWithReference(sender: sender)
            }
        }
    }
    
    private   func addLayer() {
        let bPath = UIBezierPath(arcCenter: self.center, radius: self.frame.size.height / 2, startAngle: 270.0 / 180.0 * .pi, endAngle: 265.0/180.0 * .pi, clockwise: true)
        sLayer = CAShapeLayer()
        sLayer.path = bPath.cgPath
        sLayer.lineCap = kCALineCapRound
        sLayer.fillColor = UIColor.clear.cgColor
        sLayer.lineWidth = progressWidth
        
        sLayer.bounds = self.frame
        sLayer.position = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
        sLayer.strokeColor = progressColor.cgColor
        sLayer.strokeStart = 0.0
        sLayer.strokeEnd = 0.0
        self.layer.addSublayer(sLayer)
        self.updateStroke(currentProgress: 0.0)
    }
    
    
    private func updateStroke(currentProgress:CGFloat) {
        UIView.animate(withDuration: 0.2) {
            self.sLayer.strokeEnd = currentProgress
        }
        if currentProgress >=  1.0 {
            if delegate != nil {
                delegate.progressCompleted()
            }
        }
    }
    
    private func updateDummyProgressUntilDone(isUpdating:Bool)  {
        if isUpdating {
            self.updateTestProgress()
        }
    }
    
    private func updateTestProgress() {
         self.sLayer.strokeEnd = myCurrentProgr
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
            self.myCurrentProgr += 0.05
            if self.myCurrentProgr >= 0.9 {
                return
            }
            self.updateTestProgress()
        }
    }
    
    private func completeAllProgress() {
        if completeDefaultProgress == true {
            myCurrentProgr = 1.0
            sLayer.strokeEnd = myCurrentProgr
            if delegate != nil {
                delegate.progressCompleted()
            }
        }
    }
}

@objc protocol DWButtonDelegates {
    func selectedItemActionWithReference(sender:UIButton)
    @objc func progressCompleted()
}




