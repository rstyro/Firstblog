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
	
	
	public Map<String,Object> getCommentNoticeList(ParameterMap pm);
	
	public Map<String,Object> getLetterDetail(ParameterMap pm);
	
	public Map<String,Object> replyLetter(ParameterMap pm);
	
	
	public Map<String,Object> delNotice(ParameterMap pm);
}
