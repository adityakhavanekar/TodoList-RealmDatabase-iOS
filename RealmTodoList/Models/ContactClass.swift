//
//  Model.swift
//  RealmTodoList
//
//  Created by Neosoft on 03/04/22.
//
import RealmSwift
import Foundation
class Contact:Object{
    
    @Persisted var firstName:String
    @Persisted var lastName:String
    
    convenience init(firstName:String,lastName:String) {
        self.init()
        self.firstName = firstName
        self.lastName = lastName
    }
}
