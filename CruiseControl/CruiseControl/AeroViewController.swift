import UIKit

import CoreLocation

import AudioToolbox

class AeroViewController: UIViewController , CLLocationManagerDelegate {
  
  @IBOutlet var speedLabel: UILabel?
  @IBOutlet var timeLabel: UILabel?
  
  @IBOutlet var speedoOffset: NSLayoutConstraint?
  var currentSpeed :Float = 0
  var cruiseSpeed :Float!
  
  @IBOutlet var layer1Offset: NSLayoutConstraint?
  var manager:CLLocationManager!
  
  @IBOutlet var layer2Offset: NSLayoutConstraint?
  
  var alert_tone:SystemSoundID?
  
  var deactivate_tone:SystemSoundID?
  
  func CreateAlertTone() -> SystemSoundID {
    var soundID: SystemSoundID = 0
    let soundURL = CFBundleCopyResourceURL(CFBundleGetMainBundle(), "beep1", "mp3", nil)
    AudioServicesCreateSystemSoundID(soundURL, &soundID)
    return soundID
  }
  
  func CreateDeactivateTone() -> SystemSoundID {
    var soundID: SystemSoundID = 0
    let soundURL = CFBundleCopyResourceURL(CFBundleGetMainBundle(), "beep5", "mp3", nil)
    AudioServicesCreateSystemSoundID(soundURL, &soundID)
    return soundID
  }
  
  
  @IBAction func viewTapped(sender: AnyObject)
  {
    
    
    if let cruizeSpeedNotNil = cruiseSpeed {
      AudioServicesPlaySystemSound(deactivate_tone!)
      cruiseSpeed = nil
    }
    else {
      AudioServicesPlaySystemSound(alert_tone!)
      cruiseSpeed = currentSpeed
    }
  }
  
  
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    alert_tone = CreateAlertTone()
    
    deactivate_tone = CreateDeactivateTone()
    
    // Do any additional setup after loading the view, typically from a nib.
    
    manager = CLLocationManager()
    manager.delegate = self
    manager.desiredAccuracy = kCLLocationAccuracyBest
    //  manager.requestAlwaysAuthorization()
    manager.startUpdatingLocation()
  }
  
  
  
  func updateTime()
  {
    var dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = "HH:mm"
    let d = NSDate()
    let s = dateFormatter.stringFromDate(d)
    
    timeLabel!.text = s
    
  }
  
  func locationManager(manager:CLLocationManager, didUpdateLocations locations:[AnyObject])
  {
    
    println("locations = \(locations)")
    
    updateTime()
    
    let location = locations[0] as CLLocation
    
    let speed:Float = Float(location.speed);
    
    currentSpeed = speed / 0.44706667;
    
    var difference:Float = 0.0
    
    if let cruizeSpeedNotNil = cruiseSpeed {
      
      difference = cruizeSpeedNotNil - currentSpeed
      
    }
    
    layer1Offset!.constant = CGFloat((difference*40) - 235)
    
    layer2Offset!.constant = CGFloat(-235-(difference*80))
    
    
    
    
    speedLabel!.text = String(format:"%.1f",currentSpeed)
    
    speedoOffset!.constant = CGFloat(0.0-(currentSpeed*6.34))
    
    
    
    
    
    
    UIView.animateWithDuration(0.5, animations: {
      self.view.layoutSubviews()
    })
  }
  
  
  
}

