//
//  ViewController.swift
//  memoApp
//
//  Created by REO HARADA on 2018/12/12.
//  Copyright © 2018年 reo harada. All rights reserved.
//

import UIKit

// UITableViewと相談する準備その1
class ViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var memoTableView: UITableView!
    // メモデータの配列を用意する
    var memoData: [String] = []
    
    // 一番最初どうする？（画面読み込んだときどうするぅ？）
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        // UITableViewと相談する準備その２
        self.memoTableView.delegate = self
        self.memoTableView.dataSource = self
    }
    
    // 画面が表示される瞬間どうするぅ？
    override func viewWillAppear(_ animated: Bool) {
        // UserDefautlsでiPhoneに保存されたデータを取得する。データ保存の場所は"memo"という場所
        // 保存されてるデータを取得してくれる人を呼んでくる
        let getMan = UserDefaults.standard
        
        // もしデータがなければ、データを取ってこないで終了する
        if getMan.object(forKey: "memo") == nil {
            // 終了
            return
        }
        
        // "memo"に保存さてるデータをちょうだい as! でデータの正体を保証する
        let savedMemo = getMan.object(forKey: "memo") as! [String]
        // savedMemoをmemoDataとして利用する
        self.memoData = savedMemo
        // tableViewと相談しなおす
        self.memoTableView.reloadData()
    }
    
    // UITableViewとの相談↓
    // セクションの数どうするぅ？
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // セルの数どうするぅ？
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.memoData.count
    }
    
    // 各行のセルの中身どうするぅ？
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.memoTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = self.memoData[indexPath.row]
        return cell
    }
    
    // 各行のセルを編集するときどうするぅ？
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let saveMan = UserDefaults.standard
        var savedMemoData = saveMan.object(forKey: "memo") as! [String]
        savedMemoData.remove(at: indexPath.row)
        saveMan.set(savedMemoData, forKey: "memo")
        saveMan.synchronize()
        self.memoData.remove(at: indexPath.row)
        self.memoTableView.reloadData()
    }


}

