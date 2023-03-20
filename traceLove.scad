// OpenSCAD 为免费开源的跨平台建模软件
// 作者：上海市第三女子初级中学 谢丁
/*
请打开视图菜单下的动画命令，在绘图区的下方，帧率处输入绘图的图像帧率，步数为绘制整个图形经过的步骤数，
我们可以采用帧率为20，步数为100进行查看
*/
pos = position($t); // 引入坐标与时间相关的变量

r = 2; // 圆锥底面半径
$fn = 30; // 绘图圆锥的精度

echo(pos); // 用于调试时候在控制台输出当前圆锥的坐标

function position(x) =
  [
    16 * pow(sin(360 * x), 3), // x 坐标
    13 * cos(360 * x) - 5 * cos(2 * 360 * x) - 2 * cos(3 * 360 * x) - cos(4 * 360 * x) // y坐标
  ];

module curve() // 这里其实绘制的是一个多边形，使用for循环进行迭代绘制
polygon([for (a = [ 0 : 0.005 : 1]) position(a)]);
// a 的起始值为0，步长值为0.005，终值为1，这里步长值大小决定了爱心的精度

module heart()
{ // 将外面的爱心与内部的爱心进行差值布尔运算后线性拉伸0.1个单位
  color("gold") linear_extrude(0.1) difference()
  {
    curve(); // 外面的爱心
    offset(-1) curve(); // 将爱心多边形向内偏移1个单位
  }
}

module target(x, y)
{
  translate([x, y, 2 * r]) // 绘图圆锥的位置
  cylinder(r1 = 0, r2 = r, h = 4 * r, center = true);
}

heart();
target(pos[0], pos[1]); // 圆锥的位置坐标pos[0]为x坐标，pos[1]为y坐标