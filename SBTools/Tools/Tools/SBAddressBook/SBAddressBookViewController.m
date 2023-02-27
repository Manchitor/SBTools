//
//  SBAddressBookViewController.m
//  Tools
//
//  Created by 刘永吉 on 2021/1/26.
//  Copyright © 2021 lyj. All rights reserved.
//

#import "SBAddressBookViewController.h"
#import "RITLContactsManager.h"


@interface SBAddressBookViewController ()
//存放联系人的数组，存放直接请求出的联系人数组
@property (nonatomic, copy)NSArray <RITLContactObject *> *  contactObjects;

//存放索引的数组，(e.g. A-Z,# in US/English)
@property (nonatomic, copy)NSArray <NSString *> * titles;

//存放处理过的数组
@property (nonatomic, copy)NSArray <NSArray *> * handleContactObjects;

//负责请求联系人对象
@property (nonatomic, strong) RITLContactsManager * contactManager;

@end

@implementation SBAddressBookViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //初始化属性
    self.contactManager = [[RITLContactsManager alloc]init];
    self.titles = @[];
    
    //开始请求
    [self requestContacts];
}

//开始请求所有的联系人
- (void)requestContacts
{
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

- (void)__reloadTableView:(NSArray <RITLContactObject *> *)contactObjects
{
    //开始赋值
    self.contactObjects = contactObjects;
    self.titles = [UILocalizedIndexedCollation currentCollation].sectionTitles;

    
}



#pragma mark - localizedCollation Setter
-(NSArray<NSArray *> *)handleContactObjects
{
    return [RITLContactSortManager defaultHandleContactObject:self.contactObjects];
}

@end
