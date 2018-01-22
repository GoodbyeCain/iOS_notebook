//
//  IMXAudioClipManager.swift
//  ZPRingtone
//
//  Created by zhoupan on 2017/12/9.
//  Copyright © 2017年 zhoupan. All rights reserved.
//

import Foundation
import AudioKit

public typealias AsyncRetCallback = (AKAudioFile?, NSError?) -> Swift.Void

@objc class IMXAudioClipManager: NSObject{
    var audiofile: AKAudioFile?
    var retCallback: AsyncRetCallback?
    
    override init() {
        super.init()
    }
    deinit {
    }
    func imxconvertFile(file: NSURL?,tofileName: String,retblock:@escaping AsyncRetCallback)  {
        guard let audioFileURL = file else { return  }
        do{
            audiofile = try AKAudioFile(forReading: audioFileURL as URL)
            retCallback = retblock
            
            audiofile?.exportAsynchronously(name: tofileName, baseDir: .documents, exportFormat: .m4a, fromSample: Int64(5*(audiofile?.sampleRate)!), toSample: Int64(30*(audiofile?.sampleRate)!), callback: callback)
            
        }catch{
            print(error)
        }
    }
    func callback(processedFile: AKAudioFile?, error: NSError?){
        print("Export completed!")
        // Check if processed file is valid (different from nil)
        if let converted = processedFile {
            print("Export succeeded, converted file: \(converted.directoryPath)")
            // Print the exported file's duration
            print("Exported File Duration: \(converted.duration) seconds")
            if((retCallback) != nil){
                retCallback!(processedFile,nil)
            }
        } else {
            // An error occured. So, print the Error
            print("Error: \(error?.localizedDescription ?? "")")
            retCallback!(nil,error)
        }
    }
}
