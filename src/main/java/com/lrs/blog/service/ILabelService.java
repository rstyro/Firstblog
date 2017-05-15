package com.lrs.blog.service;

import java.util.List;

import com.lrs.util.ParameterMap;

public interface ILabelService {
	/**
	 * 获取文章的所有标签
	 * @return
	 */
	public List<ParameterMap> getArticleLabels (ParameterMap pm) throws Exception;
	
	
	/**
	 * 删除文章标签
	 * @param pm
	 * @return
	 * @throws Exception
	 */
	public int delArticleLabel(ParameterMap pm) throws Exception;
}
