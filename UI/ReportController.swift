//
//  ReportController1.swift
//  UI
//
//  Created by kien on 11/16/16.
//  Copyright © 2016 kien. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage
import AVFoundation
import SpeechToTextV1

class ReportController: UIViewController,UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate
    {
    //@IBOutlet weak var ContentTextView: UITextView!
    var recorder : AVAudioRecorder!
    var speechToText: SpeechToText!
    var speechToTextSession: SpeechToTextSession!
    var isStreaming = false
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var microphoneButton: UIButton!
   // @IBOutlet weak var textView: UITextView!
    override func viewDidLoad()
    
    
    {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround1()
        let titleButton: UIButton = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 32))
        titleButton.setTitle("Reports", for: .normal)
        titleButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 20.0)
        titleButton.setTitleColor(UIColor.white, for: .normal)
        //titleButton.addTarget(self, action: Selector("titlepressed:"), for: UIControlEvents.touchUpInside)
        self.navigationItem.titleView = titleButton

        speechToText = SpeechToText(
            username: Credentials.SpeechToTextUsername,
            password: Credentials.SpeechToTextPassword
        )
        speechToTextSession = SpeechToTextSession(
            username: Credentials.SpeechToTextUsername,
            password: Credentials.SpeechToTextPassword
        )
    }
    @IBAction func speechtoText(_ sender: Any) {
        
    
    }
    @IBAction func import_image(_ sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary)
        {
            let Library = UIImagePickerController()
            Library.delegate = self
            Library.sourceType = UIImagePickerControllerSourceType.photoLibrary
            self.present(Library, animated: true, completion: nil)
        }
    }
    
    @IBAction func MenuButton(_ sender: Any) {
        self.findHamburguerViewController()?.showMenuViewController()
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = [UIImagePickerControllerOriginalImage] as? UIImage
        {
            self.performSegue(withIdentifier: "imagereport", sender: nil)
        } else
        {
            
        }
    }

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n"){
            textView.resignFirstResponder()
            return false
        }
        return true    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if (textView.text == "Your content for report: "){
            textView.text = ""
        }
        textView.becomeFirstResponder()    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if (textView.text == ""){
            textView.text = "Your content for report: "
        }
        textView.resignFirstResponder()
            }
    
    @IBAction func speechToText(_ sender: Any) {
        streamMicrophoneBasic()
    }
    public func streamMicrophoneBasic() {
        if !isStreaming {
            
            // update state
            //microphoneButton.setTitle("Stop Microphone", for: .normal)
            isStreaming = true
            
            // define recognition settings
            var settings = RecognitionSettings(contentType: .opus)
            settings.continuous = true
            settings.interimResults = true
            
            // define error function
            let failure = { (error: Error) in print(error) }
            
            // start recognizing microphone audio
            speechToText.recognizeMicrophone(settings: settings, failure: failure) {
                results in
                self.textView.text = results.bestTranscript
            }
            
        } else {
            
            // update state
           // microphoneButton.setTitle("Start Microphone", for: .normal)
            isStreaming = false
            
            // stop recognizing microphone audio
            speechToText.stopRecognizeMicrophone()
        }
    }
    
    /**
     This function demonstrates how to use the more advanced
     `SpeechToTextSession` class to transcribe microphone audio.
     */
    public func streamMicrophoneAdvanced() {
        if !isStreaming {
            
            // update state
          //  microphoneButton.setTitle("Stop Microphone", for: .normal)
            isStreaming = true
            
            // define callbacks
            speechToTextSession.onConnect = { print("connected") }
            speechToTextSession.onDisconnect = { print("disconnected") }
            speechToTextSession.onError = { error in print(error) }
            speechToTextSession.onPowerData = { decibels in print(decibels) }
            speechToTextSession.onMicrophoneData = { data in print("received data") }
            speechToTextSession.onResults = { results in self.textView.text = results.bestTranscript }
            
            // define recognition settings
            var settings = RecognitionSettings(contentType: .opus)
            settings.continuous = true
            settings.interimResults = true
            
            // start recognizing microphone audio
            speechToTextSession.connect()
            speechToTextSession.startRequest(settings: settings)
            speechToTextSession.startMicrophone()
            
        } else {
            
            // update state
           // microphoneButton.setTitle("Start Microphone", for: .normal)
            isStreaming = false
            
            // stop recognizing microphone audio
            speechToTextSession.stopMicrophone()
            speechToTextSession.stopRequest()
            speechToTextSession.disconnect()
        }
    }

}
    


extension UIViewController {
    func hideKeyboardWhenTappedAround1() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard1))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard1() {
        view.endEditing(true)
    }
}
