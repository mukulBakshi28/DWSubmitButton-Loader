//
//  ViewController.swift
//  ButtonLoadingAnimation
//
//  Created by MUKUL on 29/10/18.
//  Copyright © 2018 CoderWork. All rights reserved.
//

import UIKit

class ViewController: UIViewController,DWButtonDelegates {
   
     @IBOutlet weak var submitButton: DWSubmitButton!
    
     override func viewDidLoad() {
        super.viewDidLoad()
             submitButton.delegate = self
     }
    
 
    //DWSubmit Button
    func selectedItemActionWithReference(sender: UIButton) {
         print("button clicked")
        //self.updateTestProgress(progressVal: 0.0)
        submitButton.updatingDefaultProgressUntilDone = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 14) {
         self.submitButton.completeDefaultProgress = true
        }
    }
    
    func progressCompleted() {
       print("progress is being completed")
     }
 
   
   }

 


