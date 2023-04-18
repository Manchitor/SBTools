//
//  MainViewController.m
//  Tools
//
//  Created by 刘永吉 on 2023/3/30.
//  Copyright © 2023 lyj. All rights reserved.
//

#import "MainViewController.h"

#import "MainCustomCell.h"

#import "ERCalendarPickerViewController.h"
#import "SBAddressBookViewController.h"
#import "UBSignatureDrawingViewController.h"
#import "SBNumberScrollerViewController.h"
#import "SBAssetExportViewController.h"
#import "SBPhotoRevealViewController.h"
#import "SBAISpeechViewController.h"

@interface MainViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *tableview;

@property (nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupconfig];//初始化页面配置
        
    [self setupui];//初始化UI
        
    [self loaddata];//请求数据
}

#pragma mark ----------初始化页面配置
-(void)setupconfig{
    self.navigationItem.title = @"SBTool示例";
    
    self.view.backgroundColor = SBCOLORHEX(0xf8f8f8, 1);

}

#pragma mark ----------初始化页面
-(void)setupui{
    [self.view addSubview:self.tableview];
    [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_topLayoutGuideBottom).offset(0);
        make.left.right.equalTo(self.view).offset(0);
        make.bottom.equalTo(self.mas_bottomLayoutGuideBottom).offset(0);
    }];
    //底线上面 mas_bottomLayoutGuideTop
}

#pragma mark ----------初始化数据
-(void)loaddata{
    [self.dataArray addObject:[MainCustomModel setupExampleTitle:@"SBPickerCalendar" ExampleDesc:@"弹框式上下滚动日历示例（可设置最小展示月份、最大展示月份；基于UITableview、UICollectionView,可定制样式）；"]];
    
    [self.dataArray addObject:[MainCustomModel setupExampleTitle:@"SBAddressBook" ExampleDesc:@"带索引的通讯录列表示例，附带添加联系人到通讯录；"]];
    
    [self.dataArray addObject:[MainCustomModel setupExampleTitle:@"SBSignatureDraw" ExampleDesc:@"签名画板，签名完成后调用控制器内方法 fullSignatureImage生成签名图片;"]];
    
    [self.dataArray addObject:[MainCustomModel setupExampleTitle:@"SBNumberScroller" ExampleDesc:@"数字滚动展示控件；"]];
    
    [self.dataArray addObject:[MainCustomModel setupExampleTitle:@"SBAssetExportSession" ExampleDesc:@"视频压缩1.采用 AVAssetReader和AVAssetWriter 2.采用 AVAssetExportSession；"]];

    [self.dataArray addObject:[MainCustomModel setupExampleTitle:@"SBPhotoReveal" ExampleDesc:@"大图查看器，支持放大、双击、捏合手势、保存到相册，依赖SDWebImage图片下载，支持UIImage与NSString格式数据；"]];
    
    [self.dataArray addObject:[MainCustomModel setupExampleTitle:@"SBSpeechAudio" ExampleDesc:@"实施语音转文字、文字播报朗读（系统声音）；"]];
    
    
    [self.tableview reloadData];
}

#pragma mark ----------页面跳转
-(void)pushExampleController:(MainCustomModel *)model{
    if ([model.exampleTitle isEqualToString:@"SBPickerCalendar"]) {
        ERCalendarPickerViewController *vc = [[ERCalendarPickerViewController alloc] init];
        vc.modalPresentationStyle = UIModalPresentationCustom;
        vc.dateBlock = ^(NSDate * _Nonnull date) {
            NSLog(@"%@",[SBTools sb_date_date_to_string:date fromatter:@"yyyy-MM-dd"]);
        };
        [self presentViewController:vc animated:YES completion:nil];
    }else if ([model.exampleTitle isEqualToString:@"SBAddressBook"]){
        SBAddressBookViewController *vc = [[SBAddressBookViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([model.exampleTitle isEqualToString:@"SBSignatureDraw"]){
        UBSignatureDrawingViewController *vc = [[UBSignatureDrawingViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([model.exampleTitle isEqualToString:@"SBNumberScroller"]){
        SBNumberScrollerViewController *vc = [[SBNumberScrollerViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([model.exampleTitle isEqualToString:@"SBAssetExportSession"]){
        SBAssetExportViewController *vc = [[SBAssetExportViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([model.exampleTitle isEqualToString:@"SBPhotoReveal"]){
        SBPhotoRevealViewController *vc = [[SBPhotoRevealViewController alloc] init];
        vc.imgArr = [NSMutableArray arrayWithArray:@[@"https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/ef73be60b27d4f8895cc5e3136b2825c~tplv-k3u1fbpfcp-zoom-in-crop-mark:3024:0:0:0.awebp",@"https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/23e7429b15574087918f91a4fa8485ad~tplv-k3u1fbpfcp-zoom-in-crop-mark:3024:0:0:0.awebp"]];
        [self presentViewController:vc animated:YES completion:nil];
    }else if ([model.exampleTitle isEqualToString:@"SBSpeechAudio"]){
        SBAISpeechViewController *vc = [[SBAISpeechViewController alloc] initWithNibName:NSStringFromClass([SBAISpeechViewController class]) bundle:[NSBundle mainBundle]];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark ----------TableviewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MainCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MainCustomCell class]) forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = self.dataArray[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self pushExampleController:self.dataArray[indexPath.row]];
}

#pragma mark ----------懒加载页面控件
-(UITableView *)tableview{
    if (!_tableview) {
        _tableview = SB_INIT_TABLEVIEW(UITableViewStylePlain, self);
        [_tableview registerNib:[UINib nibWithNibName:NSStringFromClass([MainCustomCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([MainCustomCell class])];
    }
    return _tableview;
}

-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray =[[NSMutableArray alloc]init];
    }
    return _dataArray;
}
@end
