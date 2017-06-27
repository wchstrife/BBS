<%--
  Created by IntelliJ IDEA.
  User: wangchenghao
  Date: 2017/6/27
  Time: 15:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.sql.*"%>
<%@ page contentType="text/html;charset=utf-8" language="java" %>

<%!
    String str = "";
    private void tree(Connection conn, int id, int level){
    Statement stmt = null;
    ResultSet rs = null;
    String preStr = "";
    for(int i=0; i<level; i++){
        preStr += "----";
    }
    try{
        stmt = conn.createStatement();
        String sql = "SELECT * FROM article where pid = " + id;
        rs = stmt.executeQuery(sql);
        while(rs.next()){
            str += "<tr><td>" + rs.getInt("id") + "</td><td>" +
                    preStr + "<a href='ShowArticleDetail.jsp?id=" + rs.getInt("id") + "'>" + rs.getString("title") + "</a></td>" +
                    "<td><a href='Delete.jsp?id="+ rs.getInt("id") + "&pid=" + rs.getInt("pid") + "'>删除</a>" +
                    "</td></tr>";
            if(rs.getInt("isleaf") != 0){
                tree(conn, rs.getInt("id"), level+1);
            }
        }
    }catch (SQLException e){
        e.printStackTrace();
    }finally {
        try{
            if(rs != null){
                rs.close();
                rs = null;
            }
            if(stmt != null){
                stmt.close();
                stmt = null;
            }
        }catch (SQLException e){
            e.printStackTrace();
        }
    }
    }
%>

<%
    Class.forName("com.mysql.jdbc.Driver");
    String url = "jdbc:mysql://localhost/bbs?user=root&password=root";
    Connection connection = DriverManager.getConnection(url);

    Statement statement = connection.createStatement();
    ResultSet resultSet = statement.executeQuery("SELECT * FROM article where pid = 0" );
    while(resultSet.next()){
        str += "<tr><td>" + resultSet.getInt("id") + "</td><td>" +
                "<a href='ShowArticleDetail.jsp?id=" + resultSet.getInt("id")+ "'>" +
                resultSet.getString("title") + "</a></td>" +
                "<td><a href='Delete.jsp?id="+ resultSet.getInt("id") + "&pid=" + resultSet.getInt("pid") + "'>删除</a>" +
                "</td></tr>";
        if(resultSet.getInt("isleaf") != 0){
            tree(connection, resultSet.getInt("id"), 1);
        }
    }
    resultSet.close();
    statement.close();
    connection.close();
%>
<html>
<head>
    <title>Title</title>
</head>
<body>
<table border="1">
    <%= str%>
    <% str="";%>
</table>

</body>


</html>
