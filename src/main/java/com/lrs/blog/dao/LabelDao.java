package com.lrs.blog.dao;

import java.util.List;

import com.lrs.util.ParameterMap;

public interface LabelDao {
	/**
	 * 获取文章的所有标签
	 * @param pm
	 * @return
	 */
	public List<ParameterMap> getArticleLabels(ParameterMap pm);
	
	/**
	 * 获取单个文章的标签
	 * @param pm
	 * @return
	 */
	public List<ParameterMap> getArticleLabelById(ParameterMap pm);
	
	/**
	 * 批量插入数据
	 * @param list
	 * @return
	 */
	public int batchSaveArticleLabel(List<ParameterMap> list);
	
	/**
	 * 删除标签
	 * @param pm
	 * @return
	 */
	public int delArticleLabel(ParameterMap pm);
}
