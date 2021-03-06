//
//  LaunchViewController.swift
//  Covid19AlarmApp
//
//  Created by Hamlit Jason on 2021/08/01.
//

import UIKit

class SplashViewController : UIViewController {
    
    var COVIDAPICALL = LoadCOVID19API.shared // 싱글톤 객체 - 호출
    var Model = TableModel.shared // 싱글톤 객체 - 모델
    
    override func viewDidLoad() {
        super.viewDidLoad()
        COVIDAPICALL.parsing()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkDeviceNetworkStatus()
        
    }
    
    func checkDeviceNetworkStatus() {
        
        if !(DeviceManager.shared.networkStatue) {
            let alert: UIAlertController = UIAlertController(title: "네트워크 상태 확인", message: "네트워크가 불안정 합니다.", preferredStyle: .alert)
            let action: UIAlertAction = UIAlertAction(title: "다시 시도", style: .default, handler: { (action) in
                self.checkDeviceNetworkStatus()
            })
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        } else if Model.books.count == 0 {
            let AlertDialog = UIAlertController(title: "정부에서 코로나 현황을 업데이트 중입니다.", message: "NETWORK ERROR", preferredStyle: .alert)
        
            let okAction = UIAlertAction(title: "확인", style: .default) {
                _ in
                sleep(10000)
            }
            AlertDialog.addAction(okAction)
            present(AlertDialog, animated: true)
            print("AD")
        } else {
            guard let vc = self.storyboard?.instantiateViewController(identifier: "firstVC") else {
                print("ERROR")
                return
            }
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
        }
        
    }
}
