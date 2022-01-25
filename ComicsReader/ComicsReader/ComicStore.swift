//
//  ComicStore.swift
//  ComicsReader
//
//  Created by Marco Giustozzi on 2022-01-25.
//

import Foundation
import UIKit

enum LocalStorageError: Error {
    case loadFailure
    case saveFailure
    case urlFailure
    case imageSaveFailure
}

class ComicsStore: ObservableObject {
    
    @Published var allSavedComics = [IdentifiableComic]()
    
    init(withChecking: Bool) throws {
        do {
            try load()
        } catch {
            throw error
        }
    }
    
    init() {}
    
    func addFavoriteComic(comic: IdentifiableComic) {
        let comicToSave = comic
        allSavedComics.append(comicToSave)
        do {
            try save(comic: comic)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func save(comic: IdentifiableComic) throws {
        guard let dataURL = getURL() else {
            throw LocalStorageError.urlFailure
        }
        storeImage(imageURL: comic.img, title: comic.title)
        
        let plistData = allSavedComics.map {
            [$0.month,
             $0.num,
             $0.link,
             $0.year,
             $0.news,
             $0.safe_title,
             $0.transcript,
             $0.alt,
             $0.img,
             $0.title,
             $0.day]
        }
        do {
            let data = try PropertyListSerialization.data(
                fromPropertyList: plistData,
                format: .binary,
                options: .zero)
            try data.write(to: dataURL, options: .atomic)
        } catch {
            throw LocalStorageError.saveFailure
        }
    }
        
    func load() throws {
        guard let dataURL = getURL() else {
            throw LocalStorageError.urlFailure
        }
        
        guard let data = try? Data(contentsOf: dataURL) else {
            return
        }
        
        do {
            let plistData = try PropertyListSerialization.propertyList(
                from: data,
                options: [],
                format: nil)
            let convertedPlistData = plistData as? [[Any]] ?? []
            allSavedComics = convertedPlistData.map {
                IdentifiableComic(
                    month: $0[0] as? String ?? "",
                    num: $0[1] as? Int ?? 0,
                    link: $0[2] as? String ?? "",
                    year: $0[3] as? String ?? "",
                    news: $0[4] as? String ?? "",
                    safe_title: $0[5] as? String ?? "",
                    transcript: $0[6] as? String ?? "",
                    alt: $0[7] as? String ?? "",
                    img: $0[8] as? String ?? "",
                    title: $0[9] as? String ?? "",
                    day: $0[10] as? String ?? "")
            }
        } catch {
            throw LocalStorageError.loadFailure
        }
    }
    
    private func storeImage(imageURL: String, title: String) {
        if let docURL = getDocumentsURL(), let url = URL(string: imageURL) {
            URLSession.shared.downloadTask(with: url) { location, _, error in
                guard let location = location else {
                    print("download error:", error ?? "")
                    return
                }
                do {
                    try FileManager.default.moveItem(at: location, to: docURL.appendingPathComponent("ImageComic" + title + ".png"))
                } catch {
                    print(error)
                }
            }.resume()
        }
    }
    
    func getImageFromLocal(_ comic: IdentifiableComic) -> UIImage {
        let fileName = "ImageComic" + comic.title + ".png"
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! + "/" + fileName
        return UIImage(contentsOfFile: path) ?? UIImage()
    }
    
    private func getURL() -> URL? {
        guard let documentsURL = FileManager.default.urls(
            for: .documentDirectory, in: .userDomainMask).first else {
                return nil
            }
        return documentsURL.appendingPathComponent("favoriteComics.plist")
    }
    
    private func getDocumentsURL() -> URL? {
        guard let documentsURL = FileManager.default.urls(
            for: .documentDirectory, in: .userDomainMask).first else {
                return nil
            }
        return documentsURL
    }
    
    func shouldFavorite(_ comic: IdentifiableComic) -> Bool {
        guard !allSavedComics.isEmpty else {
            return true
        }
        
        return !allSavedComics.contains { $0.num == comic.num }
    }
}
