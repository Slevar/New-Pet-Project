//
//  AuthResponse.swift
//  Spotify
//
//  Created by Вардан Мукучян on 01.07.2021.
//

import Foundation

struct AuthResponse : Codable {
    let access_token: String
    let expires_in:  Int
    let refresh_token: String?
    let scope: String
    let token_type: String
}


//"access_token" = "BQBfhVyzRpRxLGsfwUgzYy0ngSvdaWQrCA5kus0V6z8wJ0UaxPEmM6pVblOmVW05RhjtQUn2gMhejckgLdtZiBbY5klIC_EJLplSBVs_eKGgLBSHbdzlNvyUtpaETPuxJh8T8PdPiXAmSvb8PkVyVrJ_m83mZtAqrF5wUb2aIekOIgg";
//"expires_in" = 3600;
//"refresh_token" = "AQCZ8xQIAtXR889WsuaBzsx0Q50sNHs1a2XEPYOo3MnMo5DbTfAyquAPlGZpyJcLsmY_1xzIqjBh63tyond5E2eb5J8JPbCrxVX9kv7j_v-QteXRtM_EZng-8UUiUw7VzH8";
//scope = "user-read-private";
//"token_type" = Bearer;
//}

