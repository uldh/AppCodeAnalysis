# AppCodeAnalysis
1.安装方法：
pod 'AppCodeAnalysis'


2.使用方法：
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
//    [self customURLCache];
#if DEBUG
    SWIZZ_IT
#endif
}
