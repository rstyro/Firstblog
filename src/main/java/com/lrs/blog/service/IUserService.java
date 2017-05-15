package com.lrs.blog.service;

import java.util.Map;

import com.lrs.util.ParameterMap;

public interface IUserService {
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
}
