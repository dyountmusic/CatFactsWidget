//
//  CatFactsWidget.swift
//  CatFactsWidget
//
//  Created by Daniel Yount on 9/8/20.
//

import WidgetKit
import SwiftUI

struct CatFactsWidgetProvider: TimelineProvider {
    func placeholder(in context: Context) -> CatFactWidgeEntry {
        CatFactWidgeEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (CatFactWidgeEntry) -> ()) {
        let entry = CatFactWidgeEntry(date: Date())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [CatFactWidgeEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = CatFactWidgeEntry(date: entryDate)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct CatFactWidgeEntry: TimelineEntry {
    let date: Date
}

struct CatFactsWidgetEntryView : View {
    var entry: CatFactsWidgetProvider.Entry

    var body: some View {
        Text(entry.date, style: .time)
    }
}

@main
struct CatFactsWidget: Widget {
    let kind: String = "CatFactsWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: CatFactsWidgetProvider()) { entry in
            CatFactsWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct CatFactsWidget_Previews: PreviewProvider {
    static var previews: some View {
        CatFactsWidgetEntryView(entry: CatFactWidgeEntry(date: Date()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
