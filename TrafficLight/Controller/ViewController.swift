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
    let queue = OperationQueue()
    
    @IBOutlet weak var trafficLightImage: UIImageView!
    
    // Button to start/restart traffic light cycle
    @IBAction func startPressedOn(_ sender: Any) {

        queue.cancelAllOperations()
        
        var counter = 0
        // Set the max number of loop
        let max = 100
        
        access.createItem(event: "Start/Restart Pressed")
        
        // Continuously loop trafficLights() till the counter gets to max
        while true {
            queue.cancelAllOperations()
            
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
        let opeGreen = BlockOperation {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0) {
                self.trafficLightImage.image = UIImage(imageLiteralResourceName: "green.png")
                self.access.createItem(event: "Light Changed - Green")
                
            }
        }
        let opeYellow = BlockOperation {
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                self.trafficLightImage.image = UIImage(imageLiteralResourceName: "yellow.png")
                self.access.createItem(event: "Light Changed - Yellow")
            }
        }
        let opeRed = BlockOperation {
            DispatchQueue.main.asyncAfter(deadline: .now() + 7) {
                self.trafficLightImage.image = UIImage(imageLiteralResourceName: "red.png")
                self.access.createItem(event: "Light Changed - Red")
            }
        }

        
        //opeGreen.addDependency(opeRed)
        opeYellow.addDependency(opeGreen)
        opeRed.addDependency(opeYellow)
        
        queue.addOperation(opeGreen)
        queue.addOperation(opeYellow)
        queue.addOperation(opeRed)
        queue.waitUntilAllOperationsAreFinished()
        

        
//        let mainQueue = OperationQueue.main
//        let greenOperation = Operation()
//        let yellowOperation = Operation()
//        let redOperation = Operation()
//
//        mainQueue.addOperation {
//            greenOperation.start()
//            yellowOperation.start()
//            redOperation.start()
//        }
//
//        yellowOperation.addDependency(greenOperation)
//        redOperation.addDependency(yellowOperation)
//
//        greenOperation.completionBlock = {
//            DispatchQueue.main.async {
//                self.trafficLightImage.image = UIImage(imageLiteralResourceName: "green.png")
//                self.access.createItem(event: "Light Changed - Green")
//            }
//        }
//
//        yellowOperation.completionBlock = {
//            DispatchQueue.main.async {
//                self.trafficLightImage.image = UIImage(imageLiteralResourceName: "yellow.png")
//                self.access.createItem(event: "Light Changed - Yellow")
//            }
//        }
//
//        redOperation.completionBlock = {
//            DispatchQueue.main.async {
//                self.trafficLightImage.image = UIImage(imageLiteralResourceName: "red.png")
//                self.access.createItem(event: "Light Changed - Red")
//            }
//
//        }
            


    }
}
