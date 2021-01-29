//
//  Constant.swift
//  TogoSwiftUI
//
//  Created by WBCVN on 1/8/21.
//

import SwiftUI

class ValidateObservale: ObservableObject {
    @Published var allError = [Array<Int>]()
    @Published var error = [Int]()
}

enum SelectBoxData: String, CaseIterable {
    case One
    case Two
    case Three
    case Four
    case Five
    var value: String { self.rawValue }
}

struct Constant {
    static var SidebarWidth:CGFloat = 300
    static var HeaderHeight:CGFloat = 150
    static var SidebarColor:String = "#F7F7F7"
    static var ContainerColor:String = "#EFEFF4"
}

struct NameBtn: View {
    @State var name:String
    @State var fontSize:CGFloat = 25
    var body: some View {
        Text(self.name).font(.system(size: self.fontSize)).padding([.top, .bottom], 4.0).padding([.leading, .trailing], 10.0).addBorder(Color.blue, width: 1, cornerRadius: 6)
    }
}

struct ActionBtn: View {
    @State var actionName:String
    var body: some View {
        if self.actionName == "ADD" {
            Image(systemName: "plus.circle.fill").resizable()
                .frame(width: 25, height: 25).foregroundColor(Color.green)
        }
        if self.actionName == "REMOVE" {
            Image(systemName: "minus.circle.fill").resizable()
                .frame(width: 25, height: 25).foregroundColor(Color.red)
        }
        if self.actionName == "SUBMIT" {
            Image(systemName: "checkmark.circle.fill").resizable()
                .frame(width: 25, height: 25).foregroundColor(Color.blue)
        }
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

extension View {
     public func addBorder<S>(_ content: S, width: CGFloat = 1, cornerRadius: CGFloat) -> some View where S : ShapeStyle {
         let roundedRect = RoundedRectangle(cornerRadius: cornerRadius)
         return clipShape(roundedRect)
              .overlay(roundedRect.strokeBorder(content, lineWidth: width))
     }
 }

extension Binding {
    func onChange(_ handler: @escaping (Value) -> Void) -> Binding<Value> {
        return Binding(
            get: { self.wrappedValue },
            set: { selection in
                self.wrappedValue = selection
                handler(selection)
        })
    }
}
