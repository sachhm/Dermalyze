//
//  HAM10000Model.swift
//  Dermalyze
//
//  Created by samo on 6/2/2025.
//

import CoreML
import Vision
import UIKit

class HAM10000Model {
    var model: VNCoreMLModel?

    init() {
        do {
            // Load the CoreML model from the .mlmodelc file
            let modelURL = Bundle.main.url(forResource: "HAM10000 Classifier - IFPV2", withExtension: ".mlpackage")!
            let coreMLModel = try MLModel(contentsOf: modelURL)
            model = try VNCoreMLModel(for: coreMLModel)
        } catch {
            print("Error loading model: \(error)")
        }
    }

    // Function to make predictions
    func predict(image: UIImage, completion: @escaping ([String: Double]?) -> Void) {
        guard let model = model else {
            completion(nil)
            return
        }

        // Create a Vision request with the loaded model
        let request = VNCoreMLRequest(model: model) { request, error in
            guard let results = request.results as? [VNClassificationObservation] else {
                print("Error making prediction: \(String(describing: error))")
                completion(nil)
                return
            }

            var labels: [String: Double] = [:]
            // Iterate through the results and store the confidence for each class
            for result in results {
                switch result.identifier {
                case "akiec":
                    labels["akiec"] = Double(result.confidence)
                case "bcc":
                    labels["bcc"] = Double(result.confidence)
                case "bkl":
                    labels["bkl"] = Double(result.confidence)
                case "df":
                    labels["df"] = Double(result.confidence)
                case "mel":
                    labels["mel"] = Double(result.confidence)
                case "nv":
                    labels["nv"] = Double(result.confidence)
                case "vasc":
                    labels["vasc"] = Double(result.confidence)
                default:
                    break
                }
            }
            // Return the predicted labels and their confidence
            completion(labels)
        }

        // Perform the request with the image
        guard let ciImage = CIImage(image: image) else {
            completion(nil)
            return
        }
        
        let handler = VNImageRequestHandler(ciImage: ciImage, options: [:])
        try? handler.perform([request])
    }
}
