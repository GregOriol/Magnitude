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
    struct Core {
        static var quote:NSString?
        static var author:NSString?
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
    
        var quoteDict = [
            [
                "quote": "Wrinkles should merely indicate where smiles have been.",
                "author": "Mark Twain"
            ],
            [
                "quote": "All diseases run into one, old age.",
                "author": "Ralph Waldo Emerson"
            ],
            [
                "quote": "Every man over forty is a scoundrel.",
                "author": "George Bernard Shaw"
            ],
            [
                "quote": "Age is a very high price to pay for maturity.",
                "author": "Tom Stoppard"
            ],
            [
                "quote": "Old age is no place for sissies.",
                "author": "Bette Davis"
            ],
            [
                "quote": "It takes a long time to become young.",
                "author": "Pablo Picasso"
            ],
            [
                "quote": "After thirty, a body has a mind of its own.",
                "author": "Bette Midler"
            ],
            [
                "quote": "Forty is the old age of youth, fifty is the youth of old age.",
                "author": "Hosea Ballou"
            ],
            [
                "quote": "Old age is fifteen years older than I am.",
                "author": "Oliver Wendell Holmes"
            ],
            [
                "quote": "It is sad to grow old but nice to ripen.",
                "author": "Brigitte Bardot"
            ],
            [
                "quote": "Age is how we determine how valuable you are.",
                "author": "Jane Elliot"
            ],
            [
                "quote": "Aging seems to be the only available way to live a long life.",
                "author": "Kitty O'Neill Collins"
            ],
            [
                "quote": "Old age is a shipwreck.",
                "author": "Charles de Gaulle"
            ],
            [
                "quote": "Peace is the one condition of survival in this nuclear age.",
                "author": "Adlai E. Stevenson"
            ],
            [
                "quote": "I wish I'd gotten sober at a younger age.",
                "author": "Janice Dickinson"
            ],
            [
                "quote": "Nothing amazes me anymore.",
                "author": "David Beckham"
            ],
            [
                "quote": "Amazement awaits us at every corner.",
                "author": "James Broughton"
            ],
            [
                "quote": "Your best teacher is your last mistake.",
                "author": "Ralph Nader"
            ],
            [
                "quote": "Imagination creates reality.",
                "author": "Richard Wagner"
            ],
            [
                "quote": "I just can't wait for the future.",
                "author": "Amanda Seyfried"
            ],
            [
                "quote": "My life is my message.",
                "author": "Mahatma Gandhi"
            ],
            [
                "quote": "Grief is the price we pay for love.",
                "author": "Queen Elizabeth II"
            ],
            [
                "quote": "Fear is the mother of foresight.",
                "author": "Thomas Hardy"
            ],
            [
                "quote": "Half a truth is better than no politics.",
                "author": "Gilbert K. Chesterton"
            ],
            [
                "quote": "Of all the home remedies, a good wife is best.",
                "author": "Kin Hubbard"
            ],
            [
                "quote": "Miracles do not, in fact, break the laws of nature.",
                "author": "C. S. Lewis"
            ],
            [
                "quote": "Knowledge comes, but wisdom lingers.",
                "author": "Alfred Lord Tennyson"
            ],
            [
                "quote": "My buildings are more famous than me.",
                "author": "Jean Nouvel"
            ],
            [
                "quote": "We are selling dreams. We are merchants of happiness.",
                "author": "Bernard Loiseau"
            ],
            [
                "quote": "I get all fired up about aging in America.",
                "author": "Willard Scott"
            ],
            [
                "quote": "For me, habit is just a synonym for death.",
                "author": "Juliette Binoche"
            ],
            [
                "quote": "I'm a food addict, that's my downfall.",
                "author": "Valerie Bertinelli"
            ],
            [
                "quote": "Real riches are the riches possessed inside.",
                "author": "B. C. Forbes"
            ],
            [
                "quote": "Argument is meant to reveal the truth, not to create it.",
                "author": "Edward de Bono"
            ],
            [
                "quote": "To be proud of learning is the greatest ignorance.",
                "author": "Jeremy Taylor"
            ],
            [
                "quote": "When women go wrong, men go right after them.",
                "author": "Mae West"
            ],
            [
                "quote": "Let us live for the beauty of our own reality.",
                "author": "Charles Lamb"
            ],
            [
                "quote": "Art may imitate life, but life imitates TV.",
                "author": "Ani DiFranco"
            ],
            [
                "quote": "Some music really does suck!",
                "author": "Henry Rollins"
            ],
            [
                "quote": "Fear doesn't exist anywhere except in the mind.",
                "author": "Dale Carnegie"
            ],
            [
                "quote": "If you want a quality, act as if you already had it.",
                "author": "William James"
            ],
            [
                "quote": "No matter how you travel, it's still you going.",
                "author": "Jeff Goldblum"
            ],
            [
                "quote": "Have no fear of perfection - you'll never reach it.",
                "author": "Salvador Dali"
            ],
            [
                "quote": "I'm extraordinarily patient provided I get my own way in the end.",
                "author": "Margaret Thatcher"
            ],
            [
                "quote": "Politics disgusts me.",
                "author": "Brigitte Bardot"
            ],
            [
                "quote": "Movies are very subjective.",
                "author": "Jeff Bridges"
            ],
            [
                "quote": "But, you know, you can't be a star at home.",
                "author": "Jim Carrey"
            ],
            [
                "quote": "My hope still is to leave the world a bit better than when I got here.",
                "author": "Jim Henson"
            ],
            [
                "quote": "A great artist is always before his time or behind it.",
                "author": "George Edward Moore"
            ],
            [
                "quote": "In politics, there are no friends.",
                "author": "Marian Wright Edelman"
            ],
            [
                "quote": "The best director is the one you don't see.",
                "author": "Billy Wilder"
            ],
            [
                "quote": "Only the elites despise earning money.",
                "author": "Newt Gingrich"
            ],
            [
                "quote": "Failure is not fatal victory is not success.",
                "author": "Tony Richardson"
            ],
            [
                "quote": "The less routine the more life.",
                "author": "Amos Bronson Alcott"
            ],
            [
                "quote": "Do not blame anybody for your mistakes and failures.",
                "author": "Bernard Baruch"
            ],
            [
                "quote": "Never separate the life you live from the words you speak.",
                "author": "Paul Wellstone"
            ],
            [
                "quote": "Strength and wisdom are not opposing values.",
                "author": "William J. Clinton"
            ],
            [
                "quote": "One must not trifle with love.",
                "author": "Alfred de Musset"
            ],
            [
                "quote": "Form follows beauty.",
                "author": "Oscar Niemeyer"
            ],
            [
                "quote": "The art of being wise is the art of knowing what to overlook.",
                "author": "William James"
            ],
            [
                "quote": "All real education is the architecture of the soul.",
                "author": "William Bennett"
            ],
            [
                "quote": "You change your life by changing your heart.",
                "author": "Max Lucado"
            ],
            [
                "quote": "To tell the truth is revolutionary.",
                "author": "Antonio Gramsci"
            ],
            [
                "quote": "War is over if you want it.",
                "author": "Yoko Ono"
            ],
            [
                "quote": "Chaos often breeds life, when order breeds habit.",
                "author": "Henry Adams"
            ],
            [
                "quote": "I don't follow the food trends.",
                "author": "Eric Ripert"
            ],
            [
                "quote": "Courage is always rewarded.",
                "author": "Kenny Loggins"
            ],
            [
                "quote": "Victims always feel alone and helpless.",
                "author": "Deepak Chopra"
            ],
            [
                "quote": "Things start out as hopes and end up as habits.",
                "author": "Lillian Hellman"
            ],
            [
                "quote": "Fear may come true that which one is afraid of.",
                "author": "Viktor E. Frankl"
            ],
            [
                "quote": "Leaders must invoke an alchemy of great vision.",
                "author": "Henry A. Kissinger"
            ],
            [
                "quote": "As soon as there is life there is danger.",
                "author": "Ralph Waldo Emerson"
            ],
            [
                "quote": "War settles nothing.",
                "author": "Dwight D. Eisenhower"
            ],
            [
                "quote": "In youth and beauty, wisdom is but rare!",
                "author": "Homer"
            ],
            [
                "quote": "I want to age with some dignity.",
                "author": "Pete Townshend"
            ],
            [
                "quote": "Failure too is a form of death.",
                "author": "Graham Greene"
            ],
            [
                "quote": "True love stories never have endings.",
                "author": "Richard Bach"
            ],
            [
                "quote": "The more you sweat in peace, the less you bleed in war.",
                "author": "Norman Schwarzkopf"
            ],
            [
                "quote": "I believe that stress is a factor in any bad health.",
                "author": "Christopher Shays"
            ],
            [
                "quote": "Only the wisest and stupidest of men never change.",
                "author": "Confucius"
            ],
            [
                "quote": "I love technology.",
                "author": "William Shatner"
            ],
            [
                "quote": "I've always been at war with myself, for right or wrong.",
                "author": "Brad Pitt"
            ],
            [
                "quote": "Life is precious and there's not a lot of room for anger.",
                "author": "Fran Drescher"
            ],
            [
                "quote": "Men must know their limitations.",
                "author": "Clint Eastwood"
            ],
            [
                "quote": "I'm working myself to death.",
                "author": "Alan Ladd"
            ],
            [
                "quote": "You must change in order to survive.",
                "author": "Pearl Bailey"
            ],
            [
                "quote": "A pint of sweat, saves a gallon of blood.",
                "author": "George S. Patton"
            ],
            [
                "quote": "The only way to enjoy anything in this life is to earn it first.",
                "author": "Ginger Rogers"
            ],
            [
                "quote": "To conquer fear is the beginning of wisdom.",
                "author": "Bertrand Russell"
            ],
            [
                "quote": "I always tell people that our sports aren't that dangerous.",
                "author": "Shaun White"
            ],
            [
                "quote": "The desire to write grows with writing.",
                "author": "Desiderius Erasmus"
            ],
            [
                "quote": "Knowledge becomes evil if the aim be not virtuous.",
                "author": "Plato"
            ],
            [
                "quote": "Only the gentle are ever really strong.",
                "author": "James Dean"
            ],
            [
                "quote": "Beauty is in the eye of the beer holder.",
                "author": "Kinky Friedman"
            ],
            [
                "quote": "It's all positive energy from me, man.",
                "author": "Swizz Beatz"
            ],
            [
                "quote": "Expectancy is the atmosphere for miracles.",
                "author": "Edwin Louis Cole"
            ],
            [
                "quote": "Today knowledge has power. It controls access to opportunity and advancement.",
                "author": "Peter Drucker"
            ],
            [
                "quote": "That which is so universal as death must be a benefit.",
                "author": "Friedrich Schiller"
            ],
            [
                "quote": "Chinese people themselves, they really want change.",
                "author": "Dalai Lama"
            ],
            [
                "quote": "We will not have peace by afterthought.",
                "author": "Norman Cousins"
            ],
            
            
            
            
            
            //200
            
            
            
            
            [
                "quote": "Education is the cheap defense of nations.",
                "author": "Edmund Burke"
            ],
            [
                "quote": "What I've learned is you treat women right.",
                "author": "Tyler Perry"
            ],
            [
                "quote": "It's a good thing we don't get all the government we pay for.",
                "author": "Will Rogers"
            ],
            [
                "quote": "I must govern the clock, not be governed by it.",
                "author": "Golda Meir"
            ],
            [
                "quote": "Resolve and thou art free.",
                "author": "Henry Wadsworth Longfellow"
            ],
            [
                "quote": "The truth doesn't hurt unless it ought to.",
                "author": "B. C. Forbes"
            ],
            [
                "quote": "Life begins at the end of your comfort zone.",
                "author": "Neale Donald Walsch"
            ],
            [
                "quote": "Sometimes the truth hurts. And sometimes it feels real good.",
                "author": "Henry Rollins"
            ],
            [
                "quote": "I loved education, and, yes, I did want to go on learning.",
                "author": "Arthur Hailey"
            ],
            [
                "quote": "The greatest mistake you can make in life is continually fearing that you'll make one.",
                "author": "Elbert Hubbard"
            ],
            [
                "quote": "We live under a government of men and morning newspapers.",
                "author": "Wendell Phillips"
            ],
            [
                "quote": "We aren't cool and never will be.",
                "author": "Chris Martin"
            ],
            [
                "quote": "Happiness seems made to be shared.",
                "author": "Pierre Corneille"
            ],
            [
                "quote": "One must not trifle with love.",
                "author": "Alfred de Musset"
            ],
            [
                "quote": "Forget the past.",
                "author": "Nelson Mandela"
            ],
            [
                "quote": "My home has always been show business.",
                "author": "Sammy Davis, Jr."
            ],
            [
                "quote": "That which does not kill us makes us stronger.",
                "author": "Friedrich Nietzsche"
            ],
            [
                "quote": "Let there be work, bread, water and salt for all.",
                "author": "Nelson Mandela"
            ],
            [
                "quote": "You help me, I'll help you. That's politics.",
                "author": "Terry McAuliffe"
            ],
            [
                "quote": "Fear is exciting for me.",
                "author": "Ayrton Senna"
            ],
            [
                "quote": "Love is a friendship set to music.",
                "author": "Joseph Campbell"
            ],
            [
                "quote": "Rules and models destroy genius and art.",
                "author": "William Hazlitt"
            ],
            [
                "quote": "Parenting is an impossible job at any age.",
                "author": "Harrison Ford"
            ],
            [
                "quote": "Excessive sorrow laughs. Excessive joy weeps.",
                "author": "William Blake"
            ],
            [
                "quote": "Anger is a transient hatred or at least very like it.",
                "author": "Robert South"
            ],
            [
                "quote": "Hope is a waking dream.",
                "author": "Aristotle"
            ],
            [
                "quote": "Satire doesn't effect change.",
                "author": "P. J. O'Rourke"
            ],
            [
                "quote": "Every man over forty is a scoundrel.",
                "author": "George Bernard Shaw"
            ],
            [
                "quote": "Age considers youth ventures.",
                "author": "Rabindranath Tagore"
            ],
            [
                "quote": "Old age is no place for sissies.",
                "author": "Bette Davis"
            ],
            [
                "quote": "It takes a long time to become young.",
                "author": "Pablo Picasso"
            ],
            [
                "quote": "After thirty, a body has a mind of its own.",
                "author": "Bette Midler"
            ],
            [
                "quote": "Old age is fifteen years older than I am.",
                "author": "Oliver Wendell Holmes"
            ],
            [
                "quote": "The trick is growing up without growing old.",
                "author": "Casey Stengel"
            ],
            [
                "quote": "I'm happy to report that my inner child is still ageless.",
                "author": "James Broughton"
            ],
            [
                "quote": "Youth is the best time to be rich, and the best time to be poor.",
                "author": "Euripides"
            ],
            [
                "quote": "It is sad to grow old but nice to ripen.",
                "author": "Brigitte Bardot"
            ],
            [
                "quote": "Age is how we determine how valuable you are.",
                "author": "Jane Elliot"
            ],
            [
                "quote": "Middle age is when your age starts to show around your middle.",
                "author": "Bob Hope"
            ],
            [
                "quote": "Aging seems to be the only available way to live a long life.",
                "author": "Kitty O'Neill Collins"
            ],
            [
                "quote": "Old age is a shipwreck.",
                "author": "Charles de Gaulle"
            ],
            [
                "quote": "I'm not afraid of aging.",
                "author": "Shelley Duvall"
            ],
            [
                "quote": "He's as cool as a prized marrow!",
                "author": "Sid Waddell"
            ],
            [
                "quote": "Luck is the residue of design.",
                "author": "Branch Rickey"
            ],
            [
                "quote": "Hope springs eternal, even in politics.",
                "author": "Gwen Ifill"
            ],
            [
                "quote": "I'm really a romantic at heart.",
                "author": "Christopher Atkins"
            ],
            [
                "quote": "To conquer fear is the beginning of wisdom.",
                "author": "Bertrand Russell"
            ],
            [
                "quote": "I do some of my best thinking while pulling weeds.",
                "author": "Martha Smith"
            ],
            [
                "quote": "True love stories never have endings.",
                "author": "Richard Bach"
            ],
            [
                "quote": "Light is the symbol of truth.",
                "author": "James Russell Lowell"
            ],
            [
                "quote": "It is legal because I wish it.",
                "author": "Louis XIV"
            ],
            [
                "quote": "Health is the core of human development.",
                "author": "Gro Harlem Brundtland"
            ],
            [
                "quote": "War is war. The only good human being is a dead one.",
                "author": "George Orwell"
            ],
            [
                "quote": "There is a fear of emotion in tennis.",
                "author": "Andy Murray"
            ],
            [
                "quote": "Rock music is niche.",
                "author": "Bono"
            ],
            [
                "quote": "Food is not your best friend or enemy.",
                "author": "Bethenny Frankel"
            ],
            [
                "quote": "But men are men the best sometimes forget.",
                "author": "William Shakespeare"
            ],
            [
                "quote": "Fine art is knowledge made visible.",
                "author": "Gustave Courbet"
            ],
            [
                "quote": "The awareness of our own strength makes us modest.",
                "author": "Paul Cezanne"
            ],
            [
                "quote": "Truth is always served by great minds, even if they fight it.",
                "author": "Jean Rostand"
            ],
            [
                "quote": "An investment in knowledge pays the best interest.",
                "author": "Benjamin Franklin"
            ],
            [
                "quote": "I'm not into business at all.",
                "author": "Freddie Mercury"
            ],
            [
                "quote": "Advertising is legalized lying.",
                "author": "H. G. Wells"
            ],
            [
                "quote": "Design is an unknown.",
                "author": "Geoffrey Beene"
            ],
            [
                "quote": "The only way to have a friend is to be one.",
                "author": "Ralph Waldo Emerson"
            ],
            [
                "quote": "A woman's health is her capital.",
                "author": "Harriet Beecher Stowe"
            ],
            [
                "quote": "Facts are to the mind what food is to the body.",
                "author": "Edmund Burke"
            ],
            [
                "quote": "We have, I fear, confused power with greatness.",
                "author": "Stewart Udall"
            ],
            [
                "quote": "I actually don't feel famous.",
                "author": "Anwar Robinson"
            ],
            [
                "quote": "The energy of the mind is the essence of life.",
                "author": "Aristotle"
            ],
            [
                "quote": "Life's a fight. It's a good fight of faith.",
                "author": "Joel Osteen"
            ],
            [
                "quote": "Never complain and never explain.",
                "author": "Benjamin Disraeli"
            ],
            [
                "quote": "It is better to travel well than to arrive.",
                "author": "Buddha"
            ],
            [
                "quote": "Be happy. It's one way of being wise.",
                "author": "Sidonie Gabrielle Colette"
            ],
            [
                "quote": "Time is money.",
                "author": "Benjamin Franklin"
            ],
            [
                "quote": "The days you work are the best days.",
                "author": "Georgia O'Keeffe"
            ],
            [
                "quote": "The quarrels of lovers are the renewal of love.",
                "author": "Jean Racine"
            ],
            
            //300
            
            
            [
                "quote": "I write music with an exclamation point!",
                "author": "Norman Schwarzkopf"
            ],
            [
                "quote": "Richard Wagner",
                "author": "Christopher Shays"
            ],
            [
                "quote": "Less is more.",
                "author": "Ludwig Mies van der Rohe"
            ],
            [
                "quote": "So vast is art, so narrow human wit.",
                "author": "Alexander Pope"
            ],
            [
                "quote": "Whatever is done for love always occurs beyond good and evil.",
                "author": "Friedrich Nietzsche"
            ],
            [
                "quote": "I don't read other science fiction. I don't read any at all.",
                "author": "Jack Vance"
            ],
            [
                "quote": "Don't be afraid to give up the good to go for the great.",
                "author": "John D. Rockefeller"
            ],
            [
                "quote": "The human race is governed by its imagination.",
                "author": "Napoleon Bonaparte"
            ],
            [
                "quote": "I won't predict anything historic. But nothing is impossible.",
                "author": "Michael Phelps"
            ],
            [
                "quote": "Nothing is work unless you'd rather be doing something else.",
                "author": "George Halas"
            ],
            [
                "quote": "I'm very much afraid of being mad - that's my one fear.",
                "author": "Sting"
            ],
            [
                "quote": "Beauty in distress is much the most affecting beauty.",
                "author": "Edmund Burke"
            ],
            [
                "quote": "One touch of nature makes the whole world kin.",
                "author": "William Shakespeare"
            ],
            [
                "quote": "A library implies an act of faith.",
                "author": "Victor Hugo"
            ],
            [
                "quote": "To understand is to forgive, even oneself.",
                "author": "Alexander Chase"
            ],
            [
                "quote": "It looks like the future's really bright.",
                "author": "Michael P. Anderson"
            ],
            [
                "quote": "I'm not afraid of aging.",
                "author": "Shelley Duvall"
            ],
            [
                "quote": "When I get into bed at night, I hope I don't get into it alone!",
                "author": "Calvin Klein"
            ],
            [
                "quote": "Sometimes you're famous before you're good.",
                "author": "Maggie Q"
            ],
            [
                "quote": "Everybody has a gun in their car in Detroit.",
                "author": "Jim Harrison"
            ],
            [
                "quote": "Olympics for me is love, peace, united.",
                "author": "Jackie Chan"
            ],
            [
                "quote": "Greed, like the love of comfort, is a kind of fear.",
                "author": "Cyril Connolly"
            ],
            [
                "quote": "There are no shortcuts in evolution.",
                "author": "Louis D. Brandeis"
            ],
            
            //300
            
            
        ]
        
        //Update every 24 hours
        let quoteTimer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("updateQuote"), userInfo: nil, repeats: true)
    
        if(!NSUserDefaults.standardUserDefaults().boolForKey("firstlaunch1.0")){
            //Put any code here and it will be executed only once.
            Core.quote = "First"
            Core.author = "First"
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "firstlaunch1.0")
            NSUserDefaults.standardUserDefaults().synchronize();
        }
        
        //Update quote every 10 seconds
        let number = Int(arc4random_uniform(100-0) + 0)
        Core.quote = String(quoteDict[number]["quote"]!)
        Core.author = "-" + String(quoteDict[number]["author"]!)
        
        
        
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
    

        let quoteCount = Core.quote as! String
        
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
        animationTimeInterval = 2.5
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
