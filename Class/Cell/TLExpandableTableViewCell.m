//
//  TLExpandableTableViewCell.m
//  600 Words for Toeic
//
//  Created by NguyenThanhLuan on 16/05/2017.
//  Copyright © 2017 Olala. All rights reserved.
//

#import "TLExpandableTableViewCell.h"

@implementation TLExpandableTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [_textview setEditable:NO];
    
    [self reloadData];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setAudio:(NSString *)au {
    audio = au;
}

-(void)setStringDetail:(NSString *)detail{
    strDetail = detail;
    
    [self reloadData];
}

-(void)reloadData{
    NSAttributedString *strAttribute = [[NSAttributedString alloc] initWithData:[strDetail dataUsingEncoding:NSUnicodeStringEncoding]
                                                                        options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType }
                                                             documentAttributes:nil
                                                                          error:nil];
    
    [_textview setAttributedText:strAttribute];
}


@end
