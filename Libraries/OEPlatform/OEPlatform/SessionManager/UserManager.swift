//
//  UserManager.swift
//  OEPlatform
//
//  Created by samuelsong on 2021/11/21.
//

import Foundation
import KeychainAccess
import Tattoo

public class UserManager: UserAPI {
    public init(scope: Scope) {
    }

    public func user(email: String) -> User? {
        if let user: User? = UserDefaults.standard.getDecodable(for: email) {
            return user
        } else {
            return nil
        }
    }

    public func setUser(_ user: User, for email: String) {
        do {
            try UserDefaults.standard.setEncodable(user, for: email)
        } catch {
            //
        }
    }

    public func createUser(token: String) -> User? {
        let dict = JWTUtil.decode(jwtToken: token)
        guard !dict.isEmpty else {
            return nil
        }
        guard let email = dict[Session.emailKey] as? String, let name = dict[Session.nameKey] as? String else {
            return nil
        }
        var user = User(email: email, name: name)
        if let imageURL = dict[Session.pictureURLKey] as? String {
            user.picture = imageURL
        }

        do {
            try UserDefaults.standard.setEncodable(user, for: email)
        } catch {
            return nil
        }
        return user
    }
}

extension UserDefaults {
    func setEncodable<T: Encodable>(_ encodable: T, for key: String) throws {
        let data = try PropertyListEncoder().encode(encodable)
        self.set(data, forKey: key)
    }

    func getDecodable<T: Decodable>(for key: String) -> T? {
        guard
            self.object(forKey: key) != nil,
            let data = self.value(forKey: key) as? Data
        else {
            return nil
        }

        let obj = try? PropertyListDecoder().decode(T.self, from: data)
        return obj
    }
}