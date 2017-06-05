package com.lrs.blog.service;

import java.util.List;

import com.lrs.plugin.Page;
import com.lrs.util.ParameterMap;

public interface IArticleService {

	/**
	 * 获取文章归档
	 * 
	 * @param pm
	 * @return
	 * @throws Exception
	 */
	public List<ParameterMap> getArticleMonthNum(ParameterMap pm) throws Exception;

	/**
	 * 获取文章列表
	 * 
	 * @param page
	 * @return
	 * @throws Exception
	 */
	public List<ParameterMap> getArticlelistPage(Page page) throws Exception;

	/**
	 * 获取标签文章列表
	 * 
	 * @param pm
	 * @return
	 * @throws Exception
	 */
	public List<ParameterMap> getLabelArticleListPage(ParameterMap pm) throws Exception;

	public List<ParameterMap> getRecommendArticle(ParameterMap pm) throws Exception;

	public List<ParameterMap> gethotArticle(ParameterMap pm) throws Exception;

	/**
	 * 获取大屏幕励志语
	 * 
	 * @param pm
	 * @return
	 * @throws Exception
	 */
	public ParameterMap getJumbotron(ParameterMap pm) throws Exception;

	/**
	 * 获取文章详情
	 * 
	 * @param pm
	 * @return
	 * @throws Exception
	 */
	public ParameterMap getArticleDetail(ParameterMap pm) throws Exception;

	/**
	 * 保存文章
	 * 
	 * @param pm
	 * @return
	 * @throws Exception
	 */
	public int saveArticle(ParameterMap pm) throws Exception;

	/**
	 * 保存文章
	 * 
	 * @param pm
	 * @return
	 * @throws Exception
	 */
	public int updateArticle(ParameterMap pm) throws Exception;

	/**
	 * 删除文章
	 * 
	 * @param pm
	 * @return
	 * @throws Exception
	 */
	public int delArticle(ParameterMap pm) throws Exception;
}
