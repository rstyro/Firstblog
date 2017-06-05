package com.lrs.blog.dao;

import java.util.List;

import com.lrs.util.ParameterMap;

public interface AdminDao {

	/**
	 * 获取一级菜单列表
	 * 
	 * @return
	 */
	public List<ParameterMap> getFirstMenuList(ParameterMap pm);

	/**
	 * 获取二级菜单列表
	 * 
	 * @return
	 */
	public List<ParameterMap> getSecondMenuList(ParameterMap pm);

}
