//
//  LoadingIndicator.swift
//  LoadingIndicator
//
//  Created by Hunter Holland on 7/22/21.
//

import SwiftUI

struct LoadingIndicator: View {
    var body: some View {
        ZStack {
            LoadingCircle(radius: 100, duration: 4)
            LoadingCircle(radius: 75, duration: 2)
            LoadingCircle(radius: 50, duration: 1)
        }
        .frame(width: 200, height: 200)
    }
}

struct LoadingCircle: View {
    var radius: CGFloat
    var duration: CGFloat
    
    @State private var isLoading = false
    
    init(radius: Int, duration: Int) {
        self.radius = CGFloat(radius)
        self.duration = CGFloat(duration)
    }
    
    init(radius: Double, duration: Double) {
        self.radius = CGFloat(radius)
        self.duration = CGFloat(duration)
    }
    
    var body: some View {
        Circle()
            .trim(from: 0, to: 0.5)
            .stroke(Color.accentColor, style: StrokeStyle(lineWidth: 7, lineCap: .round))
            .frame(width: CGFloat(radius))
            .rotationEffect(Angle(degrees: isLoading ? 360 : 0))
            .animation(.linear(duration: CGFloat(duration)).repeatForever(autoreverses: false), value: isLoading)
            .onAppear() {
                self.isLoading = true
            }
    }
}

struct LoadingIndicator_Previews: PreviewProvider {
    static var previews: some View {
        LoadingIndicator()
    }
}
