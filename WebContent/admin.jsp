<!DOCTYPE html>
<html>
<head>
<title>Administrator Page</title>
</head>
<body>

<%@ include file="auth.jsp"%>
<%@ page import="java.text.NumberFormat" %>
<%@ include file="jdbc.jsp" %>

<%@ page language="java" import="java.io.*,java.sql.*"%>
<%
String userName = (String) session.getAttribute("authenticatedUser");
String thisisAdmin = (String) session.getAttribute("thisisAdmin");
boolean flag = false;
%>

<% 


	if(userName == null && thisisAdmin == null){
		out.println("please log in to access this page");
		flag = false;
	}else
		flag = true;
			// Failed login - redirect back to login page with a message 
			
		
%>

<%

// TODO: Write SQL query that prints out total order amount by day
String sql = "Select OrderDate, SUM(totalAmount) FROM ordersummary GROUP BY orderDate ";
if(flag){
if(userName.equals("arnold") && thisisAdmin.equals("arnold") && flag == true){
	getConnection();
	out.println("<h1> ORDERS OF THE DAY </h1>");
	out.println("<table>");
	
	PreparedStatement ps = con.prepareStatement(sql);
	ResultSet rs = ps.executeQuery();
	out.println("<tr><th> Date</th><th>Total</th></tr>");
	while(rs.next()){
		out.println("<tr><th>"+ rs.getString(1)+"</th><th> $"+ rs.getString(2)+"</th></tr>");
	}
	
	out.println("<table border=\"1\">");
	out.println("<tr><th><a href=\"NewProduct.jsp\"> Add new product</a></th>");
	out.println("<th><a href=\"deleteProduct.jsp\"> Product Delete</a></th>");
	out.println("<th><a href=\"updateProduct.jsp\"> Product Update</a></th>");
	out.println("<th><a href=\"changeStatus.jsp\">Order Status</a></th>");
	out.println("<th><a href=\"photoUI.jsp\"> Add product pictues</a></th>");
	out.println("<th><a href=\"listCustomers.jsp\">Customer Lists</a></th>");
	
	out.println("</tr></table>");
	
	closeConnection();
	
}else{
	out.println("<h1> YOU ARE NOT ALLOWED TO BE HERE!!!</h1>");
}
}else
	out.println("<h1> PLEASE LOG IN NOW!!!</h1>");
%>

</body>
</html>

