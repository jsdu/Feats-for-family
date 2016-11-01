//
//  InstructionStore.swift
//  RecipeBook
//
//  Created by Austins Work on 10/20/16.
//  Copyright © 2016 AustinsIronYard. All rights reserved.
//

import UIKit

public class InstructionStore {
    var steps : [Steps] = []
    let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration:config)
    }()
    //Check to see if we get data form JSON
    func processInstructionRequest(data: Data?, error: NSError?) ->AnalyzedRecipeResult{
        guard let jsonData = data else {
            return .failure(error!)
        }
        return SpoonacularAPI.analyzedRecipeFromJSONData(jsonData)
    }
    
    //func for url request
    func fetchInstructions(id: Int, completion: @escaping (AnalyzedRecipeResult)-> Void){
        let url = SpoonacularAPI.requestAnalyzedRecipeIntruction(id: id)
        var urlrequest = URLRequest(url: url as URL)
        urlrequest.httpMethod = "GET"
        urlrequest.addValue(getAPIKey(), forHTTPHeaderField: "X-Mashape-Key")
        urlrequest.addValue("application/json", forHTTPHeaderField: "Accept")
        let task = session.dataTask(with: urlrequest, completionHandler: {
            (data, response, error) -> Void in
            let result = self.processInstructionRequest(data: data, error: error as NSError?)
            completion(result)
        })
        task.resume()
    }
}
