<%@ page import="java.sql.DriverManager" %>
<%--
  Created by IntelliJ IDEA.
  User: wangchenghao
  Date: 2017/6/27
  Time: 18:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=utf-8" language="java" %>
<%
    String s = request.getParameter("id").trim();
    int id = Integer.parseInt(s);
    String strRoot = request.getParameter("rootid").trim();
    int rootId = Integer.parseInt(strRoot);
%>


<html>
<head>
    <title>Title</title>
</head>
<body>

<form action="ReplyOK.jsp" method="post">
    <input type="hidden" name="id" value="<%=id%>">
    <input type="hidden" name="rootid" value="<%=rootId%>">
    <table border="1">
        <tr>
            <td>
                <input type="text" name="title" size="80">
            </td>
        </tr>
        <tr>
            <td>
                <textarea cols="80" rows="12" name="cont"></textarea>
            </td>
        </tr>
        <tr>
            <td>
                <input type="submit" value="提交">
            </td>
        </tr>
    </table>
</form>
</body>
</html>
