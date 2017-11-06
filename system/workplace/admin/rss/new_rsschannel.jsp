<%@ page import="com.deepthoughts.rss.admin.*" %>
<% 
    RSSNewChannelDialog admin = new RSSNewChannelDialog(pageContext, request, response);
    admin.displayDialog();
%>
