//
//  ProfileScreen.swift
//  FoodRecipe
//
//  Created by Raul Palade on 23/05/24.
//

import ScalingHeaderScrollView
import SwiftUI
import UIKit

class ProfileScreenViewModel: ObservableObject {
    
}

struct ProfileScreen: View {
    var avatarImage: String = "profileAvatar"
    var userName: String = "Alisa Millford"
    
    @Environment(\.presentationMode) var presentationMode
    @State var progress: CGFloat = 0
    private let minHeight = 110.0
    private let maxHeight = 372.0

    var body: some View {
        ZStack {
            ScalingHeaderScrollView {
                ZStack {
                    Color.white.edgesIgnoringSafeArea(.all)
                    largeHeader(progress: progress)
                }
            } content: {
                profilerContentView
            }
            .height(min: minHeight, max: maxHeight)
            .collapseProgress($progress)
            .allowsHeaderGrowth()

            topButtons
        }
        .ignoresSafeArea()
    }

    private var topButtons: some View {
        VStack {
            HStack {
                Button("", action: { self.presentationMode.wrappedValue.dismiss() })
                    .buttonStyle(CircleButtonStyle(imageName: "arrow.backward"))
                    .padding(.leading, 17)
                    .padding(.top, 50)
                Spacer()
                Button("", action: { print("Info") })
                    .buttonStyle(CircleButtonStyle(imageName: "ellipsis"))
                    .padding(.trailing, 17)
                    .padding(.top, 50)
            }
            Spacer()
        }
        .ignoresSafeArea()
    }

    // SERVE
    private var smallHeader: some View {
        HStack(spacing: 12.0) {
            Image(avatarImage)
                .resizable()
                .frame(width: 40.0, height: 40.0)
                .clipShape(RoundedRectangle(cornerRadius: 6.0))

            Text(userName)
                .fontRegular(color: .appDarkGray, size: 17)
        }
    }

    // SERVE
    private func largeHeader(progress: CGFloat) -> some View {
        ZStack {
            Image(avatarImage)
                .resizable()
                .scaledToFill()
                .frame(height: maxHeight)
                .opacity(1 - progress)

            VStack {
                Spacer()

                HStack(spacing: 4.0) {
                    Capsule()
                        .frame(width: 40.0, height: 3.0)
                        .foregroundColor(.white)

                    Capsule()
                        .frame(width: 40.0, height: 3.0)
                        .foregroundColor(.white.opacity(0.2))

                    Capsule()
                        .frame(width: 40.0, height: 3.0)
                        .foregroundColor(.white.opacity(0.2))
                }

                
                ZStack(alignment: .leading) {
                    VisualEffectView(effect: UIBlurEffect(style: .regular))
                        .mask(Rectangle().cornerRadius(40, corners: [.topLeft, .topRight]))
                        .offset(y: 10.0)
                        .frame(height: 80.0)

                    RoundedRectangle(cornerRadius: 40.0, style: .circular)
                        .foregroundColor(.clear)
                        .background(
                            LinearGradient(gradient: Gradient(colors: [.white.opacity(0.0), .white]), startPoint: .top, endPoint: .bottom)
                        )

                    userNameComponent
                        .padding(.leading, 24.0)
                        .padding(.top, 10.0)
                        .opacity(1 - max(0, min(1, (progress - 0.75) * 4.0)))
                    
                    smallHeader
                        .padding(.leading, 85.0)
                        .opacity(progress)
                        .opacity(max(0, min(1, (progress - 0.75) * 4.0)))
                }
                .frame(height: 80.0)
            }
        }
    }

    private var profilerContentView: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 20) {
                    
                    HStack(content: {
                        Text("Placeholder")
                    })
                    
                    Color.clear.frame(height: 100)
                }
                .padding(.horizontal, 24)
            }
        }
    }

    private var userNameComponent: some View {
        HStack(content: {
            /*@START_MENU_TOKEN@*/Text("Placeholder")/*@END_MENU_TOKEN@*/
        })
    }
}

// THIS
struct VisualEffectView: UIViewRepresentable {
    var effect: UIVisualEffect?

    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView { UIVisualEffectView() }
    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) { uiView.effect = effect }
}

// THIS
struct CircleButtonStyle: ButtonStyle {
    var imageName: String
    var foreground = Color.black
    var background = Color.white
    var width: CGFloat = 40
    var height: CGFloat = 40

    func makeBody(configuration: Configuration) -> some View {
        Circle()
            .fill(background)
            .overlay(Image(systemName: imageName)
                .resizable()
                .scaledToFit()
                .foregroundColor(foreground)
                .padding(12))
            .frame(width: width, height: height)
    }
}

// HEX
extension Color {
    static func hex(_ hex: String) -> Color {
        guard let uiColor = UIColor(named: hex) else {
            return Color.red
        }
        return Color(uiColor)
    }
}

// THIS
extension Color {
    static let appDarkGray = Color.hex("#0C0C0C")
    static let appGray = Color.hex("#0C0C0C").opacity(0.8)
    static let appLightGray = Color.hex("#0C0C0C").opacity(0.4)
    static let appYellow = Color.hex("#FFAC0C")

    // Booking
    static let appRed = Color.hex("#F62154")
    static let appBookingBlue = Color.hex("#1874E0")

    // Profile
    static let appProfileBlue = Color.hex("#374BFE")
}

// THIS
extension View {
    func fontBold(color: Color = .black, size: CGFloat) -> some View {
        foregroundColor(color).font(.custom("Circe-Bold", size: size))
    }

    func fontRegular(color: Color = .black, size: CGFloat) -> some View {
        foregroundColor(color).font(.custom("Circe", size: size))
    }
}

// THIS
struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

// THIS
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct ProfileScreen_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ProfileScreen()
        }
    }
}
