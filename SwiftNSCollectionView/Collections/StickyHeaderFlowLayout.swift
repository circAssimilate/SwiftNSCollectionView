import Cocoa

class StickyHeaderFlowLayout: NSCollectionViewFlowLayout {
    override func layoutAttributesForElements(in rect: NSRect) -> [NSCollectionViewLayoutAttributes] {
        guard let layoutAttributes = super.layoutAttributesForElements(in: rect).map({ $0.copy() }) as? [NSCollectionViewLayoutAttributes] else { return [] }
        
        var adjustedAttributes = [NSCollectionViewLayoutAttributes]()
        
        for attributes in layoutAttributes {
            if attributes.representedElementKind == NSCollectionView.elementKindSectionHeader {
                let adjustedAttribute = layoutAttributesForStickyHeader(attributes)
                adjustedAttributes.append(adjustedAttribute)
            } else {
                adjustedAttributes.append(attributes)
            }
        }
        
        return adjustedAttributes
    }
    
    private func layoutAttributesForStickyHeader(_ attributes: NSCollectionViewLayoutAttributes) -> NSCollectionViewLayoutAttributes {
        guard let collectionView = collectionView else { return attributes }
        
        if attributes.representedElementKind == NSCollectionView.elementKindSectionHeader {
            let contentOffsetY = collectionView.visibleRect.origin.y
            var frame = attributes.frame
            frame.origin.y = max(contentOffsetY, frame.origin.y)
            attributes.frame = frame
            attributes.zIndex = 1024 // Ensure the header is on top
        }
        
        return attributes
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: NSRect) -> Bool {
        return true
    }
}
