package com.lrs.blog.controller;

import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.imageio.ImageIO;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.druid.util.StringUtils;
import com.lrs.blog.controller.base.BaseController;
import com.lrs.blog.entity.User;
import com.lrs.blog.service.IArticleService;
import com.lrs.blog.service.ICacheService;
import com.lrs.blog.service.ILabelService;
import com.lrs.blog.service.IUserService;
import com.lrs.plugin.Page;
import com.lrs.util.CodeUtil;
import com.lrs.util.Const;
import com.lrs.util.MyUtil;
import com.lrs.util.ParameterMap;

/**
 * 页面掉转控制器
 *
 */
@Controller
public class PageController extends BaseController{
	
	@Autowired
	private ILabelService labelService;
	
	
	@Autowired
	private IArticleService articleService;
	
	@Autowired
	private ICacheService cacheService;
	
	@Autowired
	private IUserService userService;
	
	/**
	 * 去首页
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/toIndex/{pageNo}",method=RequestMethod.GET)
	public ModelAndView toIndex(@PathVariable String pageNo){
		ModelAndView view = this.getModelAndView();
		ParameterMap pm = this.getParameterMap();
		List<ParameterMap> articleLabels=null;
		List<ParameterMap> articleMonthNum=null;
		List<ParameterMap> articleList=null;
		List<ParameterMap> articleRecomend = null;
		List<ParameterMap> linkList=null;
		List<ParameterMap> userLabels=null;
		ParameterMap userInfo=null;
		Page page = new Page();
		if(StringUtils.isNumber(pageNo)){
			page.setCurrentPage(Integer.parseInt(pageNo));
		}else{
			return this.get404ModelAndView();
		}
		try {
			
			articleLabels = cacheService.getCacheLabelArticle(pm);
			if(articleLabels == null || articleLabels.size() < 1){
				// 所有文章的标签
				articleLabels = labelService.getArticleLabels(pm);
				log.info("不是缓存获取");
			}
			articleMonthNum = cacheService.getCacheMonthArticle(pm);
			if(articleMonthNum == null || articleMonthNum.size() < 1){
				// 文章的归档
				articleMonthNum = articleService.getArticleMonthNum(pm);
				log.info("不是缓存获取");
			}
			
			//文章推荐
			articleRecomend = cacheService.getCacheRecommendArticle(pm);
			if(articleRecomend == null || articleRecomend.size() < 1){
				articleRecomend = articleService.getRecommendArticle(pm);
				log.info("不是缓存获取 文章推荐");
			}
			
			//友链
			try {
				linkList = (List<ParameterMap>) cacheService.getCacheLinks(pm);
			} catch (Exception e) {
				e.printStackTrace();
				linkList = new ArrayList<ParameterMap>();
			}
			
			page.setShowCount(6);
			page.setPm(pm);
			articleList = cacheService.getCacheAllArticle(pm);
			if(articleList == null || articleList.size() < 1){
				//获取首页文章列表
				articleList=articleService.getArticlelistPage(page);
				log.info("首页的文章不是缓存获取的");
			}else{
				articleList = MyUtil.getRusultList(articleList, page);
				log.info("首页的文章是缓存获取的");
			}
			pm.put("user_id", "1");
			Map<String,Object> userMap  = userService.getUserBasicInfo(pm);
			//博主信息
			try {
				
				userInfo =  (ParameterMap) userMap.get("userInfo");
			} catch (Exception e) {
				userInfo= new ParameterMap();
				e.printStackTrace();
				log.error("获取用户信息失败", e);
			}
			
			//博主信息
			try {
				userLabels = (List<ParameterMap>) userMap.get("userLabels");
			} catch (Exception e) {
				e.printStackTrace();
				userLabels = new ArrayList<ParameterMap>();
			}
			
			//
			ParameterMap concern = null;
			Subject subject = SecurityUtils.getSubject();
			User u = (User) subject.getSession().getAttribute(Const.BLOG_USER_SESSION);
			if(u != null){
				String userId = u.getUser_id();
				if(subject.isAuthenticated() && !"1".equals(userId)){
					pm.put("user_id", u.getUser_id());
					pm.put("beconcern_user_id", "1");
					concern = userService.repeatConcern(pm);
					if(concern != null && concern.size() > 0){
						concern.put("concern_flag", "1");
					}
				}
			}
			if(concern == null){
				concern=new ParameterMap();
				concern.put("concern_flag", "0");
			}
			System.out.println("concern="+concern);
			view.addObject("concern",concern);
			pm.put("type", "home");
			ParameterMap jumbotron = articleService.getJumbotron(pm);
			ParameterMap pmpage = new ParameterMap(page);
			view.addObject("page", pmpage);
			view.addObject("article_labels", articleLabels);
			view.addObject("article_month", articleMonthNum);
			view.addObject("articles", articleList);
			view.addObject("article_recommend", articleRecomend);
			view.addObject("linkList", linkList);
			view.addObject("jumbotron", jumbotron);
			view.addObject("userInfo", userInfo);
			view.addObject("userLabels", userLabels);
			System.out.println("pmpage="+pmpage);
			System.out.println(",page="+page);
			view.setViewName("index");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			log.error(e.getMessage(), e);
		}
		return view;
	}
	
	/**
	 * 登陆
	 * @return
	 */
	@RequestMapping(value="/toLogin",method=RequestMethod.GET)
	public ModelAndView toLogin(){
		ModelAndView view = this.getModelAndView();
		System.out.println(".............login");
		String ip = this.getRemortIP();
		log.info("有人访问登录页面，ip="+ip);
		view.setViewName("account/login");
		return view;
	}
	
	/**
	 * 注册
	 * @return
	 */
	@RequestMapping(value="/toRegister",method=RequestMethod.GET)
	public ModelAndView toRegister(){
		ModelAndView view = this.getModelAndView();
		System.out.println(".............register");
		String ip = this.getRemortIP();
		log.info("有人访问注册页面，ip="+ip);
		view.setViewName("account/register");
		return view;
	}
	
	
	/**
	 * 消息
	 * @return
	 */
	@RequestMapping(value="/toNotice",method=RequestMethod.GET)
	public ModelAndView toNotice(){
		ModelAndView view = this.getModelAndView();
		System.out.println(".............notice");
		String ip = this.getRemortIP();
		log.info("有人访问注册页面，ip="+ip);
		view.setViewName("user/notice");
		return view;
	}
	
	/**
	 * 生成验证码
	 */
	@RequestMapping(value="/code")
	public void code() {
		try {
			//获取图片
			Object[] img = CodeUtil.CreateCode();
		    BufferedImage image = (BufferedImage)img[0];
		    //输出到浏览器
		    this.getResponse().setContentType("image/png");
		    OutputStream os = this.getResponse().getOutputStream();
		    ImageIO.write(image, "png", os);
		    //用于验证的字符串存入session
		    this.getSession().setAttribute("code", img[1].toString());
		} catch (IOException e) {
			printLogger(this.log, "验证码输出异常");
		}
	}
	
	
	/**
	 * 找回密码
	 * @return
	 */
	@RequestMapping(value="/toResetPsw",method=RequestMethod.GET)
	public ModelAndView toResetPsw(){
		ModelAndView view = this.getModelAndView();
		String ip = this.getRemortIP();
		log.info("有人访问找回密码页面，ip="+ip);
		view.setViewName("account/resetPsw");
		return view;
	}
	
	
	/**
	 * 留言
	 * @return
	 */
	@RequestMapping(value="/toLeaveWord",method=RequestMethod.GET)
	public ModelAndView toLeaveWord(){
		ModelAndView view = this.getModelAndView();
		System.out.println(".............leaveWord");
		String ip = this.getRemortIP();
		log.info("有人访问留言页面，ip="+ip);
		view.setViewName("leaveword");
		return view;
	}
	
	/**
	 * 私信
	 * @return
	 */
	@RequestMapping(value="/toLetter",method=RequestMethod.GET)
	public ModelAndView toLetter(){
		ModelAndView view = this.getModelAndView();
		String ip = this.getRemortIP();
		log.info("有人访问写信页面，ip="+ip);
		Subject subject = SecurityUtils.getSubject();
		Session session = subject.getSession();
		session.setAttribute(Const.BLOG_LAST_URL, "/toLetter");
		if(subject.isAuthenticated()){
			
			view.setViewName("leaveword");
		}else{
			view.setViewName("account/login");
		}
		
		return view;
	}
	
	/**
	 * 搜索
	 * @param pageNo
	 * @return
	 */
	@RequestMapping(value="/toSearch/{pageNo}",method=RequestMethod.GET)
	public ModelAndView toSearch(@PathVariable String pageNo){
		ModelAndView view = this.getModelAndView();
		ParameterMap pm = this.getParameterMap();
		String ip = this.getRemortIP();
		log.info("有人访问搜索页面，ip="+ip);
		List<ParameterMap> articleRecomend = null;
		List<ParameterMap> articlehot  = null;
		List<ParameterMap> searchArticleList  = null;
		Page page = new Page();
		if(StringUtils.isNumber(pageNo)){
			page.setCurrentPage(Integer.parseInt(pageNo));
		}else{
			return this.get404ModelAndView();
		}
		try {
			//文章推荐
			articleRecomend = cacheService.getCacheRecommendArticle(pm);
			if(articleRecomend == null || articleRecomend.size() < 1){
				articleRecomend = articleService.getRecommendArticle(pm);
				log.info("不是缓存获取 文章推荐");
			}
			//热门搜索
			articlehot = cacheService.getCacheHotArticle(pm);
			if(articlehot == null || articlehot.size() < 1){
				articlehot = articleService.gethotArticle(pm);
				log.info("不是缓存获取 文章热门");
			}
			System.out.println("pm="+pm);
			//搜索结果
			page.setShowCount(10);
			page.setPm(pm);
			searchArticleList = articleService.getArticlelistPage(page);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			log.error("搜索erro:"+e.getMessage(), e);
		}
		ParameterMap pmpage = new ParameterMap(page);
		System.out.println("pmpage="+pmpage);
		view.addObject("page", pmpage);
		view.addObject("article_recommend", articleRecomend);
		view.addObject("article_hot", articlehot);
		view.addObject("article_search", searchArticleList);
		view.addObject("keyword", pm.getString("keyword"));
		view.setViewName("search");
		return view;
	}
	
	/**
	 * 音乐
	 * @return
	 */
	@RequestMapping(value="/toMusic",method=RequestMethod.GET)
	public ModelAndView toMusic(){
		ModelAndView view = this.getModelAndView();
		System.out.println(".............music");
		ParameterMap pm = this.getParameterMap();
		List<ParameterMap> musicList=null;
		try {
			musicList = (List<ParameterMap>) cacheService.findMusiclist(pm);
		} catch (Exception e) {
			e.printStackTrace();
			musicList = new ArrayList<ParameterMap>();
		}
		String ip = this.getRemortIP();
		log.info("有人访问音乐页面，ip="+ip);
		view.addObject("musicList",musicList );
		view.setViewName("music");
		return view;
	}
}
