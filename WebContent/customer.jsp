<!DOCTYPE html>
<html>
<head>
<title>Customer Page</title>
</head>
<body>

<%@ include file="auth.jsp"%>
<%@ page import="java.text.NumberFormat" %>
<%@ include file="jdbc.jsp" %>

<%
	String userName = (String) session.getAttribute("authenticatedUser");
%>

<%
getConnection();
// TODO: Print Customer information
String sql = "SELECT customerId, firstName, lastName, email, phonenum, address, city, state, postalCode, country, userId FROM customer WHERE userid = ?";
PreparedStatement ps = con.prepareStatement(sql);
ps.setString(1, userName);
ResultSet rs = ps.executeQuery();
ResultSetMetaData rsmd = rs.getMetaData();
rs.next();

out.println("<table border=\"1\">");

for(int i = 1; i<= 11; i ++){
	out.println("<tr><th>" + rsmd.getColumnName(i)+ "</th><th>" + rs.getString(i)+"</th></tr>");
}

out.println("</table>");


// Make sure to close connection
closeConnection();
%>

</body>
</html>

