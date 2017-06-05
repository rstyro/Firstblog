package com.lrs.blog.dao;

import java.util.List;

import com.lrs.util.ParameterMap;

public interface CacheDao {

	/**
	 * 音乐列表
	 * 
	 * @param pm
	 * @return
	 */
	public List<ParameterMap> findMusiclist(ParameterMap pm);

	/**
	 * 友情链接
	 * 
	 * @param pm
	 * @return
	 */
	public List<ParameterMap> friendlinkList(ParameterMap pm);
}
