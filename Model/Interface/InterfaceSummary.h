/**
 * 用c函数写的,接口汇总
 */
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
/**
 * 登录接口
 */
NSString* loginInterface(NSString* myurl);
/**
 * 验证手机是否注册
 */
NSString* valicationInterface(NSString* myurl);
/**
 * 注册手机号
 */
NSString* registerInterface(NSString* myurl);
/**
 * 找回密码
 */
NSString* passwordBackInterface(NSString* myurl);
/**
 * 修改密码
 */
NSString* updatePasswordInterface(NSString * myurl);
/**
 * 修改绑定的手机号
 */
NSString* bindPhoneNumberInterface(NSString * myurl);
/**
 *  修改昵称
 */
NSString* updateNicknameInterface(NSString * myurl);
/**
 *  修改联系人电话
 */
NSString* updateTelephoneInterface(NSString * myurl);
/**
 *  修改车牌号码
 */
NSString* updatePlateInterface(NSString * myurl);




