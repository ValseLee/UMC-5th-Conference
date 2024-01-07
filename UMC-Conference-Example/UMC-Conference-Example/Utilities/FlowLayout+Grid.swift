//
//  FlowLayout+Grid.swift
//  UMC-Conference-Example
//
//  Created by Celan on 1/7/24.
//

import UIKit

extension UICollectionViewLayout {
  static func createGridLayout(
    with gridInfo: GridInfo,
    in view: UIView) -> UICollectionViewFlowLayout
  {
    let viewWidth = view.bounds.width
    let availablePadding = CGFloat(gridInfo.padding * 2)
    let gridSpacing = CGFloat(gridInfo.spacing * CGFloat(gridInfo.columns - 1))
    
    let availableWidth: CGFloat = viewWidth - availablePadding - gridSpacing
    let cellWidth = availableWidth / CGFloat(gridInfo.columns)
    
    let layout = UICollectionViewFlowLayout()
    layout.sectionInset = UIEdgeInsets(top: gridInfo.padding, left: gridInfo.padding, bottom: gridInfo.padding, right: gridInfo.padding)
    layout.itemSize = CGSize(width: cellWidth, height: cellWidth + 50)
    return layout
  }
}

struct GridInfo {
  let columns: Int
  let padding: CGFloat
  let spacing: CGFloat
  
  public init(
    columns: Int,
    padding: CGFloat = 12,
    spacing: CGFloat = 10
  ) {
    self.columns = columns
    self.padding = padding
    self.spacing = spacing
  }
}
