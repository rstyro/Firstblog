package com.lrs.blog.init;

import javax.annotation.PostConstruct;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.lrs.blog.service.ICacheService;
import com.lrs.util.MyLogger;
import com.lrs.util.ParameterMap;

/**
 * 所有缓存初始化都放在这里
 * @author tyro
 *
 */
@Component
public class InitRedis {
	
	private MyLogger log = MyLogger.getLogger(this.getClass());
	
	@Autowired
	private ICacheService cacheService;
	/**
	 * 初始化方法
	 */
	@PostConstruct
	public void init() {
		System.out.println("============我是初始化方法，服务器启动我就加载==============");
		try {
			ParameterMap pm = new ParameterMap();
			cacheService.cacheAllArticle(pm);
			cacheService.cacheLabelArticle(pm);
			cacheService.cacheMonthArticle(pm);
			cacheService.cacheMusicList(pm);
			cacheService.cacheRecommendArticle(pm);
			cacheService.cacheHotArticle(pm);
			cacheService.cacheBloggerLabel(pm);
			log.info("缓存成功");
		} catch (Exception e) {
			// TODO: handle exception
			log.info("初始化缓存出错,可能redis服务没开启", e);
		}
	}
}
