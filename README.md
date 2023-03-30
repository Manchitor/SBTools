# SBTools
iOS的工具库

SBTools文件目录

    SBTools+App ：相关App是否有安装检测包括（QQ、微信、微博、支付宝、高德地图、百度地图、腾讯地图）；
    
    SBTools+MD5 ：对字符串的md5操作（结果区分大小写、16位还是32位）；
    
    SBTools+Base64 ：对string或data进行base64加密、解密 (采用苹果默认规范：RFC 4648)；
    
    SBTools+Device ：获取设备型号、是否有摄像头、物理内存、cpu个数、运行内存、带宽、mac地址、显示屏 等信息；
    
    SBTools+HTML ： 去掉html格式字符串的标签（'<div>html内容</div>' 处理结果后返回：'html内容' ）；
    
    SBTools+Albums ：获取相册使用权限、创建相册、查找相册内容、匹配视频图片资源信息 ；
    
    SBTools+NSString ：判断字符串是否为空、将汉字转为拼音、去除字符串中的换行和首位空格、手机号格式化处理344（例：187 2121 8206）、字符串包含汉字个数、字符串宽高、手机号脱敏、邮箱脱敏、缓存单位转换kb\Mb\Gb；
    
    SBTools+Date ：将时间格式化字符串、将字符串格式化时间、判断两个时间是否相等（精确到秒级）、判断两个时间是否为同一（分钟、时、天、月、年）、获取当前时间戳：秒，毫秒的话要*1000、将时间字符串转化成时间戳 精确到毫秒、将时间字符串转为几分钟前、几天前、、、、；
    
    SBTools+Map ：百度与高的坐标系转换、打开手机地图目的地导航页面 ；


SBToolsKit文件目录

    UILabel目录下：
    
        SBEdgeLabel ： 自定义内边距的UILabel；
        
        UILabel+TimerColor ：UILabel的小动画（1.逐字变色动画、2.闪动动画，类似iphone滑动解锁 滑块，可适用UIView组件）;
        
    UITableView目录下：
        
        UITableView+SBDataEmpty ：UITableView的空数据展示样式，可定制空数据图片及文字；
        
    UIImage目录下：
        
        SBTools+UIImage ：修改图片正方向、获取图片主题色(主色调)；
        
        UIImage+SBExt ：根据颜色来设置image、添加高斯效果、截图生成图片；
        
    UIButton目录下：
    
        SBCustomerButton ：自定义按钮图片和文字对齐及上下左右关系；
        
    UIView目录下：
        
        UIView+CornerRadius：view 添加不规则圆角；
        
    UITextView目录下：
        
        SBCustomerTextView ：自定义TextView，增加placeholder 及maxLength属性；
        
    UITextField目录下：
        
        UITextField+MaxLength ：拓展输入框最大输入长度；
        
        UITextField+PlaceholderColor ：拓展输入框PlaceholderColor（项目没有做暗黑模式的适配所以全局设置xib中PlaceholderColor 颜色）；
        
        UITextField+Clear : 拓展输入框的编辑状态右边有clear按钮；
        
        
    UIKitInit目录下：
    
        UIKitInit : 便捷创建组件的代码 SB_INIT_组件名；
        
        
 SBFoundation文件目录：
    
    NSDictionary目录下：
    
        NSDictionary+SBCategory ：增加字典与json字符串的相互转化；
        
    NSFileManager目录下：
        
        NSFileManager+SBCategory ：对于文件的一些操作（判断是否存在、保存、删除、获取文件大小等）；
    
    NSString目录下：
        
        NSString+SBCategory ：对链接字符串进行url处理；
        
        
 SBToolsMacro文件目录：
 
        SBTools_Macro_Font：字体的一些宏定义；
        
        SBTools_Macro_Path：系统目录的一些宏定义（沙盒、缓存等）；
        
        SBTools_Macro_Block：block 的宏定义；
        
        SBTools_Macro_Color：颜色的一些宏定义；
        
        SBTools_Macro_System：系统常量的一些宏定义（屏幕宽高、版本号、导航栏高度、状态栏高度、系统版本等）；
        
 
SBToolLibrary文件目录：

    SBSignature目录下：
        
        UBSignatureDrawingViewController：签名控制器（用于签名、生成图片）；
        
    SBAddressBook目录：
    
        RITLContactsManager：带索引的通讯录相关操作展示示例；
        
    SBNumberScroller目录：
        
        SBNumberScroller：数字滚动展示控件；
        
    SBCrashException文件目录：

        UncaughtExceptionHandler：常见的iOS 异常捕获，防止线上崩溃（didFinishLaunchingWithOptions中初始化：    
    
        [UncaughtExceptionHandler installUncaughtExceptionHandler:YES showAlert:YES];）；
    
    SBAssetExportSession文件目录：
    
        SBAssetExportViewController：视频压缩
    
        1.采用 AVAssetReader和AVAssetWriter 实现逐帧压缩(优点是压缩的定制化比较好, 可以设置导出视频的编码格式,比特率, 帧率, 尺寸及视频质量, 压缩之后的画质令人满意, 缺点是视频时长较长时, 压缩时间较长)；
    
        2.采用 AVAssetExportSession(优点是压缩快, 能有效的减少视频的文件大小, 但是定制化不友好, 压缩之后的视频画质确实令人不太满意)；
    
    SBCalendar文件目录：

        ERCalendarPickerViewController：弹框式上下滚动日历示例（可设置最小展示月份、最大展示月份；基于UITableview\UICollectionView,可定制样式）；
    
    SBAddressBook文件目录：

        SBAddressBookViewController：带索引的通讯录列表示例，附带添加联系人到通讯录；
    



    
       
        
       
        
        
        
        
        
