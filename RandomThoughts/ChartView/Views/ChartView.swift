//
//  ChartView.swift
//  RandomThoughts
//
//  Created by Sukhaman Singh on 12/25/23.
//

import SwiftUI

struct PieChart: View {
    var data: [Double]
    var colors: [Color]
    var labels: [String]
    
    init(data: [Double], colors: [Color], labels: [String]) {
        self.data = data
        self.colors = colors
        self.labels = labels
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ForEach(0..<data.count, id: \.self) { index in
                    PieSlice(startAngle: angle(index).0, endAngle: angle(index + 1).0)
                        .foregroundColor(colors[index])
                        .overlay {
                           
                            Text(labels[index])
                                .position(angle(index).1)
                                .foregroundColor(.black)
                                .offset(x: angle(index).1.x,y: angle(index).1.y)
                        }
                    
                    //.position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                    // .frame(width: geometry.size.width / 1.5, height: geometry.size.height / 1.5)
                }
                
                Circle()
                    .fill(Color.white)
                    .frame(width: geometry.size.width / 2, height: geometry.size.height / 2)
                
            }
            
        }
    }
    
    private func angle(_ index: Int) -> (Angle, CGPoint) {
        guard index < data.count else { return (.zero, .zero) }
        
        let total = data.reduce(0, +)
        let startAngle = index == 0 ? .zero : data[0..<index].reduce(0, +) / total
        let endAngle = startAngle + data[index] / total
        let centerAngle = (startAngle + endAngle) / 2
        let radius: CGFloat = 0.6 // Adjust as needed
        
        let x = radius * cos(CGFloat(centerAngle.radians))
        let y = radius * sin(CGFloat(centerAngle.radians))
        
        let labelCenterPoint = CGPoint(x: x + 0.5, y: y + 0.5)
        let pieAngle: Angle = .degrees(Double(startAngle) * 360)
        print("Label x at index \(index) point",labelCenterPoint.x)
        print("Label y at index \(index) point",labelCenterPoint.y)
        return (pieAngle,labelCenterPoint)
    }
    
    private func centerOfSlice(startAngle: Angle, endAngle: Angle) -> CGPoint {
        
        let centerAngle = (startAngle + endAngle) / 2
        let radius: CGFloat = 0.6 // Adjust as needed
        
        let x = radius * cos(CGFloat(centerAngle.radians))
        let y = radius * sin(CGFloat(centerAngle.radians))
        
        return CGPoint(x: x + 0.5, y: y + 0.5)
    }
    
    private func sliceLabelOffset(angle: Double) -> CGSize {
        let radius: CGFloat = 70
        let x = radius * CGFloat(cos(angle.radians))
        let y = radius * CGFloat(sin(angle.radians))
        return CGSize(width: x, height: y)
    }
    
    private func sliceImageOffset(angle: Double) -> CGSize {
        let radius: CGFloat = 80
        let x = radius * CGFloat(cos(angle.radians))
        let y = radius * CGFloat(sin(angle.radians))
        return CGSize(width: x, height: y)
    }
    

}

struct PieSlice: Shape {
    var startAngle: Angle
    var endAngle: Angle
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.width / 2, y: rect.height / 2)
        let radius = min(rect.width, rect.height) / 2
        
        path.move(to: center)
        path.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        path.closeSubpath()
        
        return path
    }
}

struct ChartContentView: View {
    let data: [Double] = [0.3, 0.4, 0.2, 0.1]
    let colors: [Color] = [.red, .green, .blue, .orange]
    let labels: [String] = ["Label 1", "Label 2", "Label 3", "Label 4"]
    
    var body: some View {
        PieChart(data: data, colors: colors, labels: labels)
            .frame(width: 300, height: 300)
    }
}


struct ChartContentView_Previews: PreviewProvider {
    static var previews: some View {
        ChartContentView()
    }
}

extension Double {
    var radians: Double {
        return self * .pi / 180
    }
}
