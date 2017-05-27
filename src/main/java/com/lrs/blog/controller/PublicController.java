package com.lrs.blog.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lrs.blog.controller.base.BaseController;
import com.lrs.blog.service.IPublicService;
import com.lrs.util.MyUtil;
import com.lrs.util.ParameterMap;

@Controller
@RequestMapping("/public")
public class PublicController extends BaseController{
	
	@Autowired
	private IPublicService publicService;
	
	/**
	 * 关注
	 * @return
	 */
	@RequestMapping(value="/concern",method=RequestMethod.POST)
	@ResponseBody
	public Object concern(){
		log.info("点赞");
		ParameterMap pm = this.getParameterMap();
		Map<String, Object> map = publicService.concern(pm);
		return MyUtil.returnObject(pm, map);
	}
	
	
	/**
	 * 点赞
	 * @return
	 */
	@RequestMapping(value="/praise",method=RequestMethod.POST)
	@ResponseBody
	public Object praise(){
		log.info("点赞");
		ParameterMap pm = this.getParameterMap();
		Map<String, Object> map = publicService.savePraise(pm);
		return MyUtil.returnObject(pm, map);
	}
	
	/**
	 * 评论
	 * @return
	 */
	@RequestMapping(value="/comment",method=RequestMethod.POST)
	@ResponseBody
	public Object comment(){
		log.info("评论");
		ParameterMap pm = this.getParameterMap();
		String ip = this.getRemortIP();
		pm.put("ip", ip);
		Map<String, Object> map = publicService.comment(pm);
		return MyUtil.returnObject(pm, map);
	}
	
	
	/**
	 * 私信
	 * @return
	 */
	@RequestMapping(value="/letter",method=RequestMethod.POST)
	@ResponseBody
	public Object letter(){
		log.info("私信");
		ParameterMap pm = this.getParameterMap();
		String ip = this.getRemortIP();
		pm.put("ip", ip);
		Map<String, Object> map = publicService.letter(pm);
		return MyUtil.returnObject(pm, map);
	}
	
	/**
	 * 获取评论
	 * @return
	 */
	@RequestMapping(value="/getComment",method=RequestMethod.GET)
	@ResponseBody
	public Object getComment(){
		log.info("获取评论");
		ParameterMap pm = this.getParameterMap();
		String ip = this.getRemortIP();
		pm.put("ip", ip);
		Map<String, Object> map = publicService.getComment(pm);
		return MyUtil.returnObject(pm, map);
	}
	
	/**
	 * 删除评论
	 * @return
	 */
	@RequestMapping(value="/delComment",method=RequestMethod.GET)
	@ResponseBody
	public Object delComment(){
		log.info("删除评论");
		ParameterMap pm = this.getParameterMap();
		String ip = this.getRemortIP();
		pm.put("ip", ip);
		Map<String, Object> map = publicService.delComment(pm);
		return MyUtil.returnObject(pm, map);
	}
	
	/**
	 * 留言
	 * @return
	 */
	@RequestMapping(value="/leaveword",method=RequestMethod.POST)
	@ResponseBody
	public Object leaveword(){
		log.info("留言");
		ParameterMap pm = this.getParameterMap();
		String ip = this.getRemortIP();
		pm.put("ip", ip);
		Map<String, Object> map = publicService.leaveword(pm);
		return MyUtil.returnObject(pm, map);
	}
	
	
	/**
	 * test
	 * @return
	 */
	@RequestMapping(value="/test",method=RequestMethod.POST)
	@ResponseBody
	public Object testFromData(){
		log.info("test");
		ParameterMap pm = this.getParameterMap();
		String ip = this.getRemortIP();
		pm.put("ip", ip);
		Map<String, Object> map = publicService.test(pm);
		return MyUtil.returnObject(pm, map);
	}
}
