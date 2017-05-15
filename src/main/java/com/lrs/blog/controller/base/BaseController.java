package com.lrs.blog.controller.base;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.context.ContextLoader;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.lrs.util.MyLogger;
import com.lrs.util.ParameterMap;

public class BaseController {
	protected MyLogger log = MyLogger.getLogger(this.getClass());

	/**
	 * springMVC 获取requset
	 * 
	 * @return
	 */
	public HttpServletRequest getRequest() {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes())
				.getRequest();
		return request;
	}
	
	/**
	 * 获取response
	 * @return
	 */
	public HttpServletResponse getResponse() {
		HttpServletResponse response = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getResponse();
		return response;
	}
	
	/**
	 * 获取session
	 * @return
	 */
	public HttpSession getSession(){
		HttpSession session = this.getRequest().getSession();
		return session;
	}
	
	/**
	 * 获取ServletContext
	 * @return
	 */
	public ServletContext getServletContent() {
//		ServletContext application= request.getServletContext();
		
		WebApplicationContext webApplicationContext = ContextLoader.getCurrentWebApplicationContext();    
        ServletContext servletContext = webApplicationContext.getServletContext();
		return servletContext;
	}
	
	/**
	 * 获取ModelAndView
	 * @return
	 */
	public ModelAndView getModelAndView(){
		return new ModelAndView();
	}
	
	public ModelAndView get404ModelAndView(){
		ModelAndView view = new ModelAndView();
		view.setViewName("404");
		return view;
	}

	/**
	 * 过滤参数
	 * 
	 * @return
	 */
	public ParameterMap getParameterMap() {
		return new ParameterMap(this.getRequest());
	}

	/**
	 * 获取ip
	 * 
	 * @return
	 */
	public String getRemortIP() {
		HttpServletRequest request = this.getRequest();
		String ip = "";
		if (request.getHeader("x-forwarded-for") == null) {
			ip = request.getRemoteAddr();
		} else {
			ip = request.getHeader("x-forwarded-for");
		}
		return ip;
	}
	
	/**
	 * 获取port
	 * 
	 * @return
	 */
	public int getPort(){
		return this.getRequest().getServerPort();
	}
	
	
	/**
	 * 获取ip
	 * @param request
	 * @return
	 */
	public String getIpAddr() {
		HttpServletRequest request = this.getRequest();
		String ip = request.getHeader("x-forwarded-for");
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("WL-Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getRemoteAddr();
		}
		return ip;
	}
	
	public static void printLogger(MyLogger logger,String message){
		logger.info(message);
	}
}
