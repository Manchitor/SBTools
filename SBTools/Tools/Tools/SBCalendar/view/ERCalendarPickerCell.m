//
//  ERCalendarPickerCell.m
//  ElectricRoom
//
//  Created by 刘永吉 on 2022/6/27.
//

#import "ERCalendarPickerCell.h"
#import "ERCalendarPickerItemCell.h"

#import "SBToolsHeader.h"

@interface ERCalendarPickerCell ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (weak, nonatomic) IBOutlet UIView *content;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentHeight;

@end
@implementation ERCalendarPickerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupui];
}

-(void)setupui{
    
    [self.content addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.content).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}

-(void)setDataArray:(NSMutableArray *)dataArray{
    _dataArray = dataArray;
    
    NSInteger row =  (_dataArray.count + 7 - 1)/7;
    
    self.contentHeight.constant =  row *SB_SCREEN_WIDTH / 7.f;
    [self.collectionView reloadData];
    
}

#pragma mark -- UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ERCalendarPickerItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ERCalendarPickerItemCell class]) forIndexPath:indexPath];
    cell.model = self.dataArray[indexPath.item];
    return cell;
}

#pragma mark -- UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    ERCalendarPickerDayModel *model = self.dataArray[indexPath.row];
    if (sb_isEmptyObject(model.date)) {
        return;
    }
    
    if ([self compareDate:model.date date:[NSDate date]] ) {
        NSLog(@"预约时间不能小于当前时间");
        return;
    }


    for (int index = 0; index < self.dataArray.count; index++) {
        ERCalendarPickerDayModel *item = self.dataArray[index];
        item.isSelect = (index == indexPath.row);
    }
    [self.collectionView reloadData];
    
    if (self.dateBlock) {
        self.dateBlock(model.date);
    }
}

#pragma mark -- UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = SB_SCREEN_WIDTH / 7.f;
    return CGSizeMake(width, width);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.f;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(BOOL) compareDate:(NSDate *)date date:(NSDate *)other{
    if (!date || !other) {
        return NO;
    }
    
    //先转化为年月日比较 不比较时分秒
    NSDateFormatter *dateFromatter = [[NSDateFormatter alloc] init];
    [dateFromatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *dateString = [dateFromatter stringFromDate:date];
    NSString *otherString = [dateFromatter stringFromDate:other];
    
    
    NSDate *dateCompare = [dateFromatter dateFromString:dateString];
    NSDate *otherCompare = [dateFromatter dateFromString:otherString];

    
    NSComparisonResult result = [dateCompare compare:otherCompare];
    return result == NSOrderedAscending;
}

#pragma mark ---------懒加载
- (UICollectionView *) collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.sectionHeadersPinToVisibleBounds = YES;
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.bounces = NO;
        
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([ERCalendarPickerItemCell class]) bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:NSStringFromClass([ERCalendarPickerItemCell class])];
       
    }
    return _collectionView;
}

-(void)dealloc{
    self.dateBlock = nil;
}
@end
