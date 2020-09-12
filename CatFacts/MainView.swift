//
//  MainView.swift
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
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .environmentObject(loader)
    }
}

struct CatFactView: View {

    @EnvironmentObject var loader: CatFactViewModel

    var body: some View {
        VStack {
            Text("🐈 Cat Fact")
                .font(.title2)
                .padding()
            if let fact = loader.fact?.fact {
                Text(fact)
            } else {
                ProgressView()
            }
        }
        .animation(.easeInOut)
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button("New Fact") { withAnimation(.easeInOut) { loader.fetch() } }
            }
        }
        .padding()
        .onAppear(perform: loader.fetch)
    }
}

class CatFactViewModel: ObservableObject {
    @Published var fact: CatFact?

    private var service = CatFactLoader()

    func fetch() {
        service.fetchFact { result in
            switch result {
            case .success(let fact):
                DispatchQueue.main.async {
                    self.fact = fact
                }
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
