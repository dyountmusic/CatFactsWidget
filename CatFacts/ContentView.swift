//
//  ContentView.swift
//  CatFacts
//
//  Created by Daniel Yount on 9/8/20.
//

import SwiftUI

struct MainView: View {

    @StateObject var loader = CatFactViewModel()

    var body: some View {
        NavigationView {
            CatFactView()
        }.environmentObject(loader)
    }
}

struct CatFactView: View {

    @EnvironmentObject var loader: CatFactViewModel

    var body: some View {
        VStack {
            Text("Cat Fact")
                .font(.headline)
            if let fact = loader.fact?.fact {
                Text(fact)
            } else {
                ProgressView()
            }
        }
    }
}

class CatFactViewModel: ObservableObject {
    @Published var fact: CatFact?

    private var service = CatFactLoader()

    func fetch() {
        service.fetchFact { result in
            switch result {
            case .success(let fact):
                self.fact = fact
            case .failure(let error):
                print("error occured fetching cat fact:  \(error)")
            }
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
