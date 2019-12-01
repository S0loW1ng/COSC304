
<%@ page
	import="org.apache.commons.fileupload.FileUpload, org.apache.commons.fileupload.servlet.ServletFileUpload, org.apache.commons.fileupload.FileItem, org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.io.File"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<title>Process File Upload</title>
</head>
<body>


<h1>Enter file to upload to server:</h1>

<form name="uploadForm" action="validateUpload.jsp" method="post" enctype="multipart/form-data">

<table>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">ProdId:</font></div></td>
	<td><input type="text" name="this" size=10 maxlength="99"></td>
</tr></table>
<b>File:</b><input type="file" name="file" size="100"/><br>

<input type="submit" name="Submit" value="Upload File"/>

</form>
	
</body>
</html>