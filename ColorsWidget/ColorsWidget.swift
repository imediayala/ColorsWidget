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

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration, color: selectedColor(configuration: configuration))
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
    
    func selectedColor(configuration: ConfigurationIntent) -> ColorsModel {
        switch configuration.Colors {
        case .bubblegum: return .bubblegum
        case .buttercup: return .buttercup
        case .indigo: return .indigo
        case .lavender: return .lavender
        case .magenta: return .magenta
        case .navy: return .navy
        case .orange: return .orange
        case .oxblood: return .oxblood
        case .periwinkle: return .periwinkle
        case .poppy: return .poppy
        case .purple: return .purple
        case .seafoam: return .seafoam
        case .sky: return .seafoam
        case .tan: return .tan
        case .teal: return .teal
        case .yellow: return .yellow
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
                Text(colorScheme == .dark ? "In dark mode" : "In light mode")
            }
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
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct ColorsWidget_Previews: PreviewProvider {
    static var previews: some View {
        ColorsWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent(), color: .buttercup))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
