<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.*" %>
<%--
  Created by IntelliJ IDEA.
  User: wangchenghao
  Date: 2017/6/27
  Time: 18:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=utf-8" language="java" %>

<%
    /*
    请求发过来的时候编码是ISO的，这里必须设置为utf8才能正常的输入数据。
     */
    request.setCharacterEncoding("utf-8");
    String action = request.getParameter("action");
    //接收自己传过来的数据
    if(action != null && action.equals("post")) {
        String title = request.getParameter("title");
        String cont = request.getParameter("cont");

        cont.replaceAll("\n", "<br>");

        Class.forName("com.mysql.jdbc.Driver");
        String url = "jdbc:mysql://47.94.245.251:3306/bbs?&user=wangchenhao&password=Zxn960305.&useUnicode=true&characterEncoding=UTF-8";
        Connection conn = DriverManager.getConnection(url);

        //这里使用事务处理机制
        conn.setAutoCommit(false);



    String sql = "insert into article values (null, 0, ?, ?, ?, now(), 0)";
    PreparedStatement pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);//获取自动递增的id
    Statement stmt = conn.createStatement();

    pstmt.setInt(1, -1);
    pstmt.setString(2, title);
    pstmt.setString(3, cont);
    pstmt.executeUpdate();

    ResultSet rsKey = pstmt.getGeneratedKeys();
    rsKey.next();
    int key = rsKey.getInt(1);
    rsKey.close();
    stmt.executeUpdate("update article set rootid = " + key + " where id = " + key);


        conn.commit();
        conn.setAutoCommit(true);

    stmt.close();
    pstmt.close();
    conn.close();

        response.sendRedirect("ShowArticleTree.jsp");
    }
%>

<html>
<head>
    <title>Title</title>
</head>
<body>

<form action="Post.jsp" method="post">
    <input type="hidden" name="action" value="post">
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
