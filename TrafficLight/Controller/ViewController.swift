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
    weak var timer: Timer?
    @IBOutlet weak var trafficLightImage: UIImageView!
    
    // Button to start/restart traffic light cycle
    @IBAction func startPressedOn(_ sender: Any) {
                
        // To fix inconsistant Red light duration
        timer?.invalidate()
        timer = nil

        var counter = 0
        // Set the max number of loop
        let max = 100
        
        access.createItem(event: "Start/Restart Pressed")
        
        // Continuously loop trafficLights() till the counter gets to max
        while true {
            
            timer?.invalidate()
            timer = nil
            
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
        
        guard timer == nil else { return }
        
        timer = Timer.scheduledTimer(withTimeInterval: 0, repeats: false) { timer in
            self.trafficLightImage.image = UIImage(imageLiteralResourceName: "green.png")
            
            self.access.createItem(event: "Light Changed - Green")
            
        }
        timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: false) { timer in
            self.trafficLightImage.image = UIImage(imageLiteralResourceName: "yellow.png")
            
            self.access.createItem(event: "Light Changed - Yellow")

        }
        timer = Timer.scheduledTimer(withTimeInterval: 7, repeats: false) { timer in
            self.trafficLightImage.image = UIImage(imageLiteralResourceName: "red.png")
            
            self.access.createItem(event: "Light Changed - Red")
        }
        
    }
}

