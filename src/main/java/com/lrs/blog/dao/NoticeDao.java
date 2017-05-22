package com.lrs.blog.dao;

import java.util.List;

import com.lrs.plugin.Page;
import com.lrs.util.ParameterMap;

public interface NoticeDao {
	
	public List<ParameterMap> getNoticelistPage(Page page);
}
