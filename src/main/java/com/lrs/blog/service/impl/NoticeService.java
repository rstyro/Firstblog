package com.lrs.blog.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lrs.blog.dao.NoticeDao;
import com.lrs.blog.entity.User;
import com.lrs.blog.service.INoticeService;
import com.lrs.plugin.Page;
import com.lrs.util.Const;
import com.lrs.util.DateUtil;
import com.lrs.util.MyLogger;
import com.lrs.util.ParameterMap;

@Service
public class NoticeService implements INoticeService{

	@Autowired
	private NoticeDao noticeDao;
	
	private MyLogger log = MyLogger.getLogger(this.getClass());
	
	public Map<String,Object> getNoticeListByType(ParameterMap pm){
		Map<String,Object> map = new HashMap<>();
		try {
			Subject subject = SecurityUtils.getSubject();
			Session session = subject.getSession();
			User user = (User) session.getAttribute(Const.BLOG_USER_SESSION);
			String userId = user.getUser_id();
			int pageNo=1;
			String page_no = pm.getString("page_no");
			if(StringUtils.isNumeric(page_no)){
				pageNo = Integer.parseInt(page_no);
			}
			pm.put("user_id", userId);
			Page page = new Page();
			page.setCurrentPage(pageNo);
			page.setShowCount(2);
			page.setPm(pm);
			List<ParameterMap> notices = noticeDao.getNoticelistPage(page);
			ParameterMap pmpage = new ParameterMap(page);
			map.put("data", notices);
			map.put("page",pmpage);
			map.put("status", "success");
			map.put("msg", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			log.error("notice get error", e);
			map.put("status", "failed");
			map.put("msg", "获取消息错误");
		}
		return map;
	}
	
	@Override
	public Map<String, Object> getLetterDetail(ParameterMap pm) {
		Map<String,Object> map = new HashMap<>();
		try {
			Subject subject = SecurityUtils.getSubject();
			Session session = subject.getSession();
			User user = (User) session.getAttribute(Const.BLOG_USER_SESSION);
			String userId = user.getUser_id();
			pm.put("user_id", userId);
			List<ParameterMap> list = noticeDao.getLetterDetailList(pm);
			map.put("data", list);
			map.put("status", "success");
			map.put("msg", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			log.error("notice get error", e);
			map.put("status", "failed");
			map.put("msg", "获取消息错误");
		}
		return map;
	}
	
	@Override
	public Map<String, Object> replyLetter(ParameterMap pm) {
		Map<String,Object> map = new HashMap<>();
		try {
			Subject subject = SecurityUtils.getSubject();
			Session session = subject.getSession();
			User user = (User) session.getAttribute(Const.BLOG_USER_SESSION);
			String userId = user.getUser_id();
			pm.put("user_id", userId);
			pm.put("create_time", DateUtil.getTime());
			noticeDao.saveLetter(pm);
			map.put("status", "success");
			map.put("msg", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			log.error("notice get error", e);
			map.put("status", "failed");
			map.put("msg", "获取消息错误");
		}
		return map;
	}

}
