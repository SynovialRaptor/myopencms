<%@ page import="com.deepthoughts.rss.admin.*" %>
<% 
    RSSFeedsList admin = new RSSFeedsList(pageContext, request, response);
    admin.displayDialog();
%>
