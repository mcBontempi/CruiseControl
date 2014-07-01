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
  
  @IBOutlet var timeLabel: UILabel
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
    
    manager = CLLocationManager()
    manager.delegate = self
    manager.desiredAccuracy = kCLLocationAccuracyBest
    manager.requestAlwaysAuthorization()
    manager.startUpdatingLocation()
  }
  
  
  
  func updateTime()
  {
    var dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = "HH:mm"
    let d = NSDate()
    let s = dateFormatter.stringFromDate(d)
  
    timeLabel.text = s
    
  }
  
  func locationManager(manager:CLLocationManager, didUpdateLocations locations:AnyObject[])
  {
  
    println("locations = \(locations)")
    
    updateTime()
    
    let location = locations[0] as CLLocation
    
    currentSpeed = location.speed / 0.44706667;
    
    speedLabel.text = String(format:"%.1f",currentSpeed)
    
    if let cruizeSpeedNotNil = cruiseSpeed {
      
      let difference = cruiseSpeed - currentSpeed
      
      if difference < -1.5 {
        backgroundImageView.image = UIImage(named:"chevron1")
      }
      else if difference < -0.5 {
        backgroundImageView.image = UIImage(named:"chevron2")
      }
      else if difference > 1.5 {
        backgroundImageView.image = UIImage(named:"chevron5")
      }
      else if difference > 0.5 {
        backgroundImageView.image = UIImage(named:"chevron4")
      }
      else {
        backgroundImageView.image = UIImage(named:"targetspeed")
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

