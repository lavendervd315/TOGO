//
//  HighVoltageInsulation.swift
//  TogoSwiftUI
//  高圧絶縁
//  Created by WBCVN on 1/11/21.
//

import SwiftUI
import RealmSwift

struct HighVoltageInsulationView: View {
    @Binding var page:Int
    @Binding var tab:Int
    @Binding public var list:[DataForm]
    var body: some View {
        VStack {
            if self.page == 1 {
                HighVoltageInsulationFirstPageView(list: $list, tab: tab)
            } else {
                HighVoltageInsulationSecondPageView()
            }
            VStack {
                HStack{
                    HStack{
                        if !(self.page == 1 && self.tab == 0) {
                            Button(action: {
                                if page == 2 {
                                    page = 1
                                } else {
                                    tab = tab - 1
                                    page = 2
                                }
                            }) {
                                NameBtn(name: "次へ")
                            }
                        }
                    }.frame(maxWidth: .infinity, alignment: .leading)
                    HStack{
                        VStack {
                            Text(String(self.page) + "/2").foregroundColor(Color.white)
                        }.frame(maxHeight: 15).padding([.top, .bottom], 5).padding([.leading, .trailing], 10).background(Color.gray).addBorder(Color.gray, width: 1, cornerRadius: 10)
                    }.frame(maxWidth: .infinity)
                    HStack{
                        if !(self.page == 2 && self.tab == 7) {
                            Button(action: {
                                if page == 2 {
                                    tab = tab + 1
                                    page = 1
                                } else {
                                    page = 2
                                }
                                print(String(tab) + "--------" + String(page))
                            }) {
                                NameBtn(name: "前へ")
                            }
                        }
                    }.frame(maxWidth: .infinity, alignment: .trailing)
                }.padding(5)
                
            }.frame(maxWidth: .infinity, alignment: self.page == 1 ? .bottomTrailing : .bottomLeading)
        }.padding(15)
    }
}

struct HighVoltageInsulationSecondPageView: View {
    @State private var fullText: String = "テキスト"
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("記事欄").foregroundColor(Color.orange)
            }.frame(maxWidth: .infinity, alignment: .leading).padding([.bottom], 10).padding([.leading, .trailing], 15)
            HStack {
                TextEditor(text: $fullText).foregroundColor(Color.gray)
            }.frame(maxWidth: .infinity,maxHeight: 120, alignment: .topLeading).padding(10).background(Color.white)
            HStack {
                Button(action: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/{}/*@END_MENU_TOKEN@*/) {
                    NameBtn(name: "空型文 >", fontSize: 20)
                }
            }.frame(maxWidth: .infinity, maxHeight: 30, alignment: .trailing).padding(10).background(Color.white)
            HStack {
            }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        }
    }
}

struct HighVoltageInsulationFirstPageView: View {
    @EnvironmentObject var vo: ValidateObservale
    @State private var form = DataForm()
    @Binding public var list:[DataForm]
    @State var isDialog = false
    @State var isAction = false
    @State var isSelectBox = false
    @State private var selected = SelectBoxData.One
    @State var isError = false
    @State var errorMessage = ""
    @State var tab:Int
    @State private var users = ["Paul", "Taylor", "Adele"]
    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Button(action: {
                    self.isDialog = true
                    self.isAction = false
                    self.form = DataForm()
                }) {
                    ActionBtn(actionName: "ADD")
                }
                Text("高圧絶縁抵抗測定")
            }.frame(maxWidth: .infinity, alignment: .leading).padding([.top, .bottom], 10).padding([.leading, .trailing], 15).background(Color.white)
            ScrollView {
                VStack (spacing: 10){
                    ForEach(list.indices, id: \.self) { index in
                        HighVoltageInsulationRowDataView(form: list[index], delete: {self.callbackDelete(id: list[index].id)}, update: {self.callbackUpdate(formCallback: list[index])}).id(list[index].id).border(Color.red, width: ((self.vo.allError.count > 0 && self.vo.allError[tab].count > 0 && self.vo.allError[tab].contains(index)) ? 1 : 0)).onTapGesture(count: 2) {
                            self.callbackUpdate(formCallback: list[index])
                        }
                    }
                }
            }
        }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top).sheet(isPresented: $isDialog) {
            DialogStore(store: {self.callbackStore(formCallback: self.form)}, form: self.$form, isAction: $isAction)
        }
    }
    
    func callbackDelete(id: String) {
        let res = self.list.filter{($0.id != id)}
        self.list = res
    }
    
    func callbackUpdate(formCallback: DataForm) {
        self.isDialog = true
        self.isAction = true
        self.form = formCallback
    }
    
    func callbackStore(formCallback: DataForm) {
        self.isDialog = false
        if self.isAction {
            var res = [DataForm]()
            for item in list {
                if (item.id == formCallback.id) {
                    res.append(formCallback)
                } else {
                    res.append(item)
                }
            }
            self.list = res
        } else {
            self.list.append(formCallback)
        }
    }
}
struct DialogStore: View {
    var store: () -> Void
    @Binding public var form:DataForm
    @Binding public var isAction:Bool
    @State var isSelectBox = false
    @State var selected = SelectBoxData.One
    @State var errorMessage = ""
    var body: some View {
        VStack {
            Text("高圧絶縁タブ")
            Form {
                Section {
                    Text("測定範囲")
                    HStack(){
                        Text(form.sokutei_hani_em).frame(maxWidth: .infinity, alignment: .leading)
                        Button(action: {isSelectBox = true}) {
                            NameBtn(name: "空型文 >", fontSize: 20)
                        }.sheet(isPresented: $isSelectBox){
                            Picker("", selection: $selected.onChange(colorChange)) {
                                Text("One").tag(SelectBoxData.One)
                                Text("Two").tag(SelectBoxData.Two)
                                Text("Three").tag(SelectBoxData.Three)
                                Text("Four").tag(SelectBoxData.Four)
                                Text("Five").tag(SelectBoxData.Five)
                            }
                        }
                    }
                }
                Section {
                    Text("測定方法")
                    TextField("", text: $form.sokutei_hoho_koatsu_zetsuen_kb)
                }
                Section {
                    Text("測定値（ＭΩ）")
                    TextField("", text: $form.sokuteichi_koatsu_zetsuen)
                }
                Section {
                    Text("判定結果")
                    TextField("", text: $form.hantei_kekka_koatsu_zetsuen_kb)
                }
            }
            Button(action: {
                self.store()
            }) {
                NameBtn(name: "OK", fontSize: 20)
            }
        }.padding([.top, .bottom], 10)
    }
    
    func colorChange(_ tag: SelectBoxData) {
        self.isSelectBox = false
        self.form.sokutei_hani_em = tag.rawValue
    }
}


struct HighVoltageInsulationRowDataView: View {
    @State public var form: DataForm
    var delete: () -> Void
    var update: () -> Void
    var body: some View {
        HStack (spacing: 0){
            VStack{
                Button(action: {
                    self.delete()
                }) {
                    ActionBtn(actionName: "REMOVE")
                }.padding(10)
            }
            VStack {
                Text("表示")
                Button(action: {
                    self.update()
                }) {
                    ActionBtn(actionName: "SUBMIT")
                }
            }.frame(maxHeight: .infinity).padding([.top, .bottom], 15).padding([.leading, .trailing], 5).overlay(Divider(), alignment: .trailing).overlay(Divider(), alignment: .leading)
            VStack(spacing: 0.0) {
                HStack {
                    VStack(alignment: .leading) {
                        Text("測定範囲")
                        Text(form.sokutei_hani_em).foregroundColor(Color.gray)
                    }
                    Text("MM").frame(maxWidth: .infinity,alignment: .leading).foregroundColor(Color.gray)
                    Button(action: {}) {
                        NameBtn(name: "空型文 >", fontSize: 20)
                    }.padding(10)
                }.padding([.top, .bottom], 5).padding([.leading, .trailing], 10).frame(maxWidth: .infinity, maxHeight: 50, alignment: .leading).overlay(Divider(), alignment: .bottom)
                HStack{
                    HStack{
                        VStack(alignment: .leading) {
                            Text("測定方法")
                            Text(form.sokutei_hoho_koatsu_zetsuen_kb).foregroundColor(Color.gray)
                        }
                        Text("測定").foregroundColor(Color.green)
                        Text(">").foregroundColor(Color.gray).frame(maxHeight: .infinity)
                    }.padding(5).overlay(Divider(), alignment: .trailing)
                    
                    HStack{
                        VStack(alignment: .leading) {
                            Text("測定値（ＭΩ）")
                            Text(form.sokuteichi_koatsu_zetsuen).foregroundColor(Color.gray)
                        }.frame(maxWidth: .infinity, alignment: .leading)
                        Text("テキスト").foregroundColor(Color.gray).frame(maxHeight: .infinity)
                    }.padding(5).overlay(Divider(), alignment: .trailing)
                    
                    HStack {
                        VStack(alignment: .leading) {
                            Text("判定結果")
                            Text(form.hantei_kekka_koatsu_zetsuen_kb).foregroundColor(Color.gray)
                        }.frame(maxWidth: .infinity, alignment: .leading)
                        Text("次へ").foregroundColor(Color.green)
                        Text(">").foregroundColor(Color.gray).frame(maxHeight: .infinity)
                    }.padding(5)
                }.frame(maxWidth: .infinity, maxHeight: 50, alignment: .leading)
            }.frame(maxWidth: .infinity)
        }.background(Color.white)
    }
}

