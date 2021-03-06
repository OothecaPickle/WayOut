//
//  AppDelegate.m
//  WayOut
//
//  Created on 05.06.16.
//  All rights reserved.
//

#import "AppDelegate.h"
#import <sys/sysctl.h>
#import "ImageValidation.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    NSSet *supportedPlatforms = [NSSet setWithObjects:@"iPhone2,1", @"iPhone3,1", @"iPhone3,2", @"iPhone3,3", @"iPhone4,1", @"iPhone5,1", @"iPhone5,2", @"iPhone5,3", @"iPhone5,4", @"iPod3,1", @"iPod4,1", @"iPod5,1", @"iPad1,1", @"iPad2,1", @"iPad2,2", @"iPad2,3", @"iPad2,4", @"iPad2,5", @"iPad2,6", @"iPad2,7", @"iPad3,1", @"iPad3,2", @"iPad3,3", @"iPad3,4", @"iPad3,5", @"iPad3,6", nil];

    char model[16];
    size_t size = sizeof(model);
    sysctlbyname("hw.machine", model, &size, NULL, 0);
    
    if ([supportedPlatforms containsObject:[NSString stringWithCString:model encoding:NSASCIIStringEncoding]]) {
        
        int iOSVersion = [[[UIDevice currentDevice] systemVersion] intValue];
        
        if (iOSVersion > 6) {
            
            self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
            self.ViewController = [[ViewController alloc] init];
            self.window.rootViewController = self.ViewController;
            [self.window makeKeyAndVisible];
            
        } else {
            
            self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
            self.ViewControllerForiOS6 = [[ViewControllerForiOS6 alloc] init];
            self.window.rootViewController = self.ViewControllerForiOS6;
            [self.window makeKeyAndVisible];
            
            if (iOSVersion > 5) {
            
                [[UILabel appearanceWhenContainedIn:[UITableViewHeaderFooterView class], nil] setTextColor:[UIColor whiteColor]];
                [[UILabel appearanceWhenContainedIn:[UITableViewHeaderFooterView class], nil] setShadowColor:[UIColor blackColor]];
                [[UILabel appearanceWhenContainedIn:[UITableViewHeaderFooterView class], nil] setShadowOffset:CGSizeMake(0, -1)];
            }
        
        }
        
    } else {
        
        if ([[UIScreen mainScreen] scale] > 2) {
            [self adaptForiPhonePlus];
        }
        
        self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        self.NoSupportViewController = [[NoSupportViewController alloc] init];
        self.window.rootViewController = self.NoSupportViewController;
        [self.window makeKeyAndVisible];
    }
    
    if (![ImageValidation isConfigValid]) {
        [ImageValidation generateDefaults];
    }

    return YES;
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
     // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.

}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.

}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
}

- (void)adaptForiPhonePlus {
    
    if (![[NSFileManager defaultManager] moveItemAtPath:[[NSBundle mainBundle] pathForResource:@"LinenTiled@2x" ofType:@"png"] toPath:[[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"LinenTiled@3x.png"] error:nil] && ![[NSFileManager defaultManager] moveItemAtPath:[[NSBundle mainBundle] pathForResource:@"NoSupport@2x~iphone" ofType:@"png"] toPath:[[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"NoSupport@3x~iphone.png"] error:nil]) {
        NSLog(@"Graphics adaptation only works on jailbroken devices");
    }
    
}

@end
