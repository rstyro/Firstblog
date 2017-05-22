package com.lrs.blog.service;

import java.util.Map;

import com.lrs.util.ParameterMap;

public interface INoticeService {
	
	/**
	 * 获取消息列表
	 * @param pm
	 * @return
	 */
	public Map<String,Object> getNoticeListByType(ParameterMap pm);
}
