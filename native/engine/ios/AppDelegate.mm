/****************************************************************************
 Copyright (c) 2010-2013 cocos2d-x.org
 Copyright (c) 2013-2016 Chukong Technologies Inc.
 Copyright (c) 2017-2022 Xiamen Yaji Software Co., Ltd.

 http://www.cocos.com

 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated engine source code (the "Software"), a limited,
 worldwide, royalty-free, non-assignable, revocable and non-exclusive license
 to use Cocos Creator solely to develop games on your target platforms. You shall
 not use Cocos Creator software for developing other software or tools that's
 used for developing games. You are not granted to publish, distribute,
 sublicense, and/or sell copies of Cocos Creator.

 The software or tools in this License Agreement are licensed, not sold.
 Xiamen Yaji Software Co., Ltd. reserves all rights not expressly granted to you.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
****************************************************************************/

#import "AppDelegate.h"
#import "ViewController.h"
#import "View.h"

#include "platform/ios/IOSPlatform.h"
#import "platform/ios/AppDelegateBridge.h"
#import "service/SDKWrapper.h"

@implementation AppDelegate
@synthesize window;
@synthesize appDelegateBridge;

#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[SDKWrapper shared] application:application didFinishLaunchingWithOptions:launchOptions];
    appDelegateBridge = [[AppDelegateBridge alloc] init];
    
    // Add the view controller's view to the window and display.
    CGRect bounds = [[UIScreen mainScreen] bounds];
    self.window   = [[UIWindow alloc] initWithFrame:bounds];

    // Should create view controller first, cc::Application will use it.
    _viewController                           = [[ViewController alloc] init];
    _viewController.view                      = [[View alloc] initWithFrame:bounds];
    _viewController.view.contentScaleFactor   = UIScreen.mainScreen.scale;
    _viewController.view.multipleTouchEnabled = true;
    [self.window setRootViewController:_viewController];

    [self.window makeKeyAndVisible];
    [appDelegateBridge application:application didFinishLaunchingWithOptions:launchOptions];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
    [[SDKWrapper shared] applicationWillResignActive:application];
    [appDelegateBridge applicationWillResignActive:application];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
    [[SDKWrapper shared] applicationDidBecomeActive:application];
    [appDelegateBridge applicationDidBecomeActive:application];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
    [[SDKWrapper shared] applicationDidEnterBackground:application];
}
+(NSString *)openGallery:(NSString *) title andContent:(NSString *)content{
    NSLog(@"open galllery csll");
    NSLog(@"%@", NSTemporaryDirectory());
//    NSURL *parentFolderURL = [NSURL URLForDirectory:NSUserDirectory domainMask:NSUserDomainMask];
//       if (!parentFolderURL) parentFolderURL = [NSURL URLForDirectory:NSApplicationSupportDirectory domainMask:NSUserDomainMask];
//       if (!parentFolderURL) parentFolderURL = [NSURL URLForDirectory:NSDocumentDirectory domainMask:NSUserDomainMask];
//
//       // Get the temp folder URL using approach outlined in the docs
//       NSURL *tmpURL = [[NSFileManager defaultManager]
//        URLForDirectory:NSItemReplacementDirectory
//        inDomain:NSUserDomainMask
//        appropriateForURL:parentFolderURL
//        create:YES
//        error:NULL];
    UIImagePickerController *imgPickerCObj;
        UIImage *image;
    imgPickerCObj = [[UIImagePickerController alloc] init];
                imgPickerCObj.sourceType = UIImagePickerControllerSourceTypeCamera;
                [imgPickerCObj setDelegate:(id)self];
                imgPickerCObj.allowsEditing = YES;
    imgPickerCObj = [[UIImagePickerController alloc] init];
                imgPickerCObj.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                [imgPickerCObj setDelegate:(id)self];
                [[self topViewController] presentViewController:imgPickerCObj animated:YES completion:nil];
                imgPickerCObj.allowsEditing = YES;
    imgPickerCObj.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType: UIImagePickerControllerSourceTypePhotoLibrary];

    return NSTemporaryDirectory();
}
//- (IBAction)btnAddPhoto:(id)sender {
//    UIAlertController   *callactionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:(id)self cancelButtonTitle:NSLocalizedString(@"Cancel",nil) destructiveButtonTitle:nil otherButtonTitles:NSLocalizedString(@"Take photo",nil), NSLocalizedString(@"Choose from gallery",nil), nil];
//[callactionSheet showInView:self.view];
//}
+(NSString *)getPath:(NSString *) title andContent:(NSString *)content{

    NSLog(@"get path call");
    NSString *paths =title;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    // all files in the path
    NSArray *directoryContents = [fileManager contentsOfDirectoryAtPath:paths error:nil];
    NSLog(@"%@",directoryContents);
//    NSTemporaryDirectory();
//    paths=[paths stringByAppendingString : ]
    return directoryContents[0];
}
//- (IBAction)btnAddPhoto:(id)sender {s
//    UIActionSheet   *callactionSheet = [[UIActionSheet alloc]sinitWithTitle:nil delegate:(id)self cancelButtonTitle:NSLocalizedString(@"Cancel",nil) destructiveButtonTitle:nil otherButtonTitles:NSLocalizedString(@"Take photo",nil), NSLocalizedString(@"Choose from gallery",nil), nil];
//    [callactionSheet showInView:self.view];
//}

///var/mobile/Containers/Data/Application/FB53839F-364F-4B1A-9392-420E4F02F4F1/Documents/filename.zip


+(NSString *)openCamera:(NSString *) title andContent:(NSString *)content{
   
    
    UIImagePickerController *imgPickerCObj;
        UIImage *image;
    imgPickerCObj = [[UIImagePickerController alloc] init];
               imgPickerCObj.sourceType = UIImagePickerControllerSourceTypeCamera;
               [imgPickerCObj setDelegate:(id)self];
               imgPickerCObj.allowsEditing = YES;
    [[self topViewController] presentViewController:imgPickerCObj animated:YES completion:Nil];
    imgPickerCObj.allowsEditing = YES;
    imgPickerCObj.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType: UIImagePickerControllerSourceTypePhotoLibrary];

//   image = [UIImage imageNamed:@"someImage.png"];
//    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    return title;
}
//
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{   UIImageView *imgUpload;
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
//    self.imgUpload.image = image;
//    [self.navigationController dismissViewControllerAnimated: YES completio:nil];
             NSLog(@"Image Dic Description :%@",info.description);
}
- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
    [[SDKWrapper shared] applicationWillEnterForeground:application];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [[SDKWrapper shared] applicationWillTerminate:application];
    [appDelegateBridge applicationWillTerminate:application];
}
//- (IBAction)btnAddPhoto:(id)sender {
//    NSLog(@"btn Add photot click");
//    UIActionSheet   *callactionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:(id)self cancelButtonTitle:NSLocalizedString(@"Cancel",nil) destructiveButtonTitle:nil otherButtonTitles:NSLocalizedString(@"Take photo",nil), NSLocalizedString(@"Choose from gallery",nil), nil];
////    NSLog(@"%@",);
//}
+ (UIViewController *)topViewController{
  return [self topViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
}

+ (UIViewController *)topViewController:(UIViewController* )rootViewController
{
  if ([rootViewController isKindOfClass:[UINavigationController class]]) {
      UINavigationController *navigationController = (UINavigationController *)rootViewController;
    return [self topViewController:[navigationController.viewControllers lastObject]];
  }
  if ([rootViewController isKindOfClass:[UITabBarController class]]) {
      UITabBarController *tabController = (UITabBarController *)rootViewController;
    return [self topViewController:tabController.selectedViewController];
  }
  if (rootViewController.presentedViewController) {
    return [self topViewController:rootViewController];
  }
  return rootViewController;
}

#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    [[SDKWrapper shared] applicationDidReceiveMemoryWarning:application];
}

@end
