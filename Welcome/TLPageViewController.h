//
//  TLPageViewController.h
//  PageView
//
//  Created by NguyenThanhLuan on 12/12/2016.
//  Copyright © 2016 Olala. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TLPageViewControllerDelegate <NSObject>

-(void)nextpage;
-(void)closepage;
-(void)speak:(NSString*)audio;

@end

@interface TLPageViewController : UIViewController <UIActionSheetDelegate>{
    
    NSString    *_title;
    NSString    *_spell;
    NSString    *_giaithich;
    NSString    *_tuloai;
    NSString    *_vidu;
    NSString    *_audio;
}

@property id<TLPageViewControllerDelegate>          delegate;
@property (assign,nonatomic) NSInteger              index;

@property (weak, nonatomic) IBOutlet UIView *popUpView;
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UILabel *lbSpell;
@property (weak, nonatomic) IBOutlet UILabel *lbExplain;
@property (weak, nonatomic) IBOutlet UILabel *lbExample;
@property (weak, nonatomic) IBOutlet UIButton *btNext;


- (IBAction)next:(id)sender;
- (IBAction)close:(id)sender;
- (IBAction)showMore:(id)sender;
- (void)showInView:(UIView *)aView animated:(BOOL)animated;

-(void)setAudio:(NSString*)audio;
-(void)setTitle:(NSString*)title;
-(void)setSpell:(NSString*)spell;
-(void)setGiaiThich:(NSString*)giaithich;
-(void)setTuloai:(NSString*)tuloai;
-(void)setVidu:(NSString*)vidu;

@end
