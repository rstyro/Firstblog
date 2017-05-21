package com.lrs.blog.service;

import java.util.List;

import com.lrs.util.ParameterMap;

public interface IAdminService {
	
	/**
	 * 获取一级菜单和二级菜单
	 * @return
	 */
	public List<ParameterMap> getMenuList(ParameterMap pm);
	
	/**
	 * 获取常用的二级菜单列表
	 * @return
	 */
	public List<ParameterMap> getHotMenuList(ParameterMap pm);
}
