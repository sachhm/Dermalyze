//
//  HAM10000ViewModel.swift
//  Dermalyze
//
//  Created by samo on 6/2/2025.
//

import SwiftUI

class HAM10000ViewModel: ObservableObject {
    @Published var labels: [String: Double] = [
        "akiec": 0.0,
        "bcc": 0.0,
        "bkl": 0.0,
        "df": 0.0,
        "mel": 0.0,
        "nv": 0.0,
        "vasc": 0.0
    ]
    
    let labelMappings: [String: String] = [
        "akiec": "Actinic Keratoses",
        "bcc": "Basal Cell Carcinoma",
        "bkl": "Benign Keratosis-like Lesions",
        "df": "Dermatofibroma",
        "mel": "Melanoma",
        "nv": "Melanocytic Nevi",
        "vasc": "Vascular Lesions"
    ]
    
    private var model: HAM10000Model
    
    init() {
        model = HAM10000Model()
    }
    
    func makePrediction(for image: UIImage) {
        model.predict(image: image) { [weak self] newLabels in
            DispatchQueue.main.async {
                self?.labels = newLabels ?? self?.labels ?? [:]
            }
        }
    }
}
