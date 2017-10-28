//
//  AccountService.swift
//  qiiip
//
//  Created by chuross on 2017/10/30.
//  Copyright © 2017年 chuross. All rights reserved.
//

import Foundation
import RxSwift
import CHQiitaApiClient
import KeychainAccess

class AccountService {
    
    private let keychain: Keychain = Keychain(service: Bundle.main.bundleIdentifier!)
    private let accountUserKey: String = "account_user"
    private let accountUserIdKey: String = "user_id"
    private let accountUserThumbnailKey: String = "user_thumbnail"
    private let accountToken: String = "account_token"
    
    func account() -> Account? {
        guard let userData = UserDefaults.standard.dictionary(forKey: accountUserKey) as? [String:String] else { return nil }
        guard let token = keychain[accountToken] else { return nil }
        
        let user = User(
            id: userData[accountUserIdKey]!,
            profileImageUrl: userData[accountUserThumbnailKey]
        )
        
        return Account(user: user, token: token)
    }
    
    func login(code: String) -> Observable<Account> {
        let clientId = AppDelegate.application().configs.qiitaClientId
        let clientSecret = AppDelegate.application().configs.qiitaClientSecret
        
        return TokensAPI.accessTokensPost(body: Body(clientId: clientId, clientSecret: clientSecret, code: code))
            .map({ token -> Token in
                CHQiitaApiClientAPI.customHeaders["Authorization"] = "Bearer \(token.token)"
                return token
            })
            .flatMap({ token -> Observable<Account> in
                return UsersAPI.authenticatedUserGet()
                    .map({ return Account(user: $0, token: token.token) })
            })
            .map({ [weak self] account in
                self?.saveAccount(account: account)
                return account
            })
    }
    
    private func saveAccount(account: Account) {
        let userData = [
            accountUserIdKey: account.user.id,
            accountUserThumbnailKey: account.user.profileImageUrl ?? ""
        ]
        
        UserDefaults.standard.set(userData, forKey: accountUserKey)
        keychain[accountToken] = account.token
    }
}
