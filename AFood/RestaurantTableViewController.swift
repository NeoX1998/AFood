//
//  RestaurantTableViewController.swift
//  AFood
//
//  Created by 許博皓 on 2023/1/16.
//

import UIKit

class RestaurantTableViewController: UITableViewController {

    var searchController: UISearchController! // 建立 UISearchController 物件
    
    lazy var dataSource = configureDataSource()
    
    var restaurants: [Restaurant] = [
        Restaurant(name: "Cafe Deadend", type: "Coffee & Tea Shop", location: "Hong Kong", image: "cafedeadend", isFavorite: false),
        Restaurant(name: "Homei", type: "Cafe", location: "Hong Kong", image: "homei", isFavorite: false),
        Restaurant(name: "Teakha", type: "Tea House", location: "Hong Kong", image: "teakha", isFavorite: false),
        Restaurant(name: "Cafe Loisl", type: "Austrain / Causual Drink", location: "Hong Kong", image: "cafeloisl", isFavorite: false),
        Restaurant(name: "Petite Oyster", type: "French", location: "Hong Kong", image: "petiteoyster", isFavorite: false),
        Restaurant(name: "For Kee Restaurant", type: "Bakery", location: "Hong Kong", image: "forkeerestaurant", isFavorite: false),
        Restaurant(name: "Po's Atelier", type: "Bakery", location: "Hong Kong", image: "posatelier", isFavorite: false),
        Restaurant(name: "Bourke Street Bakery", type: "Chocolate", location: "Sydney", image: "bourkestreetbakery", isFavorite: false),
        Restaurant(name: "Haigh's Chocolate", type: "Cafe", location: "Sydney", image: "haighschocolate", isFavorite: false),
        Restaurant(name: "Palomino Espresso", type: "American / seafood", location: "Sydney", image: "palominoespresso", isFavorite: false),
        Restaurant(name: "Upstate", type: "American", location: "New Work", image: "upstate", isFavorite: false),
        Restaurant(name: "Traif", type: "American", location: "New Work", image: "traif", isFavorite: false),
        Restaurant(name: "Graham Avenue Meats And Deli", type: "Breakfast & Brunch", location: "New Work", image: "grahamavenuemeats", isFavorite: false),
        Restaurant(name: "Waffle & Wolf", type: "Coffee & Tea", location: "New Work", image: "wafflewolf", isFavorite: false),
        Restaurant(name: "Five Leaves", type: "Coffee & Tea", location: "New Work", image: "fiveleaves", isFavorite: false),
        Restaurant(name: "Cafe Lore", type: "Latin American", location: "New Work", image: "cafelore", isFavorite: false),
        Restaurant(name: "Confessional", type: "Spanish", location: "New Work", image: "confessional", isFavorite: false),
        Restaurant(name: "Barrafina", type: "Spanish", location: "London", image: "barrafina", isFavorite: false),
        Restaurant(name: "Donostia", type: "Spanish", location: "London", image: "donostia" ,isFavorite: false),
        Restaurant(name: "Royal Oak", type: "British", location: "London", image: "royaloak", isFavorite: false),
        Restaurant(name: "CASK Pub and Kitchen", type: "Thai", location: "London", image: "caskpubkitchen", isFavorite: false),
    ]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = dataSource //指定自訂的datasource給表格視圖的資料來源
        
        //建立要在表格視圖中顯示的資料快照
        var snapshot = NSDiffableDataSourceSnapshot<Section, Restaurant>() //使用區塊識別器型別Section與項目識別器型別String來建立空快照
        snapshot.appendSections([.all]) //加入一個區塊至快照
        snapshot.appendItems(restaurants, toSection: .all) //將restaurantNames陣列中的所有項目加入至.all區塊
        
        dataSource.apply(snapshot, animatingDifferences: false) //將快照應用在資料來源中
        
        tableView.separatorStyle = .none //移除儲存格分隔符號
        
        tableView.cellLayoutMarginsFollowReadableWidth = true //自動調整儲存格寬度
        
        navigationController?.navigationBar.prefersLargeTitles = true // 啟用導覽列大標題
        
//        prepareNotification() //呼叫通知函數
        
        searchController = UISearchController(searchResultsController: nil) // 搜尋結果會顯示於正在搜尋的相同視圖中
        self.navigationItem.searchController = searchController // 在導覽列加上搜尋列
    }

    // MARK: Data Source
    func configureDataSource() -> UITableViewDiffableDataSource<Section, Restaurant> {
        let cellIdentifier = "datacell"
        
        let dataSource = RestaurantDiffableDataSource(
            tableView: tableView,
            cellProvider: {  tableView, indexPath, restaurant in
                let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RestaurantTableViewCell
                
                cell.nameLabel.text = restaurant.name
                cell.locationLabel.text = restaurant.location
                cell.typeLabel.text = restaurant.type
                cell.thumbnailImageView.image = UIImage(named: restaurant.image)
                cell.favoriteImageView.isHidden = restaurant.isFavorite ? false : true
                
                return cell
            }
        )
        
        return dataSource
    }
    
    // MARK: User Notification
    func prepareNotification() {
        // 確認餐廳陣列不為空值
        if restaurants.count <= 0 {
            return
        }

        // 隨機選擇一間餐廳
        let randomNum = Int.random(in: 0..<restaurants.count)
        let suggestedRestaurant = restaurants[randomNum]
        
        // 建立使用者通知內容
        let content = UNMutableNotificationContent() // 建立 UNMutableNotificationContent 物件
        content.title = "Restaurant Recommendation" // 設定通知標題
        content.subtitle = "Try new food today" // 設定通知副標題
        content.body = "I recommend you to check out \(suggestedRestaurant.name). Would you like to give it a try?" // 設定通知本文
        content.sound = UNNotificationSound.default // 設定觸發通知時播放聲音
        
        // 建立自訂動作按鈕
        let categoryIdentifer = "xfood.restaurantaction"
        let makeReservationAction = UNNotificationAction(identifier: "xfood.makeReservation", title: "Reserve a table", options: [.foreground])
        let deletelAction = UNNotificationAction(identifier: "xfood.delete", title: "Delete a table", options: [])
        let cancelAction = UNNotificationAction(identifier: "xfood.cancel", title: "Later", options: [])
        let category = UNNotificationCategory(identifier: categoryIdentifer, actions: [makeReservationAction, deletelAction, cancelAction], intentIdentifiers: [], options: []) // 將動作物件與分類關聯在一起
        UNUserNotificationCenter.current().setNotificationCategories([category]) // 分類準備完成後在 UNUserNotificationCenter 註冊
        content.categoryIdentifier = categoryIdentifer // 將動作id設定給通知內容
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 8, repeats: false) // 建立偏好的觸發器: 在一段時間後觸發通知
//        var date = DateComponents()
//        date.hour = 8
//        date.minute = 9
//        let trigger2 = UNCalendarNotificationTrigger(dateMatching: date, repeats: true) // 建立觸發器: 在固定時間觸發通知
        let request = UNNotificationRequest(identifier: "xfood.restaurantSuggestion", content: content, trigger: trigger) // 以通知內容和觸發器來建立 UNNotificationRequest 物件

        // 排程通知
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
    
//    let searchResults = restaurants.filter({ (restaurant) -> Bool in
//        let isMatch = restaurant.name.localizedCaseInsensitiveContains(searchText)
//        return isMatch
//    })
    
    
    
    
    //使用者選取列之後,呼叫列的選取
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { //使用override關鍵字來覆寫父類別,常用於自訂內容

        //建立選項選單作為動作清單
        let optionMenu = UIAlertController(title: nil, message: "What do you want to do?", preferredStyle: .actionSheet)

        //加入動作至選單中
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        optionMenu.addAction(cancelAction)

        //訂位動作
        let reserveActionHandler = { (action: UIAlertAction!) -> Void in

            let alertMessage = UIAlertController(title: "Not available yet", message: "Sorry, this feature is not available yet. Please retry later.", preferredStyle: .alert)
            alertMessage.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alertMessage, animated: true, completion: nil)
        }

        let reserveAction = UIAlertAction(title: "Reserve a table", style: .default, handler: reserveActionHandler)
        optionMenu.addAction(reserveAction)

        //標記為最愛動作
        let favoriteActionTitle = self.restaurants[indexPath.row].isFavorite ? "Remove from favorite" : "Mark as favorite"

        let favoriteAction = UIAlertAction(title: favoriteActionTitle, style: .default, handler: { (action: UIAlertAction!) -> Void in
            let cell = tableView.cellForRow(at: indexPath) as! RestaurantTableViewCell

            cell.favoriteImageView.isHidden = self.restaurants[indexPath.row].isFavorite

            self.restaurants[indexPath.row].isFavorite = self.restaurants[indexPath.row].isFavorite ? false : true
        })
        optionMenu.addAction(favoriteAction)

        /*
        //標記為最愛動作
        let favoriteAction = UIAlertAction(title: "Mark as favorite", style: .default, handler: { (action: UIAlertAction!) -> Void in
            //let cell = tableView.cellForRow(at: indexPath) //使用indexPath來取得所選的表格儲存格,包含所選儲存格的索引
            //cell?.accessoryType = .checkmark //使用打勾標記更新儲存格的accessoryType屬性
            self.restaurant[indexPath.row].isFavorites = true //更新陣列的值,確保已選已被儲存
        })

        //刪除最愛動作
        let removeFavoriteAction = UIAlertAction(title: "Remove from favorite", style: .default, handler: { (action: UIAlertAction!) -> Void in
            //let cell = tableView.cellForRow(at: indexPath)
            //cell?.accessoryType = .none
            self.restaurant[indexPath.row].isFavorites = false
        })
        //儲存格有被標最愛的話提供刪除選項,反之亦然
        optionMenu.addAction(self.restaurant[indexPath.row].isFavorite ? removeFavoriteAction : favoriteAction)
        */
        //顯示選單
        present(optionMenu, animated: true, completion: nil)

        //取消列的選取: 選取完後不會有灰色突出
        tableView.deselectRow(at: indexPath, animated: false)

        //
        if let popoverController = optionMenu.popoverPresentationController {
            if let cell = tableView.cellForRow(at: indexPath) {
                popoverController.sourceView = cell
                popoverController.sourceRect = cell.bounds
            }
        }
    }
    
    
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

}
