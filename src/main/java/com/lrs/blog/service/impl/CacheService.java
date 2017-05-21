package com.lrs.blog.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lrs.blog.dao.ArticleDao;
import com.lrs.blog.dao.CacheDao;
import com.lrs.blog.dao.LabelDao;
import com.lrs.blog.redis.RedisClientTemplate;
import com.lrs.blog.service.ICacheService;
import com.lrs.plugin.Page;
import com.lrs.util.Const;
import com.lrs.util.ListTranscoder;
import com.lrs.util.MyLogger;
import com.lrs.util.ParameterMap;

@Service
public class CacheService implements ICacheService {

	@Autowired
	private CacheDao cacheDao;

	@Autowired
	private ArticleDao articleDao;

	@Autowired
	private LabelDao labelDao;

	private MyLogger log = MyLogger.getLogger(this.getClass());

	private ListTranscoder<ParameterMap> listTranscoder = new ListTranscoder<>();
	
	@Autowired
	private RedisClientTemplate redis;

	@Override
	public int cacheAllArticle(ParameterMap pm) {
		try {
		Page page = new Page();
		page.setPm(pm);
		List<ParameterMap> articleList = articleDao.getArticlelistPage(page);
		if (articleList != null && articleList.size() > 0) {
			for (ParameterMap ptm : articleList) {
				// 给文章添加标签
				List<ParameterMap> articleLabel = labelDao.getArticleLabelById(ptm);
				if (articleLabel != null && articleLabel.size() > 0) {
					ptm.put("labels", articleLabel);
				}else{
					ptm.put("labels", new ArrayList<>());
				}
			}
			byte[] bys = listTranscoder.serialize(articleList);
			redis.set(Const.ARTICLE_HOME.getBytes(), bys);
			log.info("cache article-home is success");
		} else {
			redis.set(Const.ARTICLE_HOME.getBytes(), listTranscoder.serialize(new ArrayList<ParameterMap>()));
			log.info("article-home is null or article-home this size is zero");
		}
		
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			log.error("cache article home is failed:"+e.getMessage(), e);
			return 0;
		}
		return 1;
	}

	@Override
	public int cacheHotArticle(ParameterMap pm) {
		try {
			// TODO Auto-generated method stub
			List<ParameterMap> hotList = articleDao.getHotArticle(pm);
			if (hotList != null && hotList.size() > 0) {
				byte[] bys = listTranscoder.serialize(hotList);
				redis.set(Const.ARTICLE_HOT.getBytes(), bys);
				log.info("cache hot article success");
			} else {
				redis.set(Const.ARTICLE_HOT.getBytes(), listTranscoder.serialize(new ArrayList<ParameterMap>()));
				log.info("cache hot article success but hot Article is null");
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			log.info("cache hot_article is failed:"+e.getMessage(), e);
			return 0;
		}
		return 1;
	}

	@Override
	public int cacheMonthArticle(ParameterMap pm) {
		try {
			// 缓存归档列表
			List<ParameterMap> articleMonthNum = articleDao.getArticleMonthNum(pm);
			if (articleMonthNum != null && articleMonthNum.size() > 0) {
				byte[] monthnumbys = listTranscoder.serialize(articleMonthNum);
				redis.set(Const.ARTICLE_MONTH.getBytes(), monthnumbys);
				log.info("cache month is success");
			} else {
				redis.set(Const.ARTICLE_MONTH.getBytes(), listTranscoder.serialize(new ArrayList<ParameterMap>()));
				return 0;
			}
			String articleMonth = pm.getString("article_month");
			// 缓存所有归档日期下的列表
			if (StringUtils.isBlank(articleMonth) || "all".equals(articleMonth)) {
				for (ParameterMap ptMap : articleMonthNum) {
					Page page = new Page();
					page.setPm(ptMap);
					List<ParameterMap> articleList = articleDao.getArticlelistPage(page);
					if (articleList != null && articleList.size() > 0) {
						for (ParameterMap ptm : articleList) {
							// 给文章添加标签
							List<ParameterMap> articleLabel = labelDao.getArticleLabelById(ptm);
							if (articleLabel != null && articleLabel.size() > 0) {
								ptm.put("labels", articleLabel);
							}else{
								ptm.put("labels", new ArrayList<>());
							}
						}
						byte[] bys = listTranscoder.serialize(articleList);
						String month = ptMap.getString("article_month");
						// 缓存归档日期下的文章列表
						redis.set((Const.ARTICLE_MONTH_ + month).getBytes(), bys);
						log.info("cache month =" + month + " success");
					}
				}
			} else {
				// 只缓存特定的归档日期
				Page page = new Page();
				page.setPm(pm);
				List<ParameterMap> articleList = articleDao.getArticlelistPage(page);
				byte[] bys = listTranscoder.serialize(articleList);
				// 缓存归档日期下的文章列表
				redis.set((Const.ARTICLE_MONTH_ + articleMonth).getBytes(), bys);
				log.info("cache month =" + articleMonth + " success");
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			log.info("cache month is err:" + e.getMessage(), e);
			return 0;
		}
		return 1;
	}

	@Override
	public int cacheLabelArticle(ParameterMap pm) {
		try {
		// 所有文章的标签
		List<ParameterMap> articleLabels = labelDao.getArticleLabels(pm);
		if (articleLabels != null && articleLabels.size() > 0) {
			byte[] bys = listTranscoder.serialize(articleLabels);
			redis.set((Const.ARTICLE_LABEL).getBytes(), bys);
			log.info("cache labels is success");
		} else {
			return 0;
		}
		// 缓存标签下的文章列表
		String articleLabelId = pm.getString("label_id");
		if (StringUtils.isBlank(articleLabelId) || "all".equals(articleLabelId)) {
			for (ParameterMap ptMap : articleLabels) {
				List<ParameterMap> list = articleDao.getArticleIdsByLabelId(ptMap);
				String labelId = ptMap.getString("label_id");
				if (list != null && list.size() > 0) {
					List<ParameterMap> articleList = articleDao.getLabelArticleList(list);
					if (articleList != null && articleList.size() > 0) {
						for (ParameterMap ptm : articleList) {
							// 给文章添加标签
							List<ParameterMap> articleLabel = labelDao.getArticleLabelById(ptm);
							if (articleLabel != null && articleLabel.size() > 0) {
								ptm.put("labels", articleLabel);
							}else{
								ptm.put("labels", new ArrayList<>());
							}
						}
						byte[] bys = listTranscoder.serialize(articleList);
						// 缓存归档日期下的文章列表
						redis.set((Const.ARTICLE_LABEL_ + labelId).getBytes(), bys);
						log.info("cache label =" + ptMap.getString("label_name") + " success");
					} else {
						redis.set((Const.ARTICLE_LABEL_ + labelId).getBytes(),
								listTranscoder.serialize(new ArrayList<>()));
						log.info("cache label = " + ptMap.getString("label_name") + " success but this is null Array");
					}
				}else{
					redis.set((Const.ARTICLE_LABEL_ + labelId).getBytes(),
							listTranscoder.serialize(new ArrayList<>()));
					log.info("cache label = " + ptMap.getString("label_name") + " success but this is null Array");
				}
			}
		} else {
			List<ParameterMap> list = articleDao.getArticleIdsByLabelId(pm);
			List<ParameterMap> articleList = articleDao.getLabelArticleList(list);
			if (articleList != null && articleList.size() > 0) {
				for (ParameterMap ptm : articleList) {
					// 给文章添加标签
					List<ParameterMap> articleLabel = labelDao.getArticleLabelById(ptm);
					if (articleLabel != null && articleLabel.size() > 0) {
						ptm.put("labels", articleLabel);
					}else{
						ptm.put("labels", new ArrayList<>());
					}
				}
				byte[] bys = listTranscoder.serialize(articleList);
				// 缓存归档日期下的文章列表
				redis.set((Const.ARTICLE_LABEL_ + articleLabelId).getBytes(), bys);
				log.info("cache label_id =" + articleLabelId + " success");
			}
		}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			log.info("cache label is failed:"+e.getMessage(), e);
			return 0;
		}
		return 1;
	}
	
	/**
	 * 保存在缓存中的热门搜索ids
	 * @param pm
	 * @return
	 */
	@Override
	public int reloadArticleHotNum() {
		ListTranscoder<String> lts = new ListTranscoder<>();
		try {
			byte[] bys = redis.get(Const.HOT_ARTICLE_ID_LIST.getBytes());
			if(bys != null && bys.length > 3){
				List<String> ids = lts.deserialize(bys);
				System.out.println("ids.size="+ids.size());
				if(ids.size() > 0){
					articleDao.updateArticleHotNum(ids);
					//重置
					redis.set(Const.HOT_ARTICLE_ID_LIST.getBytes(), lts.serialize(new ArrayList<>()));
				}else{
					return 2;
				}
			}else{
				return 2;
			}
		} catch (Exception e) {
			log.error("刷新 热值错误", e);
			return 0;
		}
		return 1;
	}

	@Override
	public int cacheRecommendArticle(ParameterMap pm) {
		try {
			// TODO Auto-generated method stub
			List<ParameterMap> recommendList = articleDao.getRecommendArticle(pm);
			if (recommendList != null && recommendList.size() > 0) {
				byte[] bys = listTranscoder.serialize(recommendList);
				redis.set(Const.ARTICLE_RECOMMEND.getBytes(), bys);
				log.info("cache recommend article success");
			} else {
				redis.set(Const.ARTICLE_RECOMMEND.getBytes(), listTranscoder.serialize(new ArrayList<ParameterMap>()));
				log.info("cache recommend article success but recommend Article is null");
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			log.info("cache recommend is failed:"+e.getMessage(), e);
			return 0;
		}
		return 1;
	}
	
	@Override
	public int cacheFriendLink() {
		try {
			List<ParameterMap> links = cacheDao.friendlinkList(new ParameterMap());
			if(links != null && links.size() > 0){
				byte[] bys = listTranscoder.serialize(links);
				redis.set(Const.BLOG_FRIEND_LINK.getBytes(), bys);
				log.info("cache friend links success");
			} else {
				redis.set(Const.BLOG_FRIEND_LINK.getBytes(), listTranscoder.serialize(new ArrayList<ParameterMap>()));
				log.info("cache friend links success but links  is null");
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.getMessage();
			log.error("cache link error", e);
			return 0;
		}
		return 1;
	}
	
	@Override
	public int cacheBloggerLabel(ParameterMap pm) {
		try {
			String userId = pm.getString("user_id");
			if(StringUtils.isBlank(userId)){
				userId="1";
			}
			pm.put("user_id",userId);
			List<ParameterMap> labels = labelDao.getUserLabel(pm);
			if(labels != null && labels.size() > 0){
				byte[] bys = listTranscoder.serialize(labels);
				redis.set((Const.BLOG_USER_LABEL_+userId).getBytes(), bys);
				log.info("cache blogger labels success");
			} else {
				redis.set((Const.BLOG_USER_LABEL_+userId).getBytes(), listTranscoder.serialize(new ArrayList<ParameterMap>()));
				log.info("cache blogger labels success but labels is null");
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.getMessage();
			log.error("cache blogger labels error", e);
			return 0;
		}
		return 1;
	}
	
	@Override
	public List<ParameterMap> getCacheBloggerLabel(String userId) throws Exception {
		byte[] bys = redis.get((Const.BLOG_USER_LABEL_+userId).getBytes());
		if (bys != null && bys.length > 3)
			return listTranscoder.deserialize(bys);
		return new ArrayList<>();
	}

	@Override
	public List<ParameterMap> getCacheAllArticle(ParameterMap pm) throws Exception {
		byte[] bys = redis.get(Const.ARTICLE_HOME.getBytes());
		if (bys != null && bys.length > 3)
			return listTranscoder.deserialize(bys);
		return new ArrayList<>();
	}

	@Override
	public List<ParameterMap> getCacheMonthArticle(ParameterMap pm) throws Exception {
		String month = pm.getString("article_month");
		byte[] bys = null;
		if (StringUtils.isBlank(month) || "all".equals(month)) {
			bys = redis.get(Const.ARTICLE_MONTH.getBytes());
		} else {
			bys = redis.get((Const.ARTICLE_MONTH_ + month).getBytes());
		}
		if (bys != null &&  bys.length > 3)
			return listTranscoder.deserialize(bys);
		return null;
	}

	@Override
	public List<ParameterMap> getCacheLabelArticle(ParameterMap pm) throws Exception {
		String labelId = pm.getString("label_id");
		byte[] bys = null;
		if (StringUtils.isBlank(labelId) || "all".equals(labelId)) {
			bys = redis.get(Const.ARTICLE_LABEL.getBytes());
		} else {
			bys = redis.get((Const.ARTICLE_LABEL_ + labelId).getBytes());
		}
		if (bys != null &&  bys.length > 3)
			return listTranscoder.deserialize(bys);
		return null;
	}

	@Override
	public List<ParameterMap> getCacheRecommendArticle(ParameterMap pm) throws Exception {
		byte[] bys = redis.get(Const.ARTICLE_RECOMMEND.getBytes());
		if (bys != null && bys.length > 3)
			return listTranscoder.deserialize(bys);
		return null;
	}
	
	@Override
	public List<ParameterMap> getCacheHotArticle(ParameterMap pm) throws Exception {
		byte[] bys = redis.get(Const.ARTICLE_HOT.getBytes());
		if (bys != null && bys.length > 3)
			return listTranscoder.deserialize(bys);
		return null;
	}
	
	@Override
	public List<ParameterMap> getCacheLinks(ParameterMap pm) throws Exception {
		byte[] bys = redis.get(Const.BLOG_FRIEND_LINK.getBytes());
		if (bys != null && bys.length > 3)
			return listTranscoder.deserialize(bys);
		return null;
	}
	
	@Override
	public int cacheMusicList(ParameterMap pm) {
		try {
			List<ParameterMap> list = cacheDao.findMusiclist(pm);
			if(list != null && list.size() > 0){
				byte[] bys = listTranscoder.serialize(list);
				redis.set(Const.MUSIC_LIST.getBytes(), bys);
			}else{
				redis.set(Const.MUSIC_LIST.getBytes(), listTranscoder.serialize(new ArrayList<>()));
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.getMessage();
			log.info("音乐缓存失败:"+e.getMessage(), e);
			return 0;
		}
		return 1;
	}
	
	@Override
	public List<ParameterMap> findMusiclist(ParameterMap pm) throws Exception {
		byte[] bys = redis.get(Const.MUSIC_LIST.getBytes());
		if (bys != null && bys.length > 3)
			return listTranscoder.deserialize(bys);
		return null;
	}


}
