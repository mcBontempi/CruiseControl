//
//  ViewController.swift
//  CruiseControl
//
//  Created by Daren taylor on 26/06/2014.
//  Copyright (c) 2014 LukeBuckless. All rights reserved.
//

import UIKit

import CoreLocation

class ViewController: UIViewController , CLLocationManagerDelegate {
                            
  @IBOutlet var backgroundImageView: UIImageView
  @IBOutlet var speedLabel: UILabel
  
  var currentSpeed :Double = 0
  var cruiseSpeed :Double!
  
  var manager:CLLocationManager!
  
  
  @IBAction func viewTapped(sender: AnyObject)
  {
    if let cruizeSpeedNotNil = cruiseSpeed {
      cruiseSpeed = nil
    }
    else {
      cruiseSpeed = currentSpeed
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    manager = CLLocationManager()
    manager.delegate = self
    manager.desiredAccuracy = kCLLocationAccuracyBest
    manager.requestAlwaysAuthorization()
    manager.startUpdatingLocation()
  }
  
  func locationManager(manager:CLLocationManager, didUpdateLocations locations:AnyObject[]) {
    println("locations = \(locations)")

    let location = locations[0] as CLLocation

    let metresPerSecond = location.speed
    
    let milesPerSecond:CLLocationSpeed =  1609 / metresPerSecond;
    
    let milesPerHour = milesPerSecond / 60*60
    
    speedLabel.text = "\(milesPerHour)"
    
    currentSpeed = milesPerHour;
    
    
    if let cruizeSpeedNotNil = cruiseSpeed {
    
    let difference = currentSpeed - cruiseSpeed
    
      
      
      
    if difference > 1 {
      backgroundImageView.image = UIImage(named:"chevron1")
    }
    
      
      
      
      
    }
    else {
      backgroundImageView.image = UIImage(named:"background")
    }
    
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

