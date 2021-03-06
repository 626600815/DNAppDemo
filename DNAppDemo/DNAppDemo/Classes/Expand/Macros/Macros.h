
/**
 *  项目中的样式以及配置
 */

//工具
#define DNWeakSelf __weak typeof(self) weakSelf = self;//弱引用
#define APPDelegate ((AppDelegate *)[[UIApplication sharedApplication] delegate])//获取AppDelegate


//默认加载图片
#define PLACEHOLDER [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"placeholder" ofType:@"jpg"]]
#define LOGOIMAGE   [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"logoimage" ofType:@"jpg"]]

//导航栏样式
#define Nav_BarTintColor    [UIColor colorWithRed:250.0/255.0 green:250.0/255.0 blue:250.0/255.0 alpha:1]
#define Nav_TintColor       [UIColor colorWithRed:30.0/255.0 green:30.0/255.0 blue:30.0/255.0 alpha:1]
#define Nav_TitleColor      [UIColor colorWithRed:30.0/255.0 green:30.0/255.0 blue:30.0/255.0 alpha:1]
#define Nav_TitleFont       [UIFont systemFontOfSize:19]

//Controller
#define Ctr_backgroundColor [UIColor colorWithRed:246.0/255.0 green:245.0/255.0 blue:246.0/255.0 alpha:1]