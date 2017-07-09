//
//  ViewController.swift
//  BXPageScrollDemo
//
//  Created by 毕向北 on 2017/7/9.
//  Copyright © 2017年 bifujian. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    //TableView data Source
    private let itemsTitles: [String] = ["page collection"]
    private var viewControllers: [UIViewController] {
        get {
            return [BXPageCollectionViewController()]
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.setMyTableview();
        self.title = "pageCollection"
    }
    func setMyTableview() {
        let mainTableView = UITableView(frame:CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
        mainTableView.rowHeight = 50;
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(mainTableView)
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsTitles.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = itemsTitles[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(viewControllers[indexPath.row], animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

