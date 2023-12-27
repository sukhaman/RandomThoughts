
import SwiftUI

struct PieChartDemo: View {
    var data: [ChartDataDemo]
    
    init(data: [ChartDataDemo]) {
        self.data = data
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ForEach(0..<data.count, id: \.self) { index in
                    PieSliceDemo(startAngle: angle(index), endAngle: angle(index + 1), data: data[index])
                        .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                        .frame(width: geometry.size.width / 2, height: geometry.size.height / 2)
                }
                
                // Center circle overlay
                Circle()
                    .fill(Color.white)
                    .frame(width: 30, height: 30)
            }
        }
    }
    
    private func angle(_ index: Int) -> Angle {
        guard index < data.count else { return .zero }
        
        let total = data.map { $0.value }.reduce(0, +)
        let startAngle = index == 0 ? .zero : data[0..<index].map { $0.value }.reduce(0, +) / total
        let endAngle = startAngle + data[index].value / total
        
        return .degrees(Double(startAngle) * 360)
    }
}

struct PieSliceDemo: View {
    var startAngle: Angle
    var endAngle: Angle
    var data: ChartDataDemo
    
    var body: some View {
        ZStack {
            Path { path in
                let center = CGPoint(x: 0.5, y: 0.5)
                path.move(to: center)
                path.addArc(center: center, radius: 0.5, startAngle: startAngle, endAngle: endAngle, clockwise: false)
            }
            .fill(data.color)
            
            Image(systemName: data.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 30, height: 30)
                .position(centerOfSlice(startAngle: startAngle, endAngle: endAngle))
                .foregroundColor(.black)
            
            Text(data.label)
                .position(centerOfSlice(startAngle: startAngle, endAngle: endAngle))
                .foregroundColor(.black)
        }
    }
    
    private func centerOfSlice(startAngle: Angle, endAngle: Angle) -> CGPoint {
        let centerAngle = (startAngle + endAngle) / 2
        let radius: CGFloat = 0.6 // Adjust as needed
        
        let x = radius * cos(CGFloat(centerAngle.radians))
        let y = radius * sin(CGFloat(centerAngle.radians))
        
        return CGPoint(x: x + 0.5, y: y + 0.5)
    }
}

struct ChartDataDemo {
    var value: Double
    var label: String
    var imageName: String
    var color: Color
}

struct ContentViewDemo: View {
    let data: [ChartDataDemo] = [
        ChartDataDemo(value: 0.3, label: "Label 1", imageName: "star", color: .red),
        ChartDataDemo(value: 0.4, label: "Label 2", imageName: "circle", color: .green),
        ChartDataDemo(value: 0.2, label: "Label 3", imageName: "square", color: .blue),
        ChartDataDemo(value: 0.1, label: "Label 4", imageName: "triangle", color: .orange),
    ]

    var body: some View {
        PieChartDemo(data: data)
            .frame(width: 300, height: 300)
            .background(Color.brown)
    }
}


struct ContentViewDemo_Previews: PreviewProvider {
    static var previews: some View {
        ContentViewDemo()
    }
}
