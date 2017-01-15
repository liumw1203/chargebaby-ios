//
//  LMWMapNavigationViewController.swift
//  chargebaby
//
//  Created by 刘明伟 on 2016/12/29.
//  Copyright © 2016年 刘明伟. All rights reserved.
//

import UIKit
import MapKit

class LMWMapNavigationViewController: UIViewController {

    let SHARE_APPLICATION = UIApplication.shared
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func creatOptionMenu(){
        
        let optionMenu = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        if(SHARE_APPLICATION.canOpenURL(NSURL(string:"qqmap://")! as URL) == true){
            let qqAction = UIAlertAction(title: "腾讯地图", style: .default, handler: {
                (alert: UIAlertAction!) -> Void in
//                let urlString = "qqmap://map/routeplan?from=我的位置&type=drive&tocoord=\(self.centerLat),\(self.centerLng)&to=\(self.siteTitle)&coord_type=1&policy=0"
                let urlString = "qqmap://map/routeplan?from=我的位置&type=drive&tocoord=\(30.306906),\(120.107265)&to=\("星星充电")&coord_type=1&policy=0"
                let url = NSURL(string:urlString)
                self.SHARE_APPLICATION.openURL(url! as URL)
                
            })
            optionMenu.addAction(qqAction)
        }
        
        if(SHARE_APPLICATION.canOpenURL(NSURL(string:"iosamap://")! as URL) == true){
            let gaodeAction = UIAlertAction(title: "高德地图", style: .default, handler: {
                (alert: UIAlertAction!) -> Void in
                let urlString = "iosamap://navi?sourceApplication=app名&backScheme=iosamap://&lat=\(30.306906)&lon=\(120.107265)&dev=0&style=2"
                
                let url = NSURL(string:urlString)
                self.SHARE_APPLICATION.openURL(url! as URL)

                
            })
            optionMenu.addAction(gaodeAction)
        }
        
        if(SHARE_APPLICATION.canOpenURL(NSURL(string:"comgooglemaps://")! as URL) == true){
            let googleAction = UIAlertAction(title: "Google地图", style: .default, handler: {
                (alert: UIAlertAction!) -> Void in
                let urlString = "comgooglemaps://?x-source=app名&x-success=comgooglemaps://&saddr=&daddr=\(30.306906),\(120.107265)&directionsmode=driving"
//                let url = NSURL(string:urlString.stringByAddingPercentEscapesUsingEncoding(String.Encoding.utf8)!)
                let url = NSURL(string:urlString)
                self.SHARE_APPLICATION.openURL(url! as URL)
                
            })
            optionMenu.addAction(googleAction)
        }
        
        let appleAction = UIAlertAction(title: "苹果地图", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            let loc = CLLocationCoordinate2DMake(30.306906, 120.107265)
            let currentLocation = MKMapItem.forCurrentLocation()
            let toLocation = MKMapItem(placemark:MKPlacemark(coordinate:loc,addressDictionary:nil))
            toLocation.name = "星星充电"
            MKMapItem.openMaps(with: [currentLocation,toLocation], launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving,MKLaunchOptionsShowsTrafficKey: NSNumber(value: true)])
            
        })
        optionMenu.addAction(appleAction)
        
        if(SHARE_APPLICATION.canOpenURL(NSURL(string:"baidumap://")! as URL) == true){
            let baiduAction = UIAlertAction(title: "百度地图", style: .default, handler: {
                (alert: UIAlertAction!) -> Void in
                let urlString = "baidumap://map/direction?origin={{我的位置}}&destination=latlng:\(30.306906),\(120.107265)|name=\("星星充电")&mode=driving&coord_type=gcj02"
                let url = NSURL(string:urlString)
                self.SHARE_APPLICATION.openURL(url! as URL)
                
            })
            optionMenu.addAction(baiduAction)
        }
        
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: {
            (alert: UIAlertAction!) -> Void in
        })
        optionMenu.addAction(cancelAction)
        
        self.present(optionMenu, animated: true, completion: nil)
    }

    func test() {
        
        let alertController = UIAlertController(title: nil, message: "Takes the appearance of the bottom bar if specified; otherwise, same as UIActionSheetStyleDefault.", preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            // ...
        }
        alertController.addAction(cancelAction)
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
            // ...
        }
        alertController.addAction(OKAction)
        let destroyAction = UIAlertAction(title: "Destroy", style: .destructive) { (action) in
            print(action)
        }
        alertController.addAction(destroyAction)
        self.present(alertController, animated: true) {
            // ...
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
