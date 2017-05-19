package com.lrs.util;

public class Const {
	
	public static final String PAGE	= "config/PAGE.txt";								//分页条数配置路径
	public static final String INTERCEPTOR_PATH = ".*/((article)|(page)).*";			//匹配该值的访问路径拦截（正则）
	
	//用户默认头像
	public static final String BLOG_USER_DEFAULT_PATH = "upload/user/default";			//默认头像路径
	
	//下面是SESSION key
	public static final String BLOG_USER_SESSION="BLOG_USER_SESSION";					//用户session key
	public static final String BLOG_LAST_URL="BLOG_LAST_URL";							//记录上一个请求的url session Key
	public static final String BLOG_LEAVEWORD_INDEX="BLOG_LEAVEWORD_INDEX";				//匿名留言次数限制session Key
	public static final String BLOG_ARTICLE_PRAISE_INDEX_="BLOG_ARTICLE_PRAISE_INDEX_";					//匿名点赞次数限制session Key
	public static final String BLOG_COMMENT_PRAISE_INDEX_="BLOG_COMMENT_PRAISE_INDEX_";					//匿名点赞次数限制session Key
	public static final String BLOG_COMMENT_INDEX="BLOG_COMMENT_INDEX";					//匿名评论次数限制session Key
	public static final String BLOG_ANONYM_USER_SESSION="BLOG_ANONYM_USER_SESSION";		//匿名用户session Key
	
	public static final String BLOG_REGISTER_INDEX="BLOG_REGISTER_INDEX";				//ip 每天注册限制 session Key
	
	
	//刷新缓存的相对路径
	public static final String RELOAD_HOME_ARTICLE="/reload/homeArticle";	
	public static final String RELOAD_MONTH_ARTICLE="/reload/monthArticle";	
	public static final String RELOAD_LABEL_ARTICLE="/reload/labelArticle";	
	public static final String RELOAD_RECOMMEND_ARTICLE="/reload/recommendArticle";	
	
	
	//盐
	//可参考:https://my.oschina.net/heroShane/blog/203452   
	public static final String SALT = "blog_as_salt";
	
	//下面是文章缓存前缀
	public static final String ARTICLE_HOME="ARTICLE_HOME";						//文章首页
	public static final String ARTICLE_LABEL="ARTICLE_LABEL";					//文章的所有标签列表
	public static final String ARTICLE_MONTH="ARTICLE_MONTH";					//文章的归档列表
	public static final String ARTICLE_RECOMMEND="ARTICLE_RECOMMEND";			//推荐文章列表
	public static final String ARTICLE_HOT="ARTICLE_HOT";						//热门文章列表
	
	public static final String MUSIC_LIST="MUSIC_LIST";							//音乐列表
	
	public static final String ARTICLE_LABEL_="ARTICLE_LABEL_";					//标签下的文章列表
	public static final String ARTICLE_MONTH_="ARTICLE_MONTH_";		
	//归档下的文字列表
	public static final String BLOG_FRIEND_LINK="BLOG_FRIEND_LINK";				//友情链接
	
	//博主标签
	public static final String BLOG_USER_LABEL_="BLOG_USER_LABEL_";					//博主标签
	
	
	//热门搜索缓存的id 
	public static final String HOT_ARTICLE_ID_LIST="HOT_ARTICLE_ID_LIST";					//归档下的文字列表
	
	
}
