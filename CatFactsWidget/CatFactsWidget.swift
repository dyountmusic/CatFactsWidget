//
//  CatFactsWidget.swift
//  CatFactsWidget
//
//  Created by Daniel Yount on 9/8/20.
//

import WidgetKit
import SwiftUI

struct CatFactsWidgetProvider: TimelineProvider {
    func placeholder(in context: Context) -> CatFactWidgetEntry {
        CatFactWidgetEntry(date: Date(), catFact: CatFact(fact: "This is a placeholder cat fact."))
    }

    func getSnapshot(in context: Context, completion: @escaping (CatFactWidgetEntry) -> ()) {
        let entry = CatFactWidgetEntry(date: Date(), catFact: CatFact(fact: "Add this widget to see cat facts!"))
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<CatFactWidgetEntry>) -> ()) {

        let service = CatFactLoader()
        service.fetchFact { result in
            switch result {
            case .success(let fact):
                let entry = CatFactWidgetEntry(date: Date().addingTimeInterval(15 * 60), catFact: fact)
                let timeline = Timeline(entries: [entry], policy: .atEnd)
                completion(timeline)
                return
            case .failure(let error):
                print("error with: \(error.localizedDescription)")
            }
        }
    }
}

struct CatFactWidgetEntry: TimelineEntry {
    let date: Date
    let catFact: CatFact
}


struct CatFactsWidgetEntryView : View {

    @Environment(\.widgetFamily) var family: WidgetFamily

    var entry: CatFactsWidgetProvider.Entry

    var body: some View {
        switch family {
        case .systemSmall:
            CatFactsWidgetSmallView(entry: entry)
        case .systemMedium:
            CatFactsWidgetMediumView(entry: entry)
        case .systemLarge:
            CatFactsWidgetSmallView(entry: entry)
        default:
            CatFactsWidgetSmallView(entry: entry)
        }
    }
}

@main
struct CatFactsWidget: Widget {
    let kind: String = "CatFactsWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: CatFactsWidgetProvider()) { entry in
            CatFactsWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Cat Facts")
        .description("The facts you need about cats. Now.")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

struct CatFactsWidget_Previews: PreviewProvider {
    static var previews: some View {
        CatFactsWidgetEntryView(entry: CatFactWidgetEntry(date: Date(), catFact: CatFact(fact: "Preview fact!")))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
