//
//  SBAddressBookViewController.m
//  Tools
//
//  Created by 刘永吉 on 2021/1/26.
//  Copyright © 2021 lyj. All rights reserved.
//

#import "SBAddressBookViewController.h"
#import "RITLContactsManager.h"

#import "SBToolsHeader.h"
#import <Masonry.h>
#import "UIAlertController+RITLContactFile.h"

@interface SBAddressBookViewController ()<UITableViewDelegate,UITableViewDataSource>
//存放联系人的数组，存放直接请求出的联系人数组
@property (nonatomic, copy)NSArray <RITLContactObject *> *  contactObjects;

//存放索引的数组，(e.g. A-Z,# in US/English)
@property (nonatomic, copy)NSArray <NSString *> * titles;

//存放处理过的数组
@property (nonatomic, copy)NSArray <NSArray *> * handleContactObjects;

//负责请求联系人对象
@property (nonatomic, strong) RITLContactsManager * contactManager;

@property (nonatomic,strong) UITableView *tableview;

@end

@implementation SBAddressBookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //索引
    self.titles = @[];
    
    //初始化属性
    self.contactManager = [[RITLContactsManager alloc]init];
    
    //初始化UI
    [self setupui];

    //开始请求
    [self requestContacts];
}

-(void)setupui{
    self.view.backgroundColor = SBCOLORHEX(0xf8f8f8, 1);
    
    [self.view addSubview:self.tableview];
    [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.mas_topLayoutGuideBottom).offset(0);
        make.bottom.equalTo(self.mas_bottomLayoutGuideBottom).offset(0);
    }];
}

//开始请求所有的联系人
- (void)requestContacts{
    __weak typeof(self) copy_self = self;
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 90000
    //设置便利属性，为了提升速度，只要姓名以及电话属性
    self.contactManager.descriptors = [NSString RITLContactNamePhoneKeys];
#endif

    //通讯发生变化进行的回调
    self.contactManager.contactDidChange = ^(NSArray <RITLContactObject *>* contacts){
        [copy_self __reloadTableView:contacts];
    };
    
    //开始请求
    [self.contactManager requestContactsComplete:^(NSArray<RITLContactObject *> * _Nonnull contacts) {
        [copy_self __reloadTableView:contacts];
        
    } defendBlock:^{
        //maybe you can present an AlerViewController to prompt user some message
    }];
}

- (void)__reloadTableView:(NSArray <RITLContactObject *> *)contactObjects{
    //开始赋值
    self.contactObjects = contactObjects;
    self.titles = [UILocalizedIndexedCollation currentCollation].sectionTitles;

    [self.tableview reloadData];
}

#pragma mark - localizedCollation Setter
-(NSArray<NSArray *> *)handleContactObjects{
    return [RITLContactSortManager defaultHandleContactObject:self.contactObjects];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //返回首字母可能的个数
    return self.titles.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //根据组数，获取每组联系人的数量
    return self.handleContactObjects[section].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    //fetch Model
    RITLContactObject * contactObject = [self.handleContactObjects[indexPath.section] objectAtIndex:indexPath.row];
    
    //configture cell..
    cell.textLabel.text = contactObject.nameObject.name;
    cell.detailTextLabel.text = contactObject.phoneObject.firstObject.phoneNumber;
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //select cell coding...
    
    //get model
    RITLContactObject * contactObject = self.handleContactObjects[indexPath.section][indexPath.row];
    
    //进行判断
    [self presentViewController:[UIAlertController alertControllerWithContactObject:contactObject] animated:true completion:^{
    }];
    
    [tableView deselectRowAtIndexPath:indexPath animated:true];

}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [[[UILocalizedIndexedCollation currentCollation] sectionTitles] objectAtIndex:section];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return [[UILocalizedIndexedCollation currentCollation] sectionIndexTitles];
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    return [[UILocalizedIndexedCollation currentCollation] sectionForSectionIndexTitleAtIndex:index];
}

#pragma mark - <UITableViewDelegate>
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    //如果没有数据
    if (self.handleContactObjects[section].count == 0){
        return 0;
    }
    return 20;
}

-(UITableView *)tableview{
    if (!_tableview) {
        _tableview = SB_INIT_TABLEVIEW(UITableViewStylePlain, self);
        [_tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    
    return _tableview;
}


#pragma mark ---------添加联系人
-(void)addContact{
    [self.contactManager addContact:[RITLContactObject testContactObject]];
}
@end
