//
//  HeaderContentView.swift
//  TogoSwiftUI
//
//  Created by WBCVN on 1/8/21.
//

import SwiftUI
import RealmSwift

class DataRealm: Object {
    let list = RealmSwift.List<TabOneDataModel>()
}

struct HeaderContentView: View {
    @Binding var tab:Int
    @Binding var page:Int
    @EnvironmentObject var vo: ValidateObservale
    @Binding public var list:[[DataForm]]
    @State var tabs = ["高圧絶縁", "絶縁診断","過熱診断","低圧絶縁","絶縁監視","接地抵抗","継電器","内部点検"]
    var body: some View {
        VStack {
            HStack {
                HStack {}.frame(maxWidth: .infinity)
                HStack {
                    Text("結果入力").font(.system(size: 25))
                }.frame(maxWidth: .infinity)
                HStack {
                    Button(action: {
                        validate()
                        if self.vo.error.count == 0 {
                            realmStore()
                        }
                    }) {
                        NameBtn(name: "確定")
                    }.offset(y: -5)
                }.frame(maxWidth: .infinity, alignment: .trailing)
            }
            
            HStack {
                HStack(spacing: 0){
                    ForEach(0..<tabs.count) { index in
                        Button(action: {
                            tab = index
                            page = 1
                        }) {
                            Text(tabs[index] + (self.vo.error.contains(index) ? "!" : "")).font(.system(size: 15)).padding([.top, .bottom], 15).padding([.leading, .trailing], 8).border(Color.blue).foregroundColor(self.vo.error.contains(index) ? Color.red : (self.tab == index ? Color.white : nil))
                        }.background(self.tab == index ? Color.blue : nil)
                    }
                }.addBorder(Color.blue, width: 2, cornerRadius: 6)
            }.padding([.top, .bottom], 10.0).padding([.leading, .trailing], 10.0)
        }.frame(maxWidth: .infinity, alignment: .top).padding([.top,.leading, .trailing], 25).padding([.bottom], 10)
        .overlay(Divider(), alignment: .bottom).background(Color.init(hex: Constant.SidebarColor))
    }
    
    func validate() -> Void {
        var index = 0
        var errorArray = [Int]()
        var allErrorArray = [Array<Int>]()
        for items in self.list {
            var indexChild = 0
            var errorChildArray = [Int]()
            for item in items {
                if(item.sokutei_hoho_koatsu_zetsuen_kb.isEmpty || Int(item.sokutei_hoho_koatsu_zetsuen_kb) == nil){
                    errorChildArray.append(indexChild)
                    errorArray.append(index)
                }
                if(item.sokuteichi_koatsu_zetsuen.isEmpty || Int(item.sokuteichi_koatsu_zetsuen) == nil){
                    errorChildArray.append(indexChild)
                    errorArray.append(index)
                }
                if(item.hantei_kekka_koatsu_zetsuen_kb.isEmpty || Int(item.hantei_kekka_koatsu_zetsuen_kb) == nil){
                    errorChildArray.append(indexChild)
                    errorArray.append(index)
                }
                indexChild = indexChild + 1
            }
            allErrorArray.append(errorChildArray)
            index = index + 1
        }
        self.vo.error = errorArray
        self.vo.allError = allErrorArray
        print(self.vo.error)
        print(self.vo.allError)
    }
    
    func realmStore() -> Void {
        let realm = try! Realm()
        for item in list[0] {
            let model = TabOneDataModel()
            model.id = item.hantei_kekka_koatsu_zetsuen_kb
            model.hantei_kekka_koatsu_zetsuen_kb = item.hantei_kekka_koatsu_zetsuen_kb
            model.sokutei_hani_em = item.sokutei_hani_em
            model.sokutei_hoho_koatsu_zetsuen_kb = item.sokutei_hoho_koatsu_zetsuen_kb
            model.sokuteichi_koatsu_zetsuen = item.sokuteichi_koatsu_zetsuen
            try! realm.write {
                realm.add(model)
            }
        }
        
        for item in list[1] {
            let model = TabTwoDataModel()
            model.id = item.hantei_kekka_koatsu_zetsuen_kb
            model.hantei_kekka_koatsu_zetsuen_kb = item.hantei_kekka_koatsu_zetsuen_kb
            model.sokutei_hani_em = item.sokutei_hani_em
            model.sokutei_hoho_koatsu_zetsuen_kb = item.sokutei_hoho_koatsu_zetsuen_kb
            model.sokuteichi_koatsu_zetsuen = item.sokuteichi_koatsu_zetsuen
            try! realm.write {
                realm.add(model)
            }
        }
        
        for item in list[2] {
            let model = TabThreeDataModel()
            model.id = item.hantei_kekka_koatsu_zetsuen_kb
            model.hantei_kekka_koatsu_zetsuen_kb = item.hantei_kekka_koatsu_zetsuen_kb
            model.sokutei_hani_em = item.sokutei_hani_em
            model.sokutei_hoho_koatsu_zetsuen_kb = item.sokutei_hoho_koatsu_zetsuen_kb
            model.sokuteichi_koatsu_zetsuen = item.sokuteichi_koatsu_zetsuen
            try! realm.write {
                realm.add(model)
            }
        }
        
        for item in list[3] {
            let model = TabFourDataModel()
            model.id = item.hantei_kekka_koatsu_zetsuen_kb
            model.hantei_kekka_koatsu_zetsuen_kb = item.hantei_kekka_koatsu_zetsuen_kb
            model.sokutei_hani_em = item.sokutei_hani_em
            model.sokutei_hoho_koatsu_zetsuen_kb = item.sokutei_hoho_koatsu_zetsuen_kb
            model.sokuteichi_koatsu_zetsuen = item.sokuteichi_koatsu_zetsuen
            try! realm.write {
                realm.add(model)
            }
        }
        
        for item in list[4] {
            let model = TabFiveDataModel()
            model.id = item.hantei_kekka_koatsu_zetsuen_kb
            model.hantei_kekka_koatsu_zetsuen_kb = item.hantei_kekka_koatsu_zetsuen_kb
            model.sokutei_hani_em = item.sokutei_hani_em
            model.sokutei_hoho_koatsu_zetsuen_kb = item.sokutei_hoho_koatsu_zetsuen_kb
            model.sokuteichi_koatsu_zetsuen = item.sokuteichi_koatsu_zetsuen
            try! realm.write {
                realm.add(model)
            }
        }
        
        for item in list[5] {
            let model = TabSixDataModel()
            model.id = item.hantei_kekka_koatsu_zetsuen_kb
            model.hantei_kekka_koatsu_zetsuen_kb = item.hantei_kekka_koatsu_zetsuen_kb
            model.sokutei_hani_em = item.sokutei_hani_em
            model.sokutei_hoho_koatsu_zetsuen_kb = item.sokutei_hoho_koatsu_zetsuen_kb
            model.sokuteichi_koatsu_zetsuen = item.sokuteichi_koatsu_zetsuen
            try! realm.write {
                realm.add(model)
            }
        }
        
        for item in list[6] {
            let model = TabSevenDataModel()
            model.id = item.hantei_kekka_koatsu_zetsuen_kb
            model.hantei_kekka_koatsu_zetsuen_kb = item.hantei_kekka_koatsu_zetsuen_kb
            model.sokutei_hani_em = item.sokutei_hani_em
            model.sokutei_hoho_koatsu_zetsuen_kb = item.sokutei_hoho_koatsu_zetsuen_kb
            model.sokuteichi_koatsu_zetsuen = item.sokuteichi_koatsu_zetsuen
            try! realm.write {
                realm.add(model)
            }
        }
        
        for item in list[7] {
            let model = TabEightDataModel()
            model.id = item.hantei_kekka_koatsu_zetsuen_kb
            model.hantei_kekka_koatsu_zetsuen_kb = item.hantei_kekka_koatsu_zetsuen_kb
            model.sokutei_hani_em = item.sokutei_hani_em
            model.sokutei_hoho_koatsu_zetsuen_kb = item.sokutei_hoho_koatsu_zetsuen_kb
            model.sokuteichi_koatsu_zetsuen = item.sokuteichi_koatsu_zetsuen
            try! realm.write {
                realm.add(model)
            }
        }
    }
}
