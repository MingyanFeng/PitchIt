//
//  ViewController.swift
//  Pitchit
//
//  Created by 冯明妍 on 16/5/11.
//  Copyright © 2016年 冯明妍. All rights reserved.
//

import UIKit
//import AVFoundation class
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {

    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopRecordButton: UIButton!
    
    var audioRecorder:AVAudioRecorder!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Record"
        
        // Do any additional setup after loading the view, typically from a nib.
        stopRecordButton.enabled = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func startRecording(sender: AnyObject) {
        print("Record Button Pressed")
        recordingLabel.text = "Recording in Progress"
        // Enable stop button and disable record button
        recordButton.enabled = false
        stopRecordButton.enabled = true
        
        // Codes provided by udacity course
        // Record audio function
        // Codes'directry path and build a full path including the file name, sotre it as a string
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        
        // Make a name of recording file and build a path
        let recordingName = "pitchRecording.wav"
        let filePath = NSURL.fileURLWithPathComponents([dirPath, recordingName])
        
        print(filePath)
        
        // Grab the AVAudioSessioin and set up a catagroy to record and play
        // We need AVAudioSession in order to either record or play back audio
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        
        try! audioRecorder = AVAudioRecorder(URL: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        // Tell audioRecord to prepaer to record
        audioRecorder.prepareToRecord()
        // Tell audioRecord to start to record
        audioRecorder.record()

        
    }

    @IBAction func stopRecording(sender: AnyObject) {
        print("Stop Button Pressed")
        recordingLabel.text = "Tap to Record"
        recordButton.enabled = true
        stopRecordButton.enabled = false
        
        // code provided by udacity course
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)

    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
    }
    
    
}

