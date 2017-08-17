//
//  BXPageCollectionViewController.swift
//  BXPageScrollDemo
//
//  Created by 毕向北 on 2017/7/9.
//  Copyright © 2017年 bifujian. All rights reserved.
//

import UIKit

class BXPageCollectionViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    //分页序号
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
        //注册cell
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
    //组
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    //item个数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    //cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        switch  indexPath.item{
        case numberOfItem:
            cell.contentView.backgroundColor = UIColor.red
        case let x where x % 2 == 0:
            cell.contentView.backgroundColor = UIColor.green
        case let x where x % 2 == 1:
            cell.contentView.backgroundColor = UIColor.yellow
        default:
            cell.contentView.backgroundColor = UIColor.orange
        }
        return cell
    }
    //在最后增加一个cell,防止滚动到最后一页出问题.假设屏幕宽度最多能容纳n个cell (n + 1个就超出屏幕),那么cell的宽度为屏幕宽度减n个cell的宽度.以下是cell的大小
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
    //实现父类的代理方法
    //给targetContentOffset.pointee.y赋值,改变滚动终点y坐标
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let y = targetContentOffset.pointee.y
        let pageHeight = itemHeight
        //通过selectedIndex的值，将要停下来的坐标y,计算位移
        let moveindex = y - pageHeight*CGFloat(selectedIndex)
        //当位移绝对值大于分页宽度的一半时,滚动到位移方向的相邻页
        if moveindex <  -pageHeight*0.5{
            selectedIndex -= 1
        }else if moveindex > pageHeight*0.5 {
            selectedIndex += 1
        }
        //宽度较大的分页效果滚动速率不能太慢,所以当速率小于2时,给
        //targetContentOffset.pointee.y赋值为当前位置即停止滚动,调用
        //setContentOffset(_ contentOffset: CGPoint, animated: Bool)方法，
        //立即以默认速度滚动到终点
        if abs(velocity.y) >= 2{
            targetContentOffset.pointee.y = pageHeight * CGFloat(selectedIndex)
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
