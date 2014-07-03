import UIKit

import CoreLocation

class AeroViewController: UIViewController , CLLocationManagerDelegate {
  
  @IBOutlet var speedLabel: UILabel
  @IBOutlet var timeLabel: UILabel
  
  @IBOutlet var speedoOffset: NSLayoutConstraint
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
    
    speedoOffset.constant = Float(0.0-(currentSpeed*6.34))
  
    UIView.animateWithDuration(0.5, animations: {
    
      self.view.layoutSubviews()
      
      })
    
  }

}

