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

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {

        let service = CatFactLoader()
        service.fetchFact { result in
            switch result {
            case .success(let fact):
                let entry = CatFactWidgetEntry(date: Date(), catFact: fact)
                let timeline = Timeline(entries: [entry], policy: .atEnd)
                completion(timeline)
                return
            case .failure(let error):
                print("error with: \(error.localizedDescription)")
            }
        }

        // Else fall back to placeholder data
        let entry = CatFactWidgetEntry(date: Date(), catFact: CatFact(fact: "I am not supposed to appear. Meow."))
        let timeline = Timeline(entries: [entry], policy: .atEnd)
        completion(timeline)
    }
}

struct CatFactWidgetEntry: TimelineEntry {
    let date: Date
    let catFact: CatFact
}

struct CatFact: Codable {
    let fact: String
}

struct CatFactsWidgetEntryView : View {
    var entry: CatFactsWidgetProvider.Entry

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("🐈 Cat Facts")
                    .font(.headline)
                    .bold()
                Spacer()
            }
            Spacer()
            Text(entry.catFact.fact)
        }
        .padding()
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
        CatFactsWidgetEntryView(entry: CatFactWidgetEntry(date: Date(), catFact: CatFact(fact: "Preview fact!")))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
