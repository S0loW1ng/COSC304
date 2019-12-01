<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page language="java" import="java.io.*,java.sql.*"%>
<%@ include file="jdbc.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
String prodid = request.getParameter("prodId");

String sql = "DELETE FROM product WHERE productId = ?";
try {
	getConnection();
	PreparedStatement ps = con.prepareStatement(sql);
	ps.setInt(1,Integer.parseInt(prodid));	
	int ret = ps.executeUpdate();
	
	if(ret > 0){
		out.println("SUCCESSS");
	}else
		out.println("Something Failed");
	

	closeConnection();
	
		
		} 
		catch (Exception ex) {
			out.println(ex);
		}

%>

</body>
</html>