//
//  KeychainService.swift
//  FinanceTestApp
//
//  Created by Marat Giniyatov on 07.11.2023.
//

import Foundation
import Security

class KeychainService {

    // Метод для сохранения строки в Keychain
    static func saveStringToKeychain(key: String, value: String) {
        // Преобразование строк в данные
        if let data = value.data(using: .utf8) {
            // Параметры для сохранения в Keychain
            let query: [String: Any] = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrAccount as String: key,
                kSecValueData as String: data
            ]

            // Удаление существующих данных (если они уже есть)
            SecItemDelete(query as CFDictionary)

            // Сохранение данных в Keychain
            let status = SecItemAdd(query as CFDictionary, nil)
            guard status == errSecSuccess else {
                print("Ошибка при сохранении данных в Keychain: \(status)")
                return
            }

            print("Данные успешно сохранены в Keychain.")
        }
    }

    // Метод для загрузки строки из Keychain
    static func loadStringFromKeychain(key: String) -> String? {
        // Параметры для загрузки из Keychain
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecReturnData as String: kCFBooleanTrue!,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]

        var dataTypeRef: AnyObject?

        // Загрузка данных из Keychain
        let status = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)

        if status == errSecSuccess {
            if let retrievedData = dataTypeRef as? Data,
               let retrievedString = String(data: retrievedData, encoding: .utf8) {
                return retrievedString
            }
        } else {
            print("Ошибка при загрузке данных из Keychain: \(status)")
        }

        return nil
    }

    // Метод для удаления строки из Keychain
    static func deleteStringFromKeychain(key: String) {
        // Параметры для удаления из Keychain
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key
        ]

        // Удаление данных из Keychain
        let status = SecItemDelete(query as CFDictionary)
        guard status == errSecSuccess || status == errSecItemNotFound else {
            print("Ошибка при удалении данных из Keychain: \(status)")
            return
        }

        print("Данные успешно удалены из Keychain.")
    }
}
