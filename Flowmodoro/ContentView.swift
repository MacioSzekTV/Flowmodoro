//
//  ContentView.swift
//  Flowmodoro
//
//  Created by Maciej Łabędź on 09/07/2023.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var config = Config()

    var body: some View {
        VStack {
            Text("flowmodoro")
                .font(.custom("NotoSans-BoldItalic", size: 20))
                .shadow(color: Color(NSColor.green), radius: 5)
                .padding()
            
            Text(self.config.timeElapsed)
                .font(.custom("NotoSans-Regular", size: 30))
                .frame(width: 150, height:150)
                .background(Circle().fill(Color("Timer")).shadow(color: Color("Shadow"), radius: 5, y: 0))
                .foregroundColor(Color("Shadow"))
                .padding()
            
            Spacer().frame(height: 25)
            
            if(self.config.mode == .stop){
                Button("Start"){
                    self.config.startFocus()
                }
                .background(Color.accentColor)
                .clipShape(Capsule())
            }
            if(self.config.mode == .focus){
                Button("Break"){
                    self.config.startBreak()
                }
                .background(Color.accentColor)
                .clipShape(Capsule())
                Button("Pause"){
                    self.config.pause()
                }
                .foregroundColor(.black)
                .clipShape(Capsule())
                Button("Stop"){
                    self.config.stop()
                }
                .background(Color.red)
                .clipShape(Capsule())
            }
            if(self.config.mode == .fbreak){
                Button("Focus"){
                    self.config.startFocus()
                }
                .background(Color.accentColor)
                .clipShape(Capsule())
                Button("Stop"){
                    self.config.stop()
                }
                .background(Color.red)
                .clipShape(Capsule())
            }
            if(self.config.mode == .pause){
                Button("Resume"){
                    self.config.startFocus()
                }
                .background(Color.accentColor)
                .clipShape(Capsule())
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
