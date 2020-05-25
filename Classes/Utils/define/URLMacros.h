//
//  URLMacros.h
//  MiAiApp
//
//  Created by 徐阳 on 2017/5/18.
//  Copyright © 2017年 徐阳. All rights reserved.
//



#ifndef URLMacros_h
#define URLMacros_h


//内部版本号 每次发版递增
#define KVersionCode 1
/*
 
 将项目中所有的接口写在这里,方便统一管理,降低耦合
 
 这里通过宏定义来切换你当前的服务器类型,
 将你要切换的服务器类型宏后面置为真(即>0即可),其余为假(置为0)
 如下:现在的状态为测试服务器
 这样做切换方便,不用来回每个网络请求修改请求域名,降低出错事件
 */

#define DevelopSever    1
#define TestSever       0
#define ProductSever    0

#if DevelopSever

/**开发服务器*/
#define URL_main @"https://www.goabroad.club:81/"


#elif TestSever

/**测试服务器*/
#define URL_main @"https://www.goabroad.club:81/"


#elif ProductSever

#define URL_main @"https://www.goabroad.club:81/"

#endif



#pragma mark - ——————— 详细接口地址 ————————

//测试接口
//NSString *const URL_Test = @"api/recharge/price/list";
//#define URL_Test @"/api/cast/home/start"


#pragma mark - ——————— 用户相关 ————————
//自动登录
//#define URL_user_auto_login @"/api/autoLogin"
////登录
//#define URL_user_login @"/api/login"
////用户详情
//#define URL_user_info_detail @"/api/user/info/detail"
////修改头像
//#define URL_user_info_change_photo @"/api/user/info/changephoto"
////注释
//#define URL_user_info_change @"/api/user/info/change"

#define URL_WEBSever  @"https://www.goabroad.club:81/dist/#/"
//国家是否开放
#define URL_check_bd_code     @"v1/check_bd_code"
//国家列表
#define URL_user_register_findcountry @"v1/country"
//短信接口
#define  URL_user_register_checkedCode @"v1/sms"
//注册
#define URL_user_register @"v1/user"
//登录
#define URL_user_login @"v1/user"
//忘记密码
#define URL_user_verify @"v1/user_verify"
//更新用户资料
#define URL_user_personInfo @"v1/user_data"
//创建圈子
#define URL_create_Circle @"v1/circle"
//圈子列表
#define URL_circle_list @"v1/circle_list"
//加入圈子
#define URL_join_circle @"v1/circle_ope"
//更新圈子
#define URL_update_circle @"v1/circle_put"
//动态列表
#define URL_dynamic_list @"v1/dynamic_list"
//发布动态
#define  URL_create_dynamic @"v1/dynamic"
//发布商品
#define URL_create_goods  @"v1/goods"
//获取商品列表
#define URL_goods_list  @"v1/goods_list"
//发布房源
#define URL_create_house @"v1/house"
//房源列表
#define URL_house_list @"v1/house_list"
//资讯列表
#define URL_infomation_list @"v1/portal_list"
//发布学术
#define URL_create_academic @"v1/academic"
//学术列表
#define URL_academic_list @"v1/academic_list"
//他的信息列表
#define URL_other_list  @"v1/user_info"
//他的动态列表
#define URL_other_dynamic_list @"v1/others_dynamic_list"
//他的商品
#define URL_other_goods_list  @"v1/others_goods_list"
//他的房源
#define URL_other_house_list  @"v1/others_house_list"
//他的学术
#define URL_other_academic_list @"v1/others_academic_list"
//他的圈子列表
#define URL_other_circle_list @"v1/others_circle_list"
//机构列表
#define URL_organize_list     @"v1/organize_list"
//获取方向
#define URL_direction_list   @"v1/study_screen"
//获取学校列表
#define URL_university_list @"v1/school_list"
//我的关注
#define URL_attention_list  @"v1/user_att"
//收藏商品
#define URL_collection_goods_list @"v1/collect_goods"
//收藏房源
#define URL_collection_house_list @"v1/collect_house"
//收藏学术
#define URL_collection_academic_list @"v1/collect_academic"
//商品编辑
#define URL_goods_info_edit     @"v1/goods_put"
//房源编辑
#define URL_house_info_edit     @"v1/house_put"
//用户相关gas信息
#define URL_gas_info           @"v1/user_gas"
//用户密码修改
#define URL_update_password    @"v1/user_editpass"
//设置支付密码
#define URL_set_payment        @"v1/user_strring"
//修改支付密码
#define URL_update_payment     @"v1/user_paypass"
//判断是否设置支付密码
#define URL_isSet_Payment      @"v1/user_checkpass"
//获取验证码
#define URL_Get_checked        @"v1/binding_code"
//圈子成员列表
#define URL_GET_circle_MemberList @"v1/circle_member_list"
//圈子邀请加入
#define URL_circle_joinin      @"v1/circle_ope_invite"
//圈子成员删除
#define URL_memberList_del     @"v1/circle_member_list"
//圈子设置为私密
#define URL_private_circle     @"v1/circle_set_status"
//设置加入圈子权限
#define URL_addCircle_authority @"v1/circle_set_ju"
//邀请他人加入圈子
#define URL_others_joinin_circle  @"v1/invite_circle_list"
//消息模块
//圈子消息
#define URL_circle_information   @"v1/circle_info_list"
//评论通知--动态
#define URL_dynamic_commentList   @"v1/dynamic_comment_info_list"
//评论通知--商品
#define URL_goods_commentList    @"v1/goods_comment_info_list"
//评论通知--学术
#define URL_science_commentList  @"v1/academic_comment_info_list"
//评论通知--房源
#define URL_house_commentList    @"v1/house_comment_info_list"
//智能优选提交页
#define URL_best_GoodChoice      @"v1/capacity_choose"
//消息推文
#define URL_activity_msg_list    @"v1/activity_msg_list"
//未读消息
#define URL_unread_info_count    @"v1/unread_info_count"
//列表页已读消息
#define URL_unread_info_set_list_count @"v1/unread_info_set_list_count"
//详情页已读消息
#define URl_unread_info_set_count @"v1/unread_info_set_count"
//用户同意加入圈子
#define URL_circle_userAgreement @"v1/circle_info_is_agree"
//是否允许邀请别人加入圈子
#define URL_circle_invite_others @"v1/circle_set_invite_others"
//动态列表-关注
#define URL_dynamic_list_attention @"v1/dynamic_list_attention"
//动态列表-推荐
#define URL_dynamic_list_recommend @"v1/dynamic_list_recommend"
//相关机构(学校详情)
#define URL_school_organize_list   @"v1/school_organize_list"
//相关学校(机构详情)
#define URL_organize_school_list   @"v1/organize_school_list"
//动态点赞
#define URL_dynamic_like           @"v1/dynamic_like"
//实名认证
#define URL_real_name_auth         @"v1/real_name_auth"
//已实名认证
#define URL_real_name_auth_info    @"v1/real_name_auth_info"
//i企业认证
#define URL_enterprise_checked     @"v1/enterprise_auth"
//获取电话区号
#define URL_country_phone_code     @"v1/country_phone_code"
//获取个人信息
#define URL_user_own_info          @"v1/user_own_info"
//企业认证审核中
#define URL_enterprise_check_info  @"v1/enterprise_auth_check_info"
//企业认证成功
#define URL_enterprise_auth_info   @"v1/enterprise_auth_info"
//企业认证失败
#define URL_enterprise_check_no_pass_info @"v1/enterprise_auth_check_no_pass_info"
//系统消息
#define URL_system_msg_list         @"v1/system_msg_list"
//
#define URL_study_abroad_list       @"v1/study_abroad_list"
//提交反馈
#define URL_feedback                @"v1/feedback"
//热搜榜
#define URL_circle_list_keyword     @"v1/circle_list_keyword"
//热度榜
#define URL_circle_list_heat        @"v1/circle_list_heat"
//热门机构
#define URL_organize_hot_list       @"v1/organize_hot_list"
//热门学校
#define URL_school_hot_list         @"v1/school_hot_list"
//上传下载学术文件
#define URL_upload_file             @"v1/upload"
//标签列表类别
#define URL_circle_label_type       @"v1/circle_label_type_ios"
//获取标签列表
#define URL_circle_label_list_ios   @"v1/circle_label_list_ios"
//获取标签信息
#define URL_circle_label            @"v1/circle_label"
//获取（推荐/最新）标签列表
#define URL_circle_list_in_label    @"v1/circle_list_in_label"
//获取系统推荐标签
#define URL_circle_label_recommend_list @"v1/circle_label_recommend_list"
//上传学术文件路径÷÷
#define URL_download_academic       @"v1/download_academic"
//热搜榜
#define URL_circle_list_keyword     @"v1/circle_list_keyword"
//热度榜
#define URL_circle_list_heat        @"v1/circle_list_heat"
//热门机构
#define URL_organize_hot_list       @"v1/organize_hot_list"
//热门学校
#define URL_school_hot_list         @"v1/school_hot_list"
//国家区号
#define URL_country_phone_code      @"v1/country_phone_code"
//圈子点赞
#define URL_circle_likes            @"v1/circle_likes"
//动态搜索关键词
#define URL_dynamic_list_keyword    @"v1/dynamic_list_keyword"

#endif /* URLMacros_h */
