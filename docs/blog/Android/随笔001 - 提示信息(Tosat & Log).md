# 目录

# 1. Toast

`Toast` 是 `Android` 系统提供的一种很好的提醒方式，在程序中可以使用它将一些简单的信息反馈给用户，这些信息会在一段时间后自动消失，并不会占用屏幕空间。

> 使用：首先要定义一个弹出 `Toast` 的触发点，例如设置一个按钮，在点击按钮的时候弹出一个 `Toast`。

``` java
public class MainActivity extends AppCompatActivity {
 
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
 
        Button button = findViewById(R.id.first_button);
 
        button.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Toast.makeText(MainActivity.this,"you clicked the button",Toast.LENGTH_SHORT).show();
            }
        });
    }
}
```

在活动中，通过 `findViewById()` 方法获取在布局文件中定义的元素。

得到按钮的实例后，通过 `setOnClickListener()` 方法为按钮注册一个监听器，在点击按钮的时候会执行监听器中的 `onClick()` 方法。因此弹出 `Toast` 的功能要在 `onClick()` 方法中编写。

通过 `makeText()` 创建一个 `Toast` 对象，然后调用 `show()` 将 `Toast` 显示出来。

> `makeText()` 传入三个参数，第一个是 `context`，就是 `Toast` 要求的上下文，由于活动本身也是一个上下文，所以直接传入 `MainActivity.this` 即可。第二个参数是显示的文本内容。第三个是显示时长，有两个常量可供选择  `Toast.LENGTH_SHORT` 和 `Toast.LENGTH_LONG`。

运行效果如下：点击 `first_Button`

![20190409143342115](https://user-images.githubusercontent.com/26021085/164888246-d6f1dfbc-06b7-470c-b3a6-46c411df3bca.png)

# 2. Log

`Android` 日志工具类 `Log`。

> `Log.v()`：用于打印意义最小的日志信息。对应级别 `verbose`。

> `Log.d()`：打印一些调试信息。对应级别 `debug`。

> `Log.i()`：打印一些重要的信息。可帮助分析用户行为数据，对应级别 `info`。

> `Log.w()`：打印警告信息。提示存在风险，要修复，对应级别 `warn`。

> `Log.e()`：打印错误信息。问题很严重，对应级别 `error`。

优先等级：`error > warn > info > debug > verbose`。

> `Log.d()` 方法中传入两个参数，第一个参数是 `tag`，一般传入当前的类名就好，主要用于对打印信息的筛选；第二个参数是 `msg`，即想要打印的信息内容。
