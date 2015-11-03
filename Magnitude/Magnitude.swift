//
//  Magnitude.swift
//  Magnitude
//
//  Created by Idris Khenchil on 11/1/15.
//  Copyright © 2015 Idris Khenchil. All rights reserved.
//

import ScreenSaver

public class Magnitude: ScreenSaverView {
    
    func isNight(time: Int) -> Bool{
        if(time >= 6 && time < 22){
            //Is day
            return false
        }
        else{
            //Is night
            return true
        }
    }
    
    public override func drawRect(rect: NSRect) {
        let timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("getTime"), userInfo: nil, repeats: true)

        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Hour, .Minute], fromDate: date)
        let hour = components.hour
        
        var background:NSColor
        
        if(isNight(hour)){
            //Set background as dark
            background = NSColor(red:0.01, green:0.01, blue:0, alpha:1)
        }
        else{
            //Set background as light
            background = NSColor(red:1, green:1, blue:1, alpha:1)
        }
        
        background.setFill()
        NSBezierPath.fillRect(rect)
        
        let quote = "Great companies are built on great products." as NSString
        let author = "Elon Musk"
        
        let attributes = [
            NSForegroundColorAttributeName: NSColor.blackColor()
        ]
        
        let quoteSize = quote.sizeWithAttributes(attributes)
        let authorSize = author.sizeWithAttributes(attributes)
        
        let authorRect = CGRect(
            x: round((bounds.width - authorSize.width) / 2),
            y: round(((bounds.height - authorSize.height) / 2) - 20),
            width: authorSize.width,
            height: authorSize.height
        )
        
        let quoteRect = CGRect(
            x: round((bounds.width - quoteSize.width) / 2),
            y: round((bounds.height - quoteSize.height) / 2),
            width: quoteSize.width,
            height: quoteSize.height
        )
        
        //Draw text on canvas
        quote.drawInRect(quoteRect, withAttributes: attributes)
        author.drawInRect(authorRect, withAttributes: attributes)
        
        
        //Add time label
        var time = NSDateFormatter.localizedStringFromDate(NSDate(), dateStyle: .NoStyle, timeStyle: .ShortStyle) as NSString
        
        let timeAttributes = [
            NSForegroundColorAttributeName: NSColor.blackColor()
        ]
        
        let timeSize = time.sizeWithAttributes(timeAttributes)

        let timeRect = CGRect(
            x: round((bounds.width - timeSize.width) / 2),
            y: 15,
            width: timeSize.width,
            height: timeSize.height
        )
        
        
        func getTime() {
            let date = NSDate()
            let outputFormat = NSDateFormatter()
            outputFormat.locale = NSLocale(localeIdentifier:"en_US")
            outputFormat.dateFormat = "HH:mm:ss"
            time = String(outputFormat.stringFromDate(date))
        }
        
        time.drawInRect(timeRect, withAttributes: timeAttributes)

    }
    
    public override init?(frame: NSRect, isPreview: Bool) {
        super.init(frame: frame, isPreview: isPreview)
        initialize()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }
    
    /// The screen saver engine calls this whnever it wants to display a new frame.
    public override func animateOneFrame() {
        setNeedsDisplayInRect(bounds)
    }
    
    private func initialize() {
        // Set to 15fps
        animationTimeInterval = 1.0 / 4.0
    }
}
