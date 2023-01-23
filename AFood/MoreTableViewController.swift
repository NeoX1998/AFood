//
//  MoreTableViewController.swift
//  AFood
//
//  Created by 許博皓 on 2023/1/16.
//

import UIKit
import SafariServices

class MoreTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.prefersLargeTitles = true

        // 載入表格資料
        tableView.dataSource = dataSource
        updateSnapshot()
    }

    enum Section {
        case feedback
        case followus
        case others
    }
    
    struct LinkItem: Hashable {
        var text: String
        var link: String
        var image: String
    }
    
    var sectionContent = [ [LinkItem(text: "Rate us on App Store", link: "https://www.apple.com/ios/app-store/", image: "appStoreIcon2")],
                           [LinkItem(text: "Facebook", link: "https://www.facebook.com", image: "facebook"),
                            LinkItem(text: "Instagram", link: "https://www.instagram.com", image: "instagram")],
                           [LinkItem(text: "Terms of Service", link: "https://www.termsfeed.com/live/886582c2-1036-4a07-8dc1-6b7d854ca685", image: ""),
                            LinkItem(text: "Privacy Policy", link: "https://www.privacypolicies.com/live/40960290-6e20-4711-ace4-736f3d532c82", image: ""),
                            LinkItem(text: "Disclaimer", link: "https://www.privacypolicies.com/live/2997f592-e76f-4143-87fe-94417ec69659", image: "")]
                            ]
    
    
    // MARK: - Table view data source
    func configureDataSource() -> UITableViewDiffableDataSource<Section, LinkItem> {
        
        let cellIdentifier = "morecell"
        
        let dataSource = UITableViewDiffableDataSource<Section, LinkItem>(tableView: tableView) { (tableView, indexPath, linkItem) -> UITableViewCell? in
            
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
            
            cell.textLabel?.text = linkItem.text
            cell.imageView?.image = UIImage(named: linkItem.image)
            
            return cell
        }
        
        return dataSource
    }
    
    lazy var dataSource = configureDataSource()
    //使用lazy修飾器宣告變數,因為在初始化完成之前無法取得其初始值
    
    
    func updateSnapshot() {
        
        //建立一個快照並填入資料
        var snapshot = NSDiffableDataSourceSnapshot<Section, LinkItem>()
        snapshot.appendSections([.feedback, .followus, .others]) //呼叫appendSections方法來加入所有區塊 (要支援有多個區塊的表格視圖的話
        snapshot.appendItems(sectionContent[0], toSection: .feedback) //使用appendItems方法來指定區塊項目
        snapshot.appendItems(sectionContent[1], toSection: .followus) //使用appendItems方法來指定區塊項目
        snapshot.appendItems(sectionContent[2], toSection: .others)
        
        dataSource.apply(snapshot, animatingDifferences: false) //將快照應用在資料來源中
    }
    
    
    
    //使用者選取列之後,呼叫列的選取
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // 切換至Safari開啟網頁內容
        guard let linkItem = self.dataSource.itemIdentifier(for: indexPath) else { // 取得所選連結項目
            return
        }

        if let url = URL(string: linkItem.link) {
            UIApplication.shared.open(url)
        }
        
        //取消列的選取: 選取完後不會有灰色突出
        tableView.deselectRow(at: indexPath, animated: false)
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
