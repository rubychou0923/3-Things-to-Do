//
//  ComplicationController.swift
//  Hello Watch WatchKit Extension
//
//  Created by RubyChou on 2023/5/20.
//

import ClockKit
import WatchConnectivity
import os

class ComplicationController: NSObject, CLKComplicationDataSource {
    static var count = 0
    lazy var data = Counter.share
    
    let logger = Logger(subsystem:
                            "com.example.apple-samplecode.Coffee-Tracker.watchkitapp.watchkitextension.complicationcontroller",
                        category: "Complication")
    
    // MARK: - Complication Configuration

    func getComplicationDescriptors(handler: @escaping ([CLKComplicationDescriptor]) -> Void) {
        let descriptors = [
            CLKComplicationDescriptor(identifier: "complication", displayName: "保守自己的心", supportedFamilies: CLKComplicationFamily.allCases)
  
            // Multiple complication support can be added here with more descriptors
        ]
        
        // Call the handler with the currently supported complication descriptors
        handler(descriptors)
    }
    
    func handleSharedComplicationDescriptors(_ complicationDescriptors: [CLKComplicationDescriptor]) {
        // Do any necessary work to support these newly shared complication descriptors
    }

    // MARK: - Timeline Configuration
    
    func getTimelineEndDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
        // Call the handler with the last entry date you can currently provide or nil if you can't support future timelines
        
        logger.debug("-----> getTimelineEndDate <-----")
        //handler(Date(timeIntervalSinceNow: (10)))
        
        handler(nil)
    }
    
    func getPrivacyBehavior(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationPrivacyBehavior) -> Void) {
        // Call the handler with your desired behavior when the device is locked
        handler(.showOnLockScreen)
    }

    // MARK: - Timeline Population
    
    func getCurrentTimelineEntry(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimelineEntry?) -> Void) {
        //let userDefault = UserDefaults()
        
        
        ComplicationController.count=ComplicationController.count+1
        // Call the handler with the current timeline entry

        logger.debug("-----> getCurrentTimelineEntry <----")
       // print(Counter.share.Todo1)
       //  print(Counter.share.Todo2)
       // print(Counter.share.Todo3)
        var todos:[String] = [Counter.share.Todo1,Counter.share.Todo2,Counter.share.Todo3,Counter.share.Todo4,Counter.share.Todo5]
        var todos_hidden:[Bool] = [Counter.share.isTodo1Hidden,
                                   Counter.share.isTodo2Hidden,
                                   Counter.share.isTodo3Hidden,
                                   Counter.share.isTodo4Hidden,
                                   Counter.share.isTodo5Hidden,]
        var todos_display:[String] = []
        var count: Int = 0
        var index: Int = 0

        
        for todo in todos{
            print(todos[index])
            if todos_hidden[index] {
                index = index+1
                continue
            }
            todos_display.append(todo)
            count = count+1
            index = index+1
            
        }
    
    
        index=5-count
        print(String(count))
        print(String(index))
        
        if(index>0){
            for _i in 0 ... index-1 {
                todos_display.append("")
            }
        }
            
        switch complication.family {
        case .graphicCorner:
            let template = CLKComplicationTemplateGraphicCornerStackText(
                innerTextProvider: CLKSimpleTextProvider(text:todos_display[1]),
                outerTextProvider: CLKSimpleTextProvider(text:todos_display[0]))
            handler(CLKComplicationTimelineEntry(date: Date(), complicationTemplate: template))
        case .circularSmall:
            let template = CLKComplicationTemplateGraphicCircularStackText(line1TextProvider: CLKSimpleTextProvider(text: "靠主!"), line2TextProvider: CLKSimpleTextProvider(text: "堅持！"))
            handler(CLKComplicationTimelineEntry(date: Date(), complicationTemplate: template))
        case .graphicCircular:
            let template = CLKComplicationTemplateGraphicCircularStackText(line1TextProvider: CLKSimpleTextProvider(text: Counter.share.Todo2), line2TextProvider: CLKSimpleTextProvider(text: Counter.share.Todo1))
            handler(CLKComplicationTimelineEntry(date: Date(), complicationTemplate: template))
        case .graphicBezel:
            let templateInner =     CLKComplicationTemplateGraphicCircularStackText(line1TextProvider: CLKSimpleTextProvider(text: Counter.share.Todo1), line2TextProvider: CLKSimpleTextProvider(text: Counter.share.Todo3))
            let template = CLKComplicationTemplateGraphicBezelCircularText(circularTemplate:templateInner, textProvider: CLKSimpleTextProvider(text: Counter.share.Todo2))
            handler(CLKComplicationTimelineEntry(date: Date(), complicationTemplate: template))
        default:
            let template = CLKComplicationTemplateGraphicCircularStackText(line1TextProvider: CLKSimpleTextProvider(text: "謹守"), line2TextProvider: CLKSimpleTextProvider(text: "信靠主"))
            handler(CLKComplicationTimelineEntry(date: Date(), complicationTemplate: template))
     
        }
    }
       
    func getTimelineEntries(for complication: CLKComplication, after date: Date, limit: Int, withHandler handler: @escaping ([CLKComplicationTimelineEntry]?) -> Void) {
        // Call the handler with the current timeline entry

        print(Counter.share.Todo1)
        print(Counter.share.Todo2)
        print(Counter.share.Todo3)
    
        handler(nil)
        
        /*
        let userDefault = UserDefaults()
        ComplicationController.count=ComplicationController.count+10
        
        logger.debug("-----> getTimelineEntries <-------")
        
        // Call the handler with the current timeline entry
        /*var Todo1 = userDefault.value(forKey: "Todo1") as! String
        var Todo2 = userDefault.value(forKey: "Todo2") as! String
        var Todo3 = userDefault.value(forKey: "Todo3") as! String
        */
        
        
        
        print(Counter.share.Todo1)
        print(Counter.share.Todo2)
        print(Counter.share.Todo3)
    
        
        switch complication.family {
        case .graphicCorner:
            let template = CLKComplicationTemplateGraphicCornerStackText(
                innerTextProvider: CLKSimpleTextProvider(text:Counter.share.Todo1),
                outerTextProvider: CLKSimpleTextProvider(text: Counter.share.Todo2))
            handler([CLKComplicationTimelineEntry(date: Date(), complicationTemplate: template)])
        case .circularSmall:
            let template = CLKComplicationTemplateGraphicCircularStackText(line1TextProvider: CLKSimpleTextProvider(text: "靠主!"), line2TextProvider: CLKSimpleTextProvider(text: "堅持！"))
            handler([CLKComplicationTimelineEntry(date: Date(), complicationTemplate: template)])
        case .graphicCircular:
            let template = CLKComplicationTemplateGraphicCircularStackText(line1TextProvider: CLKSimpleTextProvider(text: Counter.share.Todo1), line2TextProvider: CLKSimpleTextProvider(text: Counter.share.Todo2))
            handler([CLKComplicationTimelineEntry(date: Date(), complicationTemplate: template)])
        case .graphicBezel:
            let templateInner =     CLKComplicationTemplateGraphicCircularStackText(line1TextProvider: CLKSimpleTextProvider(text: Counter.share.Todo2), line2TextProvider: CLKSimpleTextProvider(text: Counter.share.Todo3))
            let template = CLKComplicationTemplateGraphicBezelCircularText(circularTemplate:templateInner, textProvider: CLKSimpleTextProvider(text: Counter.share.Todo1))
            handler([CLKComplicationTimelineEntry(date: Date(), complicationTemplate: template)])
        default:
            let template = CLKComplicationTemplateGraphicCircularStackText(line1TextProvider: CLKSimpleTextProvider(text: "謹守"), line2TextProvider: CLKSimpleTextProvider(text: "信靠主"))
            handler([CLKComplicationTimelineEntry(date: Date(), complicationTemplate: template)])
     
        }
          //  handler(nil)
         */

    }

    // MARK: - Sample Templates
    
    func getLocalizableSampleTemplate(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTemplate?) -> Void) {
        switch complication.family {
        case .graphicCorner:
            let template = CLKComplicationTemplateGraphicCornerStackText(innerTextProvider: CLKSimpleTextProvider(text: "保守自己的心"),outerTextProvider: CLKSimpleTextProvider(text: "信靠主"))
            handler(template)
        case .circularSmall:
            let template = CLKComplicationTemplateGraphicCircularStackText(line1TextProvider: CLKSimpleTextProvider(text: "喜樂"), line2TextProvider: CLKSimpleTextProvider(text: "信靠主"))
            handler(template)
        case .graphicCircular:
            let template = CLKComplicationTemplateGraphicCircularStackText(line1TextProvider: CLKSimpleTextProvider(text: "謹守"), line2TextProvider: CLKSimpleTextProvider(text: "信靠主"))
            handler(template)
        default:
            let template = CLKComplicationTemplateGraphicCircularStackText(line1TextProvider: CLKSimpleTextProvider(text: "剛強"), line2TextProvider: CLKSimpleTextProvider(text: "信靠主"))
            handler(template)
        }
    }
}
