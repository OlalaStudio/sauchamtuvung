//
//  TLDetailTableViewCell.m
//  600 Words for Toeic
//
//  Created by NguyenThanhLuan on 16/05/2017.
//  Copyright © 2017 Olala. All rights reserved.
//

#import "TLDetailTableViewCell.h"

@implementation TLDetailTableViewCell
@synthesize delegate = _delegate;
@synthesize categoryID = _categoryID;
@synthesize audio = _audio;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setCategoryID:(NSInteger)categoryID{
    _categoryID = categoryID;
}

-(NSInteger)categoryID{
    return _categoryID;
}

-(void)setAudio:(NSString *)audio{
    _audio = audio;
}

-(NSString*)audio{
    return _audio;
}

-(void)setDisplayTitle:(NSString *)title
{
    [_title setText:title];
}

-(void)setDisplaySpell:(NSString *)spell{
    
    [_spell setText:spell];
}

-(void)setDisplayDetail:(NSString *)detail{
    [_detail setText:detail];
}

- (IBAction)speak:(id)sender {
    
    if (_delegate && [_delegate respondsToSelector:@selector(speaker:)]) {
        [_delegate speaker:_audio];
    }
    
}

@end
