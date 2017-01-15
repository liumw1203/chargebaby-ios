//
//  LMWHomeViewController.swift
//  chargebaby
//
//  Created by 刘明伟 on 2016/11/10.
//  Copyright © 2016年 刘明伟. All rights reserved.
//

import UIKit
import AVFoundation
import MapKit


class LMWHomeViewController: UIViewController, MAMapViewDelegate,LMWPopBottomViewDelegate  {

    
    //获取数据库实例
    var db = SQLiteDB.sharedInstance
    
    var charges :[[String:Any]] = []
    
    
    /**charge中的数据*/
    //编码
    
    //充电点名称
    var name = ""
    //地址
    var address = ""
    //距离
    var distance = ""
    //距离的值
    var distanceValue = 0.0
    

    
    var annotations = [MAAnnotation]()
    var mapView: MAMapView!
    var polyline: MAPolyline?
    var coordinateArray: [CLLocationCoordinate2D] = []
    
    //定位
    var currentLocation:CLLocation?
    //定位点值
    var currentPoint:MAMapPoint?
    //当前维度
    var currentLatitude:Double?
    //当前经度
    var currentLongitude:Double?
    //点击标注物，弹出的bottomView
//    let popBottomView: LMWPopBottomView？
    
    //MARK: - Life Cycle
    
//    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: Bundle!) {
//        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置导航搜索框
        initNavSearchBar()
     
        //获取所有charge
        charges = getAllCharge()
        
        
        // 初始化MAMapView
        initMapView()
        
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        self.tabBarController?.hidesBottomBarWhenPushed = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        //开始定位
//        startLocation()

//        let long = currentLocation?.coordinate.longitude
        
        //        var pointAnnotation = MAPointAnnotation()
//        pointAnnotation.coordinate = CLLocationCoordinate2DMake(39.989614, 39.989614)
        for charge in charges {
            //必须放在循环内初始化
            let annotationCharge = ChargePointAnnotation()
            let lati = charge["latitude"] as? Double
            let long = charge["longitude"] as? Double
//            let chargeNoValue = charge["charge_no"] as? NSObject
            let pointCharge = MAMapPointForCoordinate(annotationCharge.coordinate)

            annotationCharge.coordinate = CLLocationCoordinate2DMake(Double(lati!), Double(long!))
//            distanceValue = MAMetersBetweenMapPoints(pointCharge, currentPoint!)

            annotationCharge.charge_no = charge["charge_no"] as! String?
            annotationCharge.name = charge["name"] as! String?
            annotationCharge.address = charge["address"] as! String?
            annotationCharge.price = charge["fee_standard"] as!String?
            annotationCharge.ac_builded = charge["ac_builded"] as!Int?
            annotationCharge.ac_building = charge["ac_building"] as!Int?
            annotationCharge.dc_builded = charge["dc_builded"] as!Int?
            annotationCharge.dc_building = charge["dc_building"] as!Int?
            
            
            annotations.append(annotationCharge)

        }

        mapView!.addAnnotations(annotations)

        

        
    }

    //初始化导航栏搜索框
    fileprivate func initNavSearchBar(){
        let sbHeight = self.navigationController?.navigationBar.frame.height


        
//        let searchBar:UISearchBar = UISearchBar(frame: CGRect(x:0.0, y:0.0, width:200.0, height: sbHeight!))
//        var leftNavBarButton = UIBarButtonItem(customView:searchBar)
//        self.navigationItem.leftBarButtonItem = leftNavBarButton
 
        let searchBar = LMWHomeSearchBar(frame: CGRect(x:0.0, y:0.0, width:SCREENW-30, height: sbHeight!))
        
//        searchBar.snp.makeConstraints { (make) in
//            make.right.equalTo(0)
////            make.center.equalTo(self)
//        }
        let leftNavBarButton = UIBarButtonItem(customView:searchBar)
        
        self.navigationItem.leftBarButtonItem = leftNavBarButton
        self.navigationController?.navigationBar.barTintColor = UIColor.orange
        
//        let tapGesture = UITapGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(gotoSearchStoryborad)))
        searchBar.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(gotoSearchStoryborad)))
        
        
    }
    
    
    //跳转到搜索页面
    func gotoSearchStoryborad(){
        
          print("点击搜索")
        let storyBoard = UIStoryboard(name: "LMWSearchViewStoryboard", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "searchViewStoryboard") as!LMWSearchViewController
        
//        vc.charge_no = gotoCScharge_no
        
        self.navigationController?.pushViewController(vc, animated: true)
        self.tabBarController?.tabBar.isHidden = true

    }
    func initMapView() {
        mapView = MAMapView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height-40))
        mapView!.delegate = self
        
//        let compassX = mapView?.compassOrigin.x
        
        let scaleX = mapView?.scaleOrigin.x
        
        //设置指南针和比例尺的位置
//        mapView?.compassOrigin = CGPointMake(compassX!, 21)
//        
//        mapView?.scaleOrigin = CGPoint(dictionaryRepresentation: scaleX)
        
        mapView?.showsCompass = true
        mapView?.showsScale = true
        mapView?.customizeUserLocationAccuracyCircleRepresentation = true
        
        // 开启定位
//        startLocation()
        
        
        self.view.insertSubview(mapView, at: 0)
    }
    
    func startLocation(){
        mapView!.showsUserLocation = true
        mapView!.zoomLevel = 15.5
        mapView!.distanceFilter = 3.0
//        mapView.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        // 设置跟随定位模式，将定位点设置成地图中心点
        mapView!.userTrackingMode = MAUserTrackingMode.follow
        mapView!.pausesLocationUpdatesAutomatically = false
        mapView!.allowsBackgroundLocationUpdates = true
    }
    
   
    
    
    
    
    // 定位回调,每次有位置更新变会调用
    func mapView(_ mapView: MAMapView!, didUpdate userLocation: MAUserLocation!, updatingLocation: Bool) {
        if updatingLocation {
            currentLocation = userLocation.location
//            currentPoint = MAMapPointForCoordinate(CLLocationCoordinate2DMake((currentLocation?.coordinate.latitude)!,(currentLocation?.coordinate.longitude)!));
            currentLatitude = currentLocation?.coordinate.latitude
            currentLongitude = currentLocation?.coordinate.longitude
//            print(lati?.description )
//            print(long?.description )
        }
    }
    

    
    //MARK: - MAMapViewDelegate
    
    func mapView(_ mapView: MAMapView!, rendererFor overlay: MAOverlay!) -> MAOverlayRenderer! {
        if overlay is MAPolyline {
            let polylineRenderer = MAPolylineRenderer(overlay: overlay)
            
            polylineRenderer?.lineWidth = 5.0
            polylineRenderer?.strokeColor = UIColor.red
            
            return polylineRenderer
        }
        return nil
    }
    // 点击Annoation回调
    func mapView(_ mapView: MAMapView!, viewFor annotation: MAAnnotation!) -> MAAnnotationView! {
        if annotation.isKind(of: MAPointAnnotation.self) {
            let annotationIdentifier = "annotationIdentifier"
            
            var poiAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier) as? MAPinAnnotationView
            
            if poiAnnotationView == nil {
                poiAnnotationView = MAPinAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
            }
            
            // 设置覆盖物图片
            poiAnnotationView?.image = UIImage(named: "icon_mark_charge_72*72")
            //设置覆盖物图片大小
            poiAnnotationView?.frame = CGRect(x:0, y:0,width:40,height:40 )
            poiAnnotationView!.animatesDrop   = true
            //canShowCallout＝true为弹出高德sdk 中的气泡对话框样式
            poiAnnotationView!.canShowCallout = false
            
            return poiAnnotationView;
        }
        return nil
    }
   
    
    // 点击Annoation回调
    // 若点击的是定位标注，则执行popwindow
    func mapView(_ mapView: MAMapView!, didSelect view: MAAnnotationView!) {
        
        if view.annotation is ChargePointAnnotation{
            var ac_builded = 0
            var ac_building = 0
            var dc_builded = 0
            var dc_building = 0
            
            let chargeAnnotation = view.annotation as! ChargePointAnnotation?
            
            if (chargeAnnotation?.ac_builded != nil) {
                
                ac_builded = (chargeAnnotation?.ac_builded)!
            }
            
            if (chargeAnnotation?.ac_building != nil) {
                
                
                ac_building = (chargeAnnotation?.ac_building)!
            }
            
            if (chargeAnnotation?.dc_builded != nil) {
                
                
                dc_builded = (chargeAnnotation?.dc_builded)!
            }
            
            if (chargeAnnotation?.dc_building != nil) {
                
                dc_building = (chargeAnnotation?.dc_building)!
                
            }
            
            let popBottomView = LMWPopBottomView(frame: self.view.bounds)
            popBottomView.charge_no = chargeAnnotation?.charge_no
            popBottomView.name = chargeAnnotation?.name
            popBottomView.price = chargeAnnotation?.price
            popBottomView.address = chargeAnnotation?.address
            popBottomView.ac = ac_builded + ac_building
            popBottomView.dc = dc_builded + dc_building
            popBottomView.longitude = chargeAnnotation?.coordinate.longitude
            popBottomView.latitude = chargeAnnotation?.coordinate.latitude
            
            //判断是否登录
            if (LMWGlobalIsLogin) {
                
                popBottomView.isFavorite = GetDataFromRemote.isFavorite(chargeNo: (chargeAnnotation?.charge_no)!, favorites: (LMWGlobalUserInfo?.favoriteList)!)
            }else{
                popBottomView.isFavorite = false
            }
            popBottomView.delegate = self
            popBottomView.showInView(self.view)
        }
    }
    
    
    
    //获取所有charge
    func getAllCharge() -> [[String:Any]] {
        //获取数据库数据
        //如果表还不存在则创建表（其中uid为自增主键）
        let result = db.execute(sql: "create table if not exists t_user(uid integer primary key,uname varchar(20),mobile varchar(20))")
        print(result)
        
        let data = db.query(sql: "select * from Charge")
//        print(data)
        return data

    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    
    //MARK : - LMWPopBottomViewDelegate
    /**
     页面弹出的时候
     */
    func viewWillAppear(){
    
        self.tabBarController?.tabBar.isHidden = true
    }
    
    /**
     页面消失的时候
     */
    func viewWillDisappear(){
        self.tabBarController?.tabBar.isHidden = false
    }
    
    //导航
    func nav(name:String, latitude:Double, longitude:Double) {
        print("测试导航按钮" + "name =" + name   )
        
        LMWTools().nav(controller: self, name: name, latitude: latitude, longitude: longitude)
    }
    
    func gotoChargeStoryboard(gotoCScharge_no:String) {
      
//        let storyBoard = UIStoryboard(name: "LMWChargeStoryboard", bundle: nil)
//        let vc = storyBoard.instantiateViewController(withIdentifier: "chargeStoryboard") as!LMWChargeViewController
//        
//        vc.charge_no = gotoCScharge_no
        
        let storyBoard = UIStoryboard(name: "LMWChargeDetailViewStoryboard", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "chargeDetailStoryboard") as!LMWChargeDetailViewController
        
//        vc.charges = charges
        vc.charge_no = gotoCScharge_no
        
        self.navigationController?.pushViewController(vc, animated: true)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    func favorite(chargeNo:String, isFavorite:Bool, popBottomView: LMWPopBottomView)   {

        if (isFavorite){
            // 启动线程执行已经收藏，取消收藏            
                let result = GetDataFromRemote.removeFavorite(userId: (LMWGlobalUserInfo?.id!)!, chargeNo: chargeNo)
                if(result){
                    popBottomView.isFavorite = false
                    popBottomView.bottomView.myFavoriteIV.image = FAVORITE_WHITE_IMG
                    let alertController = UIAlertController(title: "取消收藏成功",
                                                            message: nil, preferredStyle: .alert)
                    //显示提示框
                    self.present(alertController, animated: true, completion: nil)
//                    popBottomView.reloadInputViews()
                }else{
                    let alertController = UIAlertController(title: "取消收藏失败",
                                                            message: nil, preferredStyle: .alert)
                    //显示提示框
                    self.present(alertController, animated: true, completion: nil)
                }
                //                Thread.sleep(forTimeInterval: 2)
            
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                    self.presentedViewController?.dismiss(animated: false, completion: nil)
                }
        }else {

            //还未收藏，添加收藏
            
            let result = GetDataFromRemote.addFavorite(userId: (LMWGlobalUserInfo?.id!)!, chargeNo: chargeNo)
            if(result){
                popBottomView.isFavorite = true
                popBottomView.bottomView.myFavoriteIV.image = FAVORITE_RED_IMG

                let alertController = UIAlertController(title: "添加收藏成功",
                                                        message: nil, preferredStyle: .alert)
                //显示提示框
                self.present(alertController, animated: true, completion: nil)
                popBottomView.reloadInputViews()
            }else{
                let alertController = UIAlertController(title: "添加收藏失败",
                                                        message: nil, preferredStyle: .alert)
                //显示提示框
                self.present(alertController, animated: true, completion: nil)
            }
            //            Thread.sleep(forTimeInterval: 1)
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                
                self.presentedViewController?.dismiss(animated: false, completion: nil)
            }
            }
    }

}
