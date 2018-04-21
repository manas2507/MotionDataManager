//
//  ViewController.swift
//  Assignment
//
//  Created by Apple on 21/04/18.
//  Copyright © 2018 Manas. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {

    @IBOutlet weak var textArea: UITextView!
    @IBOutlet weak var textAreaAcc: UITextView!
    @IBOutlet weak var textAreaMag: UITextView!
    var flag = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func stopButton(_ sender: UIButton){
        flag = 0
    }
    
    @IBAction func startButton(_ sender: UIButton) {
        flag = 1
        startAccelerometerUpdates()
        startGyroUpdates()
        startMagnetometerUpdates()
        startDeviceMotionUpdates()
    }
    
    /// CoreMotion manager instance we receive updates from.
    fileprivate let motionManager = CMMotionManager()
    
    // MARK: - Configuring CoreMotion callbacks triggered for each sensor
    
    /**
     *  Configure the raw accelerometer data callback.
     */
    fileprivate func startAccelerometerUpdates() {
        if motionManager.isAccelerometerAvailable {
            motionManager.accelerometerUpdateInterval = 1.0
            motionManager.startAccelerometerUpdates(to: OperationQueue.main) { (accelerometerData, error) in
                self.insertInFile(acceleration: accelerometerData?.acceleration)
                //self.log(error: error, forSensor: .accelerometer)
            }
        }
    }
    
    /**
     *  Configure the raw gyroscope data callback.
     */
    fileprivate func startGyroUpdates() {
        if motionManager.isGyroAvailable {
            motionManager.gyroUpdateInterval = 1.0
            motionManager.startGyroUpdates(to: OperationQueue.main) { (gyroData, error) in
                self.insertInFile(rotationRate: gyroData?.rotationRate)
               // self.log(error: error, forSensor: .gyro)
            }
        }
    }
    
    /**
     *  Configure the raw magnetometer data callback.
     */
    fileprivate func startMagnetometerUpdates() {
        if motionManager.isMagnetometerAvailable {
            motionManager.magnetometerUpdateInterval = 1.0
            motionManager.startMagnetometerUpdates(to: OperationQueue.main) { (magnetometerData, error) in
                self.insertInFile(magneticField: magnetometerData?.magneticField)
                //self.log(error: error, forSensor: .magnetometer)
            }
        }
    }
    
    /**
     *  Configure the Device Motion algorithm data callback.
     */
    fileprivate func startDeviceMotionUpdates() {
        if motionManager.isDeviceMotionAvailable {
            motionManager.deviceMotionUpdateInterval = 1.0
            motionManager.startDeviceMotionUpdates(to: OperationQueue.main) { (deviceMotion, error) in
                self.insertInFile(acceleration: deviceMotion?.gravity)
                self.insertInFile(acceleration: deviceMotion?.userAcceleration)
                self.insertInFile(rotationRate: deviceMotion?.rotationRate)
                //self.log(error: error, forSensor: .deviceMotion)
            }
        }
    }
    
    /**
     Logs an error in a consistent format.
     
     - parameter error:  Error value.
     - parameter sensor: `DeviceSensor` that triggered the error.
     */
    /*fileprivate func log(error: Error?, forSensor sensor: DeviceSensor) {
        guard let error = error else { return }
        
        NSLog("Error reading data from \(sensor.description): \n \(error) \n")
    }*/
    
    func insertInFile(rotationRate: CMRotationRate?){
        if flag == 1{
            let val1=rotationRate?.x, val2=rotationRate?.y, val3=rotationRate?.z
            
            let time = NSDate().timeIntervalSince1970
            let myTimeInterval = TimeInterval(time)
            let finalTime = NSDate(timeIntervalSince1970: TimeInterval(myTimeInterval))
            
            textArea.text = "<\(finalTime)> <Gyrometer>\nX - <\(val1!)>\nY - <\(val2!)>\nZ - <\(val3!)>\n"
            
        }
        //Here I have tried to create a file and add the required data in it
        
        /*let file: FileHandle? = FileHandle(forWritingAtPath: "rotation.txt")
        let fileName = "rotation"
        let documentDirURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        
        let fileURL = documentDirURL.appendingPathComponent(fileName).appendingPathExtension("txt")
        
        print("File Path = \(fileURL.path)")
        
        let time : NSTimeZone = NSTimeZone()
        
        if file != nil {
            // Set the data we want to write
            
            let data = ("<\(time)> <Gyrometer> <\(val1)> <\(val2)> <\(val3)>\n" ).data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
            
            // Write it to the file
            file?.write(data!)
            textArea.text = "<\(time)> <Gyrometer> <\(val1)> <\(val2)> <\(val3)>\n"
            
            // Close the file
            file?.closeFile()
        }
        else {
            print("Ooops! Something went wrong!")
        }*/
    }
    
    func insertInFile(acceleration: CMAcceleration?){
        if flag == 1{
            let val1=acceleration?.x, val2=acceleration?.y, val3=acceleration?.z
            let time = NSDate().timeIntervalSince1970
            let myTimeInterval = TimeInterval(time)
            let finalTime = NSDate(timeIntervalSince1970: TimeInterval(myTimeInterval))

            textAreaAcc.text = "<\(finalTime)> <Acceleration>\nX - <\(val1!)>\nY - <\(val2!)>\nZ - <\(val3!)>\n"
        }
    }
    
    func insertInFile(magneticField: CMMagneticField?){
        if flag == 1{
            let val1=magneticField?.x, val2=magneticField?.y, val3=magneticField?.z
            let time = NSDate().timeIntervalSince1970
            let myTimeInterval = TimeInterval(time)
            let finalTime = NSDate(timeIntervalSince1970: TimeInterval(myTimeInterval))

            textAreaMag.text = "<\(finalTime)> <Magnetic Field>\nX - <\(val1!)> Y - <\(val2!)> Z - <\(val3!)>\n"
        }
    }
    
}

