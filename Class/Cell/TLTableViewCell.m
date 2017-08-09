//
//  TLTableViewCell.m
//  ESLListening
//
//  Created by NguyenThanhLuan on 19/12/2016.
//  Copyright © 2016 Olala. All rights reserved.
//

#import "TLTableViewCell.h"

@implementation TLTableViewCell
@synthesize state = _state;
@synthesize title = _title;
@synthesize categoryID = _categoryID;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _state = kNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setState:(LessonState)state{
    _state = state;
}

-(LessonState)state{
    return _state;
}

-(void)setCategoryID:(NSInteger)categoryID{
    _categoryID = categoryID;
}

-(NSInteger)categoryID{
    return _categoryID;
}

-(void)setDisplayTitle:(NSString *)title
{
    [_title setText:title];
}

@end
