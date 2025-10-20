//
//  Owner+Mocks.swift
//  Core
//
//  Created by Willian de Paula on 20/10/25.
//

#if DEBUG
extension Owner {
    public static let mocks: [Self] = [
        mock01,
        mock02,
        mock03
    ]
    
    public static let mock01: Self = Owner(id: 1, userName: "JohnDoe", avatarStringUrl: "somelink.com.br/image.png")
    public static let mock02: Self = Owner(id: 2, userName: "JoanaDoe", avatarStringUrl: "somelink.com.br/image.png")
    public static let mock03: Self = Owner(id: 1, userName: "Anonymous", avatarStringUrl: "")
}
#endif
