package com.lrs.blog.task;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.lrs.blog.service.ICacheService;
import com.lrs.util.MyLogger;
import com.lrs.util.ParameterMap;

/**
 * 定时执行器
 * 
 * @author Rs
 *
 */
@Component
public class TimeTask {

	@Autowired
	private ICacheService cacheService;

	private MyLogger log = MyLogger.getLogger(this.getClass());

	/**
	 * 每天凌晨1点10分刷一次
	 */
	@Scheduled(cron = "10 1 0 ? * *")
	public void homeArticle() {
		int issuccess = cacheService.cacheAllArticle(new ParameterMap());
		if (issuccess == 1) {
			log.info("定时刷新首页数据 成功");
		} else {
			log.info("定时刷新首页数据 失败");
		}
	}

	/**
	 * 每天凌晨1点刷一次
	 */
	@Scheduled(cron = "0 1 0 ? * *")
	public void monthArticle() {
		int issuccess = cacheService.cacheMonthArticle(new ParameterMap());
		if (issuccess == 1) {
			log.info("定时刷新归档数据 成功");
		} else {
			log.info("定时刷新归档数据 失败");
		}
	}

	/**
	 * 每天凌晨1点5分刷一次
	 */
	@Scheduled(cron = "5 1 0 ? * *")
	public void labelArticle() {
		int issuccess = cacheService.cacheLabelArticle(new ParameterMap());
		if (issuccess == 1) {
			log.info("定时刷新标签数据 成功");
		} else {
			log.info("定时刷新标签数据 失败");
		}
	}

	/**
	 * 每天一个小时 保存热门搜索缓存id
	 */
	@Scheduled(cron = "0 0 0/1 ? * *")
	public void reloadArticleHotNum() {
		int issuccess = cacheService.reloadArticleHotNum();
		if (issuccess == 1) {
			log.info("定时刷新标签数据 成功");
		} else if (issuccess == 2) {
			log.info("没有要插入的数据");
		} else {
			log.info("定时刷新标签数据 失败");
		}
	}

}
