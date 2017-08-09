//
//  TLPageViewController.m
//  PageView
//
//  Created by NguyenThanhLuan on 12/12/2016.
//  Copyright © 2016 Olala. All rights reserved.
//

#import "TLPageViewController.h"

@interface TLPageViewController()

@end

@implementation TLPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:.6];
    self.popUpView.layer.cornerRadius = 8;
    self.popUpView.layer.shadowOpacity = 0.8;
    self.popUpView.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    
    [_lbTitle setText:_title];
    [_lbSpell setText:_spell];
    [_lbExplain setText:_giaithich];
    [_lbExample setText:[NSString stringWithFormat:@"Ex : %@",_vidu]];
}

-(void)viewDidAppear:(BOOL)animated
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)setAudio:(NSString *)audio{
    _audio = audio;
}

-(void)setTitle:(NSString *)title{
    _title = title;
}

-(void)setSpell:(NSString *)spell{
    _spell = spell;
}

-(void)setGiaiThich:(NSString *)giaithich{
    _giaithich = giaithich;
}

-(void)setTuloai:(NSString *)tuloai{
    _tuloai = tuloai;
}

-(void)setVidu:(NSString *)vidu{
    _vidu = vidu;
}

- (void)showAnimate
{
    self.view.transform = CGAffineTransformMakeScale(1.3, 1.3);
    self.view.alpha = 0;
    [UIView animateWithDuration:.25 animations:^{
        self.view.alpha = 1;
        self.view.transform = CGAffineTransformMakeScale(1, 1);
    }];
}

- (void)removeAnimate
{
    [UIView animateWithDuration:.25 animations:^{
        self.view.transform = CGAffineTransformMakeScale(1.3, 1.3);
        self.view.alpha = 0.0;
    } completion:^(BOOL finished) {
        if (finished) {
            [self.view removeFromSuperview];
        }
    }];
}

- (IBAction)next:(id)sender {
    
    if (_delegate && [_delegate respondsToSelector:@selector(speak:)]) {
        [_delegate speak:_audio];
    }
}

-(IBAction)close:(id)sender{
    if (_delegate && [_delegate respondsToSelector:@selector(closepage)]) {
        [_delegate closepage];
    }
}

- (IBAction)showMore:(id)sender{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle: _tuloai
                                                             delegate:self
                                                    cancelButtonTitle:@"Got it"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:nil, nil];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        // In this case the device is an iPad.
        [actionSheet showFromRect:[(UIButton *)sender frame] inView:self.view animated:YES];
    }
    else{
        // In this case the device is an iPhone/iPod Touch.
        [actionSheet showInView:self.view];
    }
    
    actionSheet.tag = 100;
}

- (void)showInView:(UIView *)aView animated:(BOOL)animated
{
    [aView addSubview:self.view];
    if (animated) {
        [self showAnimate];
    }
}
@end
