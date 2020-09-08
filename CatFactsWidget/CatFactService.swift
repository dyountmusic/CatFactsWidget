//
//  CatFactService.swift
//  CatFactsWidgetExtension
//
//  Created by Daniel Yount on 9/8/20.
//

import Foundation
class CatFactService {
    var fact: CatFact?

    func fetchFact(completion: ((Bool) -> Void)? = nil) {
        let url = URL(string: "https://catfact.ninja/fact")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData)
        let task = URLSession.shared.dataTask(with: request) { (data, _, error) in
            // Respond to errors
            if let error = error {
                print("Error occured when fetching cat facts with error: \(error)")
                self.fact = nil
                completion?(false)
                return
            }

            // Get the data and transform it to our model
            let decoder = JSONDecoder()
            if let data = data, let fetchedCatFact = try? decoder.decode(CatFact.self, from: data) {
                self.fact = fetchedCatFact
                completion?(true)
                return
            }
        }
        task.resume()
    }
}
