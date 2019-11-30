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
getConnection();
// TODO: Print Customer information
String sql = "SELECT customerId, firstName, lastName, email, phonenum, address, city, state, postalCode, country, userId FROM customer";
PreparedStatement ps = con.prepareStatement(sql);

ResultSet rs = ps.executeQuery();
ResultSetMetaData rsmd = rs.getMetaData();



while(rs.next()){
	out.println("<table border=\"5\">");
for(int i = 1; i<= 11; i ++){
	out.println("<tr><th>" + rsmd.getColumnName(i)+ "</th><th>" + rs.getString(i)+"</th></tr>");
}
out.println("</table>");
}




// Make sure to close connection
closeConnection();
%>

</body>
</html>