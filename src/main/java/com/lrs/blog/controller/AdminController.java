package com.lrs.blog.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.lrs.blog.controller.base.BaseController;
import com.lrs.blog.service.IAdminService;
import com.lrs.util.ParameterMap;

@Controller
@RequestMapping(value="/admin")
public class AdminController extends BaseController{
	
	@Autowired
	private IAdminService adminService;
	
	/**
	 * 去控制台管理界面
	 * @return
	 */
	@RequestMapping(value="/index",method=RequestMethod.GET)
	public ModelAndView toAdminIndex(){
		ModelAndView view = this.getModelAndView();
		ParameterMap pm = this.getParameterMap();
		System.out.println(".............admin index");
		String ip = this.getRemortIP();
		log.info("进入控制台，ip="+ip);
		List<ParameterMap> menulist = adminService.getMenuList(pm);
		view.addObject("menulist", menulist);
		List<ParameterMap> menuhotlist = adminService.getHotMenuList(pm);
		view.addObject("menuhotlist", menuhotlist);
		view.setViewName("admin/index");
		return view;
	}
	
	
	/**
	 * 用户列表
	 * @return
	 */
	@RequestMapping(value="/author/list",method=RequestMethod.GET)
	public ModelAndView toUserList(){
		ModelAndView view = this.getModelAndView();
		System.out.println(".............admin userlist");
		String ip = this.getRemortIP();
		log.info("进入控制台，ip="+ip);
		view.setViewName("admin/author/list");
		return view;
	}
	/**
	 * 文章列表
	 * @return
	 */
	@RequestMapping(value="/article/list",method=RequestMethod.GET)
	public ModelAndView toArticleList(){
		ModelAndView view = this.getModelAndView();
		System.out.println(".............admin article");
		String ip = this.getRemortIP();
		log.info("进入控制台，ip="+ip);
		view.setViewName("admin/article/list");
		return view;
	}
	/**
	 * 标签列表
	 * @return
	 */
	@RequestMapping(value="/label/list",method=RequestMethod.GET)
	public ModelAndView tolabelList(){
		ModelAndView view = this.getModelAndView();
		System.out.println(".............admin label");
		String ip = this.getRemortIP();
		log.info("进入控制台，ip="+ip);
		view.setViewName("admin/label/list");
		return view;
	}
	
	/**
	 * top
	 * @return
	 */
	@RequestMapping(value="/top",method=RequestMethod.GET)
	public ModelAndView totop(){
		ModelAndView view = this.getModelAndView();
		System.out.println(".............admin left");
		view.setViewName("admin/top");
		return view;
	}

	/**
	 * left
	 * @return
	 */
	@RequestMapping(value="/left",method=RequestMethod.GET)
	public ModelAndView toleft(){
		ModelAndView view = this.getModelAndView();
		System.out.println(".............admin left");
		view.setViewName("admin/left");
		return view;
	}
	
	/**
	 * main
	 * @return
	 */
	@RequestMapping(value="/main",method=RequestMethod.GET)
	public ModelAndView toadminmain(){
		ModelAndView view = this.getModelAndView();
		System.out.println(".............admin login");
		view.setViewName("admin/main");
		return view;
	}
	
	/**
	 * login
	 * @return
	 */
	@RequestMapping(value="/login",method=RequestMethod.GET)
	public ModelAndView toadminlogin(){
		ModelAndView view = this.getModelAndView();
		System.out.println(".............admin login");
		view.setViewName("admin/login");
		return view;
	}

}
