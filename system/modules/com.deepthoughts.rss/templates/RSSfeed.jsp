<%@ page import="com.deepthoughts.rss.*" %>
<%
	// instantiate the RSS bean and get the feed
	RssFeedBean rss = new RssFeedBean(pageContext, request, response); 
	rss.getFeed();
%>