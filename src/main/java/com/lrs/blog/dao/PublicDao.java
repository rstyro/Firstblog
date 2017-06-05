package com.lrs.blog.dao;

import java.util.List;

import com.lrs.plugin.Page;
import com.lrs.util.ParameterMap;

public interface PublicDao {
	/**
	 * 保存浏览记录
	 * 
	 * @param pm
	 * @return
	 */
	public int saveBrowse(ParameterMap pm);

	/**
	 * 关注
	 * 
	 * @param pm
	 * @return
	 */
	public int saveConcern(ParameterMap pm);

	/**
	 * 更改浏览数
	 * 
	 * @param pm
	 * @return
	 */
	public int updateBrowseNum(ParameterMap pm);

	/**
	 * 保存点赞记录
	 * 
	 * @param pm
	 * @return
	 */
	public int savePraise(ParameterMap pm);

	/**
	 * 保存评论
	 * 
	 * @param pm
	 * @return
	 */
	public int saveComment(ParameterMap pm);

	/**
	 * 保存留言
	 * 
	 * @param pm
	 * @return
	 */
	public int saveLeaveWord(ParameterMap pm);

	/**
	 * 删除点赞记录
	 * 
	 * @param pm
	 * @return
	 */
	public int delPraise(ParameterMap pm);

	/**
	 * 删除评论
	 * 
	 * @param pm
	 * @return
	 */
	public int delComment(ParameterMap pm);

	/**
	 * 取消关注
	 * 
	 * @param pm
	 * @return
	 */
	public int delConcern(ParameterMap pm);

	/**
	 * 更改点赞数
	 * 
	 * @param pm
	 * @return
	 */
	public int updatePraiseNum(ParameterMap pm);

	/**
	 * 更改评论数
	 * 
	 * @param pm
	 * @return
	 */
	public int updateCommentNum(ParameterMap pm);

	/**
	 * 是否重复点赞
	 * 
	 * @param pm
	 * @return
	 */
	public ParameterMap repeatPraise(ParameterMap pm);

	/**
	 * 是否重复关注
	 * 
	 * @param pm
	 * @return
	 */
	public ParameterMap repeatConcern(ParameterMap pm);

	/**
	 * 检测是否是楼层评论
	 * 
	 * @param pm
	 * @return
	 */
	public ParameterMap checkCommentId(ParameterMap pm);

	/**
	 * 获取楼主的评论
	 * 
	 * @param pm
	 * @return
	 */
	public List<ParameterMap> getCommentlistPage(Page page);

	/**
	 * 获取回复楼主的评论
	 * 
	 * @param page
	 * @return
	 */
	public List<ParameterMap> getCommentlist(ParameterMap pm);

	/**
	 * 文章的作者iD
	 * 
	 * @param pm
	 * @return
	 */
	public ParameterMap getArticleAutherId(ParameterMap pm);

}
