<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.ArrayList" %>
<%
// Get the current list of products
@SuppressWarnings({"unchecked"})
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");

if (productList == null)
{	// No products currently in list.  Create a list.
	productList = new HashMap<String, ArrayList<Object>>();
}


// Add new product selected
// Get product information
String id = request.getParameter("id");

/*
// Update quantity if add same item to order again
if (productList.containsKey(id))
{	product = (ArrayList<Object>) productList.get(id);
	int curAmount = ((Integer) product.get(3)).intValue();
	product.set(3, new Integer(curAmount+1));
}
*/

ArrayList<Object> product = new ArrayList<Object>();
product = (ArrayList<Object>) productList.get(id);
int curAmount = ((Integer) product.get(3)).intValue();
if(curAmount != 0){
	product.set(3, new Integer(curAmount-1));
}


session.setAttribute("productList", productList);
%>
<jsp:forward page="showcart.jsp" />