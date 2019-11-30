<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Add new Product</title>
</head>
<body>



<form name="MyForm" method=post action="validateNewProduct.jsp">
<table style="display:inline">

<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">ProdName:</font></div></td>
	<td><input type="text" name="prodname" size=10 maxlength="10"></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">ProdPrice:</font></div></td>
	<td><input type="text" name="prodprice" size=10 maxlength="10"></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">ProdDesc:</font></div></td>
	<td><input type="text" name="proddesc" size=10 maxlength="10"></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">CategoryId:</font></div></td>
	<td><input type="text" name="categoryid" size=10 maxlength="10"></td>
</tr>

</table>

<input class="submit" type="submit" name="Submit3" value="Add Produ">
</form>


</body>
</html>