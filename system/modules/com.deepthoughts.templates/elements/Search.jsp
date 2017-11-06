<%@ page session="true" %>
<%@ page buffer="none" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ page import="com.deepthoughts.templates.*" %>
<%@ page import="org.opencms.main.*" %>
<%@ page import="org.opencms.search.*" %>
<%@ page import="org.opencms.file.*" %>
<%@ page import="org.opencms.jsp.*" %>
<%@ page import="java.util.*" %>
<%   
	// create the bean
	BlogJspTemplate blog = new BlogJspTemplate(pageContext, request, response);
%>
<jsp:useBean id="search" scope="request" class="com.deepthoughts.search.BlogSearch">
    <jsp:setProperty name = "search" property="*"/>
</jsp:useBean>
<%
	search.init(blog.getCmsObject());
	
	int resultno = 1;
	int pageno = 0;
	if (request.getParameter("searchPage")!=null) {		
		pageno = Integer.parseInt(request.getParameter("searchPage"))-1;
	}
	resultno = (pageno*search.getMatchesPerPage())+1;
	
	String fields = search.getFields();
	List result = search.getSearchResult();
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title><cms:property name="Title" /></title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<link rel="stylesheet" href="<cms:link>/styles/global.css</cms:link>" type="text/css" />
	<script language="JavaScript" src="<cms:link>/script/today.js</cms:link>"></script>
</head>

<body bgcolor="#C0DFFD">

	<%-- Include the header --%>
	<cms:include page="/index.html" element="Header" editable="true" />
	
	<%-- include the standard header code --%>
	<cms:include file="../elements/common.jsp" element="header" />

	<table border="0" cellspacing="0" cellpadding="0" align="center" width="100%">
		<%-- Table, 7 cells across --%>
		<tr align="left" valign="top">
			<%-- Left Rail --%>
			<td class="leftRail" align="left">
				<cms:include file="../elements/common.jsp" element="left_rail" />
			</td>
	
			<%-- Para spacer left side --%>
			<td class="spacer" align="left"></td>
	
			<%-- Search Results --%>
			<td colspan="2" valign="top" align="left"><img src="<cms:link>/images/spacer.gif</cms:link>" alt="" height="1" border="0" />&nbsp;<br />
				<table border="0" cellspacing="0" cellpadding="0" width="100%">
					<%-- Search Results --%>
					<%
					if (result != null) {
				        ListIterator iterator = result.listIterator();
						%>
						<tr><td width="100%" class="blogHeadline">Search For: <%=search.getQuery()%> found <%= search.getSearchResultCount() %> items</td></tr>
						<tr><td class="postDivider">&nbsp;</td></tr>
						<%
				        while (iterator.hasNext()) {
							CmsSearchResult entry = (CmsSearchResult)iterator.next();
							%>
								<TR>
									<TD class="blogSearchResult" width="100%">
										<%= resultno %>-  <a href="<%= blog.link(blog.getRequestContext().removeSiteRoot(entry.getPath())) %>"><%= entry.getTitle() %> (<%= entry.getScore() %> %)</a>
									</TD>
								</TR>
								<TR>
									<TD><p><%= entry.getExcerpt() %></p>
								    </TD>
								</TR>
								<tr><td><br/></td></tr>
							<%
							resultno++;
				        }
				        %>
						<tr>
							<td colspan="2" valign="top" align="left"><img src="<cms:link>/images/spacer.gif</cms:link>" alt="" width="680" height="1" border="0" />
						</td>
						<%
				    } else {
				        if (search.getLastException() != null) { 
							%>
								<TR>
									<TD>
										<h3>Error</h3>
										<%= search.getLastException().toString() %> 
								    </TD>
								</TR>
							<%
						}
				    }
					%>
					<TR>
						<TD class="blogCategories"><BR>
							<SPAN class="label">					
							<%
							if (search.getPreviousUrl() != null) {
								%>
								<a href="javascript:void(0);" onclick="location.href='<%= blog.link(search.getPreviousUrl()) %>&fields=<%= fields %>';"><< Previous</a>
								<%
							}
							Map pageLinks = search.getPageLinks();
							Iterator iter =  pageLinks.keySet().iterator();
							while (iter.hasNext()) {
								int pageNumber = ((Integer)iter.next()).intValue();
								String pageLink = blog.link((String)pageLinks.get(new Integer(pageNumber)));
								out.print("&nbsp; &nbsp;");
								if (pageNumber != search.getSearchPage()) {
									%>
									<a href="<%= pageLink %>&fields=<%= fields %>"><%= pageNumber %></a>
									<%
								} else {
									%>
									<span class="currentpage"><%= pageNumber %></span>
									<%
								}
							}
							if (search.getNextUrl() != null) {
								%>
								&nbsp; &nbsp;<a href="javascript:void(0);" onclick="location.href='<%= blog.link(search.getNextUrl()) %>&fields=<%= fields %>';">Next >></a>
								<%
							} 
							%>
							</SPAN>
						</TD>
					</TR>
				</table>
				<br />
			</td>
			
			<td width="10"><img src="<cms:link>/images/mm_spacer.gif</cms:link>" alt="" width="10" height="1" border="0" /></td>
	
			<%-- Sidebar --%>
			<td valign="top">
				<div id="sidebar">
				<ul>
					<%-- Search Form --%>
					<cms:include file="../elements/common.jsp" element="search_form" />
		
					<%-- Ads --%>
					<cms:include file="../elements/common.jsp" element="ads" />
		
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
