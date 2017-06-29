<%--
  Created by IntelliJ IDEA.
  User: wangchenghao
  Date: 2017/6/27
  Time: 19:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=utf-8" language="java" pageEncoding="UTF-8" %>

<%
    /*
    请求发过来的时候编码是ISO的，这里必须设置为utf8才能正常的输入数据。
     */
    request.setCharacterEncoding("utf-8");

    int id = Integer.parseInt(request.getParameter("id"));
    int rootId = Integer.parseInt(request.getParameter("rootid"));
    String title = request.getParameter("title");
    title = title.trim();

    if(title == null){
        out.println("error!");
    }

    if(title.equals("")){
        out.println("title could not be empty!");
        return;
    }
    String cont = request.getParameter("cont");
    cont = cont.trim();

    if(cont.equals("")){
        out.println("content could not be empty!");
        return;
    }

    cont.replaceAll("\n", "<br>");

    Class.forName("com.mysql.jdbc.Driver");
    String url = "jdbc:mysql://47.94.245.251:3306/bbs?&user=wangchenhao&password=Zxn960305.&useUnicode=true&characterEncoding=UTF-8";
    Connection conn = DriverManager.getConnection(url);

    //这里使用事务处理机制
    conn.setAutoCommit(false);

    Statement stmt = conn.createStatement();

    String sql = "insert into article values (null, ?, ?, ?, ?, now(), 0)";
    PreparedStatement pstmt = conn.prepareStatement(sql);
    pstmt.setInt(1, id);
    pstmt.setInt(2, rootId);
    pstmt.setString(3, title);
    pstmt.setString(4, cont);
    pstmt.executeUpdate();

    stmt.executeUpdate("UPDATE article SET isleaf = 1 WHERE id = " + id);

    conn.commit();
    conn.setAutoCommit(true);

    stmt.close();
    pstmt.close();
    conn.close();

    response.sendRedirect("ShowArticleTree.jsp");
%>


<html>
<head>
    <title>Title</title>
</head>
<body>
<font color="red" size="7">

</font>
</body>
</html>
