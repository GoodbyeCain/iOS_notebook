//
//  IMXAudioSet_CoreAudio.swift
//  IMXAudioSet
//
//  Created by zhoupanpan on 2017/11/21.
//  Copyright © 2017年 panzhow. All rights reserved.
//

import Foundation
import AVFoundation

extension IMXAudioSet {
    
    func play(path: String,type: String)  {
        guard let musicURL = Bundle.main.url(forResource: path, withExtension: type) else { return  }
        do{
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true, with: AVAudioSessionSetActiveOptions.notifyOthersOnDeactivation)
            
            audioPlayer = try AVAudioPlayer.init(contentsOf: musicURL as URL)
            audioPlayer?.numberOfLoops = 2
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
        }catch {
            print(error.localizedDescription)
        }
    }
    func readMusicFile(path: String,type: String) {
        AudioFileStreamOpen(<#T##inClientData: UnsafeMutableRawPointer?##UnsafeMutableRawPointer?#>, <#T##inPropertyListenerProc: AudioFileStream_PropertyListenerProc##AudioFileStream_PropertyListenerProc##(UnsafeMutableRawPointer, AudioFileStreamID, AudioFileStreamPropertyID, UnsafeMutablePointer<AudioFileStreamPropertyFlags>) -> Void#>, <#T##inPacketsProc: AudioFileStream_PacketsProc##AudioFileStream_PacketsProc##(UnsafeMutableRawPointer, UInt32, UInt32, UnsafeRawPointer, UnsafeMutablePointer<AudioStreamPacketDescription>) -> Void#>, <#T##inFileTypeHint: AudioFileTypeID##AudioFileTypeID#>, <#T##outAudioFileStream: UnsafeMutablePointer<AudioFileStreamID?>##UnsafeMutablePointer<AudioFileStreamID?>#>)
    }
}
