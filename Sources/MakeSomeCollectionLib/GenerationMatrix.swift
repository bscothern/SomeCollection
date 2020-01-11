//
//  GenerationMatrix.swift
//  SomeCollection
//
//  Created by Braden Scothern on 1/10/20.
//  Copyright © 2020 Braden Scothern. All rights reserved.
//

import Foundation

public struct GenerationMatrix {
    let sequenceTypes: [SequenceType]
    let collectionTypes: [CollectionType]
    let elementTypes: [ElementType]

    public init<S1, S2, S3>(sequenceTypes: S1, collectionTypes: S2, elementTypes: S3) where S1: Sequence, S2: Sequence, S3: Sequence, S1.Element == SequenceType, S2.Element == CollectionType, S3.Element == ElementType {
        self.sequenceTypes = (sequenceTypes as? Set ?? Set(sequenceTypes)).sorted()
        self.collectionTypes = (collectionTypes as? Set ?? Set(collectionTypes)).sorted()
        self.elementTypes = (elementTypes as? Set ?? Set(elementTypes)).sorted()
    }
}
