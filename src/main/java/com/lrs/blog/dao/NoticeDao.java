package com.lrs.blog.dao;

import java.util.List;

import com.lrs.plugin.Page;
import com.lrs.util.ParameterMap;

public interface NoticeDao {
	
	public List<ParameterMap> getNoticelistPage(Page page);
	
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
}
