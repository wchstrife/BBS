<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %><%--
  Created by IntelliJ IDEA.
  User: wangchenghao
  Date: 2017/6/27
  Time: 17:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=utf-8" language="java" %>

<%
    String strId = request.getParameter("id");
    int id = Integer.parseInt(strId);
    Class.forName("com.mysql.jdbc.Driver");
    String url = "jdbc:mysql://47.94.245.251:3306/bbs?&user=wangchenhao&password=Zxn960305.&useUnicode=true&characterEncoding=UTF-8";
    Connection conn = DriverManager.getConnection(url);

    Statement stmt = conn.createStatement();
    ResultSet rs = stmt.executeQuery("SELECT * FROM article where id = " + id);
%>

<html>
<head>
    <title>Title</title>
</head>
<body>
<%
    if(rs.next()){
%>

<table border="1">
    <tr>
        <td>ID</td>
        <td><%=rs.getInt("id")%></td>
    </tr>
    <tr>
        <td>Title</td>
        <td><%=rs.getString("title")%></td>
    </tr>
    <tr>
        <td>Content</td>
        <td><%=rs.getString("con")%></td>
    </tr>

</table>


<a href="Reply.jsp?id= <%=rs.getInt("id")%>&rootid=<%=rs.getInt("rootid")%>">回复</a>

<%
    }
    rs.close();
    stmt.close();
    conn.close();
%>
</body>
</html>
