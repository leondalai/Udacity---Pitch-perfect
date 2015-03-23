//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Javito on 3/14/15.
//  Copyright (c) 2015 Javiercs. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    // defines the variables for the audio that comes from the recording VC
    var audioPlayer:AVAudioPlayer!
    var receivedAudio:RecordedAudio!
    var audioEngine: AVAudioEngine!
    var audioFile:AVAudioFile!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // initializes the variables and makes the recording audio available
        
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
        
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func playSlowAudio(sender: UIButton) {
        // plays it at 0.5 speed, calling the function below
        playingAudio(0.5)
    
    }
    
    @IBAction func playFastAudio(sender: UIButton) {
        // plays it at 1.5 speed, calling the function below
        playingAudio(1.5)
    }
    
    @IBAction func playChipmunkAudio(sender: UIButton) {
        // changes the pitch to 1,000, calling the function below
        playAudioWithVariablePitch(1000)
        
    }
    
    @IBAction func playDarthvaderAudio(sender: UIButton) {
        // changes the pitch to -1,000, calling the function below
        playAudioWithVariablePitch(-1000)
    
    }
    
    
    func playAudioWithVariablePitch(pitch: Float){
        
        // stop the audio and resets it
        
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        // changes the pitch
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        // plays the audi
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
    }
    

    @IBAction func stopAudio(sender: UIButton) {
        audioPlayer.stop()
    }
    
    func playingAudio(speed: Float) {
        // stops the audio, plays the audio at speed starting at 0.0
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        audioPlayer.rate = speed
        audioPlayer.currentTime = 0.0
        audioPlayer.play()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
