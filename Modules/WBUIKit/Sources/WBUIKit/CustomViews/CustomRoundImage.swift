//
//  CustomRoundImage.swift
//  
//
//  Created by Aleksei Sablin on 04.07.2024.
//

import SwiftUI

// MARK: Computed properties

public struct CustomRoundImage: View {

    // MARK: Private properties

    private var imageName: String?
    private var imageSysName: String?
    private var size: CGSize

    // MARK: Computed properties

    public var body: some View {
        var name = ""
        if let imageSysName {
            name = imageSysName
        }
        if let imageName {
            name = imageName
        }
        return Image(name)
            .aspectRatio(contentMode: .fill)
            .frame(width: size.width, height: size.height)
            .clipShape(Circle())
    }

    // MARK: Init

    public init(
        imageName: String? = nil,
        imageSysName: String? = nil,
        size: CGSize = .init(width: 96, height: 96)
    ) {
        self.imageName = imageName
        self.imageSysName = imageSysName
        self.size = size
    }
}
