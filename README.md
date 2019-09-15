### iOS 字符搜索 总结

1. 精确的字符搜索

	```
	// rangeofString 方法
	NSString *str1 = @"can you stest speak English";
	NSString *str = @"stest";
	//在str1这个字符串中搜索stest，推断有没有
	if ([str1 rangeOfString:str].location != NSNotFound) 	{
   		NSLog(@"这个字符串中有stest");
	}

   // 8.0 之后，新出了一个方法:containsString
   	NSString *str1 = @"can you stest speak English";
	NSString *str = @"stest";
	//在str1这个字符串中搜索stest，推断有没有
	if ([str1 rangeOfString:str].location != NSNotFound) 	{
    	NSLog(@"这个字符串中有stest");
	}
	
	
	
	
	```
	
2. 谓词搜索 更快更省更多
	
	```
	@interface Info : NSObject

	@property (nonatomic, strong) NSString * loactionName;

	@property (nonatomic, strong) NSString * loaction;

	@property (nonatomic, assign) int ID;

	@end
	
	```
	
	> 基础用法，可以<=,<,=  可以用  ||  && 符号 OR AND
	
	```
	// 先列出要判断的字段的条件
	NSPredicate *predicate = [NSPredicate predicateWithFormat:@"loactionName < 'ghi' || ID < 3"];
    for(Info *info in array_Info){
        if([predicate evaluateWithObject:info]){ //判断指定的对象是否满足
            //........................
        }
    }
    result_Info = [array_Info filteredArrayUsingPredicate:predicate];
    //获取所有满足条件的对象
	
	
	```
		
	> IN - 包含区间内内容， 精确匹配，区分大小写
	
	```
	NSPredicate *predicate = [NSPredicate predicateWithFormat:@"loactionName IN {'abc' , 'ABc' , 'def' , '123'} || loaction IN {'123' , 'ABc' , 'def' , '123'}"];

	```
	> between - 包含区间内内容范围， 精确匹配，区分大小写
	
	```
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"loactionName BETWEEN {'A' , 'Y'}"];
    // 包含A到Y之间

	```
	> BEGINSWITH/ENDSWITH - 查询以xxx 开头/结尾 
	
	```
	NSPredicate *predicate = [NSPredicate 	predicateWithFormat:@"loactionName BEGINSWITH 'N'"];//	name以N打头的person  

	//    loactionName ENDSWITH 'N'" //以xxxx结尾
    

	```
	> CONTAINS - 包含指定内容，区分大小写
	
	```
	NSPredicate *predicate = [NSPredicate predicateWithFormat:@"loactionName CONTAINS 'EF'"]; //name种包含 ‘EF’的person

	```
	> like - 模糊查询, 区分大小写
	
	```
NSPredicate *predicate = [NSPredicate predicateWithFormat:@"loactionName LIKE '*A?*'"]; // *表示零个或多个字符，?代表一个字符，和数据库的like相似
	```
	> [c］表示忽略大小写，［d］表示忽略重音，可以在一起使用[cd]（ps.范围查询的命令语法是不支持这个的）
	
	```
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"loactionName LIKE[cd] '*a*'"]; // *表示零个或多个字符
	```
	> NOT - 取反
	
	```
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@" NOT ( loactionName LIKE '*A*')"]; // *表示零个或多个字符

	```
	> self,  当查询对象的数组内容是字符串，不是对象，用SELF命令查询
	
	```
	NSArray *array=[NSArray arrayWithObjects: @"abc", @"def", 	@"ghi",@"jkl", nil];
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF=='abc'"];
    [array filteredArrayUsingPredicate:pre];
	```
	> 使用正则表达式
 NSPredicate 使用MATCHES 匹配正则表达式，正则表达式的写法采用international components
 for Unicode (ICU)的正则语法。
	
	```
	NSString *regex = @"^A.+e$";//以A 开头，以e 结尾的字符。
    NSPredicate *pre= [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if([pre evaluateWithObject: @"Apple"]){
        printf("YES\n");
    }else{
        printf("NO\n");
	```
		
	
	
3. 第三方库
	- SearchCoreTest  
	  一个联系人搜索库，支持的搜索方式包括：用户名汉字、拼音及模糊搜	  索，号码搜索，最重要的是支持T9搜索,很赞。
   - UTPinYinHelper  
     通过拼音去匹配汉字，简单来说，就是拼音搜索




	

