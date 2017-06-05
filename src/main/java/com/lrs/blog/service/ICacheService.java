package com.lrs.blog.service;

import java.util.List;

import com.lrs.util.ParameterMap;

public interface ICacheService {
	/**
	 * 首页的文章缓存
	 * 
	 * @param pm
	 * @return
	 * @throws Exception
	 */
	public int cacheAllArticle(ParameterMap pm);

	/**
	 * 归档文章缓存
	 * 
	 * @param pm
	 * @return
	 * @throws Exception
	 */
	public int cacheMonthArticle(ParameterMap pm);

	/**
	 * 标签文章缓存
	 * 
	 * @param pm
	 * @return
	 * @throws Exception
	 */
	public int cacheLabelArticle(ParameterMap pm);

	/**
	 * 文章推荐缓存
	 * 
	 * @param pm
	 * @return
	 * @throws Exception
	 */
	public int cacheRecommendArticle(ParameterMap pm);

	/**
	 * 缓存音乐列表
	 * 
	 * @param pm
	 */
	public int cacheMusicList(ParameterMap pm);

	/**
	 * 缓存热门文章
	 * 
	 * @param pm
	 */
	public int cacheHotArticle(ParameterMap pm);

	/**
	 * 保存缓存中的热门ids
	 * 
	 * @param pm
	 * @return
	 */
	public int reloadArticleHotNum();

	/**
	 * 缓存友链
	 * 
	 * @return
	 */
	public int cacheFriendLink();

	/**
	 * 缓存博主标签
	 * 
	 * @return
	 */
	public int cacheBloggerLabel(ParameterMap pm);

	/**
	 * 获取博主标签
	 * 
	 * @param pm
	 * @return
	 * @throws Exception
	 */
	public List<ParameterMap> getCacheBloggerLabel(String userId) throws Exception;

	/**
	 * 获取音乐列表
	 * 
	 * @param pm
	 * @return
	 * @throws Exception
	 */
	public List<ParameterMap> findMusiclist(ParameterMap pm) throws Exception;

	/**
	 * 获取首页的文章缓存
	 * 
	 * @param pm
	 * @return
	 * @throws Exception
	 */
	public List<ParameterMap> getCacheAllArticle(ParameterMap pm) throws Exception;

	/**
	 * 获取归档文章缓存
	 * 
	 * @param pm
	 * @return
	 * @throws Exception
	 */
	public List<ParameterMap> getCacheMonthArticle(ParameterMap pm) throws Exception;

	/**
	 * 获取标签文章缓存
	 * 
	 * @param pm
	 * @return
	 * @throws Exception
	 */
	public List<ParameterMap> getCacheLabelArticle(ParameterMap pm) throws Exception;

	/**
	 * 获取文章推荐缓存
	 * 
	 * @param pm
	 * @return
	 * @throws Exception
	 */
	public List<ParameterMap> getCacheRecommendArticle(ParameterMap pm) throws Exception;

	/**
	 * 获取文章热门缓存
	 * 
	 * @param pm
	 * @return
	 * @throws Exception
	 */
	public List<ParameterMap> getCacheHotArticle(ParameterMap pm) throws Exception;

	/**
	 * 获取友情链接缓存
	 * 
	 * @param pm
	 * @return
	 * @throws Exception
	 */
	public List<ParameterMap> getCacheLinks(ParameterMap pm) throws Exception;
}
