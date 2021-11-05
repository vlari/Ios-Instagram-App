//
//  HomeCellType.swift
//  Instagram
//
//  Created by Obed Garcia on 2/11/21.
//

import Foundation

enum HomeCellType {
    case poster(viewModel: PosterCollectionViewCellViewModel)
    case post(viewModel: PostCollectionViewCellViewModel)
    case actions(viewModel: PostActionsCollectionViewCellViewModel)
    case likeCount(viewModel: PostLikesCollectionViewCellViewModel)
    case caption(viewModel: PostCaptionCollectionViewCellViewModel)
    case timestamp(viewModel: PostDateCollectionViewCellViewModel)
}
