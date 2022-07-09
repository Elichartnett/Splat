//
//  ContentView.swift
//  Splat
//
//  Created by Eli Hartnett on 7/9/22.
//

import SwiftUI

struct ContentView: View {
    
    @State var balls = [Ball]()
    
    @State var yPos: Double = 0.75
    
    @State var threshold: Double = 0.5
    
    @State var radius: Double = 0
    
    var body: some View {
        
        VStack {
            Text("Radius")
            Slider(value: $radius, in: 0 ... 30)
                .padding(.horizontal)
            
            Color.pink.mask {
                Canvas { ctx, size in
                    
                    ctx.addFilter(.alphaThreshold(min: threshold))
                    
                    ctx.addFilter(.blur(radius: radius))
                    
                    ctx.drawLayer { ctx in
                        
                        for ball in balls {
                            ctx.fill(Circle().path(in: CGRect(x: ball.x, y: ball.y, width: ball.width, height: ball.height)), with: .color(.black))
                        }
                    }
                }
            }
            .onTapGesture { tap in
                balls.append(Ball(x: tap.x, y: tap.y))
            }
        }
    }
}

struct Ball {
    
    var x: Double
    var y: Double
    var radius: Double
    var width: Double
    var height: Double
    
    init(x: Double, y: Double, radius: Double = Double.random(in: 20...100)) {
        self.x = x - (radius/2)
        self.y = y - (radius/2)
        self.radius = radius
        self.width = radius
        self.height = radius
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
