//
//  OwnerDTO.swift
//  Infrastructure
//
//  Created by Willian de Paula on 20/10/25.
//

#if DEBUG
extension OwnerDTO {
    static let mock: Self = OwnerDTO(
        id: 99,
        login: "JohnDoe",
        avatar_url: "https://somelink.com/avatar.png"
    )
}
#endif
