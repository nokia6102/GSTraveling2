#import "ViewController.h"
#import <MBCircularProgressBar/MBCircularProgressBarView.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet MBCircularProgressBarView *progressBar;
@property (weak, nonatomic) IBOutlet UILabel *dateDisplay;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy/MM/dd"];
    // or @"yyyy-MM-dd hh:mm:ss a" if you prefer the time with AM/PM
    NSString *date =[dateFormatter stringFromDate:[NSDate date]];
    _dateDisplay.text = date;
    NSLog(@"%@",date);
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [UIView animateWithDuration:1.f animations:^{
        self.progressBar.value = 55.;
    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
