<%@ page import="java.sql.*"%>
<%@ page import="java.text.NumberFormat"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>YOUR NAME Grocery Order List</title>
</head>
<body>

	<h1>Order List</h1>

	<%
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
		Statement stmt = con.createStatement();
		if(!con.isClosed()){
			out.println("<h2>WELCOME TO OUR SHOP :3:3</h2>");
			out.println("<table border=\"4\"><tr><th>orderId</th><th>OrderDate</th><th>CustomerId</th><th>Customer Name</th><th>Total Amount</th></tr>");
			ResultSet rst =stmt.executeQuery("Select orderId,orderDate,C.customerId, firstName,lastName, totalAmount FROM customer C,ordersummary O  WHERE C.customerId = O.customerId");
			
			
		while (rst.next()) {
			out.println("<tr><td>" + rst.getString(1) + "</td>" + "<td>" + rst.getString(2) + "</td>" + "<td>" + rst.getString(3) + "</td>"+ "<td>" + rst.getString(4) + " " + rst.getString(5) + "</td>"+ "<td>" + "$" + rst.getString(6) +"</td></tr>");
			Statement stmt1 = con.createStatement();
			
		 	ResultSet rst1 =stmt1.executeQuery("SELECT productId, quantity, price FROM orderproduct WHERE orderId = " + rst.getString(1));
		 	out.println("<tr align=\"right\"><td colspan=\"5\"><table border=\"1\"><th>Product Id</th><th>Quantity</th><th>Price</th></tr>");
			while(rst1.next()){
				
				out.println("<tr><td>" + rst1.getString(1) + "</td>" + "<td>" + rst1.getString(2) +"</td>" + "<td>" + "$"+rst1.getString(3) + "</td></tr>");
				 
			}
			out.println("</table></td></tr>");  
			
		}
			
			
			
			out.println("</table>");
		}else{
			out.println("<h1>Close</h1>");
		}
		
		
		
		
	}catch(SQLException e){
		out.println("<h1>" + e + "</h1>");
	}
	/* try (Connection con = DriverManager.getConnection(url, uid, pw); Statement stmt = con.createStatement();) {
		ResultSet rst = stmt.executeQuery("SELECT ename,salary FROM emp");
		out.println("<table><tr><th>Name</th><th>Salary</th></tr>");
		while (rst.next()) {
			out.println("<tr><td>" + rst.getString(1) + "</td>" + "<td>" + rst.getDouble(2) + "</td></tr>");
		}
		out.println("</table>");
	} catch (SQLException ex) {
		out.println(ex);
	} */

		// Useful code for formatting currency values:
		// NumberFormat currFormat = NumberFormat.getCurrencyInstance();
		// out.println(currFormat.format(5.0);  // Prints $5.00
		// Make connection
		// Write query to retrieve all order summary records
		// For each order in the ResultSet
		// Print out the order summary information
		// Write a query to retrieve the products in the order
		//   - Use a PreparedStatement as will repeat this query many times
		// For each product in the order
		// Write out product information 

		// Close connection
	%>

</body>
</html>

