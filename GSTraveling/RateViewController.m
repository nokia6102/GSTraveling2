#import "RateViewController.h"
#import <AFNetworking/AFNetworking.h>


@interface RateViewController ()
@property (weak, nonatomic) IBOutlet UITextField *txtNT;
@property (weak, nonatomic) IBOutlet UITextField *txtCN;
@property (weak, nonatomic) IBOutlet UITextField *txtRate;

@end

@implementation RateViewController
double rate=4.2;




- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [_txtRate setText:
     [NSString stringWithFormat:@"%f",rate]
     ];
    
    
}

- (IBAction)btnCovernt:(UIButton *)sender
{

    
    double cCN = [_txtNT.text doubleValue] * rate;
    
    NSString *text = [NSString stringWithFormat:@"%f", cCN];
    [_txtCN setText: text];
    
   
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
