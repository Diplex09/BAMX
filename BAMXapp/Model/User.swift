//
//  User.swift
//  BAMXapp
//
//  Created by user195828 on 9/4/21.
//

import Firebase

struct User
{
    let userId: String
    let email: String
    
    init(authData: Firebase.User)
    {
        userId = authData.uid
        email = authData.email ?? ""
    }
    
    init(userId: String, email: String) {
        self.userId =  userId
        self.email = email
    }
}


