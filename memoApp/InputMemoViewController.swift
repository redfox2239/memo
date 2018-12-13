//
//  InputMemoViewController.swift
//  memoApp
//
//  Created by REO HARADA on 2018/12/13.
//  Copyright © 2018年 reo harada. All rights reserved.
//

import UIKit

class InputMemoViewController: UIViewController {

    @IBOutlet weak var memoTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func tapCompleteButton(_ sender: Any) {
        // memoTextViewの内容を取得する
        let addMemo = self.memoTextView.text
        // addMemoをiPhoneの内部に保存する
        // iPhoneにデータを保存してくれる人を呼んでくる
        let saveMan = UserDefaults.standard
        // もし"memo"にデータがなかったら
        if saveMan.object(forKey: "memo") == nil {
            saveMan.set([addMemo], forKey: "memo")
        }
        else {
            // すでに"memo"に保存されてるデータを取ってくる as! で正体を保証する
            var savedMemoData = saveMan.object(forKey: "memo") as! [String]
            // addMemoという新しいデータをsavedMemoDataに追加する
            savedMemoData.append(addMemo!)
            // データを保存してね
            saveMan.set(savedMemoData, forKey: "memo")
        }
        // いますぐ保存してね
        saveMan.synchronize()
        // 前の画面に戻る
        self.navigationController?.popViewController(animated: true)
    }
    
}
