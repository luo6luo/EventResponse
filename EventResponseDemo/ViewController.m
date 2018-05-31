//
//  ViewController.m
//  EventResponseDemo
//
//  Created by dundun on 2018/5/30.
//  Copyright © 2018年 dundun. All rights reserved.
//

#import "ViewController.h"
#import "TestView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
     iOS 中事件分为：
     1、触摸事件
     2、加速计事件
     3、远程控制事件
     
     
     响应者对象：继承UIResponder的子类，才能接收并处理时间
     例子：UIApplication、UIWindow、UIViewController、UIView
     
     
     UIResponder处理事件的方法：
     1、触摸事件
     - (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event;
     - (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event;
     - (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event;
     - (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event;
     - (void)touchesEstimatedPropertiesUpdated:(NSSet<UITouch *> *)touches;
     2、加速计事件
     - (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event;
     - (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event;
     - (void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event;
     3、远程控制事件
     - (void)remoteControlReceivedWithEvent:(UIEvent *)event;
     
     
     UITouch
     触摸事件中，touches中存放的是UITouch对象；其中，一根手指对应一个UITouch对象
     触摸开始，系统会创建手指对应的UITouch对象，随着手指移动，UITouch对象会随着更新，触摸事件结束，系统会销毁这个UITouch对象
     <一> 属性
     1、window    --> 触摸产生时对应触摸的窗口
     2、view      --> 触摸产生时对应的触摸视图
     3、tapCount  --> 短时间的触摸次数，据此判断是几根手指触摸，双击、单击或者其他更多
     4、timestamp --> 触摸事件产生或者变化的时间（单位秒）
     5、phase     --> 当前触摸事件的状态（开始：Began、移动：Moved、静止：Stationary、结束：Ended、取消Cancelled）
     6、gestureRecognizers    --> 触摸手势组
     == iOS8中新增属性 ==
     7、majorRadius           --> 触摸的主半径
     8、majorRadiusTolerance  --> 触摸主半径的公差
     == iOS9中新增属性 ==
     9、type                  --> 触摸类型（直接手指触摸：Direct、间接触摸：Indirect、触摸笔触摸：Stylus）
     10、force                --> 触摸力度，其中1.0表示平均力压值
     11、maximumPossibleForce --> 能触摸的最大力度
     12、altitudeAngle        --> 高角度，仅适用于用触摸笔触摸类型。0：触摸笔平行于平面；M_PI/2：触摸笔垂直于平面
     13、estimationUpdateIndex --> 预估更新索引，可以让更新的触摸对象与原对象进行关联，当前触摸对象的触摸特性变化，该值就会加一
     14、estimatedProperties   --> 预估属性，当前触摸对象的预估触摸特性（力度：Force、方位角：Azimuth、高度：Altitude、位置：Location）
     15、estimatedPropertiesExpectingUpdates --> 预期将要更新的特性，如果没有更新，则当前值为最终预估值，用于从边缘进入时系统开始无法获得准确的touches值
     <二> 方法
        // 返回触摸在view上的坐标位置（以view左上角原点(0, 0)为准），若传入的view = nil，则返回触摸点在window上的位置
     1、- (CGPoint)locationInView:(nullable UIView *)view;
        // 同上，这个方法记录了上一个触摸点的位置
     2、- (CGPoint)previousLocationInView:(nullable UIView *)view;
     == iOS9中新增的方法 ==
        // 精准的返回触摸在view上的坐标位置
     3、- (CGPoint)preciseLocationInView:(nullable UIView *)view;
        // 精准的返回上一个在view上的触摸位置
     4、- (CGPoint)precisePreviousLocationInView:(nullable UIView *)view;
        // 返回触摸在view上的方位角（仅适用于触摸笔触摸事件）
     5、- (CGFloat)azimuthAngleInView:(nullable UIView *)view;
        // 返回触摸在view上的指向方向角的单位向量（仅适用于触摸笔触摸事件）
     6、- (CGVector)azimuthUnitVectorInView:(nullable UIView *)view;
     
     
     UIEvent
     每产生一个事件就会产生一个UIEvent对象
     UIEvent对象记录了事件的产生时刻和类型
     <一>属性
     1、type --> 事件类型（Touches：点击、Motion：加速计、RemoteControl：远程控制、Presses：按压）
     2、subtype --> 同一事件类型的具体事件
          None：type是触摸
          MotionShake：type是加速计
          // 剩下是针对远程控制事件类型
          RemoteControlPlay：播放
          RemoteControlPause：暂停
          RemoteControlStop：停止
          RemoteControlTogglePlayPause：切换播放暂停
          RemoteControlNextTrack：下一曲
          RemoteControlPreviousTrack：上一曲
          RemoteControlBeginSeekingBackward：开始往后寻找（开始快退）
          RemoteControlEndSeekingBackward：结束向后寻找（结束快退）
          RemoteControlBeginSeekingForward：开始向前寻找（开始快进）
          RemoteControlEndSeekingForward：结束向前寻找（结束快进）
     3、timestamp --> 事件产生的时间
     4、allTouches --> 事件中产生的所有触摸点
     <二>
        // 返回在窗口上的所有触摸点
     1、- (nullable NSSet <UITouch *> *)touchesForWindow:(UIWindow *)window;
        // 返回在当前视图上的所有触摸点
     2、- (nullable NSSet <UITouch *> *)touchesForView:(UIView *)view;
        // 返回事件中手势的触摸点
     3、- (nullable NSSet <UITouch *> *)touchesForGestureRecognizer:(UIGestureRecognizer *)gesture
     == iOS9中新增的方法 ==
        // 将丢失的触摸点放在一个数组中返回（手机扫描渲染是每秒60帧，会出现绘画延迟，所以有些触摸点会丢失，下列方法是针对这种情况的优化）
     4、- (nullable NSArray <UITouch *> *)coalescedTouchesForTouch:(UITouch *)touch;
        // 预测的一组触摸点位置，但是不定和实际触摸点一样，所以是预估值
     5、- (nullable NSArray <UITouch *> *)predictedTouchesForTouch:(UITouch *)touch;
     
     
     下列情况不能接收事件：
     1、不能接收用户交互，self.userInteractionEnabled = NO
     2、被隐藏，self.hidden = YES
     3、透明度小于0.01，self.alpha < 0.01
     4、如果父控件不能接收触摸事件，那么子控件也将不能接收
     
     
     触摸事件：事件的产生和传递
     1、事件发生后，系统会将事件加入到UIApplication管理的队列中
     2、UIApplication遵循先进先出的原则，将队列中先进的事件发送给主窗口（keyWindow）
     3、主窗口会在视图层级中找到一个合适的view来接收和处理事件
     4、找到合适的view后，会调用视图的touches方法来具体处理事件
     
     
     寻找合适控件接收触摸事件步骤：
     1、先判断view是否能接收触摸事件
     2、触摸点是否在view身上
     3、在子控件数组中从后向前遍历子控件，然后重复上面两步，找到则返回合适的子控件
     4、没找到合适的子控件，则自己就是合适处理的
     
     
     点击方法的内部实现方法：
        // 事件一传递给控件，就会调用下列方法，返回最合适接收事件的UIView
     1、- (nullable UIView *)hitTest:(CGPoint)point withEvent:(nullable UIEvent *)event;
        // 默认值是 YES，返回触摸点是否在调用者身上
     2、- (BOOL)pointInside:(CGPoint)point withEvent:(nullable UIEvent *)event;
     
     
     响应者链条：由事件响应者组成
     事件传递详细过程：
     1、触摸屏幕，事件产生，系统将事件加入UIApplication管理的队列中
     2、UIApplication根据先进先出原则，将时间传给主窗口
     3、主窗口将事件由上往下传递（由父视图传递给子视图），找到最合适的视图接收控件
     4、最佳视图接收调用touches方法
     5、如果最佳视图调用了[super touches...]，则事件由下往上顺着响应者链传递上去
     6、接着就会调用上一个响应者的touches方法
     7、如果上一个响应者不能响应，则传递给上上一个响应者
     8、如果传递到UIApplication还是不能处理，那这个时间就会被废弃
     
     
     判断上一个响应者：
     1、如果当前视图是视图控制器的view，则上一个响应者是该视图的视图控制器
     2、如果当前视图没有视图控制器，则上一个响应者是该视图的父视图
     */
    
    
    /*
     触摸事件实例：
     self.view：子控件灰色
     灰色：子控件红色、绿色
     绿色：子控件橘色、白色

     符合：满足可接收事件条件，自身能接收事件，触摸点在自己身上
     否：不能接收事件
     点击红色：UIApplication -> UIWindow -> 灰色（符合）-> 查询灰色子控件（红色、绿色）-> 绿色（触摸点不在身上，否）-> 红色（符合）
     点击白色：UIApplication -> UIWindow -> 灰色（符合）-> 查询灰色子控件（红色、绿色）-> 绿色（符合）-> 查询绿色子控件（白色、橘色）-> 橘色（触摸点不在身上，否）-> 白色（符合）
     点击橘色：UIApplication -> UIWindow -> 灰色（符合）-> 查询灰色子控件（红色、绿色）-> 绿色（符合）-> 查询绿色子控件（白色、橘色）-> 橘色（符合）
     */
    
    [self setupSubviews];
    
}

- (void)setupSubviews
{
    TestView *grayView = [[TestView alloc] initWithFrame:CGRectMake(50, 100, 250, 500)
                                         backgroundColor:[UIColor grayColor]
                                                   index:1];
    [self.view addSubview:grayView];
    
    TestView *redView = [[TestView alloc] initWithFrame:CGRectMake(50, 50, 100, 100)
                                        backgroundColor:[UIColor redColor]
                                                  index:2];
    [grayView addSubview:redView];
    
    TestView *greenView = [[TestView alloc] initWithFrame:CGRectMake(50, 200, 150, 200)
                                          backgroundColor:[UIColor greenColor]
                                                    index:3];
    [grayView addSubview:greenView];
    
    TestView *whiteView = [[TestView alloc] initWithFrame:CGRectMake(20, 100, 100, 70)
                                          backgroundColor:[UIColor whiteColor]
                                                    index:4];
    [greenView addSubview:whiteView];
    
    TestView *orangeView = [[TestView alloc] initWithFrame:CGRectMake(20, 20, 50, 50)
                                           backgroundColor:[UIColor orangeColor]
                                                     index:5];
    [greenView addSubview:orangeView];
}



@end
