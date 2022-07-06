//
//  ViewController.swift
//  TrafficLight
//
//  Created by Tatsuya Moriguchi on 6/29/22.
//

import UIKit
import CoreData


class ViewController: UIViewController {
    
    // Properties
    let access = AccessData()
    @IBOutlet weak var trafficLightImage: UIImageView!
    
    // Button to start/restart traffic light cycle
    @IBAction func startPressedOn(_ sender: Any) {
        
        // counter and max number to exit out of while loop just in case
        var counter = 0
        let max = 100
        
        // Accessng Core Data to log an event, Button Pressed
        access.createItem(event: "Start/Restart Pressed")
 
        // Continuously loop trafficLights() till the counter gets to max
        while true {
            
            // Schedule each function call ahead everytime it loops.
            // But why counter * 10 instead of counter * 11???
            // green: 5 seconds + yellow 2 seconds + red 4 seconds = 11 
            // The total seconds of one loop is 11 seconds
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(counter * 10)) {
                   self.trafficLights()
            }
            
            counter += 1
            
            // break when the counter reaches to max
            // to avoid endless loop
            // if endless loop is required, remove the code below
            if counter == max {
                break
            }
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //trafficLightImage.image = UIImage(named: "red.png")
        
    }
    
    
    func trafficLights() {
        
        let queue = OperationQueue()
        
        let opeGreen = BlockOperation {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0) {
                self.trafficLightImage.image = UIImage(imageLiteralResourceName: "green.png")
                self.access.createItem(event: "Light Changed - Green")
                print("Green - \(Date())")
            }
        }
        let opeYellow = BlockOperation {
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                self.trafficLightImage.image = UIImage(imageLiteralResourceName: "yellow.png")
                self.access.createItem(event: "Light Changed - Yellow")
                print("Yellow - \(Date())")
            }
        }
        let opeRed = BlockOperation {
            DispatchQueue.main.asyncAfter(deadline: .now() + 7) {
                self.trafficLightImage.image = UIImage(imageLiteralResourceName: "red.png")
                self.access.createItem(event: "Light Changed - Red")
                print("Red - \(Date())")
            }
        }
        
//        let cancelBlocks = BlockOperation {
//            DispatchQueue.main.asyncAfter(deadline: .now() + 11, execute: {
//                opeGreen.cancel()
//                opeYellow.cancel()
//                opeRed.cancel()
//            })
//        }
        
        //opeGreen.addDependency(opeRed)
        opeYellow.addDependency(opeGreen)
        opeRed.addDependency(opeYellow)
//        cancelBlocks.addDependency(opeRed)
        
        queue.addOperation(opeGreen)
        queue.addOperation(opeYellow)
        queue.addOperation(opeRed)
//        queue.addOperation(cancelBlocks)
        queue.waitUntilAllOperationsAreFinished()
        
    }
}
