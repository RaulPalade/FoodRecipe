//
//  Carousel.swift
//  FoodRecipe
//
//  Created by Raul Palade on 21/05/24.
//

import SwiftUI

struct FullscreenCarouselCard<Content: View, ItemData: Identifiable>: View {
    private let content: Content
    private let width: CGFloat
    private let height: CGFloat // Property for height

    init(
        _ itemData: ItemData,
        width: CGFloat,
        height: CGFloat, // Accept height as a parameter
        @ViewBuilder content: (_ itemData: ItemData) -> Content
    ) {
        self.width = width
        self.height = height // Initialize height
        self.content = content(itemData)
    }

    var body: some View {
        VStack(spacing: 0) {
            self.content
        }
        .frame(width: width, height: height) // Set both width and height
    }
}


/// FullscreenCarousel is by the title full screen only, there is no way to swipe more than 1 card
/// the size of the card is the percentage from screen 50-100% cards would be visible by both sides
struct FullscreenCarouselView<Content: View, ItemData: Identifiable>: View {
    /// Iterator content property
    private let content: (ItemData) -> Content
    /// Spacing is required to calculate proper offset
    private let spacing: CGFloat
    /// ItemData to pass to iterator content
    let itemsData: [ItemData]

    @State private var screenDrag: Float = 0.0
    @State private var activeCard = 0
    @State private var calcOffset: CGFloat

    private let cardWidth: CGFloat
    private let numberOfItems: CGFloat
    private let screenWidth = UIScreen.main.bounds.width
    private let cardWithSpacing: CGFloat
    private let xOffsetToShift: CGFloat
    private let height: CGFloat // Property for height

    init(
        spacing: CGFloat,
        itemsData: [ItemData],
        height: CGFloat, // Accept height as a parameter
        zoomFactor: CGFloat = 1,
        @ViewBuilder content: @escaping (ItemData) -> Content
    ) {
        self.spacing = spacing
        self.height = height // Initialize height
        cardWidth = screenWidth * zoomFactor - spacing * 2
        numberOfItems = CGFloat(itemsData.count)
        cardWithSpacing = cardWidth + spacing
        xOffsetToShift = cardWithSpacing * numberOfItems / 2 - cardWithSpacing / 2
        _calcOffset = .init(wrappedValue: xOffsetToShift)
        self.itemsData = itemsData
        self.content = content
    }

    var body: some View {
        return HStack(spacing: spacing) {
            ForEach(itemsData) { singleItemData in
                FullscreenCarouselCard(
                    singleItemData,
                    width: cardWidth,
                    height: height, // Pass height to each card
                    content: content
                )
            }
        }
        .frame(height: height) // Ensure the frame height is set
        .offset(x: calcOffset, y: 0)
        .animation(
            .easeInOut(duration: 0.15)
        )
        .gesture(
            DragGesture(minimumDistance: 0)
                .onChanged { currentState in
                    self.calculateOffset(Float(currentState.translation.width))
                }
                .onEnded { value in
                    self.handleDragEnd(value.translation.width)
                }
        )
    }

    /// Calculating proper offset for next slide
    func calculateOffset(_ screenDrag: Float) {
        let activeOffset = xOffsetToShift - (cardWithSpacing * CGFloat(activeCard))
        let nextOffset = xOffsetToShift - (cardWithSpacing * CGFloat(activeCard + 1))
        calcOffset = activeOffset
        if activeOffset != nextOffset {
            calcOffset = activeOffset + CGFloat(screenDrag)
        }
    }

    func handleDragEnd(_ translationWidth: CGFloat) {
        let impactMed = UIImpactFeedbackGenerator(style: .medium)
        if translationWidth < -50 && CGFloat(activeCard) < numberOfItems - 1 {
            activeCard += 1
            impactMed.impactOccurred()
        }
        if translationWidth > 50 && activeCard != 0 {
            activeCard -= 1
            impactMed.impactOccurred()
        }
        calculateOffset(0)
    }
}


#Preview {
    FullscreenCarouselView(
        spacing: 0,
        itemsData: recipesPreviewData,
        height: 172,
        zoomFactor: 0.72
    ) { itemData in
        VStack {
            FeaturedCard(title: itemData.name, authorName: "Bruno Barbieri", time: itemData.time)
        }
    }
}
