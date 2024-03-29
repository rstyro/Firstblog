package com.lrs.blog.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.lrs.blog.controller.base.BaseController;
import com.lrs.blog.entity.User;
import com.lrs.blog.service.ICacheService;
import com.lrs.blog.service.IUserService;
import com.lrs.util.Const;
import com.lrs.util.MyUtil;
import com.lrs.util.ParameterMap;

@Controller
@RequestMapping("/user")
public class UserController extends BaseController {

	@Autowired
	private IUserService userService;

	@Autowired
	private ICacheService cacheService;
	
	/**
	 * 去用户的页面
	 * 
	 * @param userId
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/{userId}/{pageNo}", method = RequestMethod.GET)
	public ModelAndView toUser(@PathVariable(value = "userId") String userId,
			@PathVariable(value = "pageNo") String pageNo) {
		System.out.println("comment in...");
		ModelAndView view = this.getModelAndView();
		ParameterMap pm = this.getParameterMap();
		pm.put("user_id", userId);
		pm.put("page_no", pageNo);
		pm.put("page_size", "10");
		if (StringUtils.isBlank(pageNo)) {
			pm.put("page_no", "1");
		}
		if (!StringUtils.isNumeric(pageNo)) {
			return this.get404ModelAndView();
		}
		Map<String, Object> map = userService.getUserInfo(pm);
		ParameterMap userInfo = (ParameterMap) map.get("userInfo");
		List<ParameterMap> articleList = (List<ParameterMap>) map.get("articleList");
		List<ParameterMap> userLabels = (List<ParameterMap>) map.get("userLabels");
		ParameterMap num =  (ParameterMap) map.get("totalPraiseNum");
		List<ParameterMap> labels=null;
		ParameterMap concern = null;
		Subject subject = SecurityUtils.getSubject();
		User u = (User) subject.getSession().getAttribute(Const.BLOG_USER_SESSION);
		if (u != null) {
			String meUserId = u.getUser_id();
			if (subject.isAuthenticated()) {
				pm.put("user_id", meUserId);
				pm.put("beconcern_user_id", userId);
				concern = userService.repeatConcern(pm);
				if (concern != null && concern.size() > 0) {
					concern.put("concern_flag", "1");
				}
			}
			this.getRequest().setAttribute("user_id", meUserId);
		}
		if (concern == null) {
			concern = new ParameterMap();
			concern.put("concern_flag", "0");
		}
		try {
			labels = cacheService.getCacheUserLabel(pm);
		} catch (Exception e) {
			e.printStackTrace();
			labels = new ArrayList<>();
		} 
		
		System.out.println("concern=" + concern);
		view.addObject("concern", concern);
		view.addObject("num", num);
		ParameterMap page = (ParameterMap) map.get("page");
		view.addObject("userInfo", userInfo);
		view.addObject("articles", articleList);
		view.addObject("userLabels", userLabels);
		view.addObject("labels", labels);
		view.addObject("page", page);
		view.setViewName("user/user");
		return view;
	}

	/**
	 * 登陆
	 * 
	 * @return
	 */
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	@ResponseBody
	public Object login() {
		ParameterMap pm = this.getParameterMap();
		System.out.println("pm=" + pm);
		pm.put("ip", this.getRemortIP());
		printLogger(this.log, "登录，ip="+this.getRemortIP());
		Map<String, Object> map = userService.login(pm);
		return MyUtil.returnObject(pm, map);
	}

	/**
	 * 注册
	 * 
	 * @return
	 */
	@RequestMapping(value = "/register", method = RequestMethod.POST)
	@ResponseBody
	public Object register() {
		ParameterMap pm = this.getParameterMap();
		System.out.println("pm=" + pm);
		pm.put("servletContent", this.getServletContent());
		pm.put("ip", this.getRemortIP());
		printLogger(this.log, "注册，ip="+this.getRemortIP());
		Map<String, Object> map = userService.register(pm);
		return MyUtil.returnObject(pm, map);
	}

	/**
	 * 解锁,激活
	 * 
	 * @return
	 */
	@RequestMapping(value = "/unlock", method = RequestMethod.GET)
	@ResponseBody
	public Object unlock() {
		ParameterMap pm = this.getParameterMap();
		System.out.println("pm=" + pm);
		pm.put("ip", this.getRemortIP());
		pm.put("servletContent", this.getServletContent());
		Map<String, Object> map = userService.unlock(pm);
		return MyUtil.returnObject(pm, map);
	}

	/**
	 * 发送验证码
	 * 
	 * @return
	 */
	@RequestMapping(value = "/sendCode", method = RequestMethod.POST)
	@ResponseBody
	public Object sendCode() {
		ParameterMap pm = this.getParameterMap();
		System.out.println("pm=" + pm);
		pm.put("ip", this.getRemortIP());
		Map<String, Object> map = userService.sendCode(pm);
		return MyUtil.returnObject(pm, map);
	}

	/**
	 * 找回密码
	 * 
	 * @return
	 */
	@RequestMapping(value = "/resetPsw", method = RequestMethod.POST)
	@ResponseBody
	public Object resetPsw() {
		ParameterMap pm = this.getParameterMap();
		System.out.println("pm=" + pm);
		pm.put("ip", this.getRemortIP());
		Map<String, Object> map = userService.resetPasw(pm);
		return MyUtil.returnObject(pm, map);
	}

	/**
	 * 第三方登陆
	 * 
	 * @return
	 */
	@RequestMapping(value = "/thirdlogin", method = RequestMethod.POST)
	@ResponseBody
	public Object thirdlogin() {
		ParameterMap pm = this.getParameterMap();
		System.out.println("pm=" + pm);
		pm.put("ip", this.getRemortIP());
		Map<String, Object> map = userService.login(pm);
		return MyUtil.returnObject(pm, map);
	}

	/**
	 * 退出登录
	 * 
	 * @return
	 */
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	@ResponseBody
	public Object logout() {
		ParameterMap pm = this.getParameterMap();
		System.out.println("pm=" + pm);
		Map<String, Object> map = userService.logout(pm);
		return MyUtil.returnObject(pm, map);
	}

	/**
	 * qq第三方回调
	 * 
	 * @return
	 */
	@RequestMapping(value = "/qqredirect", method = RequestMethod.GET)
	@ResponseBody
	public ModelAndView redirect() {
		ModelAndView view = this.getModelAndView();
		ParameterMap pm = this.getParameterMap();
		pm.put("ip", this.getRemortIP());
		System.out.println("pm=" + pm);
		userService.qqredirect(pm);
		view.setViewName("redirect");
		return view;
	}

	/**
	 * 微博第三方回调
	 * 
	 * @return
	 */
	@RequestMapping(value = "/weiboredirect", method = RequestMethod.GET)
	@ResponseBody
	public ModelAndView weiboredirect() {
		ModelAndView view = this.getModelAndView();
		ParameterMap pm = this.getParameterMap();
		pm.put("ip", this.getRemortIP());
		System.out.println("pm=" + pm);
		userService.weiboredirect(pm);
		view.setViewName("redirect");
		return view;
	}

	/**
	 * 更改用户信息
	 * 
	 * @return
	 */
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	@ResponseBody
	public Object upadate() {
		ParameterMap pm = this.getParameterMap();
		pm.put("ip", this.getRemortIP());
		Map<String, Object> map = userService.updateUserInfo(pm);
		return MyUtil.returnObject(pm, map);
	}

	/**
	 * 上传用户头像
	 * 
	 * @return
	 */
	@RequestMapping(value = "/uploadImg", method = RequestMethod.POST)
	@ResponseBody
	public Object uploadImg() {
		ParameterMap pm = this.getParameterMap();
		pm.put("ip", this.getRemortIP());
		Map<String, Object> map = userService.uploadUserImg(pm);
		return MyUtil.returnObject(pm, map);
	}

}
