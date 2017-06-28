<%--
  Created by IntelliJ IDEA.
  User: wangchenghao
  Date: 2017/6/27
  Time: 15:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.sql.*"%>
<%@ page contentType="text/html;charset=utf-8" language="java" %>

<%
    String strPageNo = request.getParameter("pageNO");
    int pageNo = 1;
    if(strPageNo == null || strPageNo.equals("")){
        pageNo = 1;
    }else{
        pageNo = Integer.parseInt(strPageNo.trim());
    }

    Class.forName("com.mysql.jdbc.Driver");
    String url = "jdbc:mysql://localhost/bbs?user=root&password=root";
    Connection conn = DriverManager.getConnection(url);

    Statement stmt = conn.createStatement();
    ResultSet rs = stmt.executeQuery("SELECT * FROM article where pid = 0" );

%>
<html>
<head>
    <title>Title</title>
</head>
<body>
<a href="Post.jsp">发表新帖</a>
<table border="1">

    <%
        while (rs.next()){
            %>
            <tr>
                <td>
                    <%= rs.getString("con")%>
                </td>
            </tr>



    <%
        }
        rs.close();
        stmt.close();
        conn.close();
    %>
</table>

</body>


</html>
