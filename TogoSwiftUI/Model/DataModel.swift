//
//  DataModel.swift
//  TogoSwiftUI
//
//  Created by WBCVN on 1/29/21.
//

import SwiftUI
import RealmSwift

class DataForm {
    //var hyoji_flg = false
    var id = UUID().uuidString
    var sokutei_hani_em = "One"
    var sokutei_hoho_koatsu_zetsuen_kb = "0"
    var sokuteichi_koatsu_zetsuen = "0"
    var hantei_kekka_koatsu_zetsuen_kb = "0"
    //var isDelete = false
}

class TabOneDataModel: Object {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var sokutei_hani_em = ""
    @objc dynamic var sokutei_hoho_koatsu_zetsuen_kb = ""
    @objc dynamic var sokuteichi_koatsu_zetsuen = ""
    @objc dynamic var hantei_kekka_koatsu_zetsuen_kb = ""
}

class TabTwoDataModel: TabOneDataModel {}
class TabThreeDataModel: TabOneDataModel {}
class TabFourDataModel: TabOneDataModel {}
class TabFiveDataModel: TabOneDataModel {}
class TabSixDataModel: TabOneDataModel {}
class TabSevenDataModel: TabOneDataModel {}
class TabEightDataModel: TabOneDataModel {}

