//
//  ColorsWidget.swift
//  ColorsWidget
//
//  Created by Daniel Ayala on 27/12/21.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent(), color: .bubblegum)
    }
    
    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration, color: .bubblegum)
        completion(entry)
    }
    
    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []
        let currentDate = Date()
        let colorsList: [ColorsModel]
        colorsList = ColorsModel.allCases
        
        if configuration.Colors == .showAll {
            for (index, color) in colorsList.enumerated() {
                let entryDate = Calendar.current.date(byAdding: .second, value: index, to: currentDate)!
                entries.append(SimpleEntry(date: entryDate, configuration: configuration, color: color))
            }
        }else {
            let entry = SimpleEntry(date: currentDate, configuration: configuration, color: selectedColor(configuration: configuration))
            entries.append(entry)
        }
        
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
    
    func selectedColor(configuration: ConfigurationIntent) -> ColorsModel {
        switch configuration.Colors {
        case .bubblegum: return .bubblegum
        case .buttercup: return .buttercup
        case .lavender: return .lavender
        case .magenta: return .magenta
        case .periwinkle: return .periwinkle
        case .poppy: return .poppy
        case .seafoam: return .seafoam
        case .sky: return .seafoam
        case .tan: return .tan
        case .teal: return .teal
        default: return .bubblegum
        }
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
    let color: ColorsModel
}

struct ColorsWidgetEntryView : View {
    @Environment(\.colorScheme) var colorScheme
    var entry: Provider.Entry
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(entry.color.mainColor)
            VStack {
                Text("\(entry.color.name)")
                    .foregroundColor(colorScheme == .dark ? .white : .black)
                    .bold()
                Text(colorScheme == .dark ? "In dark mode" : "In light mode")
                    .foregroundColor(colorScheme == .dark ? .white : .black)
            }
            .widgetURL(entry.color.url)
        }
    }
}

@main
struct ColorsWidget: Widget {
    let kind: String = "ColorsWidget"
    
    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            ColorsWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Colors")
        .description("This is a fancy Widget color selector.")
    }
}

struct ColorsWidget_Previews: PreviewProvider {
    static var previews: some View {
        ColorsWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent(), color: .buttercup))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
