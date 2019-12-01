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
String id = request.getParameter("Id");
String name = request.getParameter("warehouseName");


String sql = "UPDATE warehouse SET warehouseName = ? WHERE warehouseId = ?";
try {
	getConnection();
	PreparedStatement ps = con.prepareStatement(sql);
	ps.setString(1, name);
	ps.setInt(2, Integer.parseInt(id));
	
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