package com.lrs.blog.dao;

import java.util.List;

import com.lrs.plugin.Page;
import com.lrs.util.ParameterMap;

public interface NoticeDao {
	
	public List<ParameterMap> getNoticelistPage(Page page);
	
	public List<ParameterMap> getCommentlistPage(Page page);
	
	/**
	 * 获取消息个数
	 * @param pm
	 * @return
	 */
	public ParameterMap getNoticeNum(ParameterMap pm);
	
	/**
	 * 获取信件详情列表
	 * @param pm
	 * @return
	 */
	public List<ParameterMap> getLetterDetailList(ParameterMap pm);
	
	/**
	 * 保存信件
	 * @param pm
	 * @return
	 */
	public int saveLetter(ParameterMap pm);
	/**
	 * 保存消息
	 * @param pm
	 * @return
	 */
	public int saveNotice(ParameterMap pm);
	
	/**
	 * 更新状态
	 * @param pm
	 * @return
	 */
	public int updateNoticeStatus(ParameterMap pm);
	
	/**
	 * 删除消息
	 * @param pm
	 * @return
	 */
	public int delNotice(ParameterMap pm);
}
