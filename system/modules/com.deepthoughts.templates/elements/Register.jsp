<%@ page session="true" %>
<%@ page buffer="none" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ page import="com.deepthoughts.templates.*" %>
<%   
	// create the bean
	BlogJspTemplate blog = new BlogJspTemplate(pageContext, request, response);
%>
<%
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
			<td class="leftRail" align="left"></td>
	
			<%-- Para spacer left side --%>
			<td class="spacer" align="left"></td>
	
			<%-- Register --%>
			<td colspan="2" valign="top" align="left">
				<img src="<cms:link>/images/spacer.gif</cms:link>" alt="" height="40" border="0" />
				<%
					int nAction = blog.registerUserAction();
					if (nAction == BlogJspTemplate.FORMACTION_SHOWFORM ) {
						// display the registration and login forms
						blog.include("common.jsp", "register_form");
					} else {
						// make the appropriate response
						switch(nAction) {
							case BlogJspTemplate.FORMACTION_OK:
								// output a nice message
								out.write(" Thank you for registering!<br>");
								String strBlog = blog.getRequest().getParameter("blog");
								if (null != strBlog && strBlog.length() > 0) {
									// allow the user to add the comment now
									blog.include("common.jsp", "comment_form");
									out.write("<br>blog: " + blog.getRequest().getParameter("blog") + "<br>");
								} else {
									// redirect to the home page
									blog.getResponse().sendRedirect(blog.link("/index.html"));
								}
								break;
								
							case BlogJspTemplate.FORMACTION_ERROR:
								%>
								Registration Error: <%=blog.getRegisterActionMessage()%>
								<br/>
								<br/>
								Please try again<br/>
								<%
								break;
						}
					}
				%>
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
