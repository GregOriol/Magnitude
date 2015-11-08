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
    
    //Set default quote
    struct Core {
        static var quote:NSString! = "\"Failure is an option here. If things are not failing, you are not innovating enough.\""
        static var author:NSString! = "-Elon Musk"
    }
    
    func getJSON(urlToRequest: String) -> NSData{
        return NSData(contentsOfURL: NSURL(string: urlToRequest)!)!
    }
    
    func parseJSON(inputData: NSData) -> NSDictionary? {
        do {
            if let feed = try NSJSONSerialization.JSONObjectWithData(inputData, options: .MutableContainers) as? NSDictionary {
                // Success block...
                return feed
            }
        }
        catch {
            //return(error)
        }
        return nil
    }
    
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
        
        var background:NSColor
        var quoteAttributes: NSDictionary!
        var authorAttributes: NSDictionary!
        var timeAttributes: NSDictionary!
        
        var todaysAuthor:AnyObject
        var todaysQuote:AnyObject
        
        let date = NSDate()
        let timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("getTime"), userInfo: nil, repeats: true)

        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.Center
        
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Hour, .Minute], fromDate: date)
        let hour = components.hour
        
        if(isNight(hour)){
            //Set background as dark
            background = NSColor(red:0.01, green:0.01, blue:0, alpha:1)
            
            //Set text for dark mode
            quoteAttributes = [
                NSForegroundColorAttributeName: NSColor.whiteColor(),
                NSFontAttributeName: fontA,
                NSParagraphStyleAttributeName: paragraphStyle
            ]
            
            authorAttributes = [
                NSForegroundColorAttributeName: NSColor.whiteColor(),
                NSFontAttributeName: fontB,
                NSParagraphStyleAttributeName: paragraphStyle
            ]
            
            timeAttributes = [
                NSForegroundColorAttributeName: NSColor(red:1, green:0.24, blue:0.22, alpha:1),
                NSFontAttributeName: fontC,
                NSParagraphStyleAttributeName: paragraphStyle
            ]
        }
        else{
            //Set background as light
            background = NSColor(red:1, green:1, blue:1, alpha:1)
            
            //Set text for light mode
            quoteAttributes = [
                NSForegroundColorAttributeName: NSColor.blackColor(),
                NSFontAttributeName: fontA,
                NSParagraphStyleAttributeName: paragraphStyle
            ]
            
            authorAttributes = [
                NSForegroundColorAttributeName: NSColor.blackColor(),
                NSFontAttributeName: fontB,
                NSParagraphStyleAttributeName: paragraphStyle
            ]
            
            timeAttributes = [
                NSForegroundColorAttributeName: NSColor(red:0.13, green:0.75, blue:0.99, alpha:1),
                NSFontAttributeName: fontC,
                NSParagraphStyleAttributeName: paragraphStyle
            ]
        }
        
        background.setFill()
        NSBezierPath.fillRect(rect)

        
        let attributes = [
            NSForegroundColorAttributeName: NSColor.blackColor()
        ]
        
        let quoteSize = Core.quote!.sizeWithAttributes(quoteAttributes as? [String: AnyObject])
        let authorSize = Core.author!.sizeWithAttributes(authorAttributes as? [String: AnyObject])
        
        var quoteRect: CGRect!
        var authorRect: CGRect!
    

        let quoteCount = Core.quote as String
        
        //More lines
        if(quoteCount.characters.count > 100){
            //Get ready for another line
            quoteRect = CGRect(
                x: round((bounds.width - quoteSize.width / 2.20) / 2),
                y: round((bounds.height - quoteSize.height) / 2) - (quoteSize.height / 2),
                width: quoteSize.width / 2.20,
                height: quoteSize.height * 3
            )
            
            //Adjust author to fit
            authorRect = CGRect(
                x: round((bounds.width - authorSize.width) / 2),
                y: round(((bounds.height - quoteSize.height) / 2) - (quoteSize.height + (authorSize.height / 2))),
                width: authorSize.width,
                height: authorSize.height
            )

        }
            
        else if(quoteCount.characters.count > 50){
            //Get ready for another line
            quoteRect = CGRect(
                x: round((bounds.width - quoteSize.width / 1.20) / 2),
                y: round((bounds.height - quoteSize.height) / 2) - (quoteSize.height / 2),
                width: quoteSize.width / 1.20,
                height: quoteSize.height * 2
            )
            
            //Adjust author to fit
            authorRect = CGRect(
                x: round((bounds.width - authorSize.width) / 2),
                y: round(((bounds.height - quoteSize.height) / 2) - (quoteSize.height + (authorSize.height / 2))),
                width: authorSize.width,
                height: authorSize.height
            )
        }
        else{
            //All good as is
            quoteRect = CGRect(
                x: round((bounds.width - quoteSize.width) / 2),
                y: round((bounds.height - quoteSize.height) / 1.75) - (quoteSize.height / 2),
                width: quoteSize.width,
                height: quoteSize.height
            )
            
            //Adjust author to fit
            authorRect = CGRect(
                x: round((bounds.width - authorSize.width) / 2),
                y: round(((bounds.height - quoteSize.height) / 1.75) - (quoteSize.height + (authorSize.height / 2))),
                width: authorSize.width,
                height: authorSize.height
            )
        }
        
        //Draw text on canvas
        Core.quote!.drawInRect(quoteRect, withAttributes: quoteAttributes as? [String: AnyObject])
        Core.author!.drawInRect(authorRect, withAttributes: authorAttributes as? [String: AnyObject])
        
        
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

        //NSCursor.hide()
    }
    
    //Called once
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
        animationTimeInterval = 0.15
        updateFont()
    }
    
    public override func startAnimation() {
        //let quoteTimer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("update"), userInfo: nil, repeats: true)
        
        let returnedJSON = parseJSON(getJSON("http://10.0.0.4/quote"))
        //print(returnedJSON!["data"]![3])
        
        func update(){
            //Update quote every 10 seconds
            let number = Int(arc4random_uniform(300-0) + 0)
            Core.quote = returnedJSON!["data"]![number]!["quote"]! as! NSString
            Core.author = returnedJSON!["data"]![number]!["author"]! as! NSString
            //initialize()
        }
        
        update()
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
