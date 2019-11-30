<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ include file="auth.jsp"%>
<%@ page import="java.text.NumberFormat" %>
<%@ include file="jdbc.jsp" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
String custid = request.getParameter("custumerId");
String firstname = request.getParameter("firstname");
String lastname = request.getParameter("lastname");
String email = request.getParameter("email");
String phonenum = request.getParameter("phonenum");
String address = request.getParameter("address");
String city = request.getParameter("city");
String state = request.getParameter("state");
String postalcode = request.getParameter("postalcode");
String country = request.getParameter("country");

String sql = "UPDATE customer SET firstname = ?, lastname = ?, email = ?, phonenum = ?, address = ?, city = ?, state = ?, postalCode = ?, country = ? WHERE customerId = ?";

try {
	getConnection();
	PreparedStatement ps = con.prepareStatement(sql);
	ps.setString(1, firstname);
	ps.setString(2, lastname);
	ps.setString(3, email);
	ps.setString(4, phonenum);
	ps.setString(5, address);
	ps.setString(6, city);
	ps.setString(7, state);
	ps.setString(8, postalcode);
	ps.setString(9, country);
	ps.setInt(10, Integer.parseInt(custid));
		
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