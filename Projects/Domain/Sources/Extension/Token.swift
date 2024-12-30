import Moya
import Security
import Foundation

public struct TokenData: Codable {
    public let token: String
    public let expirationDate: Date
}

public class KeyChain {
    public static let shared = KeyChain()

    func create(key: String, token: String) {
        if let tokenData = token.data(using: .utf8) {
            let query: NSDictionary = [
                kSecClass: kSecClassGenericPassword,
                kSecAttrAccount: key,
                kSecValueData: tokenData
            ]
            SecItemDelete(query)
            let status = SecItemAdd(query, nil)
            assert(status == noErr, "failed to save Token")
        }
    }

    public func saveTokenWithExpiration(key: String, token: String, expiresIn: TimeInterval) {
        let expirationDate = Date().addingTimeInterval(expiresIn)
        let tokenData = TokenData(token: token, expirationDate: expirationDate)

        guard let encodedData = try? JSONEncoder().encode(tokenData) else {
            print("Token encoding failed.")
            return
        }

        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key,
            kSecValueData: encodedData
        ]

        let deleteStatus = SecItemDelete(query as CFDictionary)
        if deleteStatus != errSecSuccess {
            print("Failed to delete existing token, status: \(deleteStatus)")
        }

        let status = SecItemAdd(query as CFDictionary, nil)
        if status == errSecSuccess {
            print("Token saved successfully to Keychain.")
        } else {
            print("Failed to save token, status: \(status)")
        }
    }

    public func read(key: String) -> String? {
        let query: NSDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key,
            kSecReturnData: kCFBooleanTrue as Any,
            kSecMatchLimit: kSecMatchLimitOne
        ]

        var dataTypeRef: AnyObject?
        let status = SecItemCopyMatching(query, &dataTypeRef)

        if status == errSecSuccess {
            if let retrievedData: Data = dataTypeRef as? Data {
                let value = String(data: retrievedData, encoding: .utf8)
                return value
            } else { return nil }
        } else {
            print("failed to loading, status code = \(status)")
            return nil
        }
    }

    public func loadTokenWithExpiration(key: String) -> TokenData? {
        if let tokenString = read(key: key),
           let tokenData = tokenString.data(using: .utf8) {
            return try? JSONDecoder().decode(TokenData.self, from: tokenData)
        }
        return nil
    }

    public func isTokenExpired(key: String) -> Bool {
        if let tokenData = loadTokenWithExpiration(key: key) {
            return tokenData.expirationDate < Date()
        }
        return true
    }

    func updateItem(token: Any, key: Any) -> Bool {
        let prevQuery: [CFString: Any] = [kSecClass: kSecClassGenericPassword,
                                          kSecAttrAccount: key]
        let updateQuery: [CFString: Any] = [kSecValueData: (token as AnyObject).data(using: String.Encoding.utf8.rawValue) as Any]

        let result: Bool = {
            let status = SecItemUpdate(prevQuery as CFDictionary, updateQuery as CFDictionary)
            if status == errSecSuccess { return true }

            print("updateItem Error : \(status.description)")
            return false
        }()

        return result
    }

    func delete(key: String) {
        let query: NSDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key
        ]

        let status = SecItemDelete(query)
        if status != errSecSuccess {
            print("Failed to delete item from Keychain with status code \(status)")
        }
    }
}

public struct Const {
    public struct KeyChainKey {
        public static let accessToken = "accessToken"
        public static let refreshToken = "refreshToken"
    }
}
