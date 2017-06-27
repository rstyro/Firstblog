<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<div class="row">
	<div class="panel panel-default">
		<div class="panel-heading">
			<h3 class="panel-title">
				<i class="glyphicon glyphicon-leaf"></i><strong> 个人资料</strong>
			</h3>
		</div>
		<div class="panel-body">
			<div class="row">
				<div class="col-md-4 blog-info-head">
					<a href="<%=request.getContextPath()%>/user/${userInfo.user_id }/1"><img src="${userInfo.img }"></a>
					<c:if test="${concern.concern_flag == '1' }">
						<a href="javascript:void(0)" uid="${userInfo.user_id }" 
						 class="btn btn-default-concern btn-concern">
							<span>已关注</span>
						</a>
					</c:if>
					<c:if test="${concern.concern_flag == '0' }">
						<a href="javascript:void(0)" uid="${userInfo.user_id }" 
						 class="btn btn-info btn-concern">
							<span class="glyphicon glyphicon-plus"></span><span> 关注</span>
						</a>
					</c:if>
					<a href="javascript:void(0)" uid="${userInfo.user_id }" uname="${userInfo.name }" class="btn btn-success btn-letter" > <span
						class="glyphicon glyphicon-envelope"></span><span> 私信</span></a>
				</div>
				<div class="col-md-8">
					<a href="<%=request.getContextPath()%>/user/${userInfo.user_id }/1" class="index-user"><h4>
						<i class="glyphicon glyphicon-fire red"></i> <font
							style="font-weight: bold;">${userInfo.name }</font>
					</h4></a>
					<p>
						<i class="glyphicon glyphicon-info-sign green"></i> ${userInfo.sign }
					</p>
					<p>
						<i class="glyphicon glyphicon-map-marker green"></i> ${userInfo.locate }
					</p>
					<div class="row">
						<div class="col-sm-1 col-md-2">
							<i class="glyphicon glyphicon glyphicon-tags green"></i>
						</div>
						<div class="col-sm-11 col-md-10">
							<div class="blog-labels">
								<c:choose>
									<c:when test="${not empty userLabels}">
										<c:forEach items="${userLabels}" var="label" varStatus="vs">
											<div class="${label.label_class}">
												<a title="${label.label_name } 的标签">${label.label_name }</a>
											</div>
										</c:forEach>
									</c:when>
									<c:otherwise>
										<div class="center">没有标签</div>
									</c:otherwise>
								</c:choose>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<div style="height: 10px;"></div>
<div class="row">
	<div class="panel panel-default">
		<div class="panel-heading">
			<h3 class="panel-title">
				<i class="glyphicon glyphicon-tags"></i><strong> 文章标签</strong>
			</h3>
		</div>
		<div class="panel-body">
			<div id="tagcloud">
				<c:choose>
					<c:when test="${not empty article_labels}">
						<c:forEach items="${article_labels}" var="label" varStatus="vs">
								<a
									href="<%=request.getContextPath()%>/article/label/${label.label_id}/1"
									title="带有${label.label_name }标签的所有文章" class="${label.label_class }">${label.label_name }</a>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<div class="center">没有相关数据</div>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
	</div>
</div>
<div style="height: 10px;"></div>
<div class="row">
	<div class="panel panel-default">
		<div class="panel-heading">
			<h3 class="panel-title">
				<i class="glyphicon glyphicon-tasks"></i><strong> 文章存档</strong>
			</h3>
		</div>
		<div class="panel-body">
			<ul class="list-group">
				<c:choose>
					<c:when test="${not empty article_month}">
						<c:forEach items="${article_month }" var="var" varStatus="vs">
							<li class="list-group-item" id="${var.article_month }"
								title="${var.article_month } 共发布了 ${var.count } 篇文章">${var.article_month }<span
								class="badge">${var.count }</span></li>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<li class="list-group-item">暂无文章</li>
					</c:otherwise>
				</c:choose>
			</ul>
		</div>
	</div>
</div>

<div style="height: 10px;"></div>
<div class="row">
	<div class="panel panel-default">
		<div class="panel-heading">
			<h3 class="panel-title">
				<i class="glyphicon glyphicon-tasks"></i><strong> 我的技能雷达</strong>
			</h3>
		</div>
		<div class="panel-body">
			<div class="row">
				<div id="my-skills"></div>
			</div>
		</div>
	</div>
</div>
<div style="height: 10px;"></div>
<div class="row">
	<div class="panel panel-default">
		<div class="panel-heading">
			<h3 class="panel-title">
				<i class="glyphicon glyphicon-bookmark"></i><strong> 文章推荐</strong>
			</h3>
		</div>
		<div class="panel-body">
			<c:choose>
				<c:when test="${not empty article_recommend }">
				<ul class="blog_article_recommend_ul">
					<c:forEach items="${article_recommend }" var="recommend"
						varStatus="vs">
						<li  title="${recommend.title }">
							<span class="r_n">${vs.index+1 }</span>
							<a
								href="<%=request.getContextPath()%>/article/${recommend.article_id }">
								<c:choose>
									<c:when test="${fn:length(recommend.title) > 20}">
										<c:out value="${fn:substring(recommend.title, 0, 20)}..." />
									</c:when>
									<c:otherwise>
										<c:out value="${recommend.title}" />
									</c:otherwise>
								</c:choose>
							</a>
						</li>
					</c:forEach>
				</ul>
				</c:when>
				<c:otherwise>
					<ul>
						<li>
							暂无推荐文章
						</li>
					</ul>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
</div>
<div style="height: 10px;"></div>
<div class="row">
	<div class="panel panel-default">
		<div class="panel-heading">
			<h3 class="panel-title">
				<i class="glyphicon glyphicon-link"></i><strong> 友情链接</strong>
			</h3>
		</div>
		<div class="panel-body">
				<ul class="blog_link">
					<c:choose>
						<c:when test="${not empty linkList }">
							<c:forEach items="${linkList }" var="link" varStatus="vs">
								<li><a target="_blank" href="${link.link }">${link.link_name }</a></li>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<li><a target="_blank" href="http://lrshuai.top">这个冬天不太冷</a></li>
						</c:otherwise>
					</c:choose>
				</ul>
		</div>
	</div>
</div>

