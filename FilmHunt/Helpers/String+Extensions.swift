//
//  String+Extensions.swift
//  FilmHunt
//
//  Created by Mariya Khutornaya on 17.03.23.
//

import Foundation

extension String {
    
    var localized: String  {
        NSLocalizedString(self, comment: "")
    }
    
    func trimLeadingAndTrailingWhitespaces() -> String {
        return self.replacingOccurrences(of: "^\\s+|\\s+$", with: "", options: .regularExpression)
    }
}
