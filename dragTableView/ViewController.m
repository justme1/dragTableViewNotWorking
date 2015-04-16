
#import "ViewController.h"

#define HEADER_HEIGHT 50

@interface ViewController()

@property CGFloat oldValue;
@property(nonatomic,strong) NSLayoutConstraint *headerTopConstraint;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero];
    _tableView.translatesAutoresizingMaskIntoConstraints = NO;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor greenColor];
    [self.tableView setShowsVerticalScrollIndicator:NO];
    
    
    [self.view addSubview:_tableView];

    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_tableView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1.0f constant:0.0f]];
    
    
    self.viewHeader = [UIView new];
    self.viewHeader.translatesAutoresizingMaskIntoConstraints = NO;
    self.viewHeader.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.viewHeader];

    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_viewHeader attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1.0f constant:0.0f]];
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES
                                            withAnimation:UIStatusBarAnimationFade];
    
    
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_viewHeader attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1.0f constant:50.0f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_tableView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0.0f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_tableView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.viewHeader attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0.0f]];
    
    self.headerTopConstraint = [NSLayoutConstraint constraintWithItem:_viewHeader attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0f constant:0.0f];
    self.headerTopConstraint.priority = 1000;
    [self.view addConstraint:self.headerTopConstraint];
    
    self.navigationController.navigationBarHidden = YES;
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat delta =  scrollView.contentOffset.y - self.oldValue;
    [UIView animateWithDuration:0
                          delay:0
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^
     {
         self.headerTopConstraint.constant -= delta;
         [self.view layoutIfNeeded];
     }completion:nil];
    self.oldValue =scrollView.contentOffset.y;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [UITableViewCell new];
    cell.contentView.backgroundColor = [UIColor greenColor];
    return cell;
}


@end
