

#import "SubwebViewController.h"
#import "MyUser.h"

@interface SubwebViewController ()

@property (weak, nonatomic) IBOutlet UITextField *toDate;
@property (weak, nonatomic) IBOutlet UITextField *toCode;
@property (weak, nonatomic) IBOutlet UITextField *returnDate;
@property (weak, nonatomic) IBOutlet UITextField *returnCode;

@end

@implementation SubwebViewController

@synthesize webView;
@synthesize webConfiguration;



- (void)viewDidLoad {
    [super viewDidLoad];
    MyUser *user = [MyUser currentUser];
    if (!user) {
        NSLog(@"未有設定記錄(对象不存在)");
        [MyUser update:@{@"toCode": _toCode.text,@"toDate": _toDate.text
                        ,@"returnCode": _returnCode.text,@"returnDate": _returnDate.text
                         }];
    }else{
        NSLog(@"已有設定記錄：%@ %@", user.toDate, user.toCode);
        _toDate.text = user.toDate;
        _toCode.text = user.toCode;
        _returnDate.text = user.returnDate;
        _returnCode.text = user.returnCode;
 
    }
   
    [self browseWeb];
}



-(IBAction)unwindToSetting:(UIStoryboardSegue*)segue
{
    NSLog(@"unwind to Settting");
}

- (IBAction)toSetCode:(UITextField *)sender
{
    [MyUser update:@{@"toCode": _toCode.text,@"toDate": _toDate.text,@"returnCode": _returnCode.text,@"returnDate": _returnDate.text
                     }];
    [self browseWeb];
}

-(void)browseWeb
{
    
    
    // userScript
    
    //---    NSString *javaScript = @"console.log('hello world')";
    //
    //    WKUserScript *userScript = [[WKUserScript alloc] initWithSource:javaScript
    //                                                      injectionTime:WKUserScriptInjectionTimeAtDocumentStart
    //                                                   forMainFrameOnly:YES];
    
    
    // webConfiguration
    
    webConfiguration = [[WKWebViewConfiguration alloc] init];
    
    // webView
    
    webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 150, self.view.frame.size.width, self.view.frame.size.height - 150) configuration:webConfiguration];
    webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    //---    [webView.configuration.userContentController addUserScript:userScript];
    webView.navigationDelegate = self;
    [self.view addSubview:webView];
    
    // request
    //    [MyUser update:@{@"toCompanyCode":@"BR", @"toNumberCode":@"869"}];
    
    

    
    MyUser *user = [MyUser currentUser];
    
    //
    //    //3%2F26+br869
    NSString *reqCode ;
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"M/d"];       //M,d 不補零
    NSString *dateNow =[dateFormatter stringFromDate:[NSDate date]];
    if (![dateNow isEqual:user.returnDate])
    {
        
        reqCode = [NSString stringWithFormat:@"%@+%@",user.toDate ,user.toCode];
    }
    else
    {
        reqCode = [NSString stringWithFormat:@"%@+%@",user.returnDate ,user.returnCode];
    }
    
    NSString *preGoogle = @"https://www.google.com.tw/search?q=";
    NSString *google = [preGoogle stringByAppendingString:reqCode];
    
    NSURL *url = [[NSURL alloc] initWithString:google];
    NSURLRequest *nsrequest = [NSURLRequest requestWithURL:url];
    [webView loadRequest:nsrequest];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
