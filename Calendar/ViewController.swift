//
//  ViewController.swift
//  Calendar
//
//  Created by Benson on 2017/12/27.
//  Copyright © 2017年 Benson. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var calendar: UICollectionView!
    @IBOutlet weak var timeLabel: UILabel!
    var currentYear = Calendar.current.component(.year, from: Date())
    var currentMonth = Calendar.current.component(.month, from: Date())
    var months = ["1月", "2月", "3月", "4月", "5月", "6月", "7月", "8月", "9月", "10月", "11月", "12月"]
    
    var numberOfDaysInThisMonth:Int
    {
        let dateComponents = DateComponents(year: currentYear ,month: currentMonth)
        let date = Calendar.current.date(from: dateComponents)!
        let range = Calendar.current.range(of: .day, in: .month, for: date)
        return range?.count ?? 0
    }
    
    var whatDayIsIt:Int
    {
        let dateComponents = DateComponents(year: currentYear ,month: currentMonth)
        let date = Calendar.current.date(from: dateComponents)!
        return Calendar.current.component(.weekday, from: date)
    }
    
    var howManyItemsShouldIAdd:Int
    {
        return whatDayIsIt - 1
    }
    
    @IBAction func nextMonth(_ sender: UIButton) {
        currentMonth += 1
        if currentMonth == 13{
            currentMonth = 1
            currentYear += 1
        }
        setUp()
    }
    
    @IBAction func lastMonth(_ sender: UIButton) {
        currentMonth -= 1
        if currentMonth == 0{
            currentMonth = 12
            currentYear -= 1
        }
        setUp()
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        
        setUp()
    }
    
    func setUp(){
        timeLabel.text = months[currentMonth - 1] + " \(currentYear)"
        calendar.reloadData()
        print(whatDayIsIt)
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfDaysInThisMonth + howManyItemsShouldIAdd
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        if let textLabel = cell.contentView.subviews[0] as? UILabel{
            if indexPath.row < howManyItemsShouldIAdd{
                textLabel.text = ""
            }else{
                textLabel.text = "\(indexPath.row + 1 - howManyItemsShouldIAdd)"
            }
        }
        return cell
    }
    
    //单元格间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat
    {
        return 0
    }
    
    //行间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let width = collectionView.frame.width / 7
        return CGSize(width: width, height: 40)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        calendar.collectionViewLayout.invalidateLayout()
        calendar.reloadData()
    }
}







