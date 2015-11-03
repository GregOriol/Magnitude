//
//  Magnitude.swift
//  Magnitude
//
//  Created by Idris Khenchil on 11/1/15.
//  Copyright © 2015 Idris Khenchil. All rights reserved.
//

import ScreenSaver
import Cocoa

public class Magnitude: ScreenSaverView {
    private var fontA: NSFont!
    private var fontB: NSFont!
    private var fontC: NSFont!

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
        var quoteAttributes: NSDictionary!
        var authorAttributes: NSDictionary!
        var timeAttributes: NSDictionary!
        
        if(isNight(hour)){
            //Set background as dark
            background = NSColor(red:0.01, green:0.01, blue:0, alpha:1)
            
            //Set text for dark mode
            quoteAttributes = [
                NSForegroundColorAttributeName: NSColor.whiteColor(),
                NSFontAttributeName: fontA,
            ]
            
            authorAttributes = [
                NSForegroundColorAttributeName: NSColor.whiteColor(),
                NSFontAttributeName: fontB,
            ]
            
            timeAttributes = [
                NSForegroundColorAttributeName: NSColor(red:1, green:0.24, blue:0.22, alpha:1),
                NSFontAttributeName: fontC
            ]
        }
        else{
            //Set background as light
            background = NSColor(red:1, green:1, blue:1, alpha:1)
            
            //Set text for light mode
            quoteAttributes = [
                NSForegroundColorAttributeName: NSColor.blackColor(),
                NSFontAttributeName: fontA,
            ]
            
            authorAttributes = [
                NSForegroundColorAttributeName: NSColor.blackColor(),
                NSFontAttributeName: fontB,
            ]
            
            timeAttributes = [
                NSForegroundColorAttributeName: NSColor(red:0.13, green:0.75, blue:0.99, alpha:1),
                NSFontAttributeName: fontC
            ]
        }
        
        background.setFill()
        NSBezierPath.fillRect(rect)
        
        let quote = "\"Great companies are built on great products.\"" as String
        let author = "-" + "Elon Musk"
        
        let attributes = [
            NSForegroundColorAttributeName: NSColor.blackColor()
        ]
        
        let quoteSize = quote.sizeWithAttributes(quoteAttributes as? [String: AnyObject])
        let authorSize = author.sizeWithAttributes(authorAttributes as? [String: AnyObject])
        
        var quoteRect: CGRect!
        
        //More lines
        if(quote.characters.count > 50){
            //Get ready for another line
            quoteRect = CGRect(
                x: round((bounds.width - quoteSize.width / 2) / 2),
                y: round((bounds.height - quoteSize.height) / 2) + quoteSize.height,
                width: quoteSize.width / 2,
                height: quoteSize.height * 2
            )
        }
        else{
            //All good as is
            quoteRect = CGRect(
                x: round((bounds.width - quoteSize.width) / 2),
                y: round((bounds.height - quoteSize.height) / 2),
                width: quoteSize.width,
                height: quoteSize.height
            )
        }
        
        let authorRect = CGRect(
            x: round((bounds.width - authorSize.width) / 2),
            y: round(((bounds.height - authorSize.height) / 2) - 40),
            width: authorSize.width,
            height: authorSize.height
        )
        
        //Draw text on canvas
        quote.drawInRect(quoteRect, withAttributes: quoteAttributes as? [String: AnyObject])
        author.drawInRect(authorRect, withAttributes: authorAttributes as? [String: AnyObject])
        
        
        //Add time label
        var time = NSDateFormatter.localizedStringFromDate(NSDate(), dateStyle: .NoStyle, timeStyle: .ShortStyle) as NSString
        
        let timeSize = time.sizeWithAttributes(timeAttributes as? [String: AnyObject])

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
        
        time.drawInRect(timeRect, withAttributes: timeAttributes as? [String: AnyObject])

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
        updateFont()
    }
    
    private func updateFont() {
        fontA = fontWithSizeA(bounds.size.width / 32)
        fontB = fontWithSizeB(bounds.size.width / 55)
        fontC = fontWithSizeC(bounds.size.width / 52)
    }
    
    private func fontWithSizeA(fontSize: CGFloat) -> NSFont {
        let fontA: NSFont
        if #available(OSX 10.11, *) {
            fontA = NSFont.systemFontOfSize(fontSize, weight: NSFontWeightThin)
        } else {
            fontA = NSFont(name: "HelveticaNeue-Thin", size: fontSize)!
        }
        
        let fontDescriptor = fontA.fontDescriptor.fontDescriptorByAddingAttributes([
            NSFontFeatureSettingsAttribute: [
                [
                    NSFontFeatureTypeIdentifierKey: kNumberSpacingType,
                    NSFontFeatureSelectorIdentifierKey: kMonospacedNumbersSelector
                ]
            ]
            ])
        return NSFont(descriptor: fontDescriptor, size: fontSize)!
    }
    
    private func fontWithSizeB(fontSize: CGFloat) -> NSFont {
        let fontB: NSFont
        if #available(OSX 10.11, *) {
            fontB = NSFont.systemFontOfSize(fontSize, weight: NSFontWeightUltraLight)
        } else {
            fontB = NSFont(name: "HelveticaNeue-Thin", size: fontSize)!
        }
        
        let fontDescriptor = fontB.fontDescriptor.fontDescriptorByAddingAttributes([
            NSFontFeatureSettingsAttribute: [
                [
                    NSFontFeatureTypeIdentifierKey: kNumberSpacingType,
                    NSFontFeatureSelectorIdentifierKey: kMonospacedNumbersSelector
                ]
            ]
            ])
        return NSFont(descriptor: fontDescriptor, size: fontSize)!
    }
    
    private func fontWithSizeC(fontSize: CGFloat) -> NSFont {
        let fontC: NSFont
        if #available(OSX 10.11, *) {
            fontC = NSFont.systemFontOfSize(fontSize, weight: NSFontWeightThin)
        } else {
            fontC = NSFont(name: "HelveticaNeue-Thin", size: fontSize)!
        }
        
        let fontDescriptor = fontC.fontDescriptor.fontDescriptorByAddingAttributes([
            NSFontFeatureSettingsAttribute: [
                [
                    NSFontFeatureTypeIdentifierKey: kNumberSpacingType,
                    NSFontFeatureSelectorIdentifierKey: kMonospacedNumbersSelector
                ]
            ]
            ])
        return NSFont(descriptor: fontDescriptor, size: fontSize)!
    }

    
}
