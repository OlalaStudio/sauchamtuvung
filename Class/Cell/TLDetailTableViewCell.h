//
//  TLDetailTableViewCell.h
//  600 Words for Toeic
//
//  Created by NguyenThanhLuan on 16/05/2017.
//  Copyright © 2017 Olala. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TLDetailTableViewCellProtocol <NSObject>

-(void)speaker:(NSString*)audio;

@end

@interface TLDetailTableViewCell : UITableViewCell{
    NSInteger       _categoryID;
}

@property id<TLDetailTableViewCellProtocol>         delegate;

@property (assign, nonatomic) NSInteger             categoryID;
@property (assign, nonatomic) NSString              *audio;

@property (weak, nonatomic) IBOutlet UILabel        *title;
@property (weak, nonatomic) IBOutlet UILabel        *spell;
@property (weak, nonatomic) IBOutlet UILabel        *detail;

-(void)setDisplayTitle:(NSString*)title;
-(void)setDisplaySpell:(NSString*)spell;
-(void)setDisplayDetail:(NSString*)detail;

- (IBAction)speak:(id)sender;

@end
