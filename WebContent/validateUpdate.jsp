<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page language="java" import="java.io.*,java.sql.*"%>
<%@ include file="jdbc.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>validateUpdate</title>
</head>
<body>
<%
String prodid = request.getParameter("prodId");
String prodname = request.getParameter("prodname");
String prodprice = request.getParameter("prodprice");
String proddesc = request.getParameter("proddesc");
String categoryid = request.getParameter("categoryid");

String sql = "UPDATE product SET productName = ?, productPrice = ?, productDesc = ?, categoryId = ? WHERE productId = ?";
try {
	getConnection();
	PreparedStatement ps = con.prepareStatement(sql);
	ps.setString(1, prodname);
	ps.setInt(2, Integer.parseInt(prodprice));
	ps.setString(3, proddesc);
	ps.setInt(4, Integer.parseInt(categoryid));
	ps.setInt(5, Integer.parseInt(prodid));
	
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