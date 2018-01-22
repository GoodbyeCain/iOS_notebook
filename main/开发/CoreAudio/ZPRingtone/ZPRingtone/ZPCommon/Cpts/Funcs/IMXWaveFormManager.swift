//
//  IMXWaveFormManager.swift
//  ZPRingtone
//
//  Created by zhoupan on 2017/12/5.
//  Copyright © 2017年 zhoupan. All rights reserved.
//

import Foundation
import UIKit

@objc class IMXWaveFormManager: NSObject{
    var waveform: FDWaveformView?
    
     override init() {
        super.init()
    }
    convenience init(waveFrame: CGRect,baseView: UIView,waveColor: UIColor,proColor: UIColor){
        self.init()
        waveform = FDWaveformView.init(frame: waveFrame)
        self.configWaveForm(waveColor: waveColor,proColor: proColor)
        baseView.addSubview(waveform!)
    }
    deinit {
        
    }
    
    func loadAudio(audio: URL?) {
        guard let audioURL = audio else { return  }
        waveform?.audioURL = audioURL
    }
    
}
//MARK: property
extension IMXWaveFormManager{
    func configWaveForm(waveColor: UIColor,proColor: UIColor) {
        waveform?.alpha = 0.0
        waveform?.doesAllowScrubbing = false
        waveform?.doesAllowStretch = false;
        waveform?.doesAllowScroll = false;
        waveform?.wavesColor = waveColor
        waveform?.progressColor = proColor
        waveform?.delegate = self
    }
    public var linerWave: Bool{
        get { return ((waveform?.waveformRenderType) != nil) }
        set {
            if newValue{
                waveform?.waveformType = .linear
            }else{
                waveform?.waveformType = .logarithmic
            }
            
        }
    }
    public var enableScrollWave: Bool{
        get { return (waveform?.doesAllowScroll)! }
        set {
            waveform?.doesAllowScroll = newValue
        }
    }
}

//MARK: animation
extension IMXWaveFormManager{
    func highlightWaveform(percent: Int) {
        guard percent*(self.waveform?.totalSamples)!/100 <= (self.waveform?.totalSamples)! else {
            return
        }
        UIView.animate(withDuration: 0.0, animations: {
            self.waveform?.highlightedSamples = 0 ..< percent*(self.waveform?.totalSamples)!/100
        })
    }
}

extension IMXWaveFormManager: FDWaveformViewDelegate {
    func waveformViewWillRender(_ waveformView: FDWaveformView) {
        waveformView.alpha = 0
    }
    
    func waveformViewDidRender(_ waveformView: FDWaveformView) {
        UIView.animate(withDuration: 0, animations: {() -> Void in
            waveformView.alpha = 1.0
        })
    }
    
    func waveformViewWillLoad(_ waveformView: FDWaveformView) {
    }
    
    func waveformViewDidLoad(_ waveformView: FDWaveformView) {

    }
}
