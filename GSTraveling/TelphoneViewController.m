#import "TelphoneViewController.h"
#import "CHCSVParser.h"
#import "TelTableViewCell.h"





@interface TelphoneViewController () <UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
{
    NSMutableArray *fileredDevices;
    BOOL isFiltered;
    NSMutableDictionary *dict;
    NSMutableArray *currentRow;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end



@implementation TelphoneViewController
{
//    NSMutableDictionary *dict;
//    NSMutableArray *currentRow;
 
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
//                                   initWithTarget:self
//                                   action:@selector(dismissKeyboard)];
//
//    [self.view addGestureRecognizer:tap];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"tel1" ofType:@"csv"];
    
    CHCSVParser *parser=[[CHCSVParser alloc] initWithContentsOfCSVFile:path delimiter:','];
    
    parser.delegate=self;
    [parser parse];
    
 
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    isFiltered = false;
    self.searchBar.delegate = self;
    
 
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void) dismissKeyboard
{
    // add self
    NSLog(@"searchBar reisngFirstResopnder");
    [self.searchBar resignFirstResponder];
}

#pragma mark - Bar Delegate
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
   if( [searchText length] == 0)
    {
        isFiltered = false;
    }
    else
    {
        isFiltered = true;
        fileredDevices = [[NSMutableArray alloc]init];
        
        for (NSString *device in currentRow)
        {
            NSString *deviceEnName = [device valueForKey:@"2"];
            NSString *searchString = [NSString stringWithFormat:@"%@ %@ %@ %@"
                                      , [device valueForKey:@"1"]
                                      , [device valueForKey:@"2"]
                                      , [device valueForKey:@"5"]
                                      , [device valueForKey:@"6"]
                                      ];

            NSLog(@"%@,--->%@",searchText,searchString);
            NSRange nameRnage = [searchString rangeOfString:searchText options:NSCaseInsensitiveSearch];
            
            NSLog(@"%ld,***>",nameRnage.location);
            
                if(nameRnage.location != NSNotFound)
                {
                    [fileredDevices addObject:device];
                }
        }
    }
    [_tableView reloadData];
    
 
}




-(void) parserDidBeginDocument:(CHCSVParser *)parser
{
    currentRow = [[NSMutableArray alloc] init];
}

-(void) parserDidEndDocument:(CHCSVParser *)parser
{
    for(int i=0;i<[currentRow count];i++)
    {
        NSLog(@"%@          %@          %@",[[currentRow objectAtIndex:i] valueForKey:[NSString stringWithFormat:@"0"]],[[currentRow objectAtIndex:i] valueForKey:[NSString stringWithFormat:@"1"]],[[currentRow objectAtIndex:i] valueForKey:[NSString stringWithFormat:@"2"]]);
    }
}

- (void) parser:(CHCSVParser *)parser didFailWithError:(NSError *)error
{
    NSLog(@"Parser failed with error: %@ %@", [error localizedDescription], [error userInfo]);
}

-(void)parser:(CHCSVParser *)parser didBeginLine:(NSUInteger)recordNumber
{
    dict=[[NSMutableDictionary alloc]init];
}

-(void)parser:(CHCSVParser *)parser didReadField:(NSString *)field atIndex:(NSInteger)fieldIndex
{
    [dict setObject:field forKey:[NSString stringWithFormat:@"%d",fieldIndex]];
}

- (void) parser:(CHCSVParser *)parser didEndLine:(NSUInteger)lineNumber
{
    [currentRow addObject:dict];
    dict=nil;
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
if (isFiltered)
{
    return fileredDevices.count;
}
 
    // Return the number of rows in the section.
    NSLog(@"counttt %ld",[currentRow count]);
    return [currentRow count];
   
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    [self dismissKeyboard];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    UIView *bgColorView = [[UIView alloc] init];
    bgColorView.backgroundColor = [UIColor colorWithRed:0.0f green:0.0f blue: 1.0f alpha:0.25f];
    
   
    
    [cell setSelectedBackgroundView:bgColorView];
    
if (!isFiltered)
{

    NSLog(@"%@", [[currentRow objectAtIndex:indexPath.row] valueForKey:[NSString stringWithFormat:@"1"]]);
    
    [cell.cnName setText:[[currentRow objectAtIndex:indexPath.row] valueForKey:[NSString stringWithFormat:@"1"]]];
    
    [cell.enName setText:[[currentRow objectAtIndex:indexPath.row] valueForKey:[NSString stringWithFormat:@"2"]]];
    
    [cell.twTelphone setText:[[currentRow objectAtIndex:indexPath.row] valueForKey:[NSString stringWithFormat:@"5"]]];
    
    
    NSString *telString= [[currentRow objectAtIndex:indexPath.row] valueForKey:[NSString stringWithFormat:@"6"]];
    NSArray *arrayTel = [telString componentsSeparatedByString:@"/"];
    
    
    NSInteger count = [arrayTel count];
    
    [cell.cnTelphone1 setText:arrayTel[0]];
    if (count > 1 )
    {
        [cell.cnTelphone2 setText:arrayTel[1]];
    }
    else
    {
        [cell.cnTelphone2 setText:@"N/A"];
    }
}
else
{
    
    NSLog(@"%@", [[fileredDevices objectAtIndex:indexPath.row] valueForKey:[NSString stringWithFormat:@"1"]]);
    [cell.cnName setText:[[fileredDevices objectAtIndex:indexPath.row] valueForKey:[NSString stringWithFormat:@"1"]]];
    
    [cell.enName setText:[[fileredDevices objectAtIndex:indexPath.row] valueForKey:[NSString stringWithFormat:@"2"]]];
    
    [cell.twTelphone setText:[[fileredDevices objectAtIndex:indexPath.row] valueForKey:[NSString stringWithFormat:@"5"]]];
    
    
    NSString *telString= [[fileredDevices objectAtIndex:indexPath.row] valueForKey:[NSString stringWithFormat:@"6"]];
    NSArray *arrayTel = [telString componentsSeparatedByString:@"/"];
    
    
    NSInteger count = [arrayTel count];
    
    [cell.cnTelphone1 setText:arrayTel[0]];
    if (count > 1 )
    {
        [cell.cnTelphone2 setText:arrayTel[1]];
    }
    else
    {
        [cell.cnTelphone2 setText:@"N/A"];
    }
}
    
    return cell;
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
