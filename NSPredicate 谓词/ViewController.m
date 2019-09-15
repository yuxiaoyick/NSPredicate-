//
//  ViewController.m
//  NSPredicate 谓词
//
//  Created by Admin on 2019/9/15.
//  Copyright © 2019 me. All rights reserved.
//

//基本：
//1.创建NSPredicate（相当于创建一个过滤条件）
//NSPredicate *predicate = [NSPredicate predicateWithFormat:@"过滤条件"];
//2.判断指定的对象是否满足NSPredicate创建的过滤条件
//[predicate evaluateWithObject:person];
//3.过滤出符合条件的对象（返回所有符合条件的对象）
//NSArray *persons = [array filteredArrayUsingPredicate:predicate];

#import "ViewController.h"

@interface ViewController ()
{
    NSArray * array_Info;
    NSArray * result_Info;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self buildInfoArray];

    [self demo];
    
    [self result:[self between]];
    
    // Do any additional setup after loading the view.
}


/**
 运算demo
 */
- (NSPredicate * )demo{
    //谓词不区分大小写
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"loactionName < 'ghi' || ID < 3"];
    
    return predicate;
}

//包含指定内容，区分大小写
- (NSPredicate * )IN {
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"loactionName IN {'ABC' , 'def' , '123'}"];
    return predicate;
}

//包含指定范围内容，区分大小写
- (NSPredicate * )between {
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"loactionName BETWEEN {'A' , 'Y'}"];
    return predicate;
}


//包含指定内容，区分大小写
/**
 大小写比较
 ［c］表示忽略大小写，［d］表示忽略重音，可以在一起使用
 */
- (NSPredicate * )cd {
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"loactionName LIKE[cd] '*a*'"]; // *表示零个或多个字符
    return predicate;
}

/**
 查询以xxx开头 或结尾
 */
- (NSPredicate * )beginswithOrEndSwith {
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"loactionName BEGINSWITH 'N'"];//name以N打头的person
    
    
//    loactionName ENDSWITH 'N'" //以xxxx结尾
    
    
    return predicate;
}


/**
 包含指定内容，区分大小写
 */
- (NSPredicate * )contains {
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"loactionName CONTAINS 'EF'"]; //name种包含'N的person</span>

    return predicate;
}

/**
 模糊查询－－like, 区分大小写
 */
- (NSPredicate * )LIKE {
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"loactionName LIKE '*A?*'"]; // *表示零个或多个字符，?代表一个字符，和数据库的like相似
  
    return predicate;
}

/**
 NOT - 取反
 */
- (NSPredicate * )NOT {
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@" NOT ( loactionName LIKE '*A*')"]; // *表示零个或多个字符
    
    return predicate;
}


//根据谓词条件，获取结果
- (void)result:(NSPredicate *)predicate{
    
    for(Info *info in array_Info){
        if([predicate evaluateWithObject:info]){ //判断指定的对象是否满足
            //........................
            NSLog(@"result :%d",info.ID);
        }
    }
    result_Info = [array_Info filteredArrayUsingPredicate:predicate];//获取所有满足条件的对象
}


/**
 当查询对象的数组内容是字符串，不是对象，用SELF命令查询
 */
- (void)SELF{
    NSArray *array=[NSArray arrayWithObjects: @"abc", @"def", @"ghi",@"jkl", nil];
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF=='abc'"];
    [array filteredArrayUsingPredicate:pre];
}


/**
 使用正则表达式
 NSPredicate 使用MATCHES 匹配正则表达式，正则表达式的写法采用international components
 for Unicode (ICU)的正则语法。
 */
- (void)RegularExpression{
    
    NSString *regex = @"^A.+e$";//以A 开头，以e 结尾的字符。
    NSPredicate *pre= [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if([pre evaluateWithObject: @"Apple"]){
        printf("YES\n");
    }else{
        printf("NO\n");
    }
 
}


- (void)buildInfoArray{
    Info *info1 = [Info new];
    info1.loaction = @"123";
    info1.loactionName = @"ABC";
    info1.ID = 1;
    Info *info2 = [Info new];
    info2.loaction = @"456";
    info2.loactionName = @"DEF";
    info2.ID = 2;
    Info *info3 = [Info new];
    info3.loaction = @"789";
    info3.loactionName = @"GHI";
    info3.ID = 3;

    array_Info = [NSArray arrayWithObjects:info1,info2,info3, nil];
}



@end



@implementation Info

@end
