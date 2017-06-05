package com.lrs.blog.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.lrs.blog.dao.LabelDao;
import com.lrs.blog.service.ILabelService;
import com.lrs.util.ParameterMap;

@Service
public class LabelService implements ILabelService {

	@Autowired
	private LabelDao labelDao;

	@Override
	public List<ParameterMap> getArticleLabels(ParameterMap pm) throws Exception {
		return labelDao.getArticleLabels(pm);
	}

	@Override
	public int delArticleLabel(ParameterMap pm) throws Exception {
		// TODO Auto-generated method stub
		return labelDao.delArticleLabel(pm);
	}
}
