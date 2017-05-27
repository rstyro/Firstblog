package com.lrs.blog.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;

import org.apache.commons.lang.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.DisabledAccountException;
import org.apache.shiro.authc.ExcessiveAttemptsException;
import org.apache.shiro.authc.ExpiredCredentialsException;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.LockedAccountException;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.authz.UnauthorizedException;
import org.apache.shiro.crypto.hash.SimpleHash;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lrs.blog.dao.ArticleDao;
import com.lrs.blog.dao.LabelDao;
import com.lrs.blog.dao.PublicDao;
import com.lrs.blog.dao.UserDao;
import com.lrs.blog.entity.Lock;
import com.lrs.blog.entity.User;
import com.lrs.blog.service.ICacheService;
import com.lrs.blog.service.IUserService;
import com.lrs.plugin.Page;
import com.lrs.thread.EmailThread;
import com.lrs.util.Const;
import com.lrs.util.DateUtil;
import com.lrs.util.MyLogger;
import com.lrs.util.MyUtil;
import com.lrs.util.ParameterMap;

@Service
public class UserService implements IUserService{

	@Autowired
	private UserDao userDao;
	
	@Autowired
	private ArticleDao articleDao;
	
	@Autowired
	private LabelDao labelDao;
	
	@Autowired
	private PublicDao publicDao;
	
	@Autowired
	private ICacheService cacheService;
	
	private MyLogger log = MyLogger.getLogger(this.getClass());
	
	
	@Override
	public Map<String,Object> getUserInfo(ParameterMap pm) {
		Map<String,Object> map = new HashMap<>();
		try {
			Page page = new Page();
			int pageNo = 1;
			int pageSize = 10;
			if(StringUtils.isNotBlank(pm.getString("page_no"))){
				pageNo = Integer.parseInt(pm.getString("page_no"));
				page.setCurrentPage(pageNo);
			}
			if(StringUtils.isNotBlank(pm.getString("page_size"))){
				pageSize = Integer.parseInt(pm.getString("page_size"));
				page.setShowCount(pageSize);
			}
			page.setPm(pm);
			List<ParameterMap> articleList = articleDao.getArticlelistPage(page);
			map.put("articleList", articleList);
			
			ParameterMap pmpage = new ParameterMap(page);
			map.put("page", pmpage);
			
			//用户信息
			ParameterMap userInfo = userDao.getUserInfo(pm);
			map.put("userInfo", userInfo);
			//用户标签
			List<ParameterMap> userLabels = null;
			if("1".equals(pm.getString("user_id"))){
				userLabels=cacheService.getCacheBloggerLabel("1");
			}else{
				userLabels = labelDao.getUserLabel(pm);
			}
			map.put("userLabels", userLabels);
			
		} catch (Exception e) {
			log.info(e.getMessage(), e);
		}
		return map;
	}
	
	@Override
	public Map<String, Object> getUserBasicInfo(ParameterMap pm) {
		Map<String,Object> map = new HashMap<>();
		try {
			//用户信息
			ParameterMap userInfo = userDao.getUserInfo(pm);
			map.put("userInfo", userInfo);
			//用户标签
			List<ParameterMap> userLabels = null;
			if("1".equals(pm.getString("user_id"))){
				userLabels=cacheService.getCacheBloggerLabel("1");
			}else{
				userLabels = labelDao.getUserLabel(pm);
			}
			map.put("userLabels", userLabels);
			
		} catch (Exception e) {
			log.info(e.getMessage(), e);
		}
		return map;
	}
	
	@Override
	public ParameterMap repeatConcern(ParameterMap pm) {
		// TODO Auto-generated method stub
		return publicDao.repeatConcern(pm);
	}
	
	
	
	@Override
	public Map<String, Object> login(ParameterMap pm){
		Map<String,Object> map = new HashMap<>();
		try {
			String username = pm.getString("username");
			String password = pm.getString("password");
			String ip = pm.getString("ip");
			String msg = "";
			if (StringUtils.isNotBlank(username) && StringUtils.isNotBlank(password)) {
				Subject subject = SecurityUtils.getSubject();
				Session session = subject.getSession();
				session.setTimeout(1000*60*30);
				pm.put("username", username);
				// 密码加密
				String passwd = new SimpleHash("SHA-1", password,Const.SALT).toString(); 
				System.out.println("passwd="+passwd);
				pm.put("password", passwd);
				ParameterMap pmUser = userDao.getUserInfo(pm);
				if (pmUser != null && pmUser.size() > 0) {
					if(Lock.UNLOCK.toString().equalsIgnoreCase(pm.getString("status"))){
						map.put("msg", "账号未激活，或账号已被锁定");
						map.put("status", "failed");
						return map;
					}
				}else{
					map.put("msg", "用户名或密码错误");
			    	map.put("status", "failed");
			    	return map;
				}
				User user = new User();
				user.setUser_id(pmUser.getString("user_id"));
				user.setUsername(pmUser.getString("username"));
				user.setEmail(pmUser.getString("email"));
				user.setIp(ip);
				user.setImg(pmUser.getString("img"));
				user.setLocate(pmUser.getString("locate"));
				user.setName(pmUser.getString("name"));
				user.setSex(pmUser.getString("sex"));
				user.setSign(pmUser.getString("sign"));
				user.setStatus(pmUser.getString("status"));
				user.setThird_uuid(pmUser.getString("third_uuid"));
				user.setRegister_type(pmUser.getString("register_type"));
				session.setAttribute(Const.BLOG_USER_SESSION, user);
				UsernamePasswordToken token = new UsernamePasswordToken(username, password);  
				token.setRememberMe(true);  
				String url = "";
				try {
					//加入身份验证
					subject.login(token); 
					if (subject.isAuthenticated()) { 
						msg = "身份验证成功";
					} else {  
						msg = "身份验证失败";
					} 
					//跳转登录前的页面
					try {
						url = (String) session.getAttribute(Const.BLOG_LAST_URL); 
					} catch (Exception e) {
						// TODO: handle exception
						url="";
					}
					
				}catch (IncorrectCredentialsException e) {  
					msg = "登录密码错误. Password for account " + token.getPrincipal() + " was incorrect.";  
					System.out.println(msg);  
				} catch (ExcessiveAttemptsException e) {  
					msg = "登录失败次数过多";  
					System.out.println(msg);  
				} catch (LockedAccountException e) {  
					msg = "帐号已被锁定. The account for username " + token.getPrincipal() + " was locked.";  
					System.out.println(msg);  
				} catch (DisabledAccountException e) {  
					msg = "帐号已被禁用. The account for username " + token.getPrincipal() + " was disabled.";  
					System.out.println(msg);  
				} catch (ExpiredCredentialsException e) {  
					msg = "帐号已过期. the account for username " + token.getPrincipal() + "  was expired.";  
					System.out.println(msg);  
				} catch (UnknownAccountException e) {  
					msg = "帐号不存在. There is no user with username of " + token.getPrincipal();  
					System.out.println(msg);  
				} catch (UnauthorizedException e) {  
					msg = "您没有得到相应的授权！" + e.getMessage();  
					System.out.println(msg);  
				} finally{
					map.put("msg", msg);
					map.put("lastUrl", url);
				}
			} else {
				map.put("msg", "用户名或密码为空！");
				map.put("status", "failed");
			}
			map.put("status", "success");
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			log.error("登陆错误:"+e.getMessage(), e);
			map.put("msg", "服务器错误");
			map.put("status", "failed");
		}
		return map;
	}
	
	/**
	 * 注册
	 */
	@Override
	public Map<String, Object> register(ParameterMap pm) {
		Map<String,Object> map = new HashMap<>();
		try {
			String username = pm.getString("username");
			String password = pm.getString("password");
			String email = pm.getString("email");
			if(StringUtils.isBlank(username) || StringUtils.isBlank(password) ||StringUtils.isBlank(email) ){
				map.put("msg", "你是冒牌的！");
				map.put("status", "failed");
				return map;
			}
			ParameterMap repeatEmail = userDao.repeatEmail(pm);
			if(repeatEmail != null && repeatEmail.size() > 0){
				
				String isExistUsername = repeatEmail.getString("username");
				if(username.equalsIgnoreCase(isExistUsername)){
					map.put("msg", "用户名已存在");
					map.put("status", "failed");
					return map;
				}
				map.put("msg", "邮箱已注册,您可以通过找回密码重新设置密码");
				map.put("status", "failed");
				return map;
			}
			//加密
			String passwd = new SimpleHash("SHA-1", password,Const.SALT).toString();
			pm.put("password", passwd);
			pm.put("create_time", DateUtil.getTime());
			pm.put("name", pm.getString("username"));
			//默认头像
			pm.put("img",Const.BLOG_USER_DEFAULT_PATH+MyUtil.getRandomNum(1, 10)+".png");
			pm.put("sex", "boy");
			System.out.println("pm="+pm);
			userDao.saveUser(pm);
			String prefix = MyUtil.getPptMap().getProperty("prefix");
			String code = MyUtil.getUUID();
			String url = prefix+"/user/unlock?code="+code+"&user_id="+pm.getString("user_id");
			System.out.println("prefix="+prefix);
			System.out.println("url="+url);
			String title ="激活账号";
			String message = "这个链接30分钟之内有效，请尽快激活<a href='"+url+"'>"+url+"</a>，超过时间，该账号信息将被删除。";
			EmailThread et = new EmailThread(email, title, message);
			new Thread(et).start();
			
			//激活用户需要
			Session session = SecurityUtils.getSubject().getSession();
			ServletContext servletContext =(ServletContext) pm.get("servletContent");
			servletContext.setAttribute(code, pm.getString("user_id"));
			//跳转登录前的页面
			try {
				url = (String) session.getAttribute(Const.BLOG_LAST_URL); 
			} catch (Exception e) {
				// TODO: handle exception
				url="";
			}
			map.put("url", url);
			map.put("msg", "登记成功，需去邮箱激活账户!");
			map.put("status", "success");
		} catch (Exception e) {
			log.error("注册错误:"+e.getMessage(), e);
			map.put("msg", "服务器错误");
			map.put("status", "failed");
		}
		return map;
	}
	
	@Override
	public Map<String, Object> unlock(ParameterMap pm) {
		Map<String,Object> map = new HashMap<>();
		try {
			String code = pm.getString("code");
			String userId = pm.getString("user_id");
			System.out.println("lock  pm="+pm);
			
			ServletContext servletContext =(ServletContext) pm.get("servletContent");
			String servletContextCode = (String) servletContext.getAttribute(code);
			System.out.println("servletContextCode="+servletContextCode);
			
			if((servletContextCode.equals(userId))){
				pm.put("status", "unlock");
				userDao.updateUserInfo(pm);
			}else{
				map.put("msg", "你的请求信息已被改写或已过期！");
				map.put("status", "failed");
			}
			map.put("msg", "成功激活");
			map.put("status", "success");
		} catch (Exception e) {
			e.printStackTrace();
			log.error("unlock err:"+e.getMessage(), e);
			map.put("msg", "激活失败,可能链接已过期");
			map.put("status", "failed");
		}
		return map;
	}
	
	
	@Override
	public Map<String, Object> sendCode(ParameterMap pm) {
		Map<String,Object> map = new HashMap<>();
		try {
			String email = pm.getString("email");
			if(StringUtils.isBlank(email)){
				map.put("msg", "你是冒牌的客户端");
				map.put("status", "failed");
				return map;
			}
			ParameterMap isexist = userDao.repeatEmail(pm);
			if(isexist == null || isexist.size() < 1){
				map.put("msg", "没有绑定此邮箱");
				map.put("status", "failed");
				return map;
			}
			String title = "找回密码";
			String code = ""+MyUtil.getRandomNum();
			String message = "如果不是本人操作请忽略此条信息，您本次找回密码的验证码为:<strong>"+code+"</strong> 来自【个人博客】";
			EmailThread et = new EmailThread(email, title, message);
			new Thread(et).start();
			Session session = SecurityUtils.getSubject().getSession();
			session.setAttribute("resetcode", code);
			map.put("msg", "发送成功");
			map.put("status", "success");
		} catch (Exception e) {
			log.error("sendcode err:"+e.getMessage(), e);
			map.put("msg", "发送验证码失败,请刷新重试");
			map.put("status", "failed");
		}
		return map;
	}
	
	
	@Override
	public Map<String, Object> resetPasw(ParameterMap pm) {
		Map<String,Object> map = new HashMap<>();
		try {
			String code = pm.getString("code").trim();
			String password = pm.getString("password");
			Session session = SecurityUtils.getSubject().getSession();
			String sessionCode = (String) session.getAttribute("resetcode");
			System.out.println("code="+code+",sessionCode="+sessionCode);
			if(!code.equals(sessionCode)){
				map.put("msg", "验证码错误");
				map.put("status", "failed");
				return map;
			}
			pm.put("password", new SimpleHash("SHA-1", password, Const.SALT).toString());
			pm.put("status","unlock");
			System.out.println("pm="+pm);
			userDao.updateUserInfo(pm);
			map.put("msg", "成功激活");
			map.put("status", "success");
		} catch (Exception e) {
			e.printStackTrace();
			log.error("unlock err:"+e.getMessage(), e);
			map.put("msg", "重置失败");
			map.put("status", "failed");
		}
		return map;
	}
	
	@Override
	public Map<String, Object> logout(ParameterMap pm){
		Map<String,Object> map = new HashMap<>();
		try {
			Subject subject = SecurityUtils.getSubject();
			Session session = subject.getSession();
			session.removeAttribute(Const.BLOG_USER_SESSION);
			subject.logout();
			map.put("status", "success");
			map.put("msg", "退出成功");
		} catch (Exception e) {
			// TODO: handle exception
			log.error("退出登录失败:"+e.getMessage(), e);
			map.put("status", "failed");
			map.put("msg", "退出错误");
		}
		return map;
	}

}
