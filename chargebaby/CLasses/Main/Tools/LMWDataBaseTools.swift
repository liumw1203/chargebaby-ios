//
//  LMWDataBaseTools.swift
//  chargebaby
//
//  Created by 刘明伟 on 2017/1/3.
//  Copyright © 2017年 刘明伟. All rights reserved.
//

import Foundation

class LMWDataBaseTools: NSObject {
    //获取所有charge
    func getAllCharge() -> [[String:Any]] {
        //获取数据库数据
        
        //如果表还不存在则创建表（其中uid为自增主键）
        let result = SQLITE_DB.execute(sql: "create table if not exists t_user(uid integer primary key,uname varchar(20),mobile varchar(20))")
        print(result)
        
        let data = SQLITE_DB.query(sql: "select * from Charge")
        
      
        //        print(data)
        return data
        
    }
    
    static func getChargeByNo(chargeNo:String) ->[String:Any]{
        //获取数据库实例
        let db = SQLiteDB.sharedInstance
        
        let data = db.query(sql: "select * from charge where charge_no = ?", parameters:[chargeNo])
    
        if data.count > 0 {
            return data[0]
        }else{
            return [:]
        }
    }

    static func chargedicTransCharge(chargedic: [String: Any]) -> Charge{
        let charge:Charge! = Charge()
        
        charge.id = chargedic["id"] as? Int64
        charge.create_time  = chargedic["create_time"] as? Date
        charge.update_time  = chargedic["update_time"] as? Date
        charge.charge_no  = chargedic["charge_no"] as? String
        charge.name  = chargedic["name"] as? String
        charge.area = chargedic["area"] as? String
        charge.address  = chargedic["address"] as? String
        charge.price  = chargedic["price"] as? String
        charge.ac_builded = chargedic["ac_builded"] as? Int
        charge.ac_building = chargedic["ac_building"] as? Int
        charge.dc_builded = chargedic["dc_builded"] as? Int
        charge.dc_building = chargedic["dc_building"] as? Int
        charge.longitude = chargedic["longitude"] as? Double
        charge.latitude = chargedic["latitude"] as? Double
        charge.begin_time = chargedic["begin_time"] as? String
        charge.tel = chargedic["tel"] as? String
        charge.standard_name = chargedic["standard_name"] as? String
        charge.fee_standard = chargedic["fee_standard"] as? String
        charge.detail = chargedic["detail"] as? String
        charge.depart = chargedic["depart"] as? String
    
        return charge
    
    }

    
}
    
