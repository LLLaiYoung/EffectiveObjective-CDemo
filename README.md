# 本仓库存放《Effective Objective-C 2.0 编写高质量iOS与OS X代码的52个方法》这本书里面所有提到的例子。
#别忘了star支持哟，谢谢！😘

##写在最前面：
这是我读这本书的第一遍，目前暂定为1.0版本吧。很多地方都还没有很好的理解透彻，只是理解到了一点皮毛，并没有理会到其中的真谛，我相信在我不断的实践中，会一点一点的理解透测，同时我也将会在此更新出来。

##第一章 熟悉Objective-C
####第1条：了解Objective-C语言的起源
1、Objective-C 语法使用了`消息结构`而非`函数调用`</br>
2、关键区别在于：使用消息结构的语言，其运行时所应执行的代码由运行环境来决定，而使用函数调用的语言，则由编译器决定。</br>
3、Objective-C 为C语言添加了面向对象特效，是其超集。Objective-C使用动态绑定的消息结构，也就是说，在运行时才会检查对象类型。收到一条消息之后，究竟应执行任何代码，由运行期环境而非编译器来决定

####第2条：在类的头文件中尽量少引入其他头文件
`向前声明(@class XXX.h) 就是使用@class`</br>
1、除非确有必要，否则不要引入头文件。一般来说，应在某个类的头文件中使用向前声明来提及别的类，并在实现头文件中引入那些类的头文件。这样做可以尽量降低类之间的耦合。</br>
2、有时无法使用向前声明，比如要声明某个类遵循一项协议。这种情况下，尽量把“该类遵循某协议”的这条声明移至“class-continuation 分类”中。如果不行，就把协议单独在一个头文件中，然后将其引入。

####第3条：多用字面量与法，少用与之等价的方法
1、使用字面量语法更安全
例如：
 > id object1 = /**….**/; //有效对象
> id object2 = /**….**/; //nil
> id object3 = /**….**/; //有效对象

> NSArray *arrayA = [NSArray arrayWithObjects:object1,object2,object3,nil];
NSArray *arrayB = @[object1,object2,object3];

按字面量语法创建的数组arrayB会抛出异常。而arrayA虽然能创建出来数组，但是只含有｀object1｀一个对象，因为｀arrayWithObjects｀方法会依次处理各个参数，直到发现nil为止，由于object2是nil，所以会提前结束。
所以说，使用字面量语法会更安全。抛出异常令程序终止执行，这比创建好数组之后发现元素个数少了要好。向数组中插入nil通常说明程序错误，而通过异常就可以很快地发现这个错误。</br>

2、局限性：字面量语法有个小小的限制，就是出了字符串以外，所创建出来的对象必须属于Fundation框架才行。</br>
3、应该使用字面量语法来创建字符串、数值、数组、字典。与创建此类对象的常规方法相比，这么做更加简明扼要。</br>
4、应该通过取下表操作来访问数组下标或字典中的键所对应的元素。</br>
5、用字面量语法创建数组或字典时，若值中有nil，则会抛出异常。因此，无比确保值里不含nil</br>

####第4条：多用类型常量，少用#define 预处理指令
1、这样定义出来的常量没有类型信息，会让人不明白这个常量到底是干什么的。比方说使用 `static const NSTimeInterval kAnimationDuration ＝ 0.3; `   用此方法定义的常量包含类型信息。</br>
2、常量名称命名方式。常用的命名法是：`若常量局限于某”编译单元”(也就是“实现文件”)之内，则在前面加字面k；若常量在类之外可见，则通常以类名为前缀。`  具体的命名请见第19条</br>
3、定义常量的位置很重要，不应该放在头文件里面(.h) #define，static const 都不应该在头文件，原因可能有存在常量名称互相冲突。而且Objective-C没有 “名称空间” (namespace) 这一概念，所以那样做 (声明在头文件) 等于声明了一个全局变量</br>
4、不打算公开的常量，应该将其定义在使用该常量的实现文件里。变量一定要同时用static 与 const 来声明，如果试图修改有 const 修饰符所声明的变量，那么编译器就会报错。`补充一点，使用#define定义的常量是可以修改的，说不定在某个时候，你定义的常量就被修改了。所以尽量不要使用#define`</br>
5、使用static修饰符意味着该变量仅定义在此变量的编译单元中可见。编译器每收到一个编译单元，就会输出一份 “目标文件” 。在Objective-C的语言环境下，“编译单元” 一词通常指每个类的实现文件 (以 .m 为后缀名)。`假如声明此变量时不加static，则编译器会为它创建一个 “外部符号”。此时若是另外一个编译单元中也声明了同名变量，那么编译器就会抛出一条错误消息。  重点!!!!!`</br>
6、对外公开一个常量，常见于调用 NSNotificationCenter 发通知，在 .m 文件中定义好通知名，需要将其对外公开，以供让其它对象发起通知。此类常量需要放在 “全局符号表” 中，以便可以在定义该常量的编译单元之外使用。所以其定义方式与上面讲的static const 有所不同，定义如下

```
/** 在 .m 文件中 */
NSString *const viewControllerWillPushNotification = @"viewControllerWillPushNitification";
/** 在 .h 文件中 */
extern NSString * const viewControllerWillPushNotification;
```

####第5条：用枚举表示状态、选项、状态码
1、应该用枚举来表示状态机的状态、传递给方法的选项以及状态码等值，给这些值起一个易懂的名字。</br>
2、如果把传递给某个方法的选择表示为枚举状态，而多个选项又可同时使用，那么就讲各个选项值定义为2的幂，以便通过按位或操作将其组合起来。用  `NS_OPTIONS`</br>
3、用 NS_ENUM 与 NS_OPTIONS 宏来定义枚举类型，并指明其底层数据类型。这样做可以确保枚举是用开发者所选的底层数据类型实现出来的，而不悔采用编译器所选的类型</br>
4、在处理枚举类型的 `switch 最好不要实现 default 分支。这样的话，如果稍后又加了一种状态，那么编译器就会发出警告，提示新加入的状态并未在 switch 分支中处理。假如写上了 default 分支，那么它就会处理这个新状态，从而导致编译器不发警告信息。`

##第二章对象、消息、运行期
####第6条：理解 “属性” 这一概念
`属性特质（四类）`</br>
1、`原子性`，在默认情况下，有编译器所合成的方法会通过锁定机制确保其原子性 (atomicity)。如果属性具备nonatomic特质，则不适用同步锁。请注意，尽管没有名为 “atomic” 的特质（如果某属性不具备nonatomic特质，那它就是“原子的”，( atomic )）。`注意：在开发iOS程序时一般都会使用nonatomic属性，但是在开发Mac OS X程序时，使用atomic属性通常都不会有性能瓶颈`</br>
2、`读／写权限`

- 具备readwrite（读写）特质的属性拥有“getter”与“setter”。默认就有readwrite
- 具备readonly（只读）特质的属性仅拥有获取方法。重新定义成读写属性，参见第27条

3、`内存管理语义`

- assign “设置方法” 只会执行针对 “纯量类型”（scalar type，例如CGFloat或NSInteger等）的简单赋值操作，重要：当属性所指的对象遭到摧毁之后不会置为nil。
- strong 此特性表明该属性定义了一种 “拥有关系” （owning relationship）。为这种属性设置新值时，设置方法会先保留新值，并释放旧值，然后在将新值设置上去。
- weak 此特性表明该属性定义了一种 “非拥有关系” （nonowning relationship）。为这种属性设置新值时，设置方法既不保留新值，也不会释放旧值。此特性同assign类似，然而在属性所指的对象遭到摧毁时，属性值也会清空（nil out）置为nil。
- unsafe_unretained 此特性的语义和assign相同，但是他适用于 “对象类型”（object type），该特质表达一种 “非拥有关系”（“不保留”，unretained）,当目标对象遭到摧毁时，属性值不会自动清空（“不安全”，unsafe），这一点与weak有区别。
- copy 此特质所表达的所属关系与strong类似。然而设置方法并不保留新值，而是将其“拷贝”（copy）。当属性类型为NSString *时，经常用此特性来保护其封装性，因为传递给设置方法的新值有可能只想一个NSMutableString类的实例。这个类是NSString的子类，表示一种可以修改其值的字符串，此时如是不拷贝字符串，那么设置完属性之后，字符串的值就可能会在对象不知情的情况下遭人更改。所以，这是就要拷贝一份“不可变”（imumutable）的字符串，确保对象中的字符串值不会无意间变动。只要实现属性所用的对象是“可变的”（mutable），就应该在设置新属性时拷贝一份。

4、方法名

- getter，如果属性是Boolean类型(BOOL)，想在获取方法上加 “is” 前缀，可以这样写，`@property(nonatomic,getter=isOn) BOOL on;`
- setter，注意：在重写某些属性的时候，如果属性是用copy语义修饰的，init初始化时候，则应该像下面这样写
 
 ```
 //重写copy语义修饰的属性setter函数
 - (void)setString:(NSString *)string {
  _string = [string copy];
 }
 ```

 ```
 //init初始化
 .h
 @property (nonatomic, copy) NSString *firstName;
 
 @property (nonatomic, copy) NSString *lastName;
 - (instancetype)initWithFirstName:(NSString *)firstName lastNamne:(NSString *)lastName;
 .m
 - (instancetype)initWithFirstName:(NSString *)firstName
                         lastNamne:(NSString *)lastName {
     self = [super init];
     if (self) {
         _firstName = [firstName copy];
         _lastName = [lastName copy];
     }
     return self;
 }
```

####第7条：在对象内部尽量直接访问实例变量
1、`点语法`和`直接访问实例变量`的区别

- 由于直接访问实例变量不经过Objective-C的“方法派发”（method dispatch，参见第11条），所以速度比“点语法”快。因为在这种情况下，编译器所生成的代码会直接访问保存对象实例变量的那块内存。
- 直接访问实例变量时候，不会调用其“设置方法(setter)，获取方法(getter)”，这就绕过了为相关属性所定义的“内存管理语义”。比方说，如果在ARC下直接访问一个声明为copy的属性，那么并不会拷贝该属性，只会保留新值并释放旧值。
- 如果直接访问实例变量，那么不会触发“健值观测”(Key-Value Observing，KVO)通知。
- 通过属性来访问有助于排查与之相关的错误。可以在setter／getter函数打断点调试。

####第8条：理解“对象等同性”这一概念
1、`==`操作符比较的事两个指针本身，而不是其所指对象。</br>
2、NSObject协议中有两个用于判断等同性的关键方法

```
- (BOOL)isEqual:(id)object
- (NSUInteger)hash
```
NSObject类对这两个方法的默认实现是：当且仅当其“指针值”（pointer value）完全相等时，这两个对象才相等。如果“isEqual:”方法判定两个对象相等，那么其hash方法也必须返回同一个值。但是两个对象的hash方法返回同一个值，那么“isEqual:”方法未必会认为两者相等。</br>
3、特性类所具有的等同性判定方法，`NSArray`与`NSDictionary`类也具有特殊的等同性方法，前者名为`isEqualToArray:`，后者名为`isEqualToDictionary`。

####第9条：以"类族模式"隐藏实现细节
[demo](https://github.com/CYBoys/EffectiveObjective-CDemo/tree/master/%E7%AC%AC9%E6%9D%A1%EF%BC%9A%E4%BB%A5%E7%B1%BB%E6%97%8F%E6%A8%A1%E5%BC%8F%E9%9A%90%E8%97%8F%E5%AE%9E%E7%8E%B0%E7%BB%86%E8%8A%82/ClassClusterDemo)
####第10条：在既有类中使用关联对象存放自定义数据
1、关联对象（Associated Object）
对象关联类型（在第6条详解了`属性`这个概念）

关联类型 | 等效的@property属性
--------- | -------------
OBJC_ASSOCIATION_ASSIGN | assign
OBJC_ASSOCIATION_RETAIN_NONATOMIC|nonatomic,retain
OBJC_ASSOCIATION_COPY_NONATOMIC | nonatomic,copy
OBJC_ASSOCIATION_RETAIN | retain
OBJC_ASSOCIATION_COPY | copy

2、管理关联对象

 - `void objc_setAssociatedObject(id object, const void *key, id value, objc_AssociationPolicy policy)`
 </br>此方法以给定的键和策略为某对象设置关联对象值。
 - `id objc_getAssociatedObject(id object, const void *key)`
 </br>此方法根据给定的键从某对象中获取相应的关联对象值。
 - `void objc_removeAssociatedObjects(id object)`
  </br>此方法移除指定对象的全部关联对象。

3、关联对象用法举例。
 背景：在iOS 8.0之前，也就是`UIAlertView`还没被Apple弃用的时候，在同一个控制器中，可能会弹出多个`alertView`，而且各自的处理逻辑都不一样，这时候我们就需要在UIAlertView的delegate函数里面判断是那个alertView被show出来了，然后再对应处理其相关逻辑。[demo](https://github.com/CYBoys/EffectiveObjective-CDemo/tree/master/%E7%AC%AC10%E6%9D%A1%EF%BC%9A%E5%9C%A8%E6%97%A2%E6%9C%89%E7%B1%BB%E4%B8%AD%E4%BD%BF%E7%94%A8%E5%85%B3%E8%81%94%E5%AF%B9%E8%B1%A1%E5%AD%98%E6%94%BE%E8%87%AA%E5%AE%9A%E4%B9%89%E6%95%B0%E6%8D%AE/AssociatedObjectDemo)
 
```
点击屏幕的弹出的alertView的log
2016-09-06 14:00:22.791 StaticConst[2545:142222] touchBeganAlertViewBlock Index ==0
2016-09-06 14:00:24.557 StaticConst[2545:142222] touchBeganAlertViewBlock Index!=0
点击按钮弹出的alertView的log
2016-09-06 14:00:26.677 StaticConst[2545:142222] btnIndex==0
2016-09-06 14:00:28.482 StaticConst[2545:142222] btnIndex!=0
```
在现在的`UIAlertController`中，貌似就是引用了此做法，就直接在action的后面添加了一个block来执行相关action的操作。
用到block的时候需要注意`retain cycle`，第40条详述此问题。

####第11条：理解object_msgSend的作用
1、`void objc_msgSend(id self, SEL _cmd, ...)` ，这是一个“参数可变的函数”（variadic function），能接受两个或两个以上的参数。第一个参数代表接收者，第二个参数代表选择子(器)(SEL是选择子的类型)，后续参数就是消息中的那些参数，其顺序不变。选择子指的就是方法的名字。</br>
2、`objc_msgSend` 函数会根据接收者与选择子的类型来调用适当的方法。该方法需要在接收者所属的泪中搜寻其“方法列表”（list of methods），如果能找到与子名称相符的方法，就跳至其实现代码。若找不到，就沿着继承体系统继续向上查找，等找到合适的方法之后就跳转。如果最终还是没有找到相符的方法，那就执行“消息转发”（message forwarding）操作。第12条中详解。</br>
3、objc_msgSend会将匹配结果缓存在“快速映射表”（fast map），每个类都有这样一块缓存。</br>
4、Objective-C运行环境中的另一些处理函数

- objc_msgSend_stret。如果待发送的消息要返回结构体，那么可交由此函数处理。只有当CPU的寄存器能够容纳的下消息返回类型时，这个函数才能处理此消息。若是返回值无法容纳于CPU寄存器中（比如说返回结构体太大了），否则就交给栈上面的某个变量来处理。
- objc_msgSend_fpret。如果消息返回的是浮点数，交由此函数处理。
- objc_msgSendSuper。如果要给超类发消息，交由此函数处理。

5、Objective-C对象的每个方法都可以视为简单的C函数，原型如下：
`<return_type> Class_selector(id self, SEL _cmd,...)`
每个类里都有一张表格，其中的指针都会指向这种函数，而选择子的名词则是查表是所用的“键”。objc_msgSend等函数正是通过这张表格来寻找应该执行的方法并跳至其实现的。原型的样子和objc_msgSend函数很像，是为了利用“尾调用优化”（tail-call optimization）技术。</br>
6、发给某对象的全部消息都要由“动态消息派发系统”（dynamic message dispatch system）来处理，该系统会查出对应的方法，并执行其代码。

####第12条：理解消息转发机制
1、如果对象所属的类或者父类都找不到相符的方法，就会启动“消息转发”（message forwarding）机制。</br>
2、动态方法解析，当对象接收到无法解读的消息之后，首先会调用其所属类的下列类方法：</br>
`+ (BOOL)resolveInstanceMethod:(SEL)sel`，表示这个类是否能新增一个实例方法用以处理此选择子。如果未实现的方法是不是实例方法而是类方法，那么在运行期间系统就会调用`+ (BOOL)resolveClassMethod:(SEL)sel`。</br>使用这种办法的前提是：相关方法的代码已经写好，只等着运行的时候动态插在类里面就可以，此方案常用来实现`@dynamic`属性。

```
/** 下列代码演示了如何使用“resolveInstanceMethod:” 来实现@dynamic属性 */

id autoDictionaryGetter(id self,SEL _cmd);
void autoDictionarySetter(id self,SEL _cmd,id value);

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    //* 将选择子化为字符串 */
    NSString *selectorString = NSStringFromSelector(sel);
    if (/* selector is from a @dynamic property */) {
        //* 检测其是否表示设置方法，若前缀未set，则表示设置方法，否则就是获取方法 */
        if ([selectorString hasPrefix:@"set"]) {
            class_addMethod(self, sel, (IMP)autoDictionarySetter, "V@:@");
        } else {
            class_addMethod(self, sel, (IMP)autoDictionaryGetter, "@@:");
        }
        return YES;
    }
    return [super resolveInstanceMethod:sel];
}

```
3、备援接收者，在这一步中，运行期系统会问它：能不能把这条消息转发给其他接收者来处理。与之对应的方法如下：</br>`- (id)forwardingTargetForSelector:(SEL)aSelector`，方法参数代表未知的选择子，若当前接收者能找到备援对象，则将其返回，若找不到，就返回nil。</br>请注意，我们无法操作经由这一步所转发的消息。若是想在发送给备援接收者之前先修改消息内容，那就得通过完整的消息转发机制来做。</br>
4、完整的消息转发，这也是消息转发的最后一步。首先会创建`NSInvocation`对象，把尚未处理的那条消息有关的全部细节都封装到其中。此对象包含选择子，目标（target）及参数。在触发NSInvocation对象是，“消息派发系统”将亲自出马，把消息指派给目标对象。</br>`- (void)forwardInvocation:(NSInvocation *)anInvocation`，这个方法可以实现得很简单：只需改变调用目标，使消息在新目标上得以调用即可。然而这样实现出来的方法与“备援接收者”方案所实现的方法等效。比较有用的实现方法为：在触发消息前，先以某种方式改变消息内容，比如追加另外一个参数，或是改变选择子，等等。如果最后调用了`NSObject`类的方法，那么该方法还会继而调用`doesNotRecognizeSelector:`，以抛出异常，此异常表明选择子最终未能得到处理。</br>
5、消息转发全流程
![Effective Objective-C 配图.png](http://upload-images.jianshu.io/upload_images/959078-548e6a72dd2aa7f9.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
6、动态方法解析例子演示 [Demo](https://github.com/CYBoys/EffectiveObjective-CDemo/tree/master/%E7%AC%AC12%E6%9D%A1%EF%BC%9A%E7%90%86%E8%A7%A3%E6%B6%88%E6%81%AF%E8%BD%AC%E5%8F%91%E6%9C%BA%E5%88%B6/MessageForwardingDemo)

####第13条：用“方法调配技术”调试“黑盒方法”
1、其实“方法调配技术”就是我们常说的`method swizzling`，[Demo](https://github.com/CYBoys/EffectiveObjective-CDemo/tree/master/%E7%AC%AC13%E6%9D%A1%EF%BC%9A%E7%94%A8%E2%80%9C%E6%96%B9%E6%B3%95%E8%B0%83%E9%85%8D%E6%8A%80%E6%9C%AF%E2%80%9D%E8%B0%83%E8%AF%95%E2%80%9C%E9%BB%91%E7%9B%92%E6%96%B9%E6%B3%95%E2%80%9D/Methodswizzling)
####第14条：理解“类对象”的用意
1、

```
typedef struct objc_class *Class;

    struct objc_class {
         Class isa;
         Class super_class;
         const char *name;
         long version;
         long info;
         long instance_size;
         struct objc_ivar_list *ivars;
         struct objc_method_list **methodLists;
         struct objc_cache *cache;
         struct objc_protocol_list *protocols;
};
```
此结构体存放类的`“元数据”`（metadata），例如类的实例实现了几个方法，具备多少个实例变量等消息。此结构体的首个变量也是`isa`指针，这说明Class本身亦为Objective-C对象。结构体里还有个变量叫做`super_class`，它定义了本类的超类。类对象所属的类型（也就是isa指针所指向的类型）是另外一个类，叫做`“元类”`（metaclass），用来表述类对象本身所具备的元数据。“类方法”就定义与此处，因为这些方法可以理解成类对象的实例方法。每个类仅有一个“类对象”，而每个“类对象”仅有一个与之相关的“元类”。
![继承体系图.png](http://upload-images.jianshu.io/upload_images/959078-998606eb9dac1de9.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
super_class指针确立了继承关系，而isa指针描述了实例所属的类。</br>
2、在类继承体系中查询消息类型，`isMemberOfClass:` 能够判断出对象是否为某个特定类的实例，而`isKindOfClass:` 则能够判断出对象是否为某类或者其派生类的实例。
##第三章 接口与API设计
####第15条：用前缀避免命名空间冲突</br>
1、Objective-C没有其他语言那种内置的命名空间（namespace）机制，所以就很容易出现重名。</br>
2、Apple 宣称其保留使用所有“两字母前缀”的权利，所以你自己选用的前缀应该是三个字母的。</br>
3、在类的实现文件中所用的纯C函数及全局变量，这个问题必须注意。在编译好的目标文件中（.o），这些名称是要算作“顶级符号”的。</br>
4、选择与你的公司、应用程序或二者皆有关联之名称作为类名的前缀，并在所有代码中均适用这一前缀。</br>
5、若自己所开发的程序中用到了第三方库，则应为其中的名称加上前缀。（真要这么做？）</br>

####第16条：提供“全能初始化方法”
1、什么是全能初始化方法？ 全能初始化方法就是指的在一个类中，可能有很多初始化方法，例如`NSDate`的初始化方法:</br>

```
- (id)init;
- (id)initWithString:(NSString *)string;
- (id)initWithTimeIntervalSinceNow:(NSTimeInterval)seconds;
- (id)initWithTimeInterval:(NSTimeInterval)seconds
                 sinceDate:(NSDate *)refDate;
- (id)initWithTimeinterValSinceReferenceDate:(NSTimeInterval)seconds;
- (id)initWithTimeIntervalSince1970:(NSTimeInterval)seconds;
```
在这些初始化方法里面`- (id)initWithTimeinterValSinceReferenceDate:(NSTimeInterval)seconds;`就是全能初始化方法，也就是说其他初始化函数都要调用它初始化。只有在全能初始化方法中才能存储内部数据。这样的话，当底层数据存储机制改变时，只需修改此方法的代码就好了，无需改动其他初始化方法。</br>
2、在这里提到的细节可能不是很多，更多细节请看[demo](https://github.com/CYBoys/EffectiveObjective-CDemo/tree/master/%E7%AC%AC16%E6%9D%A1%EF%BC%9A%E6%8F%90%E4%BE%9B%E2%80%9C%E5%85%A8%E8%83%BD%E5%88%9D%E5%A7%8B%E5%8C%96%E6%96%B9%E6%B3%95%E2%80%9D/UniversalInitializationDemo)

####第17条：实现 description 方法
1、对于已经熟悉 iOS 开发的程序员来说，这是debug必备的技能。只需要在自定义的类中覆写`- (NSString *)description`函数即可，这个函数在事在你调用NSLog的时候输出的。与此相似的还有一个函数`- (NSString *)debugDescription`，这个函数是在调试器中使用命令的方式输出的，其命令格式`po +输出对象`，例如`po person`。需要注意的是，要在调试器中使用命令的方式输出需要打`断点`，使程序停在断点处，然后在调试器中使用命令。 [demo](https://github.com/CYBoys/EffectiveObjective-CDemo/tree/master/%E7%AC%AC17%E6%9D%A1%EF%BC%9A%E5%AE%9E%E7%8E%B0%20description%20%E6%96%B9%E6%B3%95/DescriptionDemo)

####第18条：尽量使用不可变对象
1、什么是不可变对象？</br>答：在使用属性时，将其声明为“只读”（read-only）。默认情况下，属性是 “即可读又可写的”（read-write），这样设计出来的类是可变的。</br>
2、为什么要使用不可变对象？</br>答：把可变对象（mutable object）放入collection（NSSet，NSArray，NSDictionary以及其子类）之后又修改其内容，那么很容易就会破坏set（集合）的内部数据结构，使其失去固有的语义。</br>
3、怎么使用？</br>答：若某属性仅可于对象内部修改，则在“class-continuation分类”中将其由readonly属性扩展为readwrite。不要把可变的collection对象作为属性公开，而应提供相关方法（增删改），以此修改对象中的可变collection。</br>
4、相关细节请查看 [demo](https://github.com/CYBoys/EffectiveObjective-CDemo/tree/master/%E7%AC%AC18%E6%9D%A1%EF%BC%9A%E5%B0%BD%E9%87%8F%E4%BD%BF%E7%94%A8%E4%B8%8D%E5%8F%AF%E5%8F%98%E5%AF%B9%E8%B1%A1/UsingImmutableObjectsDemo)

####第19条：使用清晰而协调的命名方式
1、方法命名

- 如果方法的返回值是新建的，那么方法名的首个词应是返回值的类型，除非前面还有修饰语，例如localizedString。属性的存取方法不遵循这种命名方法，因为一般认为这些方法不会创建新的对象，即便有时返回内部对象的一份拷贝，我们也认为那相当于原有的对象。这些存取方法应该按照其所对应的属性来命名。
- 应该把表示参数类型的名词放在参数前面。
- 如果方法要在当前对象上执行操作，那么就应该包含动词；若执行操作时还需要参数，则应该在动词后面加上一个或多个名词。
- 不要使用str这种简称，应该使用string这样的全称。
- Boolean属性应该加is前缀。如果某方法返回非属性的Boolean值，那么应该根据其功能，选用has或is当前缀。
- 将get这个前缀留给那些借由“输出参数”来保存返回值的方法，比如说，把返回值填充到“C语言式数组”里的那种方法就可以使用这个词做前缀。</br>

2、类与协议的命名，应该为类与协议的名称加上前缀，以避免命名空间冲突（参加第15条）

####第20条：为私有方法名加前缀
1、给私有方法的名称加上前缀，这样就可以很容易地将其公共方法区分开。</br>
2、不要单用一个下划线（`_`）做私有方法的前缀，因为这种做法是预留给苹果公司自己用的。
####第21条：理解Objective-C错误类型
1、在Objective-C里面我们可以使用`NSError`来描述错误，NSError对象封装了三条信息：

- Error domain（错误范围，其类型为字符串，`应该定义成NSString型的全局常量`）</br>
错误发生的范围。也就是产生错误的根源，通常用一个特有的全局变量来定义。比方说，“处理URL的子系统” 在从URL中解析或取得数据时如果出错了，那么就会用NSURLErrorDomain来表示错误范围。
- Error code（错误码，其类型为整数，`应该定义成枚举`）</br>
独有的错误代码，用以指明在某个范围内具体发生了何种错误。某个特定范围内可能会发生一系列相关错误，这些错误情况通常采用enum来定义。例如，当HTTP请求出错时，可能会把HTTP状态码设为错误码。
- User info（用户信息，其类型为字典）</br>
有关此错误的额外信息，其中或许包含了一段“本地化的描述”（localized description），或许还含有导致该错误发生的另外一个错误，经由此种信息，可将相关错误穿成一条“错误链”。

2、NSError的常见用法

- 通过委托协议来传递此错误。例如：</br>
`- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error`
- 经由方法的 “输出参数” 返回给调用者。例如：
`- (BOOL)doSomething:(NSError **)error`，传递给方法的参数是一个指针，而该指针本身又指向另一个指针，那个指针指向NSError对象。或者也可以把它当成一个直接指向NSError对象的指针。这样来一来，此方法不仅能有普通的返回值，而且还能经由“输出对象”把NSError对象回传给调用者。其用法如下：</br>

	```
	typedef NS_ENUM(NSUInteger, EOCError) {
	    EOCErrorUnknown = -1,
	    EOCErrorInteralInconsistency = 100,
	    EOCErrorGeneralFault = 105,
	    EOCErrorBadInput = 500,
};

	NSString *const EOCErrorDomain = @"EOCErrorDomain";
	
	- (BOOL)doSomething:(NSError **)error {
	    // Do something that may cause an error
	    if (/* there was an error*/) {
	        if (error) {
	            NSDictionary *userInfo = @{};
	            // Pass the 'error' through the out-parameter
	            *error = [NSError errorWithDomain:EOCErrorDomain code:EOCErrorGeneralFault userInfo:userInfo];
	        }
	        return NO;////< Indicate failure
	    } else {
	        return YES;////< Indicate success
	    }
	}
	```
	
	```
	NSError *error = nil;
    BOOL ret = [self doSomething:&error];
    if (error) {
    //There was an error
    }
	```
	
####第22条：理解NSCopying协议
1、要想使某个类支持拷贝功能，只需声明该类遵从 `NSCopying` 协议，并实现其中的那个方法即可。</br>
2、如果你的类分为`可变版本`与`不可变版本`，那么就还应该实现 `NSMutableCopying` 协议 。若采用此模式，则在可变类中覆写 `copyWithZone:` 方法时，不要返回可变的拷贝，而应返回一份不可变的版本，无论当前实例是否可变，若需获取其可变版本的拷贝，均应调用 `mutableCopy` 方法。同理，若需要不可变的拷贝，则总应通过 `copy` 方法来获取。</br>对于不可变的NSArray与可变的NSMutableArray来说，下列关系总是成立的：

```
-[NSMutableArray copy] => NSArray
-[NSArray mutableCopy] => NSMutableArray
```
3、实现可变版本与不可变版本之间自由切换，提供三个方法：`copy`、`immutableCopy`、`mutableCopy`，其中，copy所返回的拷贝对象与当前对象的类型一致，而另外两个方法则分别返回不可变版本与可变版本的拷贝。</br>
4、深拷贝&浅拷贝，深拷贝的意思就是：在拷贝对象自身时，将其低层数据也一并复制过去。Foundation 框架中的所有 collection 类在默认的情况下都执行浅拷贝，也就是说只拷贝容器对象本身，而不复制其中数据。如下图所示：![浅复制&深复制.png](http://upload-images.jianshu.io/upload_images/959078-1b7d1f1aa5b0862f.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240) </br>
5、如何实现深拷贝？</br>答：以 `NSSet` 为例，NSSet有一个方法`- (instancetype)initWithSet:(NSSet<ObjectType> *)set copyItems:(BOOL)flag`，若 copyItems 参数为YES，则该方法会向数组中的每个元素发送copy信息，用拷贝好的元素创建新的set，并将其返回给调用者。同样的，`NSArray` 和 `NSDictionary`都有同样类似的深拷贝方法

```
//NSArray
- (instancetype)initWithArray:(NSArray<ObjectType> *)array copyItems:(BOOL)flag
//NSDictionary
- (instancetype)initWithDictionary:(NSDictionary<KeyType, ObjectType> *)otherDictionary copyItems:(BOOL)flag
```
6、不要假定遵循了 `NSCopying` 协议的对象都会执行深拷贝，在绝大多数情况下，执行的都是浅拷贝。如果需要在某对象上执行深拷贝，那么除非该类的文档说它是用深拷贝来实现的 NSCopying 协议的，否则，要么寻找能够执行深拷贝的相关办法，要么自己编写方法来做。相关细节请查看 [demo](https://github.com/CYBoys/EffectiveObjective-CDemo/tree/master/%E7%AC%AC22%E6%9D%A1%EF%BC%9A%E7%90%86%E8%A7%A3NSCopying%E5%8D%8F%E8%AE%AE/NSCopyingDemo)


##第4章 协议与分类
####第23条：通过委托与数据源协议进行对象间通讯
1、协议的命名为`XXXDelegate`，相关类名+Delegate</br>
2、在协议方法中，`@require` 是必须实现的，`@optional` 的可选择实现的，默认是`@require`</br>
3、delegate的属性需定义成 `weak`，因为两者之间必须为“非拥有关系”，如果定义成 `strong`，那么将会出现本对象与委托对象之间定为“拥有关系”，那么就会引入“保留环”（retain cycle）。</br>
![非拥有关系.png](http://upload-images.jianshu.io/upload_images/959078-8e7a0570a3825dc9.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
4、如果协议方法调用次数很频繁，则可以实现含有位段的结构体，将委托对象是否能够响应相关协议方法这一信息缓存至其中。[demo](https://github.com/CYBoys/EffectiveObjective-CDemo/tree/master/%E7%AC%AC23%E6%9D%A1%EF%BC%9A%E9%80%9A%E8%BF%87%E5%A7%94%E6%89%98%E4%B8%8E%E6%95%B0%E6%8D%AE%E6%BA%90%E5%8D%8F%E8%AE%AE%E8%BF%9B%E8%A1%8C%E5%AF%B9%E8%B1%A1%E9%97%B4%E9%80%9A%E8%AE%AF/DelegateDemo)


####第24条：将类的实现代码分散到便于管理的数个分类之中
1、通过分类机制，可以把类代码分成很多个易于管理的小块，以便单独检视。</br>
2、便于调试，对于某个分类中的所有方法来说，分类名称都会出现在其符号中。</br>
3、[demo](https://github.com/CYBoys/EffectiveObjective-CDemo/tree/master/%E7%AC%AC24%E6%9D%A1%EF%BC%9A%E5%B0%86%E7%B1%BB%E7%9A%84%E5%AE%9E%E7%8E%B0%E4%BB%A3%E7%A0%81%E5%88%86%E6%95%A3%E5%88%B0%E4%BE%BF%E4%BA%8E%E7%AE%A1%E7%90%86%E7%9A%84%E6%95%B0%E4%B8%AA%E5%88%86%E7%B1%BB%E4%B9%8B%E4%B8%AD/CategoryDemo)


####第25条：总是为第三方类的分类名称加前缀
1、分类中的方法是直接添加在类里面的，它们就好比这个类中的固有方法。将分类方法加入类中这一操作是在运行期系统加载分类时完成的。运行期系统会把分类中所实现的每个方法都加入类的方法列表中。如果类中本来就有此方法，而分类又实现了一次，那么分类中的方法会覆盖原来那一份实现代码。</br>
2、自己实现的分类方法一定要添加前缀，不然覆盖了原有的方法，出现这种bug是很难查找的。

####第26条：勿在分类中声明属性
1、把封装数据所用的全部属性都定义在主接口里</br>
2、在 “class-continuation” 分类之外的其他分类中，可以定义存取方法，但尽量不要定义属性。</br>
3、分类的目标在于扩展类的功能，而非封装数据。

####第27条：使用 “class-continuation 分类” 隐藏实现细节
1、通过 “class-continuation 分类” 想类中新增实例变量。</br>
2、如果某属性在主接口中声明为 “只读” ，而类的内部又要用设置方法修改此属性，那么就在 “class-continuation 分类” 中将其扩展为 “可读写” 。</br>
3、把私有方法的原型声明在 “class-continuation 分类” 里面。</br>
4、若想使类所遵循的协议不为人所知，则可于 “class-continuation 分类” 中声明。

####第28条：通过协议提供匿名对象
1、协议可在某种程度上提供匿名类型。具体的对象类型可以淡化成遵从某协议的id类型，协议里规定了对象所应事先的方法。</br>
2、使用匿名对象来隐藏类型名称(或方法)。<br>
3、如果具体类型不重要，重要的是能够响应(定义在协议里的)特定方法，那么可使用匿名对象来表示。


##第5章 内存管理
####第29条：理解引用计数
1、引用计数工作原理
注意：在 `ARC` 下无法使用以下方法

- retain 递增保留计数。
- release 递减保留计数。
- autorelease 待稍后清理 “自动释放池” （autorelease pool）时，再递减保留计数。
- retainCount 查看保留计数，此方法不常用，即便在调试时也是如此。

![图片来自《Effective Objc》.png](http://upload-images.jianshu.io/upload_images/959078-65a4fac1e4555fec.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
当保留计数归零时，对象就回收了，系统会将其占用的内存标记为 “可重用”。
为避免在不经意间使用了无效对象，一般调用完release之后都会清空指针。这就能保证不会出现指向无效对象的指针，这种指针通常称为 “悬挂指针” 。

```
NSNumber *number = [[NSNumber alloc] initWithInt:1337];
[array addObject:number];
[number release];
number = nil;
```
2、自动释放池

- release 会立刻递减对象的保留计数。
- autorelease 会在稍后递减计数，通常是在下一次 “事件循环” 时递减，不过也可能执行得更早些。（能延长对象生命期，使其在跨越方法调用边界后依然可以存活一段时间）

3、保留环，对于循环中的每个对象来说，至少还有另外一个对象引用着它。通常采用 “弱引用” 来解决此问题 (参见第 33 条)。

![图片来自《Effective Objc》.png](http://upload-images.jianshu.io/upload_images/959078-b106b012c1055e62.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


####第30条：以 ARC 简化引用计数
1、由于 ARC 会自动执行 `retain`，`release`，`autorelease` 等操作，所以直接在 ARC 下调用这些内存管理方法是非法的，具体来说，不能调用下列方法：

- retain
- release
- autorelease
- dealloc

直接调用上述任何方法都会产生编译错误，因为 ARC 要分析何处应该自动调用内存管理方法，所以如果手动调用的话吗就会干扰其工作。</br>

2、使用 ARC 时必须遵循的方法命名规则，如方法名以下列词语开头，则其返回的对象归调用者所有：

- alloc
- new
- copy
- mutableCopy

归调用者所有的意思是：调用上述四种方法的那段代码要负责释放方法所返回的对象。也就是说，这些对象的保留计数是正值，而调用了这四种方法的那段代码要将其中一次保留操作抵消掉。如果还有其他对象保留此对象，并对其调用了 `autorelease`，那么保留计数的值可能比1大，这也是 retainCount 方法不太有用的原因之一。
若方法名不是以上述四个词语开头，则表示其所返回的对象并不归调用者所有。`在这种情况下，返回的对象会自动释放`，所以其值在跨越方法调用边界后依然有效。要想使对象多存活一段时间，必须令调用者保留它才行。</br>
3、变量的内存管理语义

- __strong：默认语义，保留此值。
- __unsafe_unretained：不保留此值，这么做可能不安全，因为等到再次使用变量时，其对象可能已经回收了。`注意：值不会自动清空`
- __weak：不保留此值，但是变量可以安全使用，因为如果系统把这个对象回收了，那么变量也会自动清空。
- __autoreleasing：把对象 “按引用传递” 给方法时，使用这个特殊的修饰符。此值在方法返回时自动释放。

4、ARC 只负责管理 Objective-C 对象的内存，尤其要注意：CoreFoundation 对象不归 ARC 管理，开发者必须适时调用CFRetain/CFRelease。

####第31条：在 dealloc 方法中只释放应用并解除监听
1、在 `dealloc` 方法里，应该做的事情就是释放指向其他对象的引用，并取消原来订阅的 “键值观测（KVO）” 或 `NSNotificationCenter` 等通知，不要做其他事情。</br>
2、不要在 `dealloc` 方法里面随便调用其他方法，也不要在里面调用属性的存取方法</br>
3、如果对象持有文件描述符等系统资源，那么应该专门编写一个方法来释放此种资源，这样的类要和其使用者约定：用完资源后必须调用 close 方法。</br>
4、执行异步任务的方法不应该在 dealloc 里调用；只能在正常状态下执行的那些方法也不应在 dealloc 里调用，因为此时对象已处于正在回收的状态了。

####第32条：编写 “异常安全代码” 时留意内存管理问题
1、在捕获异常时，一定要注意将try块哪所创立的对象清理干净。</br>
2、在默认情况下，ARC 不生成安全处理异常所需的清理代码。开启编译器标志后（`-fobjc-arc-exceptions`），可以生成这种代码，不过会导致应用程序变大，而且会降低运行效率。</br>
3、在 Objective-C++ 模式时， `-fobjc-arc-exceptions`会自动打开。</br>
4、在发现大量异常补货操作时，应考虑重构代码，用第21条所讲的 `NSError` 式错误信息传递来取代异常。


####第33条：以弱引用避免保留环
1、避免保留环的最佳方式就是弱引用。 使用 `unsafe_unretained` 或者 `weak`。 它们之间的区别请看第6条。</br>
2、block 中使用 `__weak typeof(self) weakSelf = self;` 来达到避免保留环，使用`weakSelf` 替代self。

```
void (^myBlock)() = ^ {
   NSLog(@"%@",[weakSelf class]);
};
myBlock();
```

####第34条：以 “自动释放池块” 降低内存峰值
1、释放对象有两种方式：一种是调用 `release` 方法，使其保留计数立即递减；另一种是调用 `autorelease` 方法，将其加入 “自动释放池” 中。自动释放池用于存放那些需要在稍后某个时刻释放的对象。清空自动释放池时，系统会向其中的对象发送 `release` 消息。</br>
2、位于自动释放池范围内的对象，将在此范围末尾处受到 `release` 消息。自动释放池可以嵌套。</br>
3、自动释放池机制就像 “栈” 一样。系统创建好自动释放池之后，就将其推入栈中，而清空自动释放池，则相当于将其从栈中弹出。</br>
4、自动释放池排布在栈中，对象收到 `autorelease` 消息后，系统将其放入最顶端的池里。

####第35条：用 “僵尸对象” 调试内存管理问题
1、开启 “僵尸对象” 调试模式
![Paste_Image.png](http://upload-images.jianshu.io/upload_images/959078-ba56bea0ff16f511.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
2、“僵尸对象” 只是一个调试模式，在正式发布应用程序时候不要把这项功能打开。</br>
3、系统会修改对象的isa指针，令其指向特殊的僵尸类，从而使该对象变为僵尸对象。`僵尸类能够响应所有的选择子`，响应方式为：打印一条包含消息内容及其接受着的消息，然后终止应用程序。相关[demo](https://github.com/CYBoys/EffectiveObjective-CDemo/tree/master/%E7%AC%AC35%E6%9D%A1%EF%BC%9A%E7%94%A8%20%E2%80%9C%E5%83%B5%E5%B0%B8%E5%AF%B9%E8%B1%A1%E2%80%9D%20%E8%B0%83%E8%AF%95%E5%86%85%E5%AD%98%E7%AE%A1%E7%90%86%E9%97%AE%E9%A2%98/ZombieObject)


####第36条：不要使用 retainCount
1、 ARC 已经将 `retainCount` 方法废弃，此方法返回的保留计数不正确，因为，它所返回的保留计数只是某个给定的时间点上的值。该方法未考虑到系统会稍后把自动释放池清空，因而不会将后续的释放操作从返回值里减去，所以说，返回的这个保留计数不能正确反应实际的保留计数。

#未完，会持续更新到完结！望持续关注！！！