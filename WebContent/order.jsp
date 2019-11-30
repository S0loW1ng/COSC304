<%@ page import="java.sql.*"%>
<%@ page import="java.text.NumberFormat"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.regex.Pattern"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>YOUR NAME Grocery Order Processing</title>
</head>
<body>

<%!
public static boolean isNumeric(String str) {
	  return str.matches("-?\\d+(\\.\\d+)?"); 
	}
%>

<%!
public static boolean checkAllLetters(String word){
	return Pattern.matches(".*[a-zA-Z]+.*[a-zA-Z]",word);
}
%>

<%!
public static boolean checkState(String state){
	boolean valid = true;
	
	char a = state.charAt(0);
    char b = state.charAt(1);
    if(!(Character.isLetter(a))){
        valid = false; 
    }
    else if (!(Character.isLetter(b))){
        valid = false;
    }
    return valid;
}
%>

<%!
public static boolean checkPostalCode(String posCod){
    boolean valid = true;

     char a = posCod.charAt(0);
     char b = posCod.charAt(1);
     char c = posCod.charAt(2);
     char d = posCod.charAt(3);
     char e = posCod.charAt(4);
     char f = posCod.charAt(5);
     
     if(!(Character.isLetter(a))){
         valid = false; 
     }
     else if (!(Character.isDigit(b))){
         valid = false;
     }
     else if (!(Character.isLetter(c))){
         valid = false;
     }
     else if (!(Character.isDigit(d))){
         valid = false;
     }
     else if (!(Character.isLetter(e))){
         valid = false;
     }
     else if (!(Character.isDigit(f))){
         valid = false;
     }
     
     return valid; 
}
%>
<%
// Get customer id

// Clear cart if order placed successfully
String custId = (String) session.getAttribute("customerId");
String posCod = (String) request.getParameter("postalCode");
String state = (String) request.getParameter("state");
String fName = (String) request.getParameter("firstname");
String city = (String) request.getParameter("city");
String cardName = (String) request.getParameter("cardname");
String cardNumb = (String) request.getParameter("cardnumber");
String expMonth = (String) request.getParameter("expmonth");
String expYear = (String) request.getParameter("expyear");
String cvv = (String) request.getParameter("cvv");
		@SuppressWarnings({ "unchecked" })
		HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session
				.getAttribute("productList");

		String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_ecaldero";
		String uid = "ecaldero";
		String pw = "63484166";
		boolean validId = false;
		boolean validCart = false;

		
		
		if ((custId.matches("-?\\d+(\\.\\d+)?")) && (checkPostalCode(posCod)) && (checkState(state))  && (checkAllLetters(fName))  && checkAllLetters(city) && checkAllLetters(cardName) && isNumeric(cardNumb) && checkAllLetters(expMonth) && isNumeric(expYear) && isNumeric(cvv)){
			// && checkAllLetters(city)) && checkAllLetters(cardName) && isNumeric(cardNumb) && checkAllLetters(expMonth) && isNumeric(expYear) && isNumeric(cvv)
			try { // Load driver class
					//Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
				Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
			} catch (java.lang.ClassNotFoundException e) {
				out.println("ClassNotFoundException: " + e);
			}

			try {

				Connection con = DriverManager.getConnection(url, uid, pw);
				PreparedStatement pstm = con.prepareStatement("SELECT * FROM customer WHERE customerId=?");
				pstm.setString(1, custId);
				ResultSet rst = pstm.executeQuery();
				if (rst.next()) {
/* 					out.println("<font color=green>");
					out.println("Valid Customer Id");
					out.println("</font>"); */
					validId = true;
				} else {
					out.println("<font color=red>");
					out.println("Customer id is not available");
					out.println("</font>");
				}

				Connection con2 = DriverManager.getConnection(url, uid, pw);
				PreparedStatement pstm2 = con2.prepareStatement("SELECT orderId FROM incart");
				ResultSet rst2 = pstm2.executeQuery();
				if (rst2 == null) {
					out.println("You cant's check out since your shopping cart is empty");
				} else {
					
					validCart = true;
				}
				rst.close();
				pstm.close();
				con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		} else {
			out.println(posCod);
			out.println("CustomerId is not available");
		}
		if (validId && validCart) {
			try {
				double totalAmount = 0;
				Connection con2 = DriverManager.getConnection(url, uid, pw);

				// Use retrieval of auto-generated keys.
				PreparedStatement pstmt2 = con2.prepareStatement("INSERT INTO ordersummary(customerId) VALUES (?)", Statement.RETURN_GENERATED_KEYS);
				pstmt2.setInt(1, Integer.parseInt(custId)); 
				pstmt2.execute();
				
				ResultSet keys = pstmt2.getGeneratedKeys();
				keys.next();
				int orderId = keys.getInt(1);
				
				//Create order summary
				Connection con = DriverManager.getConnection(url, uid, pw);
				String sql2 = "UPDATE ordersummary SET orderDate = getDate(), customerId = ? WHERE orderId = ?";
				PreparedStatement pstm = con.prepareStatement(sql2);
				pstm.setInt(1, Integer.parseInt(custId)); 
				pstm.setInt(2, orderId);			
				int rst = pstm.executeUpdate();
				
				//iterate through product list and add to orderproduct
				Connection con3 = DriverManager.getConnection(url, uid, pw);
				Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
				while (iterator.hasNext())
				{ 
					Map.Entry<String, ArrayList<Object>> entry = iterator.next();
					ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
					String productId = (String) product.get(0);
			        String price = (String) product.get(2);
					double pr = Double.parseDouble(price);
					int qty = ( (Integer)product.get(3)).intValue();
					totalAmount += pr*qty;
					PreparedStatement pstm3 = con3.prepareStatement("INSERT INTO orderProduct (orderId, productId, quantity, price) VALUES (?, ?, ?, ? )");
					pstm3.setInt(1, orderId);
					pstm3.setString(2, productId);
					pstm3.setInt(3, qty);
					pstm3.setDouble(4, pr); 
					int rst3 = pstm3.executeUpdate();
				}
					
			//Update total amount	
			Connection con4 = DriverManager.getConnection(url, uid, pw);
			String sql3 = "UPDATE ordersummary SET totalAmount = ";
			sql3+=totalAmount; 
			sql3+="WHERE orderId ="; 
			sql3+=orderId;
			PreparedStatement pstm4 = con4.prepareStatement(sql3);
			int rst4 = pstm4.executeUpdate();
			
			// Print out order summary
			out.println("Your oder was places successfully! Your order reference number is: " + orderId);
			
			PreparedStatement pstm5 = con.prepareStatement("SELECT p.productId, p.productName, op.quantity, p.productPrice FROM product as p JOIN orderproduct as op ON p.productId = op.productId JOIN ordersummary as os ON op.orderId = os.orderId WHERE os.orderDate = getDate()");
			ResultSet rst5 = pstm5.executeQuery();
			
			out.println("<table border=\"1\"><tr><th>Product ID</th><th>ProductName</th><th>Price<th></tr>");
			
				
			
			
			Iterator<Map.Entry<String, ArrayList<Object>>> iterator1 = productList.entrySet().iterator();
			while (iterator1.hasNext())
			{ 
				Map.Entry<String, ArrayList<Object>> entry = iterator1.next();
				ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
				String productId = (String) product.get(0);
		        String price = (String) product.get(2);
				double pr = Double.parseDouble(price);
				int qty = ( (Integer)product.get(3)).intValue();
				
				
				
				PreparedStatement pstm10 = con3.prepareStatement("SELECT productName FROM product WHERE productId = ?");
				pstm10.setString(1, productId);
				ResultSet rrr = pstm10.executeQuery();
				rrr.next();

				out.println("<tr><th>"+ productId +"</th><th>"+ rrr.getString(1)+"</th><th> $"+ pr + "</th></tr>");
				
				
			}
			
	
			out.println("</table>");
			out.println("order total: " + totalAmount);
			
			
			} catch (SQLException e) {
				e.printStackTrace();
			}
			productList.clear();
			
		}else out.println("error");
		
		
 %>

</body>
</html>
