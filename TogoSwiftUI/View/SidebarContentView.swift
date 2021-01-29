//
//  SidebarContentView.swift
//  TogoSwiftUI
//
//  Created by WBCVN on 1/8/21.
//

import SwiftUI
struct SidebarContentView: View {
    @State private var param = true
    var body: some View{
        VStack(alignment: .leading){
            Spacer().frame(height: 60.0)
            Text("点検報告").padding(.leading, 20.0).font(.system(size: 40))
            HStack{
                Spacer().frame(width: 20)
                Text("諸族   ：観音寺事業所").padding([.top, .leading], 5.0)
            }
            HStack{
                Spacer().frame(width: 20)
                Text("民名   ：多田羅昌治").padding([.leading, .bottom], 5.0)
            }
            
            Spacer().frame(height: 50.0)
            Text("結果参照").padding(.leading, 20.0).font(.system(size: 20))
            
            Spacer().frame(height: 10.0)
            HStack{
                Text("点検メニュー").frame(maxWidth:.infinity, alignment: .leading).font(.system(size: 20))
                Button (action: {self.param = self.param ? false: true}){
                    Image(systemName: self.param ? "chevron.down" : "chevron.up")
                }.frame(width: 30, height: 30, alignment: .center).accentColor(.black)
            }.padding(.horizontal, 20).frame(maxWidth: Constant.SidebarWidth).overlay(Divider(), alignment: .bottom)
            
            SidebarSmContent(isOk: self.$param)
        }.overlay(Divider(), alignment: .trailing).background(Color.init(hex: Constant.SidebarColor))
    }
}

struct SidebarSmContent: View {
    @Binding var isOk: Bool
    var sizeText: CGFloat = 20
    var body: some View {
        VStack {
            if isOk {
                HStack{
                    Text("点検制御").frame(maxWidth:.infinity, alignment: .leading).font(.system(size: sizeText))
                }.padding(.all, 5.0).frame(maxWidth: Constant.SidebarWidth).overlay(Divider(), alignment: .bottom)
                HStack{
                    Text("基本情報").frame(maxWidth:.infinity, alignment: .leading).font(.system(size: sizeText))
                }.padding(.all, 5.0).frame(maxWidth: Constant.SidebarWidth).overlay(Divider(), alignment: .bottom)
                HStack{
                    Text("結果入力").frame(maxWidth:.infinity, alignment: .leading).font(.system(size: sizeText))
                }.padding(.all, 5.0).frame(maxWidth: Constant.SidebarWidth).overlay(Divider(), alignment: .bottom)
            }
        }.padding(.horizontal, 25).frame(maxWidth: Constant.SidebarWidth, maxHeight: .infinity, alignment: .topLeading)
    }
}
