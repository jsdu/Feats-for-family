//
//  RecipeStore.swift
//  RecipeBook
//
//  Created by Austins Work on 10/12/16.
//  Copyright © 2016 AustinsIronYard. All rights reserved.
//

import UIKit

enum ImageResult {
    case success(UIImage)
    case failure(Error)
}
enum PhotoError: Error {
    case imageCreationError
}
//MARK: Class RecipeStore
public class RecipeStore {
    var recipes: [Recipe] = []
    var imageStore = ImageStore()

    
    public  var idArray : [AnyObject] = []
    public  var titleArray : [AnyObject] = []
    let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration:config)
    }()
    
    // Func to check if we get data from JSON
    func processRecipeRequest(data: Data?, error: NSError?) -> RecipeResult {
        guard let jsonData = data else {
            return .failure(error!)
        }
        
        return SpoonacularAPI.recipesFromJSONData(jsonData)
    }
    
     //Fuction for URL Request
    func fetchRecipes(ingredientList: [String], completion: @escaping (RecipeResult) -> Void) {
        let url = SpoonacularAPI.request(input: ingredientList)
        var urlrequest = URLRequest(url: url as URL)
        urlrequest.httpMethod = "GET"
        urlrequest.addValue(getAPIKey(), forHTTPHeaderField: "X-Mashape-Key")
        urlrequest.addValue("application/json", forHTTPHeaderField: "Accept")

        let task = session.dataTask(with: urlrequest, completionHandler: {
            (data, response, error) -> Void in
            
            let result = self.processRecipeRequest(data: data, error: error as NSError?)
            completion(result)
            
        })
        task.resume()
    }
    
    func processImageRequest(data: Data?, error: NSError?) -> ImageResult {
        
        guard let
            imageData = data,
            let image = UIImage(data: imageData) else {
                
                // Couldn't create an image
                if data == nil {
                    return .failure(error!)
                }
                else {
                    return .failure(PhotoError.imageCreationError)
                }
        }
        
        return .success(image)
    }
    
    func fetchImageForRecipe(_ recipe: Recipe, completion: @escaping (ImageResult) -> Void) {
        
        if let imageForRecipe = imageStore.imageForKey(recipe.imageKey) {
            completion(.success(imageForRecipe))
            return
        }
        
        
        
        
        let recipeImageURL = recipe.image
        let url = URL(string:recipeImageURL)
        let request = URLRequest(url: url! as URL)
        
        let task = session.dataTask(with: request, completionHandler: {
            (optData, response, optError) -> Void in
            if let data = optData,
                let image = UIImage(data: data) {
                self.imageStore.setImage(image, forKey: recipe.imageKey)
                completion(.success(image))
            } else if let error = optError {
                completion(.failure(error))
            } else {
                completion(.failure(PhotoError.imageCreationError))
            }
        })
        task.resume()
    }

    
    
}
