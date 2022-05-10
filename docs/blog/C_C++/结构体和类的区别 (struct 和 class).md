C++ 中的 struct 对 C 语言中的 struct 进行了扩充，它已经不再只是一个包含不同数据类型的数据结构了，而是具有了更多的功能：能包含成员函数、能继承、能实现多态！

但是它和 class 最本质的一个区别就是默认的访问控制权限：struct 是 public 的，class 是 private 的。

* 例如

``` C++
struct A
{
    char a;
}；

struct B : A
{
    char b;
}；
```

这个时候 `B` 是 `public` 继承 `A` 的。

如果都将上面的 struct 改成 class，那么 B 是 private 继承 A 的。所以我们在平时写类继承的时候，通常会这样写：class B : public A，就是为了指明是 public 继承，而不是用默认的 private 继承。

当然，struct 可以继承 class，同样 class 也可以继承 struct，所以到底默认是 public 继承还是 private 继承，取决于子类而不是基类。即看子类到底是用的 struct 还是 class。如下：


``` C++
struct A{};
class B : A{};     //private继承
struct C : B{};    //public继承
```

struct 作为数据结构的实现体，它默认的数据访问控制是 public 的，而 class 作为对象的实现体，它默认的成员变量访问控制是private 的。在这里，依旧将 struct 看作是一种数据结构的实现体，虽然它是可以像 class 一样的用；依旧将 struct 里的变量叫数据，class 内的变量叫成员，虽然它们并无区别。

另外：到底是用 struct 还是 class，完全看个人的喜好，将程序里所有的 class 全部替换成 struct，它依旧可以很正常的运行。但是还是那个建议，当你觉得你要做的更像是一种数据结构的话，那么用 struct，如果你要做的更像是一种对象的话，那么用class。 

当然，对于访问控制，应该在程序里明确的指出，而不是依靠默认，这是一个良好的习惯，也让你的代码更具可读性。 

最后，struct 和 class 还有一个小小的区别，但是很少涉及，那就是：“class” 这个关键字还用于定义模板参数，就像 “typename”。但关键字 “struct” 不用于定义模板参数。这一点在 Stanley B.Lippman 写的 Inside the C++ Object Model 有过说明。 

 

附：C++ 中的 struct 是对 C 语言中的 struct 的扩充，所以它就要兼容过去 C 语言中 struct 应有的所有特性。例如：

``` C++
struct NUM        //定义一个struct
{
   char c1;
   int n2;
   double db3;
};
NUM a = {'p', 7, 3.1415926};      //定义时直接赋值 
```


也就是说 struct 可以在定义的时候用 {} 赋初值。那么问题来了，class 行不行呢？将上面的 struct 改成 class，试试看，报错！

但是，这真的算是另一个区别吗？ 

当向上面的 struct 中加入一个构造函数（或虚函数）时，struct 也不能用 {} 赋初值了，这是因为以 {} 的方式来赋初值，只是用一个初始化列表来对数据进行按顺序的初始化，如上面如果写成 NUM a={'p',7}; 则 c1,n2 被初始化，而 db3 没有。这样简单的复制操作，只能发生在简单的数据结构上，而不应该放在对象上。加入一个构造函数或是一个虚函数会使 struct 更体现出一种对象的特性，而使此 {} 操作不再有效。 

事实上，是因为加入这样的函数，使得类的内部结构发生了变化。而加入一个普通的成员函数呢？你会发现 {} 依旧可用。其实你可以将普通的函数理解成对数据结构的一种算法，这并不打破它数据结构的特性。 

所以，即使是 struct 想用 {} 来赋初值，它也必须满足很多的约束条件，这些条件实际上就是让 struct 体现出一种数据结构而不是类的特性。 

此外，我们在上面仅仅将 struct 改成 class，编译报错，这恰巧印证了之前说的访问控制问题，将 struct 改成 class 的时候，访问控制由 public 变为 private 了，那当然就不能用 {} 来赋初值了。加上一个 public，你会发现，class 也是能用 {} 的，和 struct 毫无区别！！！ 

总结：struct 更适合看成是一个数据结构的实现体，class 更适合看成是一个对象的实现体。


参考：<https://www.cnblogs.com/starfire86/p/5367740.html?tdsourcetag=s_pctim_aiomsg>
