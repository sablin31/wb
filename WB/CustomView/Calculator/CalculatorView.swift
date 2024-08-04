//
//  CalculatorView.swift
//  WB
//
//  Created by Aleksei Sablin on 04.08.2024.
//

import SwiftUI

struct CalculatorView: View {

    // MARK: Private properties

    @StateObject private var model = CalculatorModel()
    let buttons: [[String]] = [
        ["7", "8", "9", "/"],
        ["4", "5", "6", "*"],
        ["1", "2", "3", "-"],
        ["0", ".", "C", "+"],
        ["="]
    ]

    // MARK: Computed properties

    var body: some View {
        ZStack {
            bg
            VStack(spacing: 10) {
                display
                VStack(spacing: 10) {
                    ForEach(buttons, id: \.self) { row in
                        HStack {
                            ForEach(row, id: \.self) { title in
                                makeBtn(with: title)
                            }
                        }
                    }
                }
                .padding()
            }
            .padding()
        }
    }
}
// MARK: - UI Properties

private extension CalculatorView {
    var bg: some View {
        Color.black
            .opacity(0.75)
            .ignoresSafeArea()
    }

    var display: some View {
        HStack {
            Spacer()
            Text(model.input.isEmpty ? model.result : model.input)
                .font(.largeTitle)
                .foregroundStyle(.white)
                .padding()
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.horizontal)
                .accessibilityIdentifier("resultLabel")
        }
    }
}
// MARK: - Private methods

private extension CalculatorView {

    // MARK: Helpers

    func makeBtn(with title: String) -> some View {
        Button(action: { model.buttonTapped(title) }) {
            Text(title)
                .font(.title)
                .frame(width: title == "=" ? 160 : 80, height: 80)
                .background(title == "=" ? Color.orange : Color.black.opacity(0.3))
                .foregroundColor(.white)
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(Color.white, lineWidth: 2)
                )
        }
        .accessibilityIdentifier(title)
    }
}
// MARK: - Preview

#Preview {
    CalculatorView()
}
