package com.lrs.blog.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lrs.blog.controller.base.BaseController;
import com.lrs.blog.service.ICacheService;
import com.lrs.util.ParameterMap;

/**
 * 更新缓存控制层
 * 
 * @author Rs
 *
 */
@Controller
@RequestMapping(value = "/reload")
public class CacheController extends BaseController {

	@Autowired
	private ICacheService cacheService;

	/**
	 * 刷新首页文章缓存
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/homeArticle", method = RequestMethod.GET)
	@ResponseBody
	public Object cacheArticle() throws Exception {
		printLogger(log, "刷新首页文章缓存");
		Map<String, Object> map = new HashMap<>();
		ParameterMap pm = this.getParameterMap();
		int issuccess = cacheService.cacheAllArticle(pm);
		if (issuccess == 1) {
			map.put("msg", "缓存成功");
			map.put("status", "success");
		} else {
			map.put("msg", "缓存失败");
			map.put("status", "failed");
		}
		return map;
	}

	/**
	 * 刷新归档文章缓存
	 * 
	 * @return
	 * @throws Exception
	 * @param article_month
	 */
	@RequestMapping(value = "/monthArticle", method = RequestMethod.GET)
	@ResponseBody
	public Object cacheMonthArticle() throws Exception {
		printLogger(log, "刷新归档文章缓存");
		Map<String, Object> map = new HashMap<>();
		ParameterMap pm = this.getParameterMap();
		int issuccess = cacheService.cacheMonthArticle(pm);
		if (issuccess == 1) {
			map.put("msg", "缓存成功");
			map.put("status", "success");
		} else {
			map.put("msg", "缓存失败");
			map.put("status", "failed");
		}
		return map;
	}

	/**
	 * 刷新标签文章缓存
	 * 
	 * @return
	 * @throws Exception
	 * @param label_id
	 */
	@RequestMapping(value = "/labelArticle", method = RequestMethod.GET)
	@ResponseBody
	public Object cacheLabelArticle() throws Exception {
		printLogger(log, "刷新标签文章缓存");
		Map<String, Object> map = new HashMap<>();
		ParameterMap pm = this.getParameterMap();
		int issuccess = cacheService.cacheLabelArticle(pm);
		if (issuccess == 1) {
			map.put("msg", "缓存成功");
			map.put("status", "success");
		} else {
			map.put("msg", "缓存失败");
			map.put("status", "failed");
		}
		return map;
	}

	/**
	 * 刷新推荐文章缓存
	 * 
	 * @return
	 * @throws Exception
	 * @param label_id
	 */
	@RequestMapping(value = "/recommendArticle", method = RequestMethod.GET)
	@ResponseBody
	public Object cacheRecommendArticle() throws Exception {
		printLogger(log, "刷新推荐文章缓存");
		Map<String, Object> map = new HashMap<>();
		ParameterMap pm = this.getParameterMap();
		int issuccess = cacheService.cacheRecommendArticle(pm);
		if (issuccess == 1) {
			map.put("msg", "缓存成功");
			map.put("status", "success");
		} else {
			map.put("msg", "缓存失败");
			map.put("status", "failed");
		}
		return map;
	}

	/**
	 * 刷新热门文章缓存
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/hotArticle", method = RequestMethod.GET)
	@ResponseBody
	public Object cacheHotArticle() throws Exception {
		printLogger(log, "刷新热门文章缓存");
		Map<String, Object> map = new HashMap<>();
		ParameterMap pm = this.getParameterMap();
		int issuccess = cacheService.cacheHotArticle(pm);
		if (issuccess == 1) {
			map.put("msg", "缓存成功");
			map.put("status", "success");
		} else {
			map.put("msg", "缓存失败");
			map.put("status", "failed");
		}
		return map;
	}

	/**
	 * 刷新音乐缓存
	 * 
	 * @return
	 * @throws Exception
	 * @param label_id
	 */
	@RequestMapping(value = "/music", method = RequestMethod.GET)
	@ResponseBody
	public Object cacheMusic() throws Exception {
		printLogger(log, "刷新音乐缓存");
		Map<String, Object> map = new HashMap<>();
		ParameterMap pm = this.getParameterMap();
		int issuccess = cacheService.cacheMusicList(pm);
		if (issuccess == 1) {
			map.put("msg", "缓存成功");
			map.put("status", "success");
		} else {
			map.put("msg", "缓存失败");
			map.put("status", "failed");
		}
		return map;
	}

	/**
	 * 刷新友链缓存
	 * 
	 * @return
	 * @throws Exception
	 * @param label_id
	 */
	@RequestMapping(value = "/links", method = RequestMethod.GET)
	@ResponseBody
	public Object cacheLinks() throws Exception {
		printLogger(log, "刷新友链缓存");
		Map<String, Object> map = new HashMap<>();
		int issuccess = cacheService.cacheFriendLink();
		if (issuccess == 1) {
			map.put("msg", "缓存成功");
			map.put("status", "success");
		} else {
			map.put("msg", "缓存失败");
			map.put("status", "failed");
		}
		return map;
	}

	/**
	 * 刷新博主标签缓存
	 * 
	 * @return
	 * @throws Exception
	 * @param label_id
	 */
	@RequestMapping(value = "/bloggerLabels", method = RequestMethod.GET)
	@ResponseBody
	public Object cacheBloggerLabels() throws Exception {
		printLogger(log, "刷新博主标签缓存");
		Map<String, Object> map = new HashMap<>();
		ParameterMap pm = this.getParameterMap();
		int issuccess = cacheService.cacheBloggerLabel(pm);
		if (issuccess == 1) {
			map.put("msg", "缓存成功");
			map.put("status", "success");
		} else {
			map.put("msg", "缓存失败");
			map.put("status", "failed");
		}
		return map;
	}
	
	/**
	 * 刷新用户标签缓存
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/userLabels", method = RequestMethod.GET)
	@ResponseBody
	public Object cacheUserLabels() throws Exception {
		printLogger(log, "刷新用户标签缓存");
		Map<String, Object> map = new HashMap<>();
		ParameterMap pm = this.getParameterMap();
		int issuccess = cacheService.cacheUserLabel(pm);
		if (issuccess == 1) {
			map.put("msg", "缓存成功");
			map.put("status", "success");
		} else {
			map.put("msg", "缓存失败");
			map.put("status", "failed");
		}
		return map;
	}

	/**
	 * 主动刷新 热门搜索的ids
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/hotNum", method = RequestMethod.GET)
	@ResponseBody
	public Object hotNum() throws Exception {
		printLogger(log, "刷新文章热值");
		Map<String, Object> map = new HashMap<>();
		int issuccess = cacheService.reloadArticleHotNum();
		if (issuccess == 1) {
			map.put("msg", "缓存成功");
			map.put("status", "success");
		} else if (issuccess == 2) {
			map.put("msg", "数据为空");
			map.put("status", "success");
		} else {
			map.put("msg", "缓存失败");
			map.put("status", "failed");
		}
		return map;
	}

}
