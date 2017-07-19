package com.lrs.blog.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
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
import com.lrs.blog.service.IArticleService;
import com.lrs.blog.service.ICacheService;
import com.lrs.blog.service.ILabelService;
import com.lrs.blog.service.IUserService;
import com.lrs.plugin.Page;
import com.lrs.thread.ReloadThread;
import com.lrs.util.Const;
import com.lrs.util.DateUtil;
import com.lrs.util.MyUtil;
import com.lrs.util.ParameterMap;

/**
 * 文章控制器
 *
 */
@Controller
@RequestMapping("/article")
public class ArticleController extends BaseController {

	@Autowired
	private ILabelService labelService;

	@Autowired
	private IArticleService articleService;

	@Autowired
	private ICacheService cacheService;
	
	@Autowired
	private IUserService userService;

	/**
	 * 获取文章详情
	 * 
	 * @param articleId
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/{articleId}", method = RequestMethod.GET)
	public ModelAndView articleDetail(@PathVariable("articleId") String articleId) throws Exception {
		ModelAndView view = this.getModelAndView();
		try {
			ParameterMap pm = this.getParameterMap();
			System.out.println("articleId=" + articleId);
			int id = 0;
			try {
				id = Integer.parseInt(articleId);
			} catch (Exception e) {
				view.setViewName("error/404");
				return view;
			}
			try {
				Subject subject = SecurityUtils.getSubject();
				Session session = subject.getSession();
				User user = (User) session.getAttribute(Const.BLOG_USER_SESSION);
				if (user != null) {
					pm.put("user_id", user.getUser_id());
					view.addObject("user_id", user.getUser_id());
				} else {
					view.addObject("user_id", "");
				}
			} catch (Exception e) {
				// TODO: handle exception
			}
			pm.put("article_id", id);
			ParameterMap article = articleService.getArticleDetail(pm);
			if (article == null || article.size() < 1) {
				view.setViewName("error/404");
				return view;
			}
			long praise_flag = (long) article.get("praise_flag");
			System.out.println("praise_flag=" + praise_flag);
			if (praise_flag == 0) {
				Session session = SecurityUtils.getSubject().getSession();
				try {
					int index = (int) session.getAttribute(Const.BLOG_ARTICLE_PRAISE_INDEX_ + articleId);
					System.out.println("index=" + index);
					if (index > 0) {
						article.put("praise_flag", 1);
					}
				} catch (Exception e) {
				}
			}
			view.addObject("article", article);
			
			view.setViewName("article/article_detail");
			
			String viewTool = article.getString("view_tool");
			if("editormd".equalsIgnoreCase(viewTool)){
				view.setViewName("article/detail");
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			log.error(e.getMessage(), e);
		}
		return view;
	}

	/**
	 * 获取文章归档
	 * 
	 * @param articleId
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/month/{article_month}/{pageNo}", method = RequestMethod.GET)
	public ModelAndView articleMonth(@PathVariable("article_month") String articleMonth,
			@PathVariable("pageNo") String pageNo) throws Exception {
		ModelAndView view = this.getModelAndView();
		ParameterMap pm = this.getParameterMap();
		Page page = new Page();
		if (com.alibaba.druid.util.StringUtils.isNumber(pageNo)) {
			page.setCurrentPage(Integer.parseInt(pageNo));
		} else {
			return this.get404ModelAndView();
		}
		try {
			List<ParameterMap> articleLabels = null;
			List<ParameterMap> articleMonthNum = null;
			List<ParameterMap> articleList = null;
			List<ParameterMap> articleRecomend = null;

			articleLabels = cacheService.getCacheLabelArticle(pm);
			if (articleLabels == null || articleLabels.size() < 1) {
				// 所有文章的标签
				articleLabels = labelService.getArticleLabels(pm);
				log.info("不是缓存获取 所有文章的标签");
			}
			articleMonthNum = cacheService.getCacheMonthArticle(pm);
			if (articleMonthNum == null || articleMonthNum.size() < 1) {
				// 文章的归档
				articleMonthNum = articleService.getArticleMonthNum(pm);
				log.info("不是缓存获取 文章的归档");
			}

			// 文章推荐
			articleRecomend = cacheService.getCacheRecommendArticle(pm);
			if (articleRecomend == null || articleRecomend.size() < 1) {
				articleRecomend = articleService.getRecommendArticle(pm);
				log.info("不是缓存获取 文章推荐");
			}

			pm.put("article_month", articleMonth);
			page.setShowCount(6);
			page.setPm(pm);
			articleList = cacheService.getCacheMonthArticle(pm);
			if (articleList == null || articleList.size() < 1) {
				// 获取归档文章列表
				articleList = articleService.getArticlelistPage(page);
				log.info("不是缓存获取 归档文章列表");
			} else {
				articleList = MyUtil.getRusultList(articleList, page);
				log.info("缓存获取 归档文章列表");
			}
			
			List<ParameterMap> userLabels = null;
			ParameterMap userInfo = null;
			pm.put("user_id", "1");
			Map<String, Object> userMap = userService.getUserBasicInfo(pm);
			// 博主信息
			try {

				userInfo = (ParameterMap) userMap.get("userInfo");
			} catch (Exception e) {
				userInfo = new ParameterMap();
				e.printStackTrace();
				log.error("获取用户信息失败", e);
			}

			// 博主信息
			try {
				userLabels = (List<ParameterMap>) userMap.get("userLabels");
			} catch (Exception e) {
				e.printStackTrace();
				userLabels = new ArrayList<ParameterMap>();
			}
			view.addObject("userInfo", userInfo);
			view.addObject("userLabels", userLabels);

			ParameterMap concern = null;
			Subject subject = SecurityUtils.getSubject();
			User u = (User) subject.getSession().getAttribute(Const.BLOG_USER_SESSION);
			if (u != null) {
				String userId = u.getUser_id();
				if (subject.isAuthenticated() && !"1".equals(userId)) {
					pm.put("user_id", u.getUser_id());
					pm.put("beconcern_user_id", "1");
					concern = userService.repeatConcern(pm);
					if (concern != null && concern.size() > 0) {
						concern.put("concern_flag", "1");
					}
				}
			}
			if (concern == null) {
				concern = new ParameterMap();
				concern.put("concern_flag", "0");
			}
			view.addObject("concern", concern);
			
			// 友链
			List<ParameterMap> linkList = null;
			try {
				linkList = (List<ParameterMap>) cacheService.getCacheLinks(pm);
			} catch (Exception e) {
				e.printStackTrace();
				linkList = new ArrayList<ParameterMap>();
			}
			view.addObject("linkList", linkList);
			
			// 分页Map
			ParameterMap pmpage = new ParameterMap(page);
			pm.put("type", "month");
			ParameterMap jumbotron = articleService.getJumbotron(pm);
			view.addObject("article_labels", articleLabels);
			view.addObject("article_month", articleMonthNum);
			view.addObject("articles", articleList);
			view.addObject("article_recommend", articleRecomend);
			view.addObject("page", pmpage);
			view.addObject("jumbotron", jumbotron);
			view.addObject("title", articleMonth + " 的所有文章");
			System.out.println("pmpage=" + pmpage);
			System.out.println(",page=" + page);
		} catch (Exception e) {
			// TODO: handle exception
		}
		view.setViewName("article/article_month");
		return view;
	}

	/**
	 * 标签获取文章
	 * 
	 * @param articleId
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/label/{label_id}/{pageNo}", method = RequestMethod.GET)
	public ModelAndView articleLabel(@PathVariable("label_id") String labelId, @PathVariable("pageNo") String pageNo)
			throws Exception {
		ModelAndView view = this.getModelAndView();
		ParameterMap pm = this.getParameterMap();
		Page page = new Page();
		if (com.alibaba.druid.util.StringUtils.isNumber(pageNo)) {
			page.setCurrentPage(Integer.parseInt(pageNo));
		} else {
			return this.get404ModelAndView();
		}
		try {
			List<ParameterMap> articleLabels = null;
			List<ParameterMap> articleMonthNum = null;
			List<ParameterMap> articleList = null;
			List<ParameterMap> articleRecomend = null;
			articleLabels = cacheService.getCacheLabelArticle(pm);
			if (articleLabels == null || articleLabels.size() < 1) {
				// 所有文章的标签
				articleLabels = labelService.getArticleLabels(pm);
				log.info("不是缓存获取  所有文章的标签");
			}
			String title = "";
			for (ParameterMap temp : articleLabels) {
				if (temp.getString("label_id").equals(labelId)) {
					title = temp.getString("label_name") + " 标签的所有文章";
					break;
				}
			}
			articleMonthNum = cacheService.getCacheMonthArticle(pm);
			if (articleMonthNum == null || articleMonthNum.size() < 1) {
				// 文章的归档
				articleMonthNum = articleService.getArticleMonthNum(pm);
				log.info("不是缓存获取 文章的归档");
			}

			// 文章推荐
			articleRecomend = cacheService.getCacheRecommendArticle(pm);
			if (articleRecomend == null || articleRecomend.size() < 1) {
				articleRecomend = articleService.getRecommendArticle(pm);
				log.info("不是缓存获取 文章推荐");
			}

			pm.put("label_id", labelId);
			page.setShowCount(6);
			page.setPm(pm);
			articleList = cacheService.getCacheLabelArticle(pm);
			if (articleList == null || articleList.size() < 1) {
				// 获取标签文章列表
				articleList = articleService.getLabelArticleListPage(pm);
				log.info("不是缓存获取 标签文章列表");
			} else {
				log.info("缓存获取 标签文章列表");
			}
			// 分页
			articleList = MyUtil.getRusultList(articleList, page);
			
			List<ParameterMap> userLabels = null;
			ParameterMap userInfo = null;
			pm.put("user_id", "1");
			Map<String, Object> userMap = userService.getUserBasicInfo(pm);
			// 博主信息
			try {

				userInfo = (ParameterMap) userMap.get("userInfo");
			} catch (Exception e) {
				userInfo = new ParameterMap();
				e.printStackTrace();
				log.error("获取用户信息失败", e);
			}

			// 博主信息
			try {
				userLabels = (List<ParameterMap>) userMap.get("userLabels");
			} catch (Exception e) {
				e.printStackTrace();
				userLabels = new ArrayList<ParameterMap>();
			}
			view.addObject("userInfo", userInfo);
			view.addObject("userLabels", userLabels);
			
			ParameterMap concern = null;
			Subject subject = SecurityUtils.getSubject();
			User u = (User) subject.getSession().getAttribute(Const.BLOG_USER_SESSION);
			if (u != null) {
				String userId = u.getUser_id();
				if (subject.isAuthenticated() && !"1".equals(userId)) {
					pm.put("user_id", u.getUser_id());
					pm.put("beconcern_user_id", "1");
					concern = userService.repeatConcern(pm);
					if (concern != null && concern.size() > 0) {
						concern.put("concern_flag", "1");
					}
				}
			}
			if (concern == null) {
				concern = new ParameterMap();
				concern.put("concern_flag", "0");
			}
			view.addObject("concern", concern);
			
			// 友链
			List<ParameterMap> linkList = null;
			try {
				linkList = (List<ParameterMap>) cacheService.getCacheLinks(pm);
			} catch (Exception e) {
				e.printStackTrace();
				linkList = new ArrayList<ParameterMap>();
			}
			view.addObject("linkList", linkList);
			
			// 分页Map
			ParameterMap pmpage = new ParameterMap(page);
			pm.put("type", "label");
			ParameterMap jumbotron = articleService.getJumbotron(pm);
			view.addObject("article_labels", articleLabels);
			view.addObject("article_month", articleMonthNum);
			view.addObject("articles", articleList);
			view.addObject("article_recommend", articleRecomend);
			view.addObject("page", pmpage);
			view.addObject("jumbotron", jumbotron);
			view.addObject("title", title);
			System.out.println("label_pmpage=" + pmpage);
			System.out.println(",label_page=" + page);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		view.setViewName("article/article_label");
		return view;
	}

	/**
	 * 去新增文章
	 * 
	 * @param articleId
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/add/go", method = RequestMethod.GET)
	@ResponseBody
	public ModelAndView toAddArticle() throws Exception {
		ModelAndView view = this.getModelAndView();
		ParameterMap pm = this.getParameterMap();
		try {
			List<ParameterMap> articleLabels = null;
			articleLabels = cacheService.getCacheLabelArticle(pm);
			if (articleLabels == null || articleLabels.size() < 1) {
				// 所有文章的标签
				articleLabels = labelService.getArticleLabels(pm);
				log.info("不是缓存获取 所有文章的标签");
			} else {
				log.info("缓存获取 所有文章的标签");
			}
			view.addObject("labelList", articleLabels);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e.getMessage(), e);
		}
		
		view.setViewName("article/article_edit");
		Subject subject = SecurityUtils.getSubject();
		User  us = (User) subject.getSession().getAttribute(Const.BLOG_USER_SESSION);
		if(us != null ){
			String editTool = us.getEdit_tool();
			if("editormd".equalsIgnoreCase(editTool)){
				view.setViewName("article/edit");
			}
		}
		view.addObject("title", "写文章");
		view.addObject("btnValue", "发布文章");
		view.addObject("action", "add/new");
		return view;
	}

	/**
	 * 新增文章
	 * 
	 * @param articleId
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/add/new", method = RequestMethod.POST)
	@ResponseBody
	public ModelAndView addArticle() throws Exception {
		ModelAndView view = this.getModelAndView();
		ParameterMap pm = this.getParameterMap();
		try {
			Subject subject = SecurityUtils.getSubject();
			Session session = subject.getSession();
			User user = (User) session.getAttribute(Const.BLOG_USER_SESSION);
			String userId = user.getUser_id();
			String editTool = user.getEdit_tool();
			pm.put("user_id", userId);
			String formToken = pm.getString("token");
			String sessionToken = (String) session.getAttribute("token");
			if (formToken.equals(sessionToken)) {
				pm.put("create_time", DateUtil.getTime());
				pm.put("view_tool", editTool);
				articleService.saveArticle(pm);
				session.removeAttribute("token");
				view.addObject("msg", "保存成功");
				view.addObject("msg_class", "");
				view.addObject("url", "article/" + pm.getString("id"));
			} else {
				view.addObject("msg", "不能重复提交表单");
				view.addObject("msg_class", "blog-warning");
				view.addObject("url", "/");
			}
			view.addObject("title", pm.getString("title"));
			view.setViewName("result/success");
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			log.error(e.getMessage(), e);
			view.addObject("msg", "保存文章失败，重试多次失败，请联系博主");
			view.addObject("msg_class", "red");
			view.setViewName("result/failed");
		}
		return view;
	}

	/**
	 * 更新文章
	 * 
	 * @param articleId
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/update/{articleId}", method = RequestMethod.POST)
	@ResponseBody
	public ModelAndView updateArticle(@PathVariable String articleId) throws Exception {
		ModelAndView view = this.getModelAndView();
		ParameterMap pm = this.getParameterMap();
		try {
			pm.put("article_id", articleId);
			articleService.updateArticle(pm);
			view.addObject("url", "article/" + articleId);
			view.addObject("title", pm.getString("title"));
			view.setViewName("result/success");
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			log.error(e.getMessage(), e);
			view.addObject("msg", "更新文章失败，重试多次失败，请联系博主");
			view.addObject("msg_class", "red");
			view.setViewName("result/failed");
		}
		return view;
	}

	/**
	 * 删除文章
	 * 
	 * @param articleId
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/del/{articleId}", method = RequestMethod.GET)
	@ResponseBody
	public ModelAndView delArticle(@PathVariable String articleId) throws Exception {
		ModelAndView view = this.getModelAndView();
		ParameterMap pm = this.getParameterMap();
		try {
			Subject subject = SecurityUtils.getSubject();
			Session session = subject.getSession();
			pm.put("article_id", articleId);
			if (subject.isAuthenticated()) {
				ParameterMap article = articleService.getArticleDetail(pm);
				User user = (User) session.getAttribute(Const.BLOG_USER_SESSION);
				if (!article.getString("user_id").equals(user.getUser_id())) {
					view.addObject("msg", "你删除的文章不是自家的");
					view.addObject("msg_class", "red");
					view.setViewName("failed");
					return view;
				}
			}
			articleService.delArticle(pm);
			String url = MyUtil.getPptMap().getProperty("prefix");

			String reloadPath1 = url + Const.RELOAD_HOME_ARTICLE;
			String reloadPath2 = url + Const.RELOAD_LABEL_ARTICLE;
			String reloadPath3 = url + Const.RELOAD_MONTH_ARTICLE;
			String reloadPath4 = url + Const.RELOAD_RECOMMEND_ARTICLE;

			ReloadThread rt1 = new ReloadThread(reloadPath1);
			ReloadThread rt2 = new ReloadThread(reloadPath2);
			ReloadThread rt3 = new ReloadThread(reloadPath3);
			ReloadThread rt4 = new ReloadThread(reloadPath4);
			new Thread(rt1).start();
			new Thread(rt2).start();
			new Thread(rt3).start();
			new Thread(rt4).start();

			view.addObject("url", "#");
			view.addObject("title", "操作成功");
			view.setViewName("result/success");
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			log.error(e.getMessage(), e);
			view.addObject("msg", "删除文章失败，重试多次失败，请联系博主");
			view.addObject("msg_class", "red");
			view.setViewName("result/failed");
		}
		return view;
	}

	/**
	 * 编辑文章
	 * 
	 * @param articleId
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/edit/{articleId}", method = RequestMethod.GET)
	@ResponseBody
	public ModelAndView editArticle(@PathVariable("articleId") String articleId) throws Exception {
		ModelAndView view = this.getModelAndView();
		ParameterMap pm = this.getParameterMap();
		System.out.println("articleId=" + articleId);
		pm.put("article_id", articleId);
		try {
			Subject subject = SecurityUtils.getSubject();
			Session session = subject.getSession();
			if (subject.isAuthenticated()) {
				ParameterMap article = articleService.getArticleDetail(pm);
				if (article == null || article.size() < 1) {
					view.setViewName("error/404");
					return view;
				}
				User user = (User) session.getAttribute(Const.BLOG_USER_SESSION);
				if (!article.getString("user_id").equals(user.getUser_id())) {
					view.addObject("msg", "你修改的文章不是自家的");
					view.addObject("msg_class", "red");
					view.setViewName("failed");
					return view;
				}
				List<ParameterMap> articleLabels = null;
				articleLabels = cacheService.getCacheLabelArticle(pm);
				if (articleLabels == null || articleLabels.size() < 1) {
					// 所有文章的标签
					articleLabels = labelService.getArticleLabels(pm);
					log.info("不是缓存获取 所有文章的标签");
				} else {
					log.info("缓存获取 所有文章的标签");
				}
				view.addObject("labelList", articleLabels);
				view.addObject("article", article);
				String view_tool = article.getString("view_tool");
				view.setViewName("article/article_edit");
				if("editormd".equalsIgnoreCase(view_tool)){
					view.setViewName("article/edit");
				}
			} else {
				view.setViewName("error/404");
				return view;
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			log.error(e.getMessage(), e);
		}
		view.addObject("title", "编辑文章");
		view.addObject("btnValue", "发布更新");
		view.addObject("action", "update/" + articleId);
		return view;
	}

}
