//
//  Strings.swift
//  The_You_Frontier
//
//  Created by Chawtech on 19/01/24.
//

import Foundation
import UIKit

extension String {
    
    func isValidEmail() -> Bool {
        let regex = try! NSRegularExpression(pattern: "^[_A-Za-z0-9-]+(\\.[_A-Za-z0-9-]+)*@[A-Za-z0-9.-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$", options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
    
    func trim() -> String {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    func isLengthValid(minLength: Int , maxLength: Int) -> Bool {
        return self.count >= minLength && self.count <= maxLength
    }
    
    func isPasswordValidation (password: String) -> Bool {
//        let passRegEx = "(?=[^a-z]*[a-z])(?=[^0-9]*[0-9])[a-zA-ZÀ-ÿ0-9!@#$%^&*]{8,}"
//        let passRegEx = "^(?=.*[A-Z])(?=.*[!@#$%^&*])(?=.*[0-9])(?=.*[a-z]).{8}$"
        let passRegEx = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[d$@$!%*?&#~`^:;<,>./])[A-Za-zÀ-ÿ\\dd$@$!%*?&#~`^:;<,>./]{8,}"
        //"^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)[a-zA-Z\\d]{8,}$"
        //~`! @#$%^&*()_-+={[}]|\:;"'<,>.?/
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passRegEx)
        return passwordTest.evaluate(with: password)
    }

    func isValidUrl(url: String) -> Bool {
        let urlRegEx = "^(https?://)?(www\\.)?([-a-z0-9]{1,63}\\.)*?[a-z0-9][-a-z0-9]{0,61}[a-z0-9]\\.[a-z]{2,6}(/[-\\w@\\+\\.~#\\?&/=%]*)?$"
        let urlTest = NSPredicate(format:"SELF MATCHES %@", urlRegEx)
        let result = urlTest.evaluate(with: url)
        return result
    }
    
    func localized(bundle: Bundle = .main, tableName: String = "Localizable") -> String {
        return NSLocalizedString(self, tableName: tableName, value: "\(self)", comment: "")
    }
    
    var containsEmoji: Bool {
        return unicodeScalars.contains { scalar in
            let isEmoji = scalar.properties.isEmoji
            return isEmoji
        }
    }
//    var containsEmoji: Bool {
//        let alphanumericPattern = "^[a-zA-Z0-9]*$"
//        return range(of: alphanumericPattern, options: .regularExpression) != nil
//    }
    
//    func containsOnlyAlphanumeric() -> Bool {
//        let regex = try! NSRegularExpression(pattern: "^[_A-Za-z0-9-]+(\\.[_A-Za-z0-9-]+)*@[A-Za-z0-9.-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$", options: .caseInsensitive)
//        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
//    }
//
    func containsOnlyAlphanumeric() -> Bool {
        let allowedCharacterSet = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 \\/.,?!@#$%^&*()_-+=<>:;\"'{}[]|~`")
                return rangeOfCharacter(from: allowedCharacterSet.inverted) == nil
        }

}


extension String {
    var capitalized: String {
        // 1
        let firstLetter = self.prefix(1).capitalized
        // 2
        let remainingLetters = self.dropFirst().lowercased()
        // 3
        return firstLetter + remainingLetters
    }
}
