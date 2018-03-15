# ArrayGroup
iOS Array 分组
之前介绍过数组的排序，现在介绍数组的分组。什么意思呢？由于后台给我们的数据是一个数组，里面有很多分类，我们把每个不同的分类放到一个数组以便于我们使用，用一个简单的例子介绍：

[2,2,4,3,5,6,3,6,5,4]

[2,2,3,3,4,4,5,5,6,6]

[[2,2],[3,3],[4,4],[5,5],[6,6]]

介绍大致思路，第一步把一个混乱的数组排序。第二步把排序好的数组按照分类拆分多个。

下面举一个我工作中的例子。之前介绍过数据的排序下面直接进入怎么分组的。一般有两个方法，第一种方法利用set 的不重复性来做。第二种方法利用集合的KVC 运算符来做。

## 第一种方法利用set 的不重复性来做：
```
//对返回的数据进行区分筛选

- (NSMutableArray *)groupAction1:(NSMutableArray *)arr {

    NSMutableSet *set = [NSMutableSet set];

    [arr enumerateObjectsUsingBlock:^(WCServiceListModelBodyV2 * _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {

        [set addObject:model.serviceType];

    }];

    NSArray *sortDesc = @[[[NSSortDescriptor alloc] initWithKey:@“self" ascending:YES]];

    NSArray *sortSetArray = [set sortedArrayUsingDescriptors:sortDesc];

    __block NSMutableArray *groupArr = [NSMutableArray array];

    [sortSetArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {

        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"serviceType = %@", obj];

        NSArray *tempArr = [NSArray arrayWithArray:[arr filteredArrayUsingPredicate:predicate]];

        [groupArr addObject:tempArr];

    }];

    return groupArr;

}
```
 大致描述：

1：数组里面存储着多个model对象，现在我们根据model中的serviceType字段进行分组。利用set不重复的特性,得到有多少组,根据model中的serviceType字段。

2：set本身是无序的直接排序变成有序的利用sortedArrayUsingDescriptors方法。

3：利用数组的filteredArrayUsingPredicate方法和NSPredicate语法进行过滤筛选出新的数组们。

注意：NSPredicate语法类似写SQL语句类似，比如过滤文章开头大于3返回数组。

NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF > 3”];然后调用数组filteredArrayUsingPredicate方法即可。

## 第二种方法利用集合的KVC 运算符来做，由于上面第一种方法要循环遍历下为了避免用循环方法。
```
//对返回的数据进行区分筛选

- (NSMutableArray *)groupAction2:(NSMutableArray *)arr {

    NSArray *serviceTypes = [arr valueForKeyPath:@"@distinctUnionOfObjects.serviceType"];

    NSArray *sortDesc = @[[[NSSortDescriptor alloc] initWithKey:@"self" ascending:YES]];

    NSArray *sortSetArray = [serviceTypes sortedArrayUsingDescriptors:sortDesc];

    __block NSMutableArray *groupArr = [NSMutableArray array];

    [sortSetArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {

        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"serviceType = %@", obj];

        NSArray *tempArr = [NSArray arrayWithArray:[arr filteredArrayUsingPredicate:predicate]];

        [groupArr addObject:tempArr];

    }];

    return groupArr;

}
```
 大致描述：

1： @distinctUnionOfObjects: 返回一个由操作符右边的key path所指定的对象属性组成的数组。其中@distinctUnionOfObjects 会对数组去重。

2：对分类进行排序

3：和第一种方法一样，利用数组的filteredArrayUsingPredicate方法和NSPredicate语法进行过滤筛选出新的数组们。

## 总结：利用集合的KVC方法可以简化处理一些复杂的操作，比如计算开头数组的元素sum总和你可能会用循环，求最大，平均值都可以使用这个集合运算符。
