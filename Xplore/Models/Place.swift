//
//  Place.swift
//  Xplore
//
//  Created by Dilshad P on 08/05/25.
//

import Foundation

struct Place: Codable{
    
    let name: String
    let category: String
    let inageURL: String
    let docID: Int
    let placeID: String
    var distance: String?
}
