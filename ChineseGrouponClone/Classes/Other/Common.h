
// dock item size
#define kDockItemW 100
#define kDockItemH 80

// size of top menu item
#define kTopMenuItemW 140
#define kTopMenuItemH 44

// size of bottom menu item
#define kBottomMenuItemW 130
#define kBottomMenuItemH 70

#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

#ifdef DEBUG
#define MyLog(...) NSLog(__VA_ARGS__)
#else
#define MyLog(...)
#endif

#define kCityChangeNote @"city_change"
#define kDistrictChangeNote @"district_change"
#define kCategoryChangeNote @"category_change"
#define kOrderChangeNote @"order_change"
#define kCollectChangeNote @"collect_change"
#define kCityKey @"city"

#define kGlobalBg [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_deal.png"]]

#define kDefaultAnimDuration 0.3

// constant string
#define kAllCategory @"All Categories"
#define kAllDistrict @"All Districts"
#define kAll @"All"

// 1. macro that check if the device is iPhone5
#define iPhone5 ([UIScreen mainScreen].bounds.size.height == 568)

#define kAddAllNotes(method) \
[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(method) name:kCityChangeNote object:nil]; \
[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(method) name:kCategoryChangeNote object:nil]; \
[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(method) name:kDistrictChangeNote object:nil]; \
[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(method) name:kOrderChangeNote object:nil];