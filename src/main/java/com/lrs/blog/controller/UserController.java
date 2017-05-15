package com.lrs.blog.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lrs.blog.controller.base.BaseController;
import com.lrs.blog.service.IUserService;
import com.lrs.util.MyUtil;
import com.lrs.util.ParameterMap;

@Controller
@RequestMapping("/user")
public class UserController extends BaseController{
	
	@Autowired
	private IUserService userService;
	
	/**
	 * 登陆
	 * @return
	 */
	@RequestMapping(value="/login",method=RequestMethod.POST)
	@ResponseBody
	public Object login() {
		ParameterMap pm = this.getParameterMap();
		System.out.println("pm="+pm);
		pm.put("ip", this.getRemortIP());
		Map<String, Object> map = userService.login(pm);
		return MyUtil.returnObject(pm, map);
	}
	
	
	/**
	 * 注册
	 * @return
	 */
	@RequestMapping(value="/register",method=RequestMethod.POST)
	@ResponseBody
	public Object register() {
		ParameterMap pm = this.getParameterMap();
		System.out.println("pm="+pm);
		pm.put("servletContent", this.getServletContent());
		pm.put("ip", this.getRemortIP());
		Map<String, Object> map = userService.register(pm);
		return MyUtil.returnObject(pm, map);
	}
	
	
	/**
	 * 解锁,激活
	 * @return
	 */
	@RequestMapping(value="/unlock",method=RequestMethod.GET)
	@ResponseBody
	public Object unlock() {
		ParameterMap pm = this.getParameterMap();
		System.out.println("pm="+pm);
		pm.put("ip", this.getRemortIP());
		pm.put("servletContent", this.getServletContent());
		Map<String, Object> map = userService.unlock(pm);
		return MyUtil.returnObject(pm, map);
	}
	
	
	/**
	 * 发送验证码
	 * @return
	 */
	@RequestMapping(value="/sendCode",method=RequestMethod.POST)
	@ResponseBody
	public Object sendCode() {
		ParameterMap pm = this.getParameterMap();
		System.out.println("pm="+pm);
		pm.put("ip", this.getRemortIP());
		Map<String, Object> map = userService.sendCode(pm);
		return MyUtil.returnObject(pm, map);
	}
	
	
	
	
	/**
	 * 找回密码
	 * @return
	 */
	@RequestMapping(value="/resetPsw",method=RequestMethod.POST)
	@ResponseBody
	public Object resetPsw() {
		ParameterMap pm = this.getParameterMap();
		System.out.println("pm="+pm);
		pm.put("ip", this.getRemortIP());
		Map<String, Object> map = userService.resetPasw(pm);
		return MyUtil.returnObject(pm, map);
	}
	
	
	
	/**
	 * 第三方登陆
	 * @return
	 */
	@RequestMapping(value="/thirdlogin",method=RequestMethod.POST)
	@ResponseBody
	public Object thirdlogin() {
		ParameterMap pm = this.getParameterMap();
		System.out.println("pm="+pm);
		pm.put("ip", this.getRemortIP());
		Map<String, Object> map = userService.login(pm);
		return MyUtil.returnObject(pm, map);
	}
	
	/**
	 * 退出登录
	 * @return
	 */
	@RequestMapping(value="/logout",method=RequestMethod.GET)
	@ResponseBody
	public Object logout() {
		ParameterMap pm = this.getParameterMap();
		System.out.println("pm="+pm);
		Map<String, Object> map = userService.logout(pm);
		return MyUtil.returnObject(pm, map);
	}
}
