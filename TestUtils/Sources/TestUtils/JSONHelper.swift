//
//  File.swift
//  
//
//  Created by m.contreras.selman on 18-08-22.
//

import Foundation

public enum JSONHelper {
    public static func loadJSON<Element: Decodable>(withFile fileName: String, inBundleWithName bundle: String, subdirectory: String) -> Element? {
        let bundle = Bundle.currentModule(name: bundle)
        var jsonData: Element?

        if let url = bundle.url(forResource: fileName, withExtension: "json", subdirectory: subdirectory) {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                jsonData = try decoder.decode(Element.self, from: data)
                return jsonData
            } catch {
                debugPrint(error)
            }
        } else {
            debugPrint("Could not find the json file: \(fileName) in bundle: \(bundle)")
        }
        return nil
    }
}
