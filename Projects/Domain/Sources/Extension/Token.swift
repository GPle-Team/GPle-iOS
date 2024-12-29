import Moya
import Security
import Foundation

// 토큰과 만료 기간을 포함하는 구조체
struct TokenData: Codable {
    let token: String
    let expirationDate: Date
}

public class KeyChain {
    public static let shared = KeyChain()

    // 토큰 저장하기 (만료 기간과 함께)
    func create(key: String, token: String) {
        // 먼저 토큰을 데이터로 변환하고 만료 기간을 설정
        if let tokenData = token.data(using: .utf8) {
            let query: NSDictionary = [
                kSecClass: kSecClassGenericPassword,
                kSecAttrAccount: key,
                kSecValueData: tokenData
            ]
            SecItemDelete(query)  // 기존 데이터 삭제
            let status = SecItemAdd(query, nil)
            assert(status == noErr, "failed to save Token")
        }
    }

    // 토큰과 만료 기간을 JSON으로 저장하기
    public func saveTokenWithExpiration(key: String, token: String, expiresIn: TimeInterval) {
        let expirationDate = Date().addingTimeInterval(expiresIn)  // 만료일 계산
        let tokenData = TokenData(token: token, expirationDate: expirationDate)

        if let encodedData = try? JSONEncoder().encode(tokenData),
           let tokenString = String(data: encodedData, encoding: .utf8) {
            create(key: key, token: tokenString)
            print("Token 저장 완료: \(tokenString)")
        } else {
            print("TokenData 인코딩 실패")
        }
    }

    // 저장된 토큰 읽기 (만료 기간 포함)
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

    // 토큰과 만료 기간을 함께 읽기
    func loadTokenWithExpiration(key: String) -> TokenData? {
        if let tokenString = read(key: key),
           let tokenData = tokenString.data(using: .utf8) {
            return try? JSONDecoder().decode(TokenData.self, from: tokenData)
        }
        return nil
    }

    // 만료 여부 확인
    func isTokenExpired(key: String) -> Bool {
        if let tokenData = loadTokenWithExpiration(key: key) {
            return tokenData.expirationDate < Date()  // 현재 시간과 만료일 비교
        }
        return true  // 토큰이 없으면 만료된 것으로 간주
    }

    // 토큰 업데이트하기
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

    // 토큰 삭제
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
