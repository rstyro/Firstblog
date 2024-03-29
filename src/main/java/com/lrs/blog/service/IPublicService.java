package com.lrs.blog.service;

import java.util.Map;

import com.lrs.util.ParameterMap;

public interface IPublicService {

	/**
	 * 保存浏览记录
	 * 
	 * @param pm
	 * @return
	 */
	public int saveBrowse(ParameterMap pm);

	/**
	 * 保存点赞记录
	 * 
	 * @param pm
	 * @return
	 */
	public Map<String, Object> savePraise(ParameterMap pm);

	/**
	 * 关注
	 * 
	 * @param pm
	 * @return
	 */
	public Map<String, Object> concern(ParameterMap pm);

	/**
	 * 留言
	 * 
	 * @param pm
	 * @return
	 */
	public Map<String, Object> leaveword(ParameterMap pm);

	/**
	 * 评论
	 * 
	 * @param pm
	 * @return
	 */
	public Map<String, Object> comment(ParameterMap pm);

	/**
	 * 私信
	 * 
	 * @param pm
	 * @return
	 */
	public Map<String, Object> letter(ParameterMap pm);

	/**
	 * 获取评论
	 * 
	 * @param pm
	 * @return
	 */
	public Map<String, Object> getComment(ParameterMap pm);

	/**
	 * 删除评论
	 * 
	 * @param pm
	 * @return
	 */
	public Map<String, Object> delComment(ParameterMap pm);

	public Map<String, Object> test(ParameterMap pm);
}
