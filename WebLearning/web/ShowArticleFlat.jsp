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
    int pageSize = 3;

    String strPageNo = request.getParameter("pageNo");
    int pageNo = 1;
    if(strPageNo == null || strPageNo.equals("")){
        pageNo = 1;
    }else{
        try {
            pageNo = Integer.parseInt(strPageNo.trim());
        }catch (NumberFormatException e){
            pageNo = 1;
        }
        if(pageNo <= 0) pageNo = 1;
    }


    Class.forName("com.mysql.jdbc.Driver");
    String url = "jdbc:mysql://localhost/bbs?user=root&password=root";
    Connection conn = DriverManager.getConnection(url);

    Statement stmtCount = conn.createStatement();
    ResultSet rsCount = stmtCount.executeQuery("SELECT count(*) FROM article WHERE pid = 0");
    rsCount.next();
    int totalRecords = rsCount.getInt(1);

    //计算有多少页
    int totalPages = (totalRecords % pageSize) == 0 ? totalRecords/pageSize : totalRecords/pageSize + 1;
    if(pageNo > totalPages) pageNo = totalPages;

    int startPos = (pageNo - 1) * pageSize;

    Statement stmt = conn.createStatement();
    //分页查询
    ResultSet rs = stmt.executeQuery( "SELECT * FROM article where pid = 0 ORDER BY pdate DESC LIMIT " + startPos + "," + pageSize);

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
                    <%= rs.getString("title")%>
                </td>
            </tr>



    <%
        }
        rs.close();
        stmt.close();
        conn.close();
    %>
</table>

共有<%=totalPages %>页 第<%=pageNo%>页
<a href="ShowArticleFlat.jsp?pageNo=<%=pageNo-1%>"> < </a> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<a href="ShowArticleFlat.jsp?pageNo=<%=pageNo+1%>"> > </a>

<form name="form1" action="ShowArticleFlat.jsp">
    <select name="pageNo" onchange="document.form1.submit()">
        <%
            for(int i=1; i<=totalPages; i++){
              %>
        <option value=<%=i%> <%=(pageNo==i) ? "selected" : ""%>> 第<%=i%>页</option>
        <%
            }
        %>
    </select>
</form>

<form name="form2" action="ShowArticleFlat.jsp">
    <input type="text" size="4" name="pageNo" value="<%=pageNo%>"/>
    <input type="submit" value="go"/>
</form>
</body>


</html>
