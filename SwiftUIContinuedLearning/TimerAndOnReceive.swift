//
//  TimerAndOnReceive.swift
//  SwiftUIContinuedLearning
//
//  Created by Adkhamjon Rakhimov on 02/12/24.
//

import SwiftUI

struct TimerAndOnReceive: View {
    
    let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    
    // current time
    /*
     
    @State var currentDate: Date = Date()
    
    var dateFormatter: DateFormatter{
        let formatter = DateFormatter()
        //formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        return formatter
    }
     */
    
    // countDown
    /*
    @State var count: Int = 50
    
    @State var finishedText: String? = nil
    */
    
    // countdown to date
    /*
     @State var timeRemaining: String = ""
     
     let futureDate: Date = Calendar.current.date(byAdding: .hour, value: 1, to: Date()) ?? Date()
     
     func updateTimeRemainig() {
         let remaining = Calendar.current.dateComponents([.hour,.minute,.second], from: Date(), to: futureDate)
         
         let hour = remaining.hour ?? 0
         let minute = remaining.minute ?? 0
         let second = remaining.second ?? 0
         
         timeRemaining = "\(hour):\(minute):\(second)"
     }
     */
    
    
    // animation counter
    @State var count: Int = 1
    
    
    
    var body: some View {
        ZStack {
            RadialGradient(
                colors: [Color.purple, Color.blue],
                center: .center,
                startRadius: 5,
                endRadius: 500
            ).ignoresSafeArea()
            
            
//            Text(timeRemaining)
//                .font(.system(size: 100, weight: .semibold, design: .rounded))
//                .foregroundColor(.white)
//                .lineLimit(1)
//                .minimumScaleFactor(0.1)
            
//            HStack(spacing: 15) {
//                Circle()
//                    .offset(y: count == 1 ? -20 : 0)
//                Circle()
//                    .offset(y: count == 2 ? -20 : 0)
//                Circle()
//                    .offset(y: count == 3 ? -20 : 0)
//            }
//            .frame(width: 150)
//            .foregroundColor(.white)


            TabView(
                selection: $count,content: {
                    Rectangle()
                        .foregroundColor(.red)
                        .tag(1)
                    
                    Rectangle()
                        .foregroundColor(.blue)
                        .tag(2)
                    
                    Rectangle()
                        .foregroundColor(.green)
                        .tag(3)
                    
                    Rectangle()
                        .foregroundColor(.orange)
                        .tag(4)
                    
                    Rectangle()
                        .foregroundColor(.pink)
                        .tag(5)
                })
            .frame(height: 200)
            .tabViewStyle(PageTabViewStyle())

        }
        .onReceive(timer) { _ in
            //currentDate = value
            //updateTimeRemainig()
            
            withAnimation(.default){
                count = count == 5 ? 1 : count+1
            }
        }
    }
}

#Preview {
    TimerAndOnReceive()
}
