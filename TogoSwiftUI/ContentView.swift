//
//  ContentView.swift
//  TogoSwiftUI
//
//  Created by WBCVN on 1/8/21.
//

import SwiftUI
import RealmSwift

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewLayout(.fixed(width: 1024, height: 768))
    }
}

struct LoadingView : View {
    @State private var showAction = false

    var body: some View {
        Image(systemName: "arrow.triangle.2.circlepath")
            .font(.system(size: 29))
            .rotationEffect(.degrees(self.showAction ? 360.0 : 0.0))
            .animation(self.showAction ? Animation.linear(duration: 1.5).repeatForever(autoreverses: false) : nil)
        .onAppear() {
            self.showAction = true
        }
    }
}

struct ContentView: View {
    var body: some View {
        TabView {
//            Text("点検報告書").tabItem {
//                Image(systemName: "globe")
//                Text("点検報告書")
//            }.tag(1)
            TabViewContent().tabItem {
                Image(systemName: "alarm")
                Text("年次点検記録")
            }.tag(2)
            Text("作業計画").tabItem {
                Image(systemName: "bed.double")
                Text("作業計画")
            }.tag(2)
            Text("不良").tabItem {
                Image(systemName: "stopwatch")
                Text("不良")
            }.tag(2)
        }
        .padding(.all, 2.0)
    }
}

struct TabViewContent: View {
    @State private var param = true
    var body: some View{
        HStack(alignment: .top, spacing: 0) {
            SidebarContentView()
            ContainerContent()
        }
    }
}

struct MainContent: View {
    @Binding var tab:Int
    @Binding var page:Int
    @Binding public var list:[[DataForm]]
    var body: some View {
        if tab == 0 {
            //高圧絶縁
            HighVoltageInsulationView(page: $page, tab: $tab, list: $list[0])
        }
        if tab == 1 {
            HighVoltageInsulationView(page: $page, tab: $tab, list: $list[1])
        }
        if tab == 2 {
            HighVoltageInsulationView(page: $page, tab: $tab, list: $list[2])
        }
        if tab == 3 {
            HighVoltageInsulationView(page: $page, tab: $tab, list: $list[3])
        }
        if tab == 4 {
            HighVoltageInsulationView(page: $page, tab: $tab, list: $list[4])
        }
        if tab == 5 {
            HighVoltageInsulationView(page: $page, tab: $tab, list: $list[5])
        }
        if tab == 6 {
            HighVoltageInsulationView(page: $page, tab: $tab, list: $list[6])
        }
        if tab == 7 {
            HighVoltageInsulationView(page: $page, tab: $tab, list: $list[7])
        }
    }
}

struct ContainerContent: View {
    @State var tab:Int = 0
    @State var page:Int = 1
    @State private var list = [[DataForm()], [DataForm()], [DataForm()], [DataForm()], [DataForm()], [DataForm()], [DataForm()], [DataForm()]]
    var body: some View {
        VStack(spacing: 0) {
            HeaderContentView(tab: $tab, page: $page, list: $list)
            MainContent(tab: $tab, page: $page, list: $list)
        }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading).background(Color.init(hex: Constant.ContainerColor)).environmentObject(ValidateObservale())
    }
}
