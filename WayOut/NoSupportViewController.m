//
//  NoSupportViewController.m
//  WayOut
//
//  Created on 06.07.16.
//  All rights reserved.
//

#import "NoSupportViewController.h"

@interface NoSupportViewController ()

@end

@implementation NoSupportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    cpu_type_t arch = 0;
    size_t size = sizeof(arch);
    sysctlbyname("hw.cputype", &arch, &size, NULL, 0);
    NSString *description;
    
    switch (arch) {
        case CPU_TYPE_ARM64:
            description = @"arm64 devices aren't supported";
            break;
            
        case CPU_TYPE_ARM:
            description = @"iPhone 5c isn't supported";
            break;
            
        default:
            description = @"Perhaps you're running it on simulator? Add x86_64 to set in AppDelegate";
            break;
    }
    
    self.view.layer.cornerRadius = 4.0f;
    self.view.layer.masksToBounds = YES;
    
    UIImageView *backgroundImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, screenRect.size.width, screenRect.size.height)];
    backgroundImage.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"LinenTiled"]];
    
    UIImage *deviceImage = [UIImage imageNamed:@"NoSupport"];
    UIImageView *deviceImageView = [[UIImageView alloc] initWithFrame:CGRectMake(ceilf(screenRect.size.width/2-deviceImage.size.width/2), ceilf(screenRect.size.height/2-deviceImage.size.height/2)-70, deviceImage.size.width, deviceImage.size.height)];
    deviceImageView.image = deviceImage;
    
    UIView *labelView = [[UIView alloc] initWithFrame:CGRectMake(ceilf(screenRect.size.width/2-270/2), deviceImageView.frame.origin.y+deviceImageView.frame.size.height+75, 270, 150)];
    labelView.backgroundColor = [UIColor clearColor];
    CATextLayer *headerLayer = [CATextLayer layer];
    headerLayer.backgroundColor = [UIColor clearColor].CGColor;
    headerLayer.string = @"No support";
    headerLayer.font = (__bridge CFTypeRef)@"MyriadPro-Semibold";
    headerLayer.fontSize = 45;
    headerLayer.contentsScale = [[UIScreen mainScreen] scale];
    headerLayer.frame = CGRectMake(0, 0, labelView.layer.frame.size.width, 45);
    headerLayer.alignmentMode = kCAAlignmentCenter;
    [labelView.layer addSublayer:headerLayer];
   
    UILabel *descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, headerLayer.frame.size.height, labelView.layer.frame.size.width, 70)];
    descriptionLabel.backgroundColor = [UIColor clearColor];
    descriptionLabel.text = description;
    descriptionLabel.textColor = [UIColor whiteColor];
    descriptionLabel.numberOfLines = 0;
    descriptionLabel.font = [UIFont fontWithName:@"Helvetica" size:18];
    descriptionLabel.textAlignment = NSTextAlignmentCenter;
    descriptionLabel.shadowColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    descriptionLabel.shadowOffset = CGSizeMake(0, -1);
    [labelView addSubview:descriptionLabel];
    
    [self.view addSubview:backgroundImage];
    [self.view addSubview:deviceImageView];
    [self.view addSubview:labelView];
    
    if ([[UIScreen mainScreen] scale] != 3) {
        
        UIImage *infoButtonImage = [UIImage imageNamed:@"InfoButton"];
        UIButton *infoButton = [[UIButton alloc] initWithFrame:CGRectMake(screenRect.size.width-infoButtonImage.size.width-15, screenRect.size.height-infoButtonImage.size.height-16 , infoButtonImage.size.width, infoButtonImage.size.height)];
        [infoButton setImage:infoButtonImage forState:UIControlStateNormal];
        [infoButton addTarget:self action:@selector(InfoButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:infoButton];
    }

}

- (IBAction)InfoButtonAction:(id)sender {

    iOS6AlertView *infoButton = [[iOS6AlertView alloc] initWithTitle:[NSString stringWithFormat:@"Way Out %@ (%@)", [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"], [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey]] message:@"Way Out supports only iOS 6 compatible devices\n\nUse iPhone 5, iPad 4, iPad mini 1G, iPod touch 5 or older" delegate:nil cancelButtonTitle:nil otherButtonTitle:@"Cancel" backgroundImage:[UIImage imageNamed:@"UIPopupAlertBackground"] dimmingImage:[UIImage imageNamed:@"UIAlertViewDimming"] position:CGPointZero animated:YES];
    [infoButton show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
