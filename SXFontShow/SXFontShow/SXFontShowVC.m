//
//  SXFontShowVC.m
//  SXFontShow
//
//  Created by dongshangxian on 15/8/2.
//  Copyright (c) 2015年 Sankuai. All rights reserved.
//

#import "SXFontShowVC.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface SXFontShowVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic,strong)UITableView * tableView2;
@end

@implementation SXFontShowVC

#pragma mark - **************** 初始样式

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, SCREEN_HEIGHT-40)style:UITableViewStyleGrouped];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [self.view addSubview:_tableView];
    
    _tableView2=[[UITableView alloc] initWithFrame:_tableView.frame style:UITableViewStyleGrouped];
    _tableView2.delegate=self;
    _tableView2.dataSource=self;
    [self.view addSubview:_tableView2];
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    topView.backgroundColor = [UIColor darkGrayColor];
    [self.view addSubview:topView];
    
    UIButton *btnLess = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/4, 0, SCREEN_WIDTH/4, 40)];
    UIButton *btnMore = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2, 0, SCREEN_WIDTH/4, 40)];
    
    [btnLess setTitle:@"精简显示" forState:UIControlStateNormal];
    [btnMore setTitle:@"完整显示" forState:UIControlStateNormal];
    btnLess.tag = 50;
    btnMore.tag = 51;
    
    [btnLess addTarget:self action:@selector(topClickWithSender:) forControlEvents:UIControlEventTouchUpInside];
    [btnMore addTarget:self action:@selector(topClickWithSender:) forControlEvents:UIControlEventTouchUpInside];
    
    [topView addSubview:btnLess];
    [topView addSubview:btnMore];
    
    [self topClickWithSender:btnLess];
}

- (void)topClickWithSender:(UIButton *)button
{
    if (button.tag == 50) {
        _tableView.hidden = NO;
        _tableView2.hidden = YES;
    }else if (button.tag == 51){
        _tableView.hidden = YES;
        _tableView2.hidden = NO;
    }
    
}

- (BOOL)prefersStatusBarHidden{
    return YES;
}

#pragma mark - **************** UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //字体家族总数
    return [[UIFont familyNames] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.tableView) {
        return 1;
    }else{
        //字体家族包括的字体库总数
        return [[UIFont fontNamesForFamilyName:[[UIFont familyNames] objectAtIndex:section] ] count];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (tableView == self.tableView) {
        return @"";
    }else{
        return [[UIFont familyNames] objectAtIndex:section];
    }
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    [tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:index] atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
    return index;
}

int a = 0;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        if (tableView == self.tableView) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        }else{
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        }
    }

    NSString *familyName= [[UIFont familyNames] objectAtIndex:indexPath.section];
    
    NSArray *fontNameArray = [UIFont fontNamesForFamilyName:familyName];
    if (fontNameArray.count < 1) {
        cell.textLabel.text = [NSString stringWithFormat:@"%@字体在iOS9后废弃了",familyName];
        cell.detailTextLabel.text = @"";
        cell.textLabel.font = [UIFont systemFontOfSize:10];
        return cell;
    }
    NSString *fontName  = [fontNameArray objectAtIndex:indexPath.row];
    
    if (tableView == self.tableView) {
        cell.textLabel.text=@"DSXNiubility-2015@;";
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", familyName];
        cell.textLabel.font = [UIFont fontWithName:fontName size:20.0f];
        cell.detailTextLabel.font = [UIFont fontWithName:fontName size:12.0f];
    }else{
        cell.textLabel.text=@"董铂然-DSX-dantesx2012@gmail.com";
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%d - %@",a++,fontName];
        cell.textLabel.font = [UIFont fontWithName:fontName size:16.0f];
    }
    
    return cell;
}

#pragma mark - **************** UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView == self.tableView) {
        return CGFLOAT_MIN;
    }else{
        return 30;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (tableView == self.tableView) {
        return CGFLOAT_MIN;
    }else{
        return 10;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    NSString *familyName= [[UIFont familyNames] objectAtIndex:indexPath.section];
    NSString *fontName  = [[UIFont fontNamesForFamilyName:[[UIFont familyNames] objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
    
    NSLog(@"%@-%@",familyName,fontName);
    
}

@end
