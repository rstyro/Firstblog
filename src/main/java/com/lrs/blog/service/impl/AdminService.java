package com.lrs.blog.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lrs.blog.dao.AdminDao;
import com.lrs.blog.service.IAdminService;
import com.lrs.util.ParameterMap;

@Service
public class AdminService implements IAdminService {

	@Autowired
	private AdminDao adminDao;
	
	@Override
	public List<ParameterMap> getMenuList(ParameterMap pm) {
		List<ParameterMap> firstMenuList = adminDao.getFirstMenuList(pm);
		List<ParameterMap> secondMenuList = adminDao.getSecondMenuList(pm);
		Map<String,List<ParameterMap>> tmp = new HashMap<>();
		//整理二级菜单
		for(ParameterMap second:secondMenuList){
			if(tmp.containsKey(second.getString("parent_id"))){
				tmp.get(second.getString("parent_id")).add(second);
			}else{
				List<ParameterMap> list = new ArrayList<>();
				list.add(second);
				tmp.put(second.getString("parent_id"), list);
			}
		}
		//给一级菜单加二级菜单
		for(ParameterMap ptm:firstMenuList){
			if(tmp.containsKey(ptm.getString("menu_id"))){
				ptm.put("second_menu", tmp.get(ptm.getString("menu_id")));
			}else{
				ptm.put("second_menu", new ArrayList<>());
			}
		}
		
		return firstMenuList;
	}

	@Override
	public List<ParameterMap> getHotMenuList(ParameterMap pm) {
		pm.put("is_hot", "1");
		return adminDao.getSecondMenuList(pm);
	}

}
