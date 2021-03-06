//
//  JLADetailViewController.h
//  PokedexSprint
//
//  Created by Jorge Alvarez on 3/27/20.
//  Copyright © 2020 Jorge Alvarez. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JLAPokemon;

NS_ASSUME_NONNULL_BEGIN

@interface JLADetailViewController : UIViewController

@property (nonatomic) JLAPokemon *pokemon;

@end

NS_ASSUME_NONNULL_END
