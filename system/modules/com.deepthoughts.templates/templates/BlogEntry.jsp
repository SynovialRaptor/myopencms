<%@ page session="true" import="com.deepthoughts.templates.*, org.opencms.jsp.util.*"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%
	// create the bean
	BlogJspTemplate blog = new BlogJspTemplate(pageContext, request, response);
	// get the blog entry that was clicked on
	blog.getBlog(blog.getCmsObject().getRequestContext().getUri());
	// allow edit mode for offline previewing
	blog.editable();
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title><cms:property name="Title" /></title>
	<link rel="stylesheet" href="<cms:link>/styles/global.css</cms:link>" type="text/css" />
	<script language="JavaScript" src="<cms:link>/script/today.js</cms:link>"></script>
</head>

<body bgcolor="#C0DFFD">
	<%-- Include the user editable header content --%>
	<cms:include file="/index.html" element="Header" editable="true" />
	
	<%-- include the standard header code --%>
	<cms:include file="../elements/common.jsp" element="header" />

	<%-- Table, 7 cells across --%>
	<table border="0" cellspacing="0" cellpadding="0" align="center" width="100%">
	
		<!-- Content Row -->
		<tr align="left" valign="top">
			<%-- Left Rail --%>
			<td class="leftRail" align="left"></td>
	
			<%-- Para spacer left side --%>
			<td class="spacer" align="left"></td>
	
			<%-- Content --%>
			<td colspan="2" valign="top" align="left"><img src="<cms:link>/images/spacer.gif</cms:link>" alt="" height="1" border="0" /> <br />
				<table border="0" cellspacing="0" cellpadding="0" width="100%">

					<%-- Load all blogs in the most recent folder and display them --%>
					<% while (blog.hasMoreBlogs()) { %>
						<tr>
							<td width="100%" class="blogHeadline"><%=blog.getField("Title")%><cms:editable mode="manual" /></td>
						</tr>
						<tr>
							<td class="blogTimestamp"><%=BlogJspTemplate.formatDate(blog.getField("Date"), "dd.MM.yyyy")%></td>
						</tr>
						<tr>
							<td class="bodyText" valign="top">
								<div class="photo"><%=blog.getBlogImage(240)%><%=blog.getField("BlogText")%></div>
							</td>
						</tr>
						<tr>
							<td class="blogCategories"><br />
								<span class="label">TOPICS:&nbsp;</span> <%=blog.showTopics()%>
							</td>
						</tr>

						<%-- Comments --%>
						<tr>
							<td>
								<div id="blogComments">
									<h3 class="blogCommentsTitle">Comments</h3>
										<ul class="blogCommentList">
											<% 
												blog.getBlogComments();
												while (blog.hasMoreComments()) { %>
												<li>
													<div class="commentMeta">
														<b><%= blog.getBlogCommentUser() %></b><br/>
														<fmt:formatDate value="<%= blog.getBlogCommentDate() %>" 
															type="date" dateStyle="LONG" pattern="MM/dd/yyyy hh:mm a"/>
													</div>
													<div class="commentText"><%= blog.getCommentField("Comment") %></div>
													<div class="commentSpacer">&nbsp;</div>
												</li>
											<% } %>
										</ul>
								</div>
							</td>
						</tr>
						<tr>
							<td class="blogCategories">
								<a href="<%=blog.getAddCommentUrl()%>">Add your comment</a><br/>
							</td>
						</tr>
						
						<tr><td class="postDivider">&nbsp;</td></tr>
					<% } %>
				</table>
				<br />
			</td>
			<td width="10"><img src="<cms:link>/images/spacer.gif</cms:link>" alt="" width="10" height="1" border="0" /></td>
	
			<%-- Sidebar --%>
			<td valign="top">
				<div id="sidebar">
					<ul>
						<%-- Search Form --%>
						<cms:include file="../elements/common.jsp" element="search_form" />
			
						<%-- Ads --%>
						<cms:include file="../elements/common.jsp" element="adverts" />
			
						<%-- Archives --%>
						<cms:include file="../elements/common.jsp" element="archives" />
			
						<%-- RSS Client --%>
						<cms:include file="../elements/common.jsp" element="rss_client" />
			
						<%-- RSS Feed --%>
						<cms:include file="../elements/common.jsp" element="rss_feed" />
					</ul>
				</div>
			</td>
			<td>&nbsp;</td>
		</tr>
	
		<%-- Footer --%>
		<tr bgcolor="#CCFF99">
			<td>&nbsp;</td>
			<td colspan="5" class="pageFooter">
				<cms:include file="../elements/common.jsp" element="footer" />
			</td>
			<td>&nbsp;</td>
		</tr>
	</table>
</body>
</html>
