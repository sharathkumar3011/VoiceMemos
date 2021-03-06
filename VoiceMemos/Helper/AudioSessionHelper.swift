//
//  AudioSessionHelper.swift
//  VoiceMemos
//
//  Created by Zhouqi Mo on 2/24/15.
//  Copyright (c) 2015 Zhouqi Mo. All rights reserved.
//

import AVFoundation

class AudioSessionHelper {
    
    struct Constants {
        struct Notification {
            struct AudioObjectWillStart {
                static let Name = "KMAudioObjectWillStartNotification"
                struct UserInfo {
                    static let AudioObjectKey = "KMAudioObjectWillStartNotificationAudioObjectKey"
                }
            }
        }
    }
    
    class func postStartAudioNotificaion(_ AudioObject: NSObject) {
        let userInfo = [Constants.Notification.AudioObjectWillStart.UserInfo.AudioObjectKey: AudioObject]
        NotificationCenter.default.post(name: Notification.Name(rawValue: Constants.Notification.AudioObjectWillStart.Name),
            object: nil,
            userInfo: userInfo)
    }
    
    class func setupSessionActive(_ active: Bool, catagory: String = AVAudioSessionCategoryPlayback) {
        let session = AVAudioSession.sharedInstance()
        if active {
            do {
                try session.setCategory(catagory)
            } catch {
                debugPrint("Could not set session category: \(error)")
            }
            
            do {
                try session.setActive(true)
            } catch {
                debugPrint("Could not activate session: \(error)")
            }
        } else {
            do {
                try session.setActive(false, with: .notifyOthersOnDeactivation)
            } catch {
                debugPrint("Could not deactivate session: \(error)")
            }
        }
    }
}

