//
//  FileManagerController.swift
//  BestRecipes
//
//  Created by realeti on 22.07.2024.
//

import Foundation

final class FileManagerController {
    // MARK: - Singleton Instance
    static let shared = FileManagerController()
    
    // MARK: - Save Image
    func saveImage(_ imageUrl: String, imageData: Data) {
        guard let documentsDirectory = getDocumentsDirectory() else {
            return
        }
        
        let fileURL = documentsDirectory.appendingPathComponent(imageUrl, conformingTo: .jpeg)
        
        do {
            try imageData.write(to: fileURL)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // MARK: - Load Image
    func loadImage(imageUrl: String) -> Data? {
        guard let documentsDirectory = getDocumentsDirectory() else {
            return nil
        }
        
        let fileURL = documentsDirectory.appendingPathComponent(imageUrl, conformingTo: .jpeg)
        
        guard let imageData = try? Data(contentsOf: fileURL) else {
            return nil
        }
        
        return imageData
    }
    
    private init() {}
}

// MARK: - Documents Directory URL
private extension FileManagerController {
    private func getDocumentsDirectory() -> URL? {
        return FileManager.default.urls(for: .documentDirectory, in: .allDomainsMask).first
    }
}
