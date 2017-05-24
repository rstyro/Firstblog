package com.lrs.blog.interceptor;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.lrs.blog.dao.NoticeDao;
import com.lrs.blog.entity.User;
import com.lrs.blog.service.IPublicService;
import com.lrs.util.Const;
import com.lrs.util.MyLogger;
import com.lrs.util.ParameterMap;

public class MyHandlerInterceptor extends HandlerInterceptorAdapter {
	private String saveBrowseUrl;
	private String needLoginUrl;// 需要登陆才能访问的url,才springmvc的配置文件中配置
	private String resourceUrl;
	
	
	@Autowired
	private IPublicService publicService;
	
	@Autowired
	private NoticeDao noticeDao;
	
	private MyLogger log = MyLogger.getLogger(this.getClass());

	public void setSaveBrowseUrl(String saveBrowseUrl) {
		this.saveBrowseUrl = saveBrowseUrl;
	}
	
	public void setNeedLoginUrl(String needLoginUrl) {
		this.needLoginUrl = needLoginUrl;
	}

	public void setResourceUrl(String resourceUrl) {
		this.resourceUrl = resourceUrl;
	}
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		String path = request.getServletPath();
		boolean flag = true;
		if (path.matches(Const.INTERCEPTOR_PATH)) {
			if (path.matches(resourceUrl)) {
				System.out.println("这是资源请求拦截。。。。：" + path);
			}
			// 需要登陆的请求拦截
			if (path.matches(needLoginUrl)) {
				System.out.println("needLoginUrl:" + path);
				Subject subject = SecurityUtils.getSubject();
				if (!subject.isAuthenticated()) {
					subject.getSession().setAttribute(Const.BLOG_LAST_URL, path);
					request.getRequestDispatcher("/toLogin").forward(request, response);
					return false;
				}
			}
			//浏览拦截
			if (path.matches(saveBrowseUrl)) {
				ParameterMap pm = new ParameterMap();
				Subject subject = SecurityUtils.getSubject();
				if(subject.isAuthenticated()){
					Session session = subject.getSession();
					User sessionUser = (User) session.getAttribute(Const.BLOG_USER_SESSION);
					if(sessionUser != null) {
						pm.put("user_id", sessionUser.getUser_id());
					} else {
						pm.put("user_id", null);
					}
				}
				String articleId = path.substring(path.lastIndexOf("/")+1, path.length());
				log.info("浏览拦截");
				int id= 0;
				try {
					id = Integer.parseInt(articleId);
				} catch (Exception e) {
					e.printStackTrace();
					request.getRequestDispatcher(request.getContextPath()+"/WEB-INF/jsp/error/404.jsp").forward(request, response);
					return false;
				}
				pm.put("table_id", id);
				//保存浏览记录
				try {
					publicService.saveBrowse(pm);
				} catch (Exception e) {
					e.printStackTrace();
					log.error("保存浏览记录失败", e);
				}
			}
		}
		return flag;

	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		try {
			Session session = SecurityUtils.getSubject().getSession();
			User user = (User) session.getAttribute(Const.BLOG_USER_SESSION);
			if(user != null){
				ParameterMap pm = new ParameterMap();
				pm.put("user_id", user.getUser_id());
				ParameterMap notice = noticeDao.getNoticeNum(new ParameterMap());
				System.out.println("notice="+notice);
				if(notice != null && notice.size() > 0){
					filterNum(notice, "totalNum");
					filterNum(notice, "praiseNum");
					filterNum(notice, "concernNum");
					filterNum(notice, "letterNum");
					filterNum(notice, "systemNum");
					filterNum(notice, "commentNum");
					if(modelAndView != null){
						modelAndView.addObject("notice", notice);
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		super.postHandle(request, response, handler, modelAndView);
	}
	
	public void filterNum(ParameterMap pm,String key){
		Object obj = pm.get(key);
		if(obj == null || StringUtils.isBlank(obj.toString()))return;
		long value = Integer.parseInt(obj.toString());
		if(value <= 0){
			pm.put(key, "");
		}
	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		super.afterCompletion(request, response, handler, ex);
	}
}
