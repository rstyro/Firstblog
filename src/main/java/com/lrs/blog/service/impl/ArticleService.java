package com.lrs.blog.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lrs.blog.dao.ArticleDao;
import com.lrs.blog.dao.LabelDao;
import com.lrs.blog.redis.RedisClientTemplate;
import com.lrs.blog.service.IArticleService;
import com.lrs.plugin.Page;
import com.lrs.util.Const;
import com.lrs.util.ListTranscoder;
import com.lrs.util.ParameterMap;

@Service
public class ArticleService implements IArticleService {

	@Autowired
	private ArticleDao articleDao;
	
	@Autowired
	private LabelDao labelDao;
	
	private ListTranscoder<String> listTranscoder = new ListTranscoder<>();
	
	@Autowired
	private RedisClientTemplate redis;
	
	@Override
	public List<ParameterMap> getArticleMonthNum(ParameterMap pm) throws Exception {
		// TODO Auto-generated method stub
		return articleDao.getArticleMonthNum(pm);
	}
	
	@Override
	public List<ParameterMap> getArticlelistPage(Page page) throws Exception {
		// TODO Auto-generated method stub
		List<ParameterMap> articleList = articleDao.getArticlelistPage(page);
		if(StringUtils.isNotBlank(page.getPm().getString("keyword"))){
			if(articleList.size() > 0){
				List<String> cacheArticleIds= listTranscoder.deserialize(redis.get(Const.HOT_ARTICLE_ID_LIST.getBytes()));
				if(cacheArticleIds == null){
					cacheArticleIds = new ArrayList<>();
				}
				for(ParameterMap spm:articleList){
					cacheArticleIds.add(spm.getString("article_id"));
				}
				byte[] bys = listTranscoder.serialize(cacheArticleIds);
				if(bys != null && bys.length > 3){
					redis.set(Const.HOT_ARTICLE_ID_LIST.getBytes(), bys);
				}
			}
		}
		for (ParameterMap ptm : articleList) {
			// 给文章添加标签
			List<ParameterMap> articleLabel = labelDao.getArticleLabelById(ptm);
			if (articleLabel != null && articleLabel.size() > 0) {
				ptm.put("labels", articleLabel);
			}
		}
		return articleList;
	}
	
	@Override
	public ParameterMap getJumbotron(ParameterMap pm) throws Exception {
		// TODO Auto-generated method stub
		return articleDao.getJumbotron(pm);
	}
	
	@Override
	public ParameterMap getArticleDetail(ParameterMap pm) throws Exception {
		ParameterMap article = articleDao.getArticleDetail(pm);
		if(article == null || article.size() < 1){
			return null;
		}
		// 给文章添加标签
		List<ParameterMap> articleLabel = labelDao.getArticleLabelById(article);
		if (articleLabel != null && articleLabel.size() > 0) {
			article.put("labels", articleLabel);
		}
		return articleDao.getArticleDetail(pm);
	}
	
	@Override
	public int saveArticle(ParameterMap pm) throws Exception {
		// TODO Auto-generated method stub
		articleDao.saveArticle(pm);
		String labelidStirng = pm.getString("labels");
		if (StringUtils.isNotBlank(labelidStirng)) {
			String[] labelIds = pm.getString("labels").split(",");
			System.out.println(labelIds);
			System.out.println("labelids-length=" + labelIds.length);
			if (labelIds.length > 0) {
				List<ParameterMap> articlelabelList = new ArrayList<>();
				String articleId = pm.getString("id");
				System.out.println("id===" + articleId);
				for (int i = 0; i < labelIds.length; i++) {
					String labelId = labelIds[i];
					ParameterMap parameData = new ParameterMap();
					parameData.put("article_id", articleId);
					parameData.put("label_id", labelId);
					articlelabelList.add(parameData);
				}
				if (articlelabelList.size() > 0) {
					labelDao.batchSaveArticleLabel(articlelabelList);
				}
			}
		}
		return 1;
	}
	
	@Override
	public int updateArticle(ParameterMap pm) throws Exception {
		// TODO Auto-generated method stub
		articleDao.updateArticle(pm);
		String articleId = pm.getString("article_id");
		String labelidStirng = pm.getString("labels");
		if (StringUtils.isNotBlank(labelidStirng)) {
			String[] labelIds = pm.getString("labels").split(",");
			if (labelIds.length > 0) {
				List<ParameterMap> articlelabelList = new ArrayList<>();
				System.out.println("id===" + articleId);
				for (int i = 0; i < labelIds.length; i++) {
					String labelId = labelIds[i];
					ParameterMap parameData = new ParameterMap();
					parameData.put("article_id", articleId);
					parameData.put("label_id", labelId);
					articlelabelList.add(parameData);
				}
				if (articlelabelList.size() > 0) {
					labelDao.delArticleLabel(pm);
					labelDao.batchSaveArticleLabel(articlelabelList);
				}
			}
		}
		return 1;
	}

	@Override
	public List<ParameterMap> getLabelArticleListPage(ParameterMap pm) throws Exception {
		List<ParameterMap> list = articleDao.getArticleIdsByLabelId(pm);
		if(list.size() > 0){
			List<ParameterMap> articleList=articleDao.getLabelArticleList(list);
			for (ParameterMap ptm : articleList) {
				// 给文章添加标签
				List<ParameterMap> articleLabel = labelDao.getArticleLabelById(ptm);
				if (articleLabel != null && articleLabel.size() > 0) {
					ptm.put("labels", articleLabel);
				}
			}
			return articleList;
		}else{
			return new ArrayList<>();
		}
	}
	
	@Override
	public List<ParameterMap> getRecommendArticle(ParameterMap pm) throws Exception {
		// TODO Auto-generated method stub
		return articleDao.getRecommendArticle(pm);
	}
	
	@Override
	public List<ParameterMap> gethotArticle(ParameterMap pm) throws Exception {
		// TODO Auto-generated method stub
		return articleDao.getHotArticle(pm);
	}

	@Override
	public int delArticle(ParameterMap pm) throws Exception {
		// TODO Auto-generated method stub
		return articleDao.delArticle(pm);
	}
}
