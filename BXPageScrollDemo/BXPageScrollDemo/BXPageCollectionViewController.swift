//
//  BXPageCollectionViewController.swift
//  BXPageScrollDemo
//
//  Created by 毕向北 on 2017/7/9.
//  Copyright © 2017年 bifujian. All rights reserved.
//

import UIKit

class BXPageCollectionViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    private var selectedIndex: Int = 0
    private let itemWith: CGFloat = 100
    private let itemHeight: CGFloat = 100
    private let numberOfItem: NSInteger = 20
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        self.setPageCollection()
    }
    func setPageCollection(){
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: itemWith, height:itemHeight)
        flowLayout.sectionInset = UIEdgeInsetsMake(205, 0, itemHeight*3+64, 0)
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.scrollDirection = .vertical
        let frame = CGRect(x: UIScreen.main.bounds.width/2-itemWith/2, y: 0, width: itemHeight, height: UIScreen.main.bounds.height)
        let collectionView = UICollectionView(frame: frame, collectionViewLayout: flowLayout)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.backgroundColor = UIColor.clear
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
        let line = UIView(frame: CGRect(x: 0, y: 205, width: UIScreen.main.bounds.size.width, height: 1))
        line.backgroundColor = .red
        view.addSubview(line)
        let bottomLine = UIView(frame: CGRect(x: 0, y: 305, width: UIScreen.main.bounds.size.width, height: 1))
        bottomLine.backgroundColor = .red
        view.addSubview(bottomLine)
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        switch  indexPath.item{
        case numberOfItem:
            cell.contentView.backgroundColor = UIColor.yellow
        case let x where x % 2 == 0:
            cell.contentView.backgroundColor = UIColor.orange
        case let x where x % 2 == 1:
            cell.contentView.backgroundColor = UIColor.green
        default:
            cell.contentView.backgroundColor = UIColor.red
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.item {
        case numberOfItem:
            let n = UIScreen.main.bounds.size.height/itemHeight
            let height = UIScreen.main.bounds.size.height - itemHeight*n
            return CGSize(width: itemWith, height: height)
        default:
            return CGSize(width: itemWith, height: itemHeight)
        }
    }
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let y = targetContentOffset.pointee.y
        let pageHeight = itemHeight
        let moveindex = y - pageHeight*CGFloat(selectedIndex)
        if moveindex <  -pageHeight*0.5{
            selectedIndex -= 1
        }else if moveindex > pageHeight*0.5 {
            selectedIndex += 1
        }
        if abs(velocity.y) >= 2{
            targetContentOffset.pointee.x = pageHeight * CGFloat(selectedIndex)
        }else{
            targetContentOffset.pointee.y = scrollView.contentOffset.y
            scrollView .setContentOffset(CGPoint(x: 0, y: pageHeight * CGFloat(selectedIndex)), animated: true)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
