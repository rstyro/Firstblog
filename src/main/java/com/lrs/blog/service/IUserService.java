package com.lrs.blog.service;

import java.util.Map;

import com.lrs.util.ParameterMap;

public interface IUserService {
	
	/**
	 * 获取用户信息
	 * @param pm
	 * @return
	 */
	public Map<String,Object> getUserInfo(ParameterMap pm);
	
	/**
	 * 获取用户基本信息
	 * @param pm
	 * @return
	 */
	public Map<String,Object> getUserBasicInfo(ParameterMap pm);
	
	/**
	 * 登陆
	 * @param pm
	 * @return
	 */
	public Map<String,Object> login(ParameterMap pm);
	
	
	/**
	 * 注册
	 * @param pm
	 * @return
	 */
	public Map<String,Object> register(ParameterMap pm);
	
	
	/**
	 * 激活账号
	 * @param pm
	 * @return
	 */
	public Map<String,Object> unlock(ParameterMap pm);
	
	
	/**
	 * 找回密码发送的验证码
	 * @param pm
	 * @return
	 */
	public Map<String,Object> sendCode(ParameterMap pm);
	
	
	/**
	 * 找回密码
	 * @param pm
	 * @return
	 */
	public Map<String,Object> resetPasw(ParameterMap pm);
	
	/**
	 * 退出
	 * @param pm
	 * @return
	 */
	public Map<String,Object> logout(ParameterMap pm);
	
	/**
	 * 回调
	 * @param pm
	 * @return
	 */
	public Map<String,Object> qqredirect(ParameterMap pm);
	
	public Map<String,Object> weiboredirect(ParameterMap pm);
	
	public Map<String,Object> weixinredirect(ParameterMap pm);
	
	/**
	 * 是否关注了
	 * @param pm
	 * @return
	 */
	public ParameterMap repeatConcern(ParameterMap pm);
}
