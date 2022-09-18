//
//  UsersDBHelper.swift
//  TrailDatabase
//
//  Created by Hei Lok Keith Kong on 15/9/2022.
//

import Foundation
import SQLite3
import UIKit

class UsersDBHelper {
    var DB: OpaquePointer?
    var DBname: String = "lostItemUsers.sqlite"
    init () {
        self.DB = createDB()
        self.createTable()
    }
    
    // 1. initilialize a database
    func createDB() -> OpaquePointer? {
        let DBpath = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathExtension(DBname)
        
        var DB: OpaquePointer? = nil
        
        if sqlite3_open(DBpath.path, &DB) != SQLITE_OK {
            sqlite3_close(DB)
            print("Failed to open database")
            return nil
        } else {
            print("Connected to database with path \(DBpath)")
            return DB
        }
    }
    
    // 2. create a table
    func createTable() {
        let createTableString = """
        CREATE TABLE IF NOT EXISTS users(
        Id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_name TEXT,
        password TEXT);
        """
        var createTableStatement:OpaquePointer? = nil
        
        if sqlite3_prepare_v2(DB, createTableString, -1, &createTableStatement, nil) == SQLITE_OK {
            if sqlite3_step(createTableStatement) == SQLITE_DONE {
                print("Created table")
            } else {
                print("Failed to create table")
            }
        } else {
            print("Failed to prepare table")
        }
        sqlite3_finalize(createTableStatement)
    }
    
    // 3. insert data
    func insert(user_name: String, password: String) {
        
        let insertString = "INSERT INTO Users (Id, user_name, password) VALUES (?, ?, ?);"
        var insertStatement: OpaquePointer? = nil
        
        var isEmpty = false
        if query()!.isEmpty {
            isEmpty = true
        }
        
        if sqlite3_prepare_v2(DB, insertString, -1, &insertStatement, nil) == SQLITE_OK {
            if isEmpty {
                sqlite3_bind_int(insertStatement, 1, 1)
            }
            sqlite3_bind_text(insertStatement, 2, (user_name as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 3, (password as NSString).utf8String, -1, nil)
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Inserted data")
            } else {
                print("Failed to insert data")
            }
        } else {
            print("Failed to prepare table")
        }
    }
    
    // 4. query data
    func query() -> [UserDB]? {
        var modelList = [UserDB]()
        let queryString = "SELECT * FROM Users;"
        var queryStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(DB, queryString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let id:Int = Int(sqlite3_column_int(queryStatement, 0))
                let user_name:String = String(cString: sqlite3_column_text(queryStatement, 1))
                let password:String = String(cString: sqlite3_column_text(queryStatement, 2))
                
                let model = UserDB()
        
                model.id = id
                model.user_name = user_name
                model.password = password
                modelList.append(model)
            }
            return modelList
        } else {
            print("Failed to query data")
            return nil
        }
    }
    
    // 5. Update data
    func update (id: Int, user_name: String, password: String){
        
        let updateString = "UPDATE Users SET user_name = \(user_name), password = \(password) WHERE Id = \(id);"
        var updateStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(DB, updateString, -1, &updateStatement, nil) == SQLITE_OK {
            if sqlite3_step(updateStatement) == SQLITE_DONE {
                print("Updated data")
            } else {
                print("Failed to update data")
            }
        }
    }
    
    // 6. Delete data
    func delete(id: Int) {
        let deleteString = "DELETE FROM Users where Id = \(id)"
        var deleteStatement:OpaquePointer? = nil
        if sqlite3_prepare_v2(DB, deleteString, -1, &deleteStatement, nil) == SQLITE_OK {
            if sqlite3_step(deleteStatement) == SQLITE_DONE {
                print("Deleted data at id \(id)")
            } else {
                print("Failed to delete data")
            }
        }
    }
}
