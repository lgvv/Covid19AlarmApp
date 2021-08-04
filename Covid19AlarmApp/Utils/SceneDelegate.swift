//
//  SceneDelegate.swift
//  Covid19AlarmApp
//
//  Created by Hamlit Jason on 2021/07/20.
//

import UIKit
import UserNotifications

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var Model = TableModel.shared // 싱글톤 객체 - 모델

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }

    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
        
        if #available(iOS 10.0, *) { // iOS 버전 10 이상에서 작동
            
            UNUserNotificationCenter.current().getNotificationSettings { [self] settings in
                
                if settings.authorizationStatus == UNAuthorizationStatus.authorized && UserDefaults.standard.integer(forKey: "BellCheck") == 1 {
                    /*
                     로컬 알림을 발송할 수 있는 상태이고, 등록된 벨 값이 있으면
                     - 유저의 동의를 구한다.
                     */
                    let location = UserDefaults.standard.string(forKey: "BellLocation")
                    let nContent = UNMutableNotificationContent() // 로컬알림에 대한 속성 설정 가능
                    nContent.title = "🦠오늘의 코로나 현황 알림⏰"
                    nContent.subtitle = "우리나라 총 확진자 : \(self.Model.books[18].defCnt)"
                    nContent.body = "\(location!) 총 확진자 : \(Model.books[1].defCnt)\n\(location!) 오늘 확진자 : \(Model.books[1].incDec)"
                    nContent.sound = UNNotificationSound.default
                    nContent.userInfo = ["name":"lgvv"]
                    
                    var date = DateComponents()
                    date.hour = 8
                    date.minute = 50
                    
                    
                    // 알림 발송 조건 객체
                    let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: false)
                    // 알림 요청 객체
                    let request = UNNotificationRequest(identifier: "wakeup", content: nContent, trigger: trigger)
                    // NotificationCenter에 추가
                    UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
                } else {
                    NSLog("User not agree")
                }
            }
            
        } else {
            NSLog("User iOS Version lower than 13.0. please update your iOS version")
            // iOS 9.0 이하에서는 UILocalNotification 객체를 활용한다.
        }
        
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

