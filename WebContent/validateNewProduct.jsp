<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page language="java" import="java.io.*,java.sql.*"%>
<%@ include file="jdbc.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>ValidateNewProduct</title>
</head>
<body>
<%
String prodname = request.getParameter("prodname");
String prodprice = request.getParameter("prodprice");
String proddesc = request.getParameter("proddesc");
String categoryid = request.getParameter("categoryid");

String sql = "INSERT INTO product ( productName, productPrice, productDesc, categoryId) VALUES ( ?, ?, ?, ?)";

try {
	getConnection();
	PreparedStatement ps = con.prepareStatement(sql);
	ps.setString(1, prodname);
	ps.setInt(2, Integer.parseInt(prodprice));
	ps.setString(3, proddesc);
	ps.setInt(4, Integer.parseInt(categoryid));
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