//
//  ComplicationController.swift
//  Hello Watch WatchKit Extension
//
//  Created by RubyChou on 2023/5/20.
//

import ClockKit
import WatchConnectivity

class ComplicationController: NSObject, CLKComplicationDataSource {

    
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
        handler(nil)
    }
    
    func getPrivacyBehavior(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationPrivacyBehavior) -> Void) {
        // Call the handler with your desired behavior when the device is locked
        handler(.showOnLockScreen)
    }

    // MARK: - Timeline Population
    
    func getCurrentTimelineEntry(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimelineEntry?) -> Void) {
        let userDefault = UserDefaults()
        
        // Call the handler with the current timeline entry
        var Todo1 = userDefault.value(forKey: "Todo1") as! String
        var Todo2 = userDefault.value(forKey: "Todo2") as! String
        var Todo3 = userDefault.value(forKey: "Todo3") as! String
        

        switch complication.family {
        case .graphicCorner:
            let template = CLKComplicationTemplateGraphicCornerStackText(
                innerTextProvider: CLKSimpleTextProvider(text:Todo1),
                outerTextProvider: CLKSimpleTextProvider(text: Todo2))
            handler(CLKComplicationTimelineEntry(date: Date(), complicationTemplate: template))
        case .circularSmall:
            let template = CLKComplicationTemplateGraphicCircularStackText(line1TextProvider: CLKSimpleTextProvider(text: "靠主!"), line2TextProvider: CLKSimpleTextProvider(text: "堅持！"))
            handler(CLKComplicationTimelineEntry(date: Date(), complicationTemplate: template))
        case .graphicCircular:
            let template = CLKComplicationTemplateGraphicCircularStackText(line1TextProvider: CLKSimpleTextProvider(text: Todo1), line2TextProvider: CLKSimpleTextProvider(text: Todo2))
            handler(CLKComplicationTimelineEntry(date: Date(), complicationTemplate: template))
        case .graphicBezel:
            let templateInner =     CLKComplicationTemplateGraphicCircularStackText(line1TextProvider: CLKSimpleTextProvider(text: Todo2), line2TextProvider: CLKSimpleTextProvider(text: Todo3))
            let template = CLKComplicationTemplateGraphicBezelCircularText(circularTemplate:templateInner, textProvider: CLKSimpleTextProvider(text: Todo1))
            handler(CLKComplicationTimelineEntry(date: Date(), complicationTemplate: template))
        default:
            let template = CLKComplicationTemplateGraphicCircularStackText(line1TextProvider: CLKSimpleTextProvider(text: "謹守"), line2TextProvider: CLKSimpleTextProvider(text: "信靠主"))
            handler(CLKComplicationTimelineEntry(date: Date(), complicationTemplate: template))
     
        }
    }
       
    func getTimelineEntries(for complication: CLKComplication, after date: Date, limit: Int, withHandler handler: @escaping ([CLKComplicationTimelineEntry]?) -> Void) {
        // Call the handler with the current timeline entry

            handler(nil)

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
