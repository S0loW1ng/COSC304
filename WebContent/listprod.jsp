<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Map" %>
<!DOCTYPE html>
<html>
<head>
<title>YOUR NAME Grocery</title>
</head>
<body>

<h1>Search for the products you want to buy:</h1>

<form method="get" action="listprod.jsp">
<input type="text" name="productName" size="50">
<input type="submit" value="Submit"><input type="reset" value="Reset"> (Leave blank for all products)
</form>

<% // Get product name to search for
String reqname = request.getParameter("productName");
@SuppressWarnings({ "unchecked" })
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");
		
//Note: Forces loading of SQL Server driver
	String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_ecaldero";
	String uid = "ecaldero";
	String pw = "63484166";
		//Note: Forces loading of SQL Server driver
		try { // Load driver class
			//Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
		} catch (java.lang.ClassNotFoundException e) {
			out.println("ClassNotFoundException: " + e);
		}
	
		try{
			Connection con = DriverManager.getConnection(url, uid, pw); 
			String SQL = "";
			ResultSet rs = null;
			if(reqname == null){
				SQL = "SELECT productId, productName, productPrice,productImageURL,productDesc  "
						+ "FROM Product ";
				PreparedStatement prstm = con.prepareStatement(SQL);
				rs = prstm.executeQuery();
			}else{
			
			SQL = "SELECT productId, productName, productPrice, productImageURL,productDesc FROM product WHERE productName LIKE ?  ";
			PreparedStatement prstm = con.prepareStatement(SQL);
			prstm.setString(1, "%" + reqname + "%");
			rs = prstm.executeQuery();
			
			}
			
			String quantity = "<form method=\"get\" action=\"quantity.jsp\"><input type=\"text\" name=\"quantity\" size=\"20\">";
			
			out.println("<table border=\"1\"><tr><th>Quantity</th><th>ProductName</th><th>Price</th><th></th><th>Description</th></tr>");
			while(rs.next()){
				
				if(rs.getString(1).equals("1")){
				out.println("<tr><th><a href=\"addcart.jsp?id="+ rs.getString(1) + "&name="+ rs.getString(2)+ "&price=" +rs.getString(3) +"\">+ </a></th><th><a href=\"deletecart.jsp?id="+ rs.getString(1) + "\"> -</a></th><th>"+ rs.getString(2) +"</th><th>"+"$" +rs.getString(3) +"</th><th><img src = \"displayImage.jsp?id="+ rs.getString(1)+"\"/><th>"+rs.getString(5)+"</th></tr>");
				}else{ 
					out.println("<tr><th><div><a href=\"addcart.jsp?id="+ rs.getString(1) + "&name="+ rs.getString(2)+ "&price=" +rs.getString(3) +"\">+ </a><a href=\"deletecart.jsp?id="+ rs.getString(1) + "\"> -</a></div></th><th>"+ rs.getString(2) +"</th><th>"+"$" +rs.getString(3) +"</th><th><img src =\""+ rs.getString(4)+"\"/></th><th>"+rs.getString(5)+"</th></tr>");
				}
			}
			out.println("</table>");
			con.close();
		}catch(SQLException e){
			out.println(e);
		}

// Variable name now contains the search string the user entered
// Use it to build a query and print out the resultset.  Make sure to use PreparedStatement!

// Make the connection

// Print out the ResultSet

// For each product create a link of the form
// addcart.jsp?id=productId&name=productName&price=productPrice
// Close connection

// Useful code for formatting currency values:
// NumberFormat currFormat = NumberFormat.getCurrencyInstance();
// out.println(currFormat.format(5.0);	// Prints $5.00
%>

</body>
</html>