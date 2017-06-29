<%--
  Created by IntelliJ IDEA.
  User: wangchenghao
  Date: 2017/6/27
  Time: 21:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<%!
    private void del(Connection conn, int id) {
        Statement stmt = null;
        ResultSet rs = null;
        try {
            stmt = conn.createStatement();
            String sql = "SELECT * FROM article where pid = " + id;
            rs = stmt.executeQuery(sql);
            //删除子节点
            while (rs.next()) {
                del(conn, rs.getInt("id"));
            }
            //删除自己
            stmt.executeUpdate("DELETE  FROM article WHERE id =" + id);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                    rs = null;
                }
                if (stmt != null) {
                    stmt.close();
                    stmt = null;
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
%>

<%
    String admin = (String) session.getAttribute("admin");
    if (admin == null || !admin.equals("true")) {
        out.println("请登录");
        return;
    }
%>

<%
    int id = Integer.parseInt(request.getParameter("id"));
    int pid = Integer.parseInt(request.getParameter("pid"));

    Class.forName("com.mysql.jdbc.Driver");
    String url = "jdbc:mysql://47.94.245.251:3306/bbs?&user=wangchenhao&password=Zxn960305.&useUnicode=true&characterEncoding=UTF-8";
    Connection conn = DriverManager.getConnection(url);

    //这里使用事务处理机制
    conn.setAutoCommit(false);

    del(conn, id);//删除此节点以及子节点

    //判断删除之后父节点是否变为叶子节点
    Statement stmt = conn.createStatement();
    ResultSet rs = stmt.executeQuery("SELECT count(*) FROM article WHERE pid =" + pid);
    rs.next();
    int count = rs.getInt(1);
    if (count <= 0) {
        Statement stmtUpdate = conn.createStatement();
        stmtUpdate.executeUpdate("UPDATE article SET isleaf = 0 WHERE id = pid");
        stmtUpdate.close();
    }

    conn.commit();
    conn.setAutoCommit(true);
    conn.close();


    response.sendRedirect("ShowArticleTree.jsp");
%>

<html>
<head>
    <title>Title</title>
</head>
<body>

</body>
</html>
