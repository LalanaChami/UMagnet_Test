//
//  ContentView.swift
//  UMagnet_Test
//
//  Created by Lalana Thanthirigama on 2024-09-11.
//

import SwiftUI


struct ContentView: View {
    @State private var imageLogoScaleAmount: CGFloat = 1
    @State var isHomeRootScreen = false
    
    
    var body: some View {
        if isHomeRootScreen {
            HomeScreen()
        } else {
            VStack {
                PhaseAnimator([0, 1, 2, 3, 4, 5 , 6 ,7, 8, 9 , 10 , 11, 12 , 13 , 14, 15 , 16, 17 , 18 , 19]) { value in
                    VStack {
                        if value >= 1 && value <= 3 {
                            Text("Catch")
                                .font(.system(size: 100))
                                .fontWeight(.black)
                                .foregroundStyle(LinearGradient(colors: [.pink, .purple , .blue], startPoint: .topLeading, endPoint: .bottomTrailing))
                                .scaleEffect(value)
                                .opacity(value == 1 ? 1 : 0)
                                .animation(.easeOut(duration: 1.5), value: value)
                        }
                        
                        if value >= 3 && value <= 8 {
                            Text("Your")
                                .font(.system(size: 100))
                                .fontWeight(.black)
                                .foregroundStyle(LinearGradient(colors: [.pink, .purple , .blue], startPoint: .topLeading, endPoint: .bottomTrailing))
                                .scaleEffect(value - 4)
                                .opacity(value - 4 == 1 ? 1 : 0)
                                .animation(.easeOut(duration: 0.5), value: value)
                        }
                        
                        if value >= 8 && value <= 12 {
                            Text("Crush")
                                .font(.system(size: 100))
                                .fontWeight(.black)
                                .foregroundStyle(LinearGradient(colors: [.pink, .purple , .blue], startPoint: .topLeading, endPoint: .bottomTrailing))
                                .scaleEffect(value - 9)
                                .opacity(value - 9 == 1 ? 1 : 0)
                                .animation(.easeOut(duration: 0.5), value: value)
                        }
                        
                        if value >= 12 && value <= 13 {
                            ParallaxTextView()
                        }
                        
                        
                        if value >= 13 && value <= 17 {
                            Image("umag-icon")
                                .resizable()
                                .frame(width: 60 , height: 60)
                                .offset(y: getImageOffset(value: value))
                                .animation(.linear(duration: 0.5), value: value)
                        }
                        
                        if value >= 18 && value <= 19 {
                            Image("umag-icon")
                                .resizable()
                                .frame(width: 60 , height: 60)
                                .scaleEffect(imageLogoScaleAmount)
                                .onAppear() {
                                    // Shrink the icon
                                    withAnimation(.easeOut(duration: 0.5)) {
                                        imageLogoScaleAmount = 0.6
                                    }
                                    
                                    // Enlarge the logo
                                    withAnimation(.easeInOut(duration: 1).delay(0.5)) {
                                        imageLogoScaleAmount = 80
                                        
                                    }
                                    
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
                                        isHomeRootScreen = true
                                    }
                                }
                        }
                    }
                }
            }
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            .background(
                Color.black
            )
            
            .padding()
        }
        
    }
    
    
    private func getImageOffset(value: Double) -> CGFloat {
        let screenHeight = UIScreen.main.bounds.height * 2.5
        let progress = CGFloat(value - 13) / 4
        print(screenHeight - progress * (screenHeight ))
        return screenHeight - progress * (screenHeight )
    }
    
}

struct ParallaxTextView: View {
    @State private var offsetY: CGFloat = 0
    
    let numberOfLines = 5
    let text = "Crush"
    
    var body: some View {
        ZStack {
            ForEach(0..<numberOfLines, id: \.self) { index in
                Text(text)
                    .font(.system(size: 100))
                    .fontWeight(.black)
                    .foregroundStyle(LinearGradient(colors: [.pink, .purple , .blue], startPoint: .topLeading, endPoint: .bottomTrailing))
                    .offset(y: self.getOffset(index: index))
                    .animation(.easeIn(duration: Double(index + 1) * 2), value: offsetY)
            }
        }
        .onAppear {
            self.offsetY = -UIScreen.main.bounds.height * 6
        }
    }
    
    private func getOffset(index: Int) -> CGFloat {
        let baseOffset = UIScreen.main.bounds.height / 2
        return baseOffset + CGFloat(index) * 50 + offsetY * CGFloat(index + 1) * 0.3
    }
}

#Preview {
    ContentView()
}
