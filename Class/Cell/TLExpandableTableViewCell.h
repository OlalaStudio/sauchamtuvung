//
//  TLExpandableTableViewCell.h
//  600 Words for Toeic
//
//  Created by NguyenThanhLuan on 16/05/2017.
//  Copyright © 2017 Olala. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TLExpandableTableViewCell : UITableViewCell{
    NSString *audio;
    NSString *strDetail;
}

@property (weak, nonatomic) IBOutlet UITextView *textview;

-(void)setStringDetail:(NSString*)detail;
-(void)setAudio:(NSString*)au;

@end
