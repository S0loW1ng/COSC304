<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Map" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="style.css"/>
<title>Your Shopping Cart</title>
<style type="text/css">
:focus {
  outline: 2px solid;
}

.clipped {
  clip: rect(1px, 1px, 1px, 1px);
  position: absolute;
  overflow: hidden;
  width: 0;
}

#cart .list {
  width: 100%;
  padding: 0;
  list-style: none;
  border-bottom: 1px dotted #ccc;
}

#cart .item {
  padding: 10px 0;
  border-top: 1px dotted #ccc;
}

#cart th, #cart td {
  padding: 0 10px;
}

#cart table > tbody > tr:nth-child(even) {
  background-color: #eee;
}

#cart .actions {
  padding: 10px;
  width: 250px;
}

#cart .actions ul,
#cart .extras ul {
  list-style: none;
  margin: 0;
  padding: 0;
  font-size: .9em;
}

#cart .actions button {
  background-color: inherit;
  border: none;
  text-decoration: underline;
}

#cart .actions button:hover,
#cart .actions button:focus {
  color: blue;
}

#cart .extras {
  width: 150px;
}

#cart .extras li {
  display: none;
}

#cart .extras li.active {
  display: block;
}

</style>
</head>
<body>

<%
// Get the current list of products
@SuppressWarnings({"unchecked"})
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");

if (productList == null)
{	out.println("<H1>Your shopping cart is empty!</H1>");
	productList = new HashMap<String, ArrayList<Object>>();
}
else
{
	NumberFormat currFormat = NumberFormat.getCurrencyInstance();

	out.println("<h1>Your Shopping Cart</h1>");
	out.print("<div id=\"cart\"><table class=\"list\" tabindex=\"-1\"><caption class=\"clipped\"><span>Shopping cart, total </span><span class=\"total\"></span><span> dollars</span></caption><thead><tr><th scope = \"col\">Product Id</th><th scope = \"col\">Product Name</th><th scope = \"col\">Quantity</th>");
	out.println("<th scope = \"col\">Price</th><th scope = \"col\">Subtotal</th></tr>");
	out.println("</thead><tbody></tbody></table></div>");

	double total =0;
	Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
	while (iterator.hasNext()) 
	{	Map.Entry<String, ArrayList<Object>> entry = iterator.next();
		ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
		if (product.size() < 4)
		{
			out.println("Expected product with four entries. Got: "+product);
			continue;
		}
		
		out.print("<tr><td>"+product.get(0)+"</td>");
		out.print("<td>"+product.get(1)+"</td>");

		out.print("<td align=\"center\">"+product.get(3)+"</td>");
		Object price = product.get(2);
		Object itemqty = product.get(3);
		double pr = 0;
		int qty = 0;
		
		try
		{
			pr = Double.parseDouble(price.toString());
		}
		catch (Exception e)
		{
			out.println("Invalid price for product: "+product.get(0)+" price: "+price);
		}
		try
		{
			qty = Integer.parseInt(itemqty.toString());
		}
		catch (Exception e)
		{
			out.println("Invalid quantity for product: "+product.get(0)+" quantity: "+qty);
		}		

		out.print("<td align=\"right\">"+currFormat.format(pr)+"</td>");
		out.print("<td align=\"right\">"+currFormat.format(pr*qty)+"</td><tr>");
		out.println("</tr>");
		total = total +pr*qty;
	}
	out.println("<tr><td colspan=\"4\" align=\"right\"><b>Order Total</b></td>"
			+"<td align=\"right\">"+currFormat.format(total)+"</td></tr>");
	out.println("</table>");

	out.println("<h2><a href=\"checkout.jsp\">Check Out</a></h2>");
}
%>
<h2><a href="listprod.jsp">Continue Shopping</a></h2>
</body>
</html> 

