<%--
	This template contains common JSP code.  The element is divided into sections that can
	individually be included into a parent JSP via the OpenCms 'include' API.
--%>
<%@ page pageEncoding="UTF-8" %>

<%-- include necessary imports --%>
<%@ page import="java.util.*" %>
<%@ page import="org.opencms.file.*" %>
<%@ page import="com.deepthoughts.templates.*" %>
<%@ page import="com.deepthoughts.rss.*" %>
<%@ page import="com.sun.syndication.feed.synd.*" %>

<%-- include necessary taglibs --%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>

<%
	// create the bean
	BlogJspTemplate blog = new BlogJspTemplate(pageContext, request, response);
%>

<%-- Header --%>
<cms:template element="header">
	<%-- Header Divider --%>
	<table cellspacing="0" cellpadding="0" width="100%" align="center" border="0">
	    <tbody>
	        <%-- Date Bar --%>
	        <tr bgcolor="#ccff99">
	            <td id="dateformat" colspan="6" height="25">&nbsp;&nbsp;
	            	<script language="JavaScript" type="text/javascript">document.write(TODAY);</script>&nbsp;<%= blog.getCurrentFolderName() %>
	            </td>
	            <td align="right">
	            	<%
	            	if (blog.getRequestContext().currentUser().isGuestUser()) {
	            		%>
	            		<form class="login" action="<cms:link>/index.html</cms:link>">
			            			<input name="action" value="login" type="hidden">
			            			<input name="blog" value="<%=request.getParameter("blog")%>" type="hidden">
	            			Username: <input class="input" name="username" value="" type="text" size="10">
                            Password: <input class="input" name="password" value="" type="password" size="10">
                            <input class="submit" type="submit" name="Submit" value="Login" />
            			</form>
	            		<a href="<cms:link>/system/modules/com.deepthoughts.templates/elements/Register.jsp</cms:link>">Register</a>
	            		<%
	            	} else {
		            	%>
		            	Welcome: <%= blog.getCurrentUser() %>&nbsp;
	            		<form class="login" name="login" action="<cms:link>/index.html</cms:link>">
	            			<input type="hidden" name="action" value="logout" />
                            <input class="submit" type="submit" name="Submit" value="Logout" />
            			</form>
						<a href="<cms:link>/system/modules/com.deepthoughts.templates/elements/Manage.jsp</cms:link>">My Account</a>
		            	<% } %>
            	</td>
	        </tr>
	        <%-- Thin spacer --%>
	        <tr>
	            <td bgcolor="#003366" colspan="7"><img height="1" alt="spacer.gif" 
	            	width="1" border="0" src="<cms:link>/images/spacer.gif</cms:link>" /></td>
	        </tr>
	    </tbody>
	</table>
</cms:template>

<%-- search form --%>
<cms:template element="search_form">
	<form action="<cms:link>/system/modules/com.deepthoughts.templates/elements/Search.jsp</cms:link>" method="post" id="searchform">
	<li class="widget widget_search" id="search">
		<h2 class="widgettitle">Search</h2>
			<div>
				<input type="text" size="15" id="query" name="query" /><input type="submit" value="Go" /><br>
			</div>
	</li>
	</form>
</cms:template>

<%-- Advertisements --%>
<cms:template element="adverts">
	<li class="widget widget_text" id="text-4">
		<h2 class="widgettitle"></h2>
		<div class="textwidget">
			<!-- ADS HERE -->
			<cms:include file="/index.html" element="Ads" editable="true" />
			<!-- ADS HERE -->
		</div>
	</li>
</cms:template>

<%-- Blog Archives --%>
<cms:template element="archives">
	<li class="widget widget_archives" id="archives">
		<h2 class="widgettitle">Archives</h2>
		<ul>
			<%
				// get the list of blog folders, in descending date order
				List lstBlogs = blog.getBlogFolders();
				Iterator i = lstBlogs.iterator();
				// for each folder...
				while (i.hasNext()) {
					CmsResource res = (CmsResource) i.next();
					// count blogs in it
					String strCount = Integer.toString(blog.getBlogCount(res));
					// get the title
					String strTitle = blog.getCmsObject().readPropertyObject(res, 
						CmsPropertyDefinition.PROPERTY_TITLE, false).getValue();
					// build a uri parameter to it
					String strLink = blog.getCmsObject().getSitePath(res);
					// link to the homepage with a folder switch
					String strI = blog.link("/index.html").concat("?uri=").concat(strLink);
					%>
					<li><a title="<%=strTitle%>" href="<%=strI%>"><%=strTitle%></a>&nbsp;(<%=strCount%>)</li>
				<% } %>
		</ul>
	</li>
</cms:template>

<%-- RSS Client --%>
<cms:template element="rss_client">
	<li class="widget widget_archives" id="archives">
		<h2 class="widgettitle">Feeds</h2>
		<ul>
		<%
			// get the feed from the user account
			RSSReader r = new RSSReader(blog.getUserRSSFeedURL());
			r.readAll();
			while (r.hasMore()) {
				SyndEntry e = r.getNext();
				%>
				<li><a title="" href="<%=e.getLink()%>"><%=e.getTitle()%></a> 
					(<%=blog.formatDate(e.getPublishedDate(),"HH:mm")%>)</li>
				<%
			}
		 %>
		</ul>
	</li>
</cms:template>

<%-- RSS Feed --%>
<cms:template element="rss_feed">
	<li class="widget widget_text" id="text-6">
		<h2 class="widgettitle">Subscribe</h2>
		<div class="textwidget">
		<br/>
			<ul>
				<a type="application/rss+xml" 
					rel="alternate" 
					title="Subscribe to my feed" 
					href="<cms:link>/Blogs/DeepThoughts.rss?fmt=rss_0.9</cms:link>"><img style="border: 0pt none ;" 
						alt="RSS 0.9" 
						src="<cms:link>/images/xml.gif</cms:link>">&nbsp;RSS 0.9 Feed</a>
			</ul>
			<ul>
				<a type="application/rss+xml" 
					rel="alternate" 
					title="Subscribe to my feed" 
					href="<cms:link>/Blogs/DeepThoughts.rss?fmt=rss_1.0</cms:link>"><img style="border: 0pt none ;" 
						alt="RSS 1.0" 
						src="<cms:link>/images/xml.gif</cms:link>">&nbsp;RSS 1.0 Feed</a>
			</ul>
			<ul>
				<a type="application/rss+xml" 
					rel="alternate" 
					title="Subscribe to my feed" 
					href="<cms:link>/Blogs/DeepThoughts.rss</cms:link>"><img style="border: 0pt none ;" 
						alt="RSS 2.0" 
						src="<cms:link>/images/xml.gif</cms:link>">&nbsp;RSS 2.0 Feed</a>
			</ul>
			<ul>
				<a type="application/rss+xml" 
					rel="alternate" 
					title="Subscribe to my feed" 
					href="<cms:link>/Blogs/DeepThoughts.rss?fmt=atom_1.0</cms:link>"><img style="border: 0pt none ;" 
						alt="Atom 1.0" 
						src="<cms:link>/images/xml.gif</cms:link>">&nbsp;Atom 1.0. Feed</a>
			</ul>
		</div>
	</li>
</cms:template>

<%-- Footer --%>
<cms:template element="footer">
	<%-- Include the footer content --%>
	<cms:include file="/index.html" element="Footer" editable="true" />
</cms:template>

<%-- Register form --%>
<cms:template element="register_form">
	<%
		String strBlog = blog.getRequest().getParameter("blog");
		if (null == strBlog) {
			strBlog = "";
		}
		// this form is used for both a new registration and for updating
		// user account settings. When updating, the 'forupdate' variable
		// will be present
		String strUpdate = blog.getRequest().getParameter("forupdate");
		boolean bUpdate = strUpdate!=null && strUpdate.equals("true");
		String strMsg = bUpdate? 
			"Update Account Settings" : "Please Register or Login to add comments";
		
		// get the user
		CmsUser user = blog.getCmsObject().getRequestContext().currentUser();
		String strUsername = user.getSimpleName();
		if (user.isGuestUser())
			strUsername = "";
		// get any RSS feed
		String strFeed = (String) user.getAdditionalInfo().get(BlogJspTemplate.RSS_FEED_PARAM);
		if (null == strFeed)
			strFeed = "";
	%>
	<form name="register" method="post"
		action="<cms:link>/system/modules/com.deepthoughts.templates/elements/Register.jsp</cms:link>">
	<input type="hidden" name="action" value="<%=bUpdate?"update":"register" %>" />
	<input type="hidden" name="blog" value="<%= strBlog %>" />
	<table border="0" cellspacing="0" cellpadding="2" width="100%">
		<tr>
			<th colspan="2"><%=strMsg%></th>
		</tr>
		<tr>
			<td>Username:</td>
			<td class="bodyText"><input name="username" type="text" <%=bUpdate?"disabled":""%> size="20" value="<%=strUsername%>"/></td>
		</tr>
		<tr>
			<td>Password:</td>
			<td class="bodyText"><input name="password" type="password" size="15" /></td>
		</tr>
		<tr>
			<td>Re-type password:</td>
			<td class="bodyText"><input name="passconfirm" type="password" size="15" /></td>
		</tr>
		<tr>
			<td>First Name:</td>
			<td class="bodyText"><input name="firstname" type="text" size="15" value="<%=user.getFirstname()%>"/></td>
		</tr>
		<tr>
			<td>Last Name:</td>
			<td class="bodyText"><input name="lastname" type="text" size="15" value="<%=user.getLastname()%>"/></td>
		</tr>
		<tr>
			<td>eMail:</td>
			<td class="bodyText"><input name="email" type="text" size="15" value="<%=user.getEmail()%>"/></td>
		</tr>
		<tr>
			<td>RSS Feed:</td>
			<td class="bodyText"><input name="rss" type="text" size="20" value="<%=strFeed%>"/></td>
		</tr>
		<tr>
			<td colspan="2" class="bodyText">
				<img src="<cms:link>/images/spacer.gif</cms:link>" alt="" height="1" width="80" border="0" />
				<input type="reset" value="Clear"/>&nbsp;
				<input type="submit" value="<%=bUpdate?"Update":"Register"%>"/>
			</td>
		</tr>
	</table>
	</form>
</cms:template>

<%-- Comment form --%>
<cms:template element="comment_form">
	<form name="addcomment" method="post"
		action="<cms:link>/system/modules/com.deepthoughts.templates/elements/AddComment.jsp</cms:link>">
	<input type="hidden" name="blog" value="<%= blog.getRequest().getParameter("blog") %>" />
	<table border="0" cellspacing="0" cellpadding="2" width="100%">
		<tr>
			<th colspan="2" align="left">Add your comments:</th>
		</tr>
		<tr>
			<td class="bodyText" colspan="2">
			<textarea name="comment" type="text" cols="60" rows="10"></textarea>
			</td>
		</tr>
		<tr>
			<td colspan="2" class="bodyText">
				<input type="submit" value="Add Comments" />
			</td>
		</tr>
	</table>
	</form>
</cms:template>
