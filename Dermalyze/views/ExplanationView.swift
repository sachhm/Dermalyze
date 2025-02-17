//
//  ExplanationView.swift
//  DermaDiary
//
//  Created by samo on 6/2/2025.
//
import SwiftUI

let titlesDescription: [String: String] = [
    "Actinic Keratoses" : """
            Actinic Keratoses (AKs) are rough, scaly patches on the skin that can be a precursor to skin cancer. They are caused by damage to the skin from ultraviolet (UV) light exposure, often from sunburns or tanning beds. AKs are typically found on sun-exposed areas such as the face, ears, neck, scalp, chest, backs of the hands, forearms, or lips. While they are usually not cancerous, they can develop into squamous cell carcinoma (SCC) if untreated.
        """,
    "Basal Cell Carcinoma" : """
            Basal Cell Carcinoma (BCC) is the most common type of skin cancer, arising from the basal cells in the epidermis. BCC often appears as a small, shiny bump or nodule on the skin, typically on sun-exposed areas like the face, ears, neck, scalp, shoulders, and back. Although BCC rarely spreads to other parts of the body, it can cause significant local damage if left untreated.
        """,
    "Benign Keratosis-like Lesions" : """
            Benign Keratosis-like Lesions are non-cancerous growths that often resemble actinic keratoses but do not have the same potential to develop into skin cancer. These lesions are typically found in areas that have been chronically exposed to the sun. They can appear as flat, scaly, or raised patches of skin and are generally harmless, but they can be mistaken for precancerous or cancerous growths, so it's important to monitor them.
        """,
    "Dermatofibroma" : """
            Dermatofibromas are common, benign skin tumors that typically appear as small, brownish nodules or growths. They are most often found on the arms, legs, and back. Dermatofibromas develop from fibrous tissue and are usually harmless, though they may become itchy or tender in some cases. They are not cancerous and rarely require treatment unless they become problematic.
        """,
    "Melanoma" : """
            Melanoma is a dangerous form of skin cancer that develops from melanocytes, the cells responsible for producing the pigment melanin. It is known for its ability to spread quickly to other parts of the body (metastasize). Melanoma often appears as a new mole or a change in an existing mole, typically characterized by asymmetry, irregular borders, multiple colors, and larger diameter. Early detection and treatment are critical for a favorable prognosis.
        """,
    "Melanocytic Nevi" : """
            Melanocytic Nevi, commonly known as moles, are benign growths that develop from melanocytes. They are usually round or oval, with a smooth, uniform color and shape. Moles are typically brown or black but can vary in color. Most people have between 10 to 40 moles on their body, and they usually do not require treatment unless there is a change in size, shape, or color, which could indicate the development of melanoma.
        """,
    "Vascular Lesions" : """
            Vascular Lesions are abnormalities in the blood vessels that can appear on the skin. These lesions can be congenital (present at birth) or acquired over time due to factors like sun exposure, trauma, or aging. They include conditions like hemangiomas (commonly known as "strawberry marks"), which are benign growths of blood vessels, and spider veins or varicose veins, which occur when veins become enlarged and twisted. While most vascular lesions are benign, some may require treatment if they cause discomfort or aesthetic concerns.
        """
]

struct ExplanationView: View {
    @Environment(\.dismiss) private var dismiss
    let diseaseName: String
    @Binding var path: NavigationPath
    
    var body: some View {
        ZStack {
            Color(.systemBackground).ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 24) {
                    Text(diseaseName)
                        .font(.title2)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                    
                    Text(titlesDescription[diseaseName] ?? "No description available.")
                        .font(.body)
                        .foregroundColor(.secondary)
                        .lineSpacing(4)
                    
                    VStack(spacing: 16) {
                        Button(action: { dismiss() }) {
                            HStack {
                                Image(systemName: "arrow.left")
                                Text("Back to Results")
                            }
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(height: 50)
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(12)
                        }
                        
                        Button(action: {
                            path = NavigationPath(["camera"])
                        }) {
                            HStack {
                                Image(systemName: "camera.fill")
                                Text("Take Another Photo")
                            }
                            .font(.headline)
                            .foregroundColor(.blue)
                            .frame(height: 50)
                            .frame(maxWidth: .infinity)
                            .background(Color.blue.opacity(0.1))
                            .cornerRadius(12)
                        }

                    }
                }
                .padding(24)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
    }
}
