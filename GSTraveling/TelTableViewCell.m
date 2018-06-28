 
#import "TelTableViewCell.h"

@implementation TelTableViewCell

//@synthesize cnName,enName,twTelphone,cnTelphone1,cnTelphone2;


 
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}




- (IBAction)callPhoneButton:(UIButton *)sender
{
    switch (sender.tag) {
        case 1:
            
      NSLog(@"**1 %@",   [NSString stringWithFormat:@"tel:%@",_twTelphone.text] );
      [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",_twTelphone.text]]];
      
            break;        case 2:
            NSLog(@"**2 %@",   [NSString stringWithFormat:@"tel:%@",_cnTelphone1.text] );
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",_cnTelphone1.text]]];
            break;
        case 3:
            NSLog(@"**3 %@",   [NSString stringWithFormat:@"tel:%@",_cnTelphone2.text] );
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",_cnTelphone2.text]]];
            break;
        default:
            break;
    }
}

@end
