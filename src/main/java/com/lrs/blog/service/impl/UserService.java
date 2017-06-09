package com.lrs.blog.service.impl;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.util.ArrayList;
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
import org.apache.shiro.codec.Base64;
import org.apache.shiro.crypto.hash.SimpleHash;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.json.JSONObject;
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
import com.lrs.util.HttpUtils;
import com.lrs.util.MyLogger;
import com.lrs.util.MyUtil;
import com.lrs.util.ParameterMap;
import com.lrs.util.UploadUtil;

@Service
public class UserService implements IUserService {

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
	public Map<String, Object> getUserInfo(ParameterMap pm) {
		Map<String, Object> map = new HashMap<>();
		try {
			Page page = new Page();
			int pageNo = 1;
			int pageSize = 10;
			if (StringUtils.isNotBlank(pm.getString("page_no"))) {
				pageNo = Integer.parseInt(pm.getString("page_no"));
				page.setCurrentPage(pageNo);
			}
			if (StringUtils.isNotBlank(pm.getString("page_size"))) {
				pageSize = Integer.parseInt(pm.getString("page_size"));
				page.setShowCount(pageSize);
			}
			page.setPm(pm);
			List<ParameterMap> articleList = articleDao.getArticlelistPage(page);
			map.put("articleList", articleList);

			ParameterMap pmpage = new ParameterMap(page);
			map.put("page", pmpage);

			// 用户信息
			ParameterMap userInfo = userDao.getUserInfo(pm);
			map.put("userInfo", userInfo);
			// 用户标签
			List<ParameterMap> userLabels = null;
			if ("1".equals(pm.getString("user_id"))) {
				userLabels = cacheService.getCacheBloggerLabel("1");
			} else {
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
		Map<String, Object> map = new HashMap<>();
		try {
			// 用户信息
			ParameterMap userInfo = userDao.getUserInfo(pm);
			map.put("userInfo", userInfo);
			// 用户标签
			List<ParameterMap> userLabels = null;
			if ("1".equals(pm.getString("user_id"))) {
				userLabels = cacheService.getCacheBloggerLabel("1");
			} else {
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
	public Map<String, Object> login(ParameterMap pm) {
		Map<String, Object> map = new HashMap<>();
		try {
			String username = pm.getString("username");
			String password = pm.getString("password");
			String ip = pm.getString("ip");
			String msg = "";
			if (StringUtils.isNotBlank(username) && StringUtils.isNotBlank(password)) {
				Subject subject = SecurityUtils.getSubject();
				Session session = subject.getSession();
				session.setTimeout(1000 * 60 * 30);
				pm.put("username", username);
				// 密码加密
				String passwd = new SimpleHash("SHA-1", password, Const.SALT).toString();
				System.out.println("passwd=" + passwd);
				pm.put("password", passwd);
				ParameterMap pmUser = userDao.getUserInfo(pm);
				if (pmUser != null && pmUser.size() > 0) {
					if (Lock.UNLOCK.toString().equalsIgnoreCase(pm.getString("status"))) {
						map.put("msg", "账号未激活，或账号已被锁定");
						map.put("status", "failed");
						return map;
					}
				} else {
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
					// 加入身份验证
					subject.login(token);
					if (subject.isAuthenticated()) {
						msg = "身份验证成功";
					} else {
						msg = "身份验证失败";
					}
					// 跳转登录前的页面
					try {
						url = (String) session.getAttribute(Const.BLOG_LAST_URL);
					} catch (Exception e) {
						// TODO: handle exception
						url = "";
					}

				} catch (IncorrectCredentialsException e) {
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
				} finally {
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
			log.error("登陆错误:" + e.getMessage(), e);
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
		Map<String, Object> map = new HashMap<>();
		try {
			String username = pm.getString("username");
			String password = pm.getString("password");
			String email = pm.getString("email");
			if (StringUtils.isBlank(username) || StringUtils.isBlank(password) || StringUtils.isBlank(email)) {
				map.put("msg", "你是冒牌的！");
				map.put("status", "failed");
				return map;
			}
			ParameterMap repeatEmail = userDao.repeatEmail(pm);
			if (repeatEmail != null && repeatEmail.size() > 0) {

				String isExistUsername = repeatEmail.getString("username");
				if (username.equalsIgnoreCase(isExistUsername)) {
					map.put("msg", "用户名已存在");
					map.put("status", "failed");
					return map;
				}
				map.put("msg", "邮箱已注册,您可以通过找回密码重新设置密码");
				map.put("status", "failed");
				return map;
			}
			// 加密
			String passwd = new SimpleHash("SHA-1", password, Const.SALT).toString();
			pm.put("password", passwd);
			pm.put("create_time", DateUtil.getTime());
			pm.put("name", pm.getString("username"));
			// 默认头像
			pm.put("img", Const.BLOG_USER_DEFAULT_PATH + MyUtil.getRandomNum(1, 10) + ".png");
			pm.put("sex", "boy");
			System.out.println("pm=" + pm);
			userDao.saveUser(pm);
			String prefix = MyUtil.getPptMap().getProperty("prefix");
			String code = MyUtil.getUUID();
			String url = prefix + "/user/unlock?code=" + code + "&user_id=" + pm.getString("user_id");
			System.out.println("prefix=" + prefix);
			System.out.println("url=" + url);
			String title = "激活账号";
			String message = "这个链接30分钟之内有效，请尽快激活<a href='" + url + "'>" + url + "</a>，超过时间，该账号信息将被删除。";
			EmailThread et = new EmailThread(email, title, message);
			new Thread(et).start();

			// 激活用户需要
			Session session = SecurityUtils.getSubject().getSession();
			ServletContext servletContext = (ServletContext) pm.get("servletContent");
			servletContext.setAttribute(code, pm.getString("user_id"));
			// 跳转登录前的页面
			try {
				url = (String) session.getAttribute(Const.BLOG_LAST_URL);
			} catch (Exception e) {
				// TODO: handle exception
				url = "";
			}
			map.put("url", url);
			map.put("msg", "登记成功，需去邮箱激活账户!");
			map.put("status", "success");
		} catch (Exception e) {
			log.error("注册错误:" + e.getMessage(), e);
			map.put("msg", "服务器错误");
			map.put("status", "failed");
		}
		return map;
	}

	@Override
	public Map<String, Object> unlock(ParameterMap pm) {
		Map<String, Object> map = new HashMap<>();
		try {
			String code = pm.getString("code");
			String userId = pm.getString("user_id");
			System.out.println("lock  pm=" + pm);

			ServletContext servletContext = (ServletContext) pm.get("servletContent");
			String servletContextCode = (String) servletContext.getAttribute(code);
			System.out.println("servletContextCode=" + servletContextCode);

			if ((servletContextCode.equals(userId))) {
				pm.put("status", "unlock");
				userDao.updateUserInfo(pm);
			} else {
				map.put("msg", "你的请求信息已被改写或已过期！");
				map.put("status", "failed");
			}
			map.put("msg", "成功激活");
			map.put("status", "success");
		} catch (Exception e) {
			e.printStackTrace();
			log.error("unlock err:" + e.getMessage(), e);
			map.put("msg", "激活失败,可能链接已过期");
			map.put("status", "failed");
		}
		return map;
	}

	@Override
	public Map<String, Object> sendCode(ParameterMap pm) {
		Map<String, Object> map = new HashMap<>();
		try {
			String email = pm.getString("email");
			if (StringUtils.isBlank(email)) {
				map.put("msg", "你是冒牌的客户端");
				map.put("status", "failed");
				return map;
			}
			ParameterMap isexist = userDao.repeatEmail(pm);
			if (isexist == null || isexist.size() < 1) {
				map.put("msg", "没有绑定此邮箱");
				map.put("status", "failed");
				return map;
			}
			String title = "找回密码";
			String code = "" + MyUtil.getRandomNum();
			String message = "如果不是本人操作请忽略此条信息，您本次找回密码的验证码为:<strong>" + code + "</strong> 来自【个人博客】";
			EmailThread et = new EmailThread(email, title, message);
			new Thread(et).start();
			Session session = SecurityUtils.getSubject().getSession();
			session.setAttribute("resetcode", code);
			map.put("msg", "发送成功");
			map.put("status", "success");
		} catch (Exception e) {
			log.error("sendcode err:" + e.getMessage(), e);
			map.put("msg", "发送验证码失败,请刷新重试");
			map.put("status", "failed");
		}
		return map;
	}

	@Override
	public Map<String, Object> resetPasw(ParameterMap pm) {
		Map<String, Object> map = new HashMap<>();
		try {
			String code = pm.getString("code").trim();
			String password = pm.getString("password");
			Session session = SecurityUtils.getSubject().getSession();
			String sessionCode = (String) session.getAttribute("resetcode");
			System.out.println("code=" + code + ",sessionCode=" + sessionCode);
			if (!code.equals(sessionCode)) {
				map.put("msg", "验证码错误");
				map.put("status", "failed");
				return map;
			}
			pm.put("password", new SimpleHash("SHA-1", password, Const.SALT).toString());
			pm.put("status", "unlock");
			System.out.println("pm=" + pm);
			userDao.updateUserInfo(pm);
			map.put("msg", "成功激活");
			map.put("status", "success");
		} catch (Exception e) {
			e.printStackTrace();
			log.error("unlock err:" + e.getMessage(), e);
			map.put("msg", "重置失败");
			map.put("status", "failed");
		}
		return map;
	}

	@Override
	public Map<String, Object> logout(ParameterMap pm) {
		Map<String, Object> map = new HashMap<>();
		try {
			Subject subject = SecurityUtils.getSubject();
			Session session = subject.getSession();
			session.removeAttribute(Const.BLOG_USER_SESSION);
			subject.logout();
			map.put("status", "success");
			map.put("msg", "退出成功");
		} catch (Exception e) {
			// TODO: handle exception
			log.error("退出登录失败:" + e.getMessage(), e);
			map.put("status", "failed");
			map.put("msg", "退出错误");
		}
		return map;
	}

	@Override
	public Map<String, Object> qqredirect(ParameterMap pm) {
		Map<String, Object> map = new HashMap<>();
		String code = pm.getString("code");
		String state = pm.getString("state");
		String openUrl = MyUtil.getPptMap().getProperty("qq_open_url");
		String userUrl = MyUtil.getPptMap().getProperty("qq_user_url");
		String grant_type = "authorization_code";
		String client_id = MyUtil.getPptMap().getProperty("qq_app_key");
		String client_secret = MyUtil.getPptMap().getProperty("qq_app_secret");
		String redirect_uri = MyUtil.getPptMap().getProperty("qq_redirect_url");
		ParameterMap param = new ParameterMap();
		param.put("code", code);
		param.put("state", state);
		param.put("grant_type", grant_type);
		param.put("client_id", client_id);
		param.put("client_secret", client_secret);
		param.put("redirect_uri", redirect_uri);
		try {
			// 获取access_token
			System.out.println("param=" + param);
			String url = "https://graph.qq.com/oauth2.0/token?grant_type=authorization_code&client_id="+client_id
					+"&client_secret="+client_secret+"&code="+code+"&state="+state+"&redirect_uri="+redirect_uri;
			String result = HttpUtils.getInstance().sendGetMethod(url, "UTF-8");
			System.out.println("result=" + result);
			ParameterMap acToken = MyUtil.getMapByUrlString(result);
			String access_token = acToken.getString("access_token");
			String expires_in = acToken.getString("expires_in");
			String refresh_token = acToken.getString("refresh_token");
			// 权限自动续期
			// pm.put("grant_type", "refresh_token");
			// pm.put("client_id", client_id);
			// pm.put("client_secret", client_secret);
			// pm.put("refresh_token", refresh_token);
			// HttpUtils.getInstance().sendGetMethod(tokenUrl, pm, "UTF-8");

			// 获取open_id
			param.put("access_token", access_token);
			String openString = HttpUtils.getInstance().sendGetMethod(openUrl, param, "UTF-8");
			System.out.println("openString=" + openString);
			openString = openString.replaceAll("callback", "");
			openString = openString.replaceAll("[(]", "");
			openString = openString.replaceAll("[)]", "");
			System.out.println("openString=" + openString);
			JSONObject open = new JSONObject(openString);
			String openId = open.getString("openid");
			// 获取用户信息
			param.put("register_type", "qq");
			param.put("third_uuid", openId);
			if(!checkIsExist(param)){
				param.put("access_token", access_token);
				param.put("oauth_consumer_key", client_id);
				param.put("openid", openId);
				String userString = HttpUtils.getInstance().sendGetMethod(userUrl, param, "UTF-8");
				System.out.println("userString=" + userString);
				JSONObject user = new JSONObject(userString);
				System.out.println("user=" + user);
				saveQQUser(user,pm.getString("ip"),openId);
			}
			map.put("msg", "ok");
			map.put("status", "success");
		} catch (Exception e) {
			log.error("error:" + e.getMessage(), e);
			map.put("status", "failed");
			map.put("msg", "回调错误");
		}
		return map;
	}

	private void saveQQUser(JSONObject user,String ip,String openId) {
		ParameterMap userpm = new ParameterMap();
		String sex = user.getString("gender");
		if("女".equalsIgnoreCase(sex)){
			sex="girl";
		}else{
			sex="boy";
		}
		String userPath = user.getString("figureurl_qq_2");//100x100 图片
		if(StringUtils.isBlank(userPath)){
			userPath=user.getString("figureurl_qq_1");
		}
		try {
			userpm.put("username", "blog_" + MyUtil.random(8));
			userpm.put("password", "password_" + MyUtil.random(8));
			userpm.put("name", user.getString("nickname"));
			userpm.put("third_uuid", openId);
			userpm.put("register_type", "qq");
			userpm.put("sex", sex);
			userpm.put("locate", user.getString("city"));
			userpm.put("sign", "人懒连个性签名都没有!");
			userpm.put("ip", ip);
			userpm.put("status", "unlock");
			userpm.put("create_time", DateUtil.getTime());
			String path = Const.USER_IMG_PATH + MyUtil.random(8) + ".png";
			try {
				UploadUtil.saveImgByUrl(userPath, Const.ROOT_PATH + "../" + path);
			} catch (Exception e) {
				path = Const.BLOG_USER_DEFAULT_PATH + MyUtil.getRandomNum(1, 10) + ".png";
				log.error("errpt=" + e.getMessage(), e);
			}
			userpm.put("img", path);
			userDao.saveUser(userpm);
			addUserShiro(userpm);
		} catch (Exception e) {
			log.error("error", e);
		}
	}

	@Override
	public Map<String, Object> weiboredirect(ParameterMap pm) {
		Map<String, Object> map = new HashMap<>();
		try {
			String code = pm.getString("code");
			String tokenUrl = MyUtil.getPptMap().getProperty("weibo_token_url");
			String grant_type = "authorization_code";
			String client_id = MyUtil.getPptMap().getProperty("weibo_app_key");
			String client_secret = MyUtil.getPptMap().getProperty("weibo_app_secret");
			String redirect_uri = MyUtil.getPptMap().getProperty("weibo_redirect_url");
			String registerType = "weibo";
			ParameterMap param = new ParameterMap();
			param.put("ip", pm.getString("ip"));
			param.put("code", code);
			param.put("grant_type", grant_type);
			param.put("client_id", client_id);
			param.put("client_secret", client_secret);
			param.put("redirect_uri", redirect_uri);
			// 验证accesToken
			boolean flag = accessToken(tokenUrl, param, registerType, "UTF-8");
			if (!flag) {
				// 获取用户信息，并新增用户
				param.put("uid", param.getString("third_uuid"));
				saveNewUser(param);
			}
			map.put("msg", "ok");
			map.put("status", "success");
		} catch (Exception e) {
			log.error("error:" + e.getMessage(), e);
			map.put("status", "failed");
			map.put("msg", "回调错误");
		}
		return map;
	}

	@SuppressWarnings("unchecked")
	private void saveNewUser(ParameterMap param) throws Exception {
		String userUrl = MyUtil.getPptMap().getProperty("weibo_user_url");
		System.out.println("param=" + param);
		String userString = HttpUtils.getInstance().sendGetMethod(userUrl, param, "UTF-8");
		System.out.println("userString=" + userString);
		JSONObject user = new JSONObject(userString);
		String sex = user.getString("gender");
		if ("m".equals(sex)) {
			sex = "boy";
		} else {
			sex = "girl";
		}
		ParameterMap userpm = new ParameterMap();
		userpm.put("username", "blog_" + MyUtil.random(8));
		userpm.put("password", "password_" + MyUtil.random(8));
		userpm.put("name", user.getString("screen_name"));
		userpm.put("third_uuid", user.getString("idstr"));
		userpm.put("register_type", "weibo");
		userpm.put("sex", sex);
		userpm.put("locate", user.getString("location"));
		userpm.put("sign", user.getString("description"));
		userpm.put("ip", param.getString("ip"));
		userpm.put("status", "unlock");
		userpm.put("create_time", DateUtil.getTime());
		String path = Const.USER_IMG_PATH + MyUtil.random(8) + ".png";
		String imgUrl = user.getString("profile_image_url");
		try {
			UploadUtil.saveImgByUrl(imgUrl, Const.ROOT_PATH + "../" + path);
		} catch (Exception e) {
			path = Const.BLOG_USER_DEFAULT_PATH + MyUtil.getRandomNum(1, 10) + ".png";
			log.error("errpt=" + e.getMessage(), e);
		}
		userpm.put("img", path);
		userDao.saveUser(userpm);
		addUserShiro(userpm);
	}

	/**
	 * 验证token,判断是否存在此用户
	 * 
	 * @param tokenUrl
	 * @param param
	 * @param uid
	 * @param access_token
	 * @param registerType
	 * @param encode
	 * @return
	 */
	private boolean accessToken(String tokenUrl, ParameterMap param, String registerType, String encode) {
		String result = HttpUtils.getInstance().sendPostMethod(tokenUrl, param, encode);
		System.out.println("result=" + result);
		JSONObject acToken = new JSONObject(result);
		// Integer expires_in = (Integer) acToken.get("expires_in"); //生命周期
		String access_token = acToken.getString("access_token");
		String uid = acToken.getString("uid");
		param.put("access_token", access_token);
		param.put("register_type", registerType);
		param.put("third_uuid", uid);
		return checkIsExist(param);
	}
	
	/**
	 * 检测是否存在了
	 * @param pm
	 * @return
	 */
	private boolean checkIsExist(ParameterMap pm){
		ParameterMap userInfo = userDao.getUserInfo(pm);
		if (userInfo != null && userInfo.size() > 0) {
			addUserShiro(userInfo);
			return true;
		}
		return false;
	}

	/**
	 * 把用户信息添加到shiro中
	 * 
	 * @param userInfo
	 */
	private void addUserShiro(ParameterMap pmUser) {
		Subject subject = SecurityUtils.getSubject();
		Session session = subject.getSession();
		session.setTimeout(1000 * 60 * 30);
		User user = new User();
		user.setIp(pmUser.getString("ip"));
		user.setUser_id(pmUser.getString("user_id"));
		user.setUsername(pmUser.getString("username"));
		user.setEmail(pmUser.getString("email"));
		user.setImg(pmUser.getString("img"));
		user.setLocate(pmUser.getString("locate"));
		user.setName(pmUser.getString("name"));
		user.setSex(pmUser.getString("sex"));
		user.setSign(pmUser.getString("sign"));
		user.setStatus(pmUser.getString("status"));
		user.setThird_uuid(pmUser.getString("third_uuid"));
		user.setRegister_type(pmUser.getString("register_type"));
		session.setAttribute(Const.BLOG_USER_SESSION, user);
		UsernamePasswordToken token = new UsernamePasswordToken(pmUser.getString("username"),
				pmUser.getString("password"));
		token.setRememberMe(true);
		subject.login(token);
	}

	@Override
	public Map<String, Object> weixinredirect(ParameterMap pm) {
		// TODO Auto-generated method stub
		return null;
	}

	/**
	 * 更改用户信息
	 * 
	 * @param pm
	 * @return
	 */
	public Map<String, Object> updateUserInfo(ParameterMap pm) {
		Map<String, Object> map = new HashMap<>();
		try {
			System.out.println("pm=" + pm);
			Subject subject = SecurityUtils.getSubject();
			if (subject.isAuthenticated()) {
				Session session = subject.getSession();
				User user = (User) session.getAttribute(Const.BLOG_USER_SESSION);
				if (user != null) {
					String userId = user.getUser_id();
					pm.put("user_id", userId);
					String password = pm.getString("password");
					if(StringUtils.isNotBlank(password)){
						pm.put("password", new SimpleHash("SHA-1", password, Const.SALT).toString());
					}
					userDao.updateUserInfo(pm);
					String labels = pm.getString("labels");
					if(StringUtils.isNotBlank(labels)){
						String[] ids = labels.split(",");
						if (ids.length > 0) {
							labelDao.delUserLabel(pm);
							List<ParameterMap> userlabelList = new ArrayList<>();
							for (int i = 0; i < ids.length; i++) {
								String labelId = ids[i];
								ParameterMap parameData = new ParameterMap();
								parameData.put("user_id", userId);
								parameData.put("label_id", labelId);
								userlabelList.add(parameData);
							}
							if (userlabelList.size() > 0) {
								labelDao.batchSaveUserLabel(userlabelList);
							}
						}
					}
					map.put("msg", "ok");
					map.put("status", "success");
					if(StringUtils.isNotBlank(password)){
						session.removeAttribute(Const.BLOG_USER_SESSION);
						subject.logout();
						map.put("msg", "更新密码，请重新登陆");
						map.put("status", "auth");
					}
				} else {
					map.put("msg", "请重新登陆");
					map.put("status", "auth");
				}
			} else {
				map.put("msg", "你请求的是冒牌接口");
				map.put("status", "failed");
				return map;
			}
		} catch (Exception e) {
			log.error("error:" + e.getMessage(), e);
			map.put("status", "failed");
			map.put("msg", "回调错误");
		}
		return map;
	}

	@Override
	public Map<String, Object> uploadUserImg(ParameterMap pm) {
		Map<String, Object> map = new HashMap<>();
		try {
			System.out.println("pm=" + pm);
			Subject subject = SecurityUtils.getSubject();
			if (subject.isAuthenticated()) {
				Session session = subject.getSession();
				User user = (User) session.getAttribute(Const.BLOG_USER_SESSION);
				if (user != null) {
					String userId = user.getUser_id();
					pm.put("user_id", userId);
					String base64Code = pm.getString("base64code");
					base64Code = base64Code.replace("data:image/png;base64,", "");
					base64Code = base64Code.replace("data:image/jpeg;base64,", "");
					base64Code = base64Code.replace("data:image/bmp;base64,", "");
					base64Code = base64Code.replace("data:image/x-icon;base64,", "");
					base64Code = base64Code.replace("data:image/gif;base64,", "");
					byte[] bytes = Base64.decode(base64Code);
					InputStream in = new ByteArrayInputStream(bytes);
					String path = Const.USER_IMG_PATH + MyUtil.random(8) + ".png";
					int x = (int) Double.parseDouble(pm.getString("x"));
					int y = (int) Double.parseDouble(pm.getString("y"));
					int width = (int) Double.parseDouble(pm.getString("width"));
					int height = (int) Double.parseDouble(pm.getString("height"));
					UploadUtil.crop(in, Const.ROOT_PATH + "../" + path, x, y, width, height, true);
					map.put("data", path);
					// userDao.updateUserInfo(pm);
				} else {
					map.put("msg", "请重新登陆");
					map.put("status", "auth");
				}
			} else {
				map.put("msg", "你请求的是冒牌接口");
				map.put("status", "failed");
				return map;
			}
			map.put("msg", "ok");
			map.put("status", "success");
		} catch (Exception e) {
			log.error("error:" + e.getMessage(), e);
			map.put("status", "failed");
			map.put("msg", "回调错误");
		}
		return map;
	}
}
