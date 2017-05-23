package com.lrs.blog.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lrs.blog.controller.base.BaseController;
import com.lrs.blog.service.INoticeService;
import com.lrs.util.MyUtil;
import com.lrs.util.ParameterMap;

@Controller
@RequestMapping("/notice")
public class NoticeController extends BaseController{
	
	@Autowired
	private INoticeService noticeService;
	
	/**
	 * 获取关注消息列表
	 * @return
	 */
	@RequestMapping(value="/getConcernList",method=RequestMethod.GET)
	@ResponseBody
	public Object getConcernList(){
		printLogger(log, "关注消息列表");
		ParameterMap pm = this.getParameterMap();
		pm.put("notice_type", "concern");
		Map<String,Object> map = noticeService.getNoticeListByType(pm);
		return MyUtil.returnObject(pm, map);
	}
	
	
	/**
	 * 获取点赞消息列表
	 * @return
	 */
	@RequestMapping(value="/getPraiseList",method=RequestMethod.GET)
	@ResponseBody
	public Object getPraiseList(){
		printLogger(log, "点赞消息列表");
		ParameterMap pm = this.getParameterMap();
		pm.put("notice_type", "praise");
		Map<String,Object> map = noticeService.getNoticeListByType(pm);
		return MyUtil.returnObject(pm, map);
	}
	
	
	/**
	 * 获取信件消息列表
	 * @return
	 */
	@RequestMapping(value="/getLetterList",method=RequestMethod.GET)
	@ResponseBody
	public Object getLetterList(){
		printLogger(log, "信件消息列表");
		ParameterMap pm = this.getParameterMap();
		pm.put("notice_type", "letter");
		Map<String,Object> map = noticeService.getNoticeListByType(pm);
		return MyUtil.returnObject(pm, map);
	}
	
	/**
	 * 获取信件详情
	 * @return
	 */
	@RequestMapping(value="/getLetterDetail",method=RequestMethod.GET)
	@ResponseBody
	public Object getLetterDetail(){
		printLogger(log, "信件消息详情");
		ParameterMap pm = this.getParameterMap();
		Map<String,Object> map = noticeService.getLetterDetail(pm);
		return MyUtil.returnObject(pm, map);
	}
	
	
	/**
	 * 获取信件详情
	 * @return
	 */
	@RequestMapping(value="/replyLetter",method=RequestMethod.POST)
	@ResponseBody
	public Object replyLetter(){
		printLogger(log, "回复信件");
		ParameterMap pm = this.getParameterMap();
		Map<String,Object> map = noticeService.replyLetter(pm);
		return MyUtil.returnObject(pm, map);
	}
	
	
}
