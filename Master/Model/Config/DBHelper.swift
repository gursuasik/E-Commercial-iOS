//
//  DBHelper.swift
//  Master
//
//  Created by Gürsu Aşık on 7.09.2018.
//  Copyright © 2018 RND. All rights reserved.
//

import Foundation
import SQLite3

class DBHelper {
    var db: OpaquePointer?
    var fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("master.sqlite")
    
    internal let SQLITE_STATIC = unsafeBitCast(0, to: sqlite3_destructor_type.self)
    internal let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self)
    
    class Token {
        static let TABLE_NAME = "token"
        static let USERNAME = "username";
        static let PASSWORD = "password"
    }
    
    init() {
        onCreate()
    }
    
    func onCreate() {
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("error opening database")
        }

        sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS " + Token.TABLE_NAME + "(" + Token.USERNAME + " TEXT, " + Token.PASSWORD + " TEXT)", nil, nil, nil)
        
        if sqlite3_close(db) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error closing database: \(errmsg)")
        }
        db = nil
    }
    
    func insertToken(tokenRequest: TokenRequest) {
        sqlite3_open(fileURL.path, &db)
        
        var insertUserStatement: OpaquePointer?
        sqlite3_prepare_v2(db, "INSERT INTO " + Token.TABLE_NAME + "(" + Token.USERNAME + ", " + Token.PASSWORD + ") VALUES(?, ?)", -1, &insertUserStatement, nil)
        
        sqlite3_bind_text(insertUserStatement, 1, tokenRequest.username, -1, SQLITE_TRANSIENT)
        sqlite3_bind_text(insertUserStatement, 2, tokenRequest.password, -1, SQLITE_TRANSIENT)
        
        sqlite3_step(insertUserStatement)
        
        sqlite3_finalize(insertUserStatement)
        
        sqlite3_close(db)
        db = nil
    }
    
    func selectUser() -> TokenRequest? {
        sqlite3_open(fileURL.path, &db)
        
        var selectUserStatement: OpaquePointer?
        sqlite3_prepare_v2(db, "SELECT " + Token.USERNAME + ", " + Token.PASSWORD + " FROM " + Token.TABLE_NAME, -1, &selectUserStatement, nil)
        
        var user: TokenRequest?
        while sqlite3_step(selectUserStatement) == SQLITE_ROW {
            user = TokenRequest(username: String(cString: sqlite3_column_text(selectUserStatement, 0)), password: String(cString: sqlite3_column_text(selectUserStatement, 1)))
        }
        
        sqlite3_finalize(selectUserStatement)
        selectUserStatement = nil
        
        sqlite3_close(db)
        db = nil

        return user
    }
    
    func deleteUser() {
        sqlite3_open(fileURL.path, &db)
        
        var deleteUserStatement: OpaquePointer?
        sqlite3_prepare_v2(db, "DELETE FROM " + Token.TABLE_NAME, -1, &deleteUserStatement, nil)
        
        sqlite3_step(deleteUserStatement)
        
        sqlite3_finalize(deleteUserStatement)
        
        sqlite3_close(db)
        db = nil
    }
}
