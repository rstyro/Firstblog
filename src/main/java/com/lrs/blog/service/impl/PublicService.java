package com.lrs.blog.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lrs.blog.dao.PublicDao;
import com.lrs.blog.entity.User;
import com.lrs.blog.service.IPublicService;
import com.lrs.plugin.Page;
import com.lrs.thread.EmailThread;
import com.lrs.thread.LeaveThread;
import com.lrs.util.Const;
import com.lrs.util.DateUtil;
import com.lrs.util.MyLogger;
import com.lrs.util.MyUtil;
import com.lrs.util.ParameterMap;

import net.sf.json.JSONArray;

@Service
public class PublicService implements IPublicService {

	@Autowired
	private PublicDao publicDao;
	
	private MyLogger log = MyLogger.getLogger(this.getClass());
	
	@Override
	public int saveBrowse(ParameterMap pm) {
		try {
			int issuccess =  publicDao.updateBrowseNum(pm);
			if(issuccess > 0){//存在这个id，就保存浏览记录
				publicDao.saveBrowse(pm);
			}else{
				return 0;
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return 0;
		}
		return 1;
	}
	
	@Override
	public Map<String, Object> comment(ParameterMap pm) {
		Map<String, Object> map = new HashMap<>();
		try {
			System.out.println("pm="+pm);
			String tableId = pm.getString("table_id");
			String content = pm.getString("content");
			if(StringUtils.isBlank(tableId) || StringUtils.isBlank(content)){
				map.put("msg", "你请求的是一个冒牌接口");
				map.put("status", "failed");
				return map;
			}
			Subject subject = SecurityUtils.getSubject();
			Session session = subject.getSession();
			pm.put("create_time", DateUtil.getTime());
			User user = null;
			if(subject.isAuthenticated()){
				user = (User) session.getAttribute(Const.BLOG_USER_SESSION);
				if(user != null){
					pm.put("user_id", user.getUser_id());
				}else{
					session.setAttribute(Const.BLOG_LAST_URL, "/article/"+pm.getString("table_id"));
					map.put("status", "auth");
					map.put("msg", "auth failed");
					return map;
				}
				publicDao.saveComment(pm);
			}else{
				try {
					int index = (int) session.getAttribute(Const.BLOG_COMMENT_INDEX+tableId);
					if(index > 0){
						map.put("status", "failed");
						map.put("msg", "匿名只能评论一次");
						return map;
					}
				} catch (Exception e) {
				}
				user = (User) session.getAttribute(Const.BLOG_ANONYM_USER_SESSION);
				if(user == null){
					user = new User();
					int randomNum = MyUtil.getRandomNum(11, 20);
					user.setUser_id(randomNum+"");
					user.setImg("upload/user/default"+(randomNum-10)+".png");
					user.setName("匿名用户");
					session.setAttribute(Const.BLOG_ANONYM_USER_SESSION, user);
				}
				pm.put("user_id", user.getUser_id());
				publicDao.saveComment(pm);
				session.setAttribute(Const.BLOG_COMMENT_INDEX+tableId, 1);
			}
			//更改评论数
			pm.put("comment_type", "add");
			publicDao.updateCommentNum(pm);
			pm.put("img", user.getImg());
			pm.put("praise_num", 0);
			pm.put("name", user.getName());
			map.put("data", pm);
			map.put("status", "success");
			map.put("msg", "ok");
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			log.error("评论异常:"+e.getMessage(), e);
			map.put("status", "failed");
			map.put("msg", "评论失败");
		}
		return map;
	}
	
	@Override
	public Map<String, Object> getComment(ParameterMap pm) {
		Map<String, Object> map = new HashMap<>();
		List<ParameterMap> floorlist = null;
		List<ParameterMap> replyfloorlist = null;
		try {
			String tableId = pm.getString("table_id");
			if(StringUtils.isBlank(tableId)){
				map.put("msg", "你请求的是一个冒牌接口");
				map.put("status", "failed");
				return map;
			}
			int pageNo = 1;
			int pageSize = 10;
			if(StringUtils.isNotBlank(pm.getString("page_no"))){
				pageNo = Integer.parseInt(pm.getString("page_no"));
			}
			if(StringUtils.isNotBlank(pm.getString("page_size"))){
				pageSize = Integer.parseInt(pm.getString("page_size"));
			}
			Page page = new Page();
			page.setCurrentPage(pageNo);
			page.setShowCount(pageSize);
			page.setPm(pm);
			//楼主评论
			floorlist = publicDao.getCommentlistPage(page);
			if(floorlist != null && floorlist.size() > 0){
				//回复楼主的评论
				replyfloorlist = publicDao.getCommentlist(pm);
				if(replyfloorlist != null && replyfloorlist.size() > 0){
					Map<String,List<ParameterMap>> commentMap = new HashMap<>();
					//把同一个楼层回复的放到一个数组里
					for(ParameterMap ptm:replyfloorlist){
						if(commentMap.containsKey(ptm.getString("parent_id"))){
							commentMap.get(ptm.getString("parent_id")).add(ptm);
						}else{
							List<ParameterMap> list = new ArrayList<>();
							list.add(ptm);
							commentMap.put(ptm.getString("parent_id"), list);
						}
					}
					
					//给每层的楼主添加回复到replybody中
					for(ParameterMap ptm:floorlist){
						if(commentMap.containsKey(ptm.getString("comment_id"))){
							ptm.put("replybody", commentMap.get(ptm.getString("comment_id")));
						}else{
							ptm.put("replybody", new ArrayList<>());
						}
					}
				}
			}else{
				floorlist = new ArrayList<>();
			}
			ParameterMap pmpage = new ParameterMap(page);
			map.put("page", pmpage);
			map.put("msg", "ok");
			map.put("status", "success");
			map.put("data", floorlist);
		} catch (Exception e) {
			e.printStackTrace();
			log.error("获取评论异常:"+e.getMessage(), e);
			map.put("status", "failed");
			map.put("msg", "获取评论失败");
		}
		return map;
	}

	@Override
	public Map<String,Object> savePraise(ParameterMap pm){
		Map<String, Object> map = new HashMap<>();
		try {
			Subject subject = SecurityUtils.getSubject();
			String tableId = pm.getString("table_id");
			String tableType = pm.getString("table_type");
			System.out.println("table_id="+tableId+", table_type="+tableType);
			if(StringUtils.isBlank(tableId) || StringUtils.isBlank(tableType)){
				map.put("msg", "你请求的是一个冒牌接口");
				map.put("status", "failed");
				return map;
			}
			Session session = subject.getSession();
			if(subject.isAuthenticated()){
				User user = (User) session.getAttribute(Const.BLOG_USER_SESSION);
				if(user != null){
					pm.put("user_id", user.getUser_id());
				}else{
					session.setAttribute(Const.BLOG_LAST_URL, "/article/"+pm.getString("table_id"));
					map.put("status", "auth");
					map.put("msg", "auth failed");
					return map;
				}
				ParameterMap repeatPraise = publicDao.repeatPraise(pm);
				if(repeatPraise != null && repeatPraise.size() > 0){
					pm.put("praise_type", "sub");
					System.out.println("pm="+pm);
					publicDao.updatePraiseNum(pm);
					publicDao.delPraise(pm);
				}else{
					pm.put("praise_type", "add");
					System.out.println("pm="+pm);
					int issuccess =  publicDao.updatePraiseNum(pm);
					if(issuccess > 0){//有修改记录，就保存点赞记录
						publicDao.savePraise(pm);
					}
				}
			}else{
				try {
					int index = 0;
					if("article".equalsIgnoreCase(tableType)){
						index = (int) session.getAttribute(Const.BLOG_ARTICLE_PRAISE_INDEX_+tableId);
					}else{
						index = (int) session.getAttribute(Const.BLOG_COMMENT_PRAISE_INDEX_+tableId);
					}
					if(index > 0){
						map.put("status", "failed");
						map.put("msg", "匿名只能赞一次");
						return map;
					}
				} catch (Exception e) {
				}
				pm.put("praise_type", "add");
				System.out.println("pm="+pm);
				int issuccess =  publicDao.updatePraiseNum(pm);
				if(issuccess > 0){//有修改记录，就保存点赞记录
					publicDao.savePraise(pm);
				}
				if("article".equalsIgnoreCase(tableType)){
					session.setAttribute(Const.BLOG_ARTICLE_PRAISE_INDEX_+tableId, 1);
				}else{
					session.setAttribute(Const.BLOG_COMMENT_PRAISE_INDEX_+tableId, 1);
				}
			}
			map.put("status", "success");
			map.put("msg", "ok");
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			log.error("点赞异常:"+e.getMessage(), e);
			map.put("status", "failed");
			map.put("msg", "点赞失败");
		}
		return map;
	}
	
	@Override
	public Map<String,Object> leaveword(ParameterMap pm){
		Map<String, Object> map = new HashMap<>();
		try {
			Subject subject = SecurityUtils.getSubject();
			Session session = subject.getSession();
			if(subject.isAuthenticated()){
				User user = (User) session.getAttribute(Const.BLOG_USER_SESSION);
				if(user != null){
					pm.put("user_id", user.getUser_id());
				}
			}else{
				try {
					int index = (int) session.getAttribute(Const.BLOG_LEAVEWORD_INDEX);
					if(index > 0){
						map.put("status", "failed");
						map.put("msg", "匿名只能留言一次");
						return map;
					}
				} catch (Exception e) {
				}
			}
			
			//线程发送邮件
			String message = pm.getString("content");
			EmailThread et = new EmailThread("1006059906@qq.com", "留言", message);
			new Thread(et).start();
			
			publicDao.saveLeaveWord(pm);
			session.setAttribute(Const.BLOG_LEAVEWORD_INDEX, 1);
			session.setTimeout(1000*60*20);
			map.put("status", "success");
			map.put("msg", "你的留言已发送给博主");
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			log.error("点赞异常:"+e.getMessage(), e);
			map.put("status", "failed");
			map.put("msg", "留言失败");
		}
		return map;
	}
	@Override
	public Map<String, Object> test(ParameterMap pm) {
		Map<String, Object> map = new HashMap<>();
		try {
			System.out.println("pm="+pm);
			JSONArray picArray = JSONArray.fromObject(pm.getString("data"));
			System.out.println("arr.size="+picArray.size());
			for (Object object : picArray) {
				System.out.println("object="+object.toString().length());
				
			}
			
			
			map.put("status", "success");
			map.put("msg", "ok");
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			log.error("点赞异常:"+e.getMessage(), e);
			map.put("status", "failed");
			map.put("msg", "留言失败");
		}
		return map;
	}
}
