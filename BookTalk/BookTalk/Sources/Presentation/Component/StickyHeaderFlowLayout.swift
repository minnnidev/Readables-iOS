//
//  StickyHeaderFlowLayout.swift
//  BookTalk
//
//  Created by RAFA on 8/20/24.
//

import UIKit

final class StickyHeaderFlowLayout: UICollectionViewFlowLayout {
    
    override func layoutAttributesForElements(
        in rect: CGRect
    ) -> [UICollectionViewLayoutAttributes]? {
        guard let attributes = super.layoutAttributesForElements(in: rect) else {
            return nil
        }
        
        let modifiedAttributes = attributes.map { $0.copy() as! UICollectionViewLayoutAttributes }
        
        for attributes in modifiedAttributes {
            if attributes.representedElementKind == UICollectionView.elementKindSectionHeader {
                if attributes.indexPath.section == 1 {
                    let stickyAttributes = getStickyAttributes(at: attributes)
                    attributes.frame = stickyAttributes.frame
                }
            }
        }
        
        return modifiedAttributes
    }

    private func getStickyAttributes(
        at attributes: UICollectionViewLayoutAttributes
    ) -> UICollectionViewLayoutAttributes {
        guard let collectionView = collectionView else { return attributes }
        
        let contentOffsetY = collectionView.contentOffset.y
        let originalY = attributes.frame.origin.y
        
        if contentOffsetY > originalY {
            var frame = attributes.frame
            frame.origin.y = contentOffsetY
            attributes.frame = frame
            attributes.zIndex = 1024
        }
        
        return attributes
    }
}
