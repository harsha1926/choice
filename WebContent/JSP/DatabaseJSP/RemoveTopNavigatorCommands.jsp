<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="databaseActions.Actions"%>
<%@page import="java.io.File"%>
<%@page import="java.sql.ResultSetMetaData"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="javax.sql.rowset.CachedRowSet"%>
<%@page import="java.util.ArrayList"%>

<html>
<%
if (session == null || session.getAttribute("User") == null) {
%>
		<script>
			window.open("/Choice/Login.jsp","_top");
		</script>
<%
}
if(request.getHeader("X-Requested-With") != null)
{
		
	if(request.getHeader("X-Requested-With").equalsIgnoreCase("XMLHttpRequest"))
		{
%>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1">
		  <!-- Included CSS Files -->
		  <!-- Combine and Compress These CSS Files -->
			  <link rel="stylesheet" href="/Choice/CSS/ResponsiveTables/globals.css">
			  <link rel="stylesheet" href="/Choice/CSS/ResponsiveTables/typography.css">
			  <link rel="stylesheet" href="/Choice/CSS/ResponsiveTables/grid.css">
			  <link rel="stylesheet" href="/Choice/CSS/ResponsiveTables/ui.css">
			  <link rel="stylesheet" href="/Choice/CSS/ResponsiveTables/forms.css">
			  <link rel="stylesheet" href="/Choice/CSS/ResponsiveTables/orbit.css">
			  <link rel="stylesheet" href="/Choice/CSS/ResponsiveTables/reveal.css">
			  <link rel="stylesheet" href="/Choice/CSS/ResponsiveTables/mobile.css">
			  <link rel="stylesheet" href="/Choice/CSS/Common/CommonCSS.css" type="text/css">
		  <!-- End Combine and Compress These CSS Files -->
				<link rel="stylesheet" href="/Choice/CSS/ResponsiveTables/app.css">
				<link rel="stylesheet" href="/Choice/CSS/ResponsiveTables/responsive-tables.css">
				<link rel="stylesheet" href="/Choice/CSS/Common/CommonCSS.css">
				<script src="/Choice/JS/CommonJS.js"></script>
				<script src="/Choice/JS/ResponsiveTables/jquery.min.js"></script>
				<script src="/Choice/JS/ResponsiveTables/responsive-tables.js"></script>
		
<%
		String strIsCommand = request.getParameter("isCommand");
		Actions action = new Actions();	
		String strDatabaseTableName = "clienttopnavigator";
		String strWhere = "Name != 'NA'";
		CachedRowSet resultSetTopNavigator = action.fetchDataFromDB(strDatabaseTableName, null, strWhere);
		String strNoData = null;
		if(!resultSetTopNavigator.next())
		{
			strNoData = "No Data Found";
		}
		resultSetTopNavigator.beforeFirst();
%>
		<script type="text/javascript">
			
			function setCheckboxes()
			{
				var selectedFields = document.getElementsByName("Checkbox");
				var value = "";
				for(var a=0;a<selectedFields.length;a++)
					{
						var obj = selectedFields[a];
						if(obj.checked)
							{
							 	value = value + document.getElementById(obj.value).value + ",";
							}
					}
				
				value = value.substring(0,value.length-1);
				document.getElementById("selectedFields").value = value;
			}
			
			function submitData()
			{
				var selectedFields = document.getElementById("selectedFields").value;
				loadAdminActiveScreen('/Choice/JSP/DatabaseJSP/RemoveTopNavigatorCommandsProcess.jsp?selectedFields='+selectedFields);
			}
			
			$(document).ready(function(){
				var checkCount = <%=strNoData%>;
				if(checkCount == "No Data Found")
					{
						$('#TopNavigatorCommands').html("<br><br><h6>No data found!</h6>");
					}
			});
			
			</script>
		
		<title>Remove Commands</title>
	</head>

	<body>
		<div id = Formheader class = "Formheader">
		<h4 style="color:#ff6a22">Remove Top Navigator Commands</h4><br><br>
		</div>
		<input type="hidden" id="isCommand" name="isCommand" value="<%=strIsCommand%>" />
<%
	try
		{
		if(strNoData == null)
			{

%>	
			<div id="TopNavigatorCommands" class="TopNavigatorCommands">
				<table border="1">
					<th>Select Field</th><th>Name</th><th>Label</th><th>Link</th>
<%

				int count = 0;
				while(resultSetTopNavigator.next())
					{
%>
						<tr>
<%
							String strName = resultSetTopNavigator.getString("Name");
							String strLabel = resultSetTopNavigator.getString("Label");
							String strLink = resultSetTopNavigator.getString("Link");
%>
							<td><input type="checkbox" id="Checkbox" name="Checkbox" value="Name<%=count%>" onclick="setCheckboxes();" /></td>
							<td><%=strName%></td>
							<input type="hidden" id="Name<%=count%>" name="Name<%=count%>" value="<%=strName%>" />
							<td><%=strLabel%></td>
							<td><%=strLink%></td>
							
						</tr>
<%			
							count++;
					}
%>	
				</table><br><br>
				<input type="hidden" name="selectedFields" id="selectedFields" value="" />
				<input type="button" value="Remove Commands" name="Remove_Commands" id="Remove_Commands" onclick="submitData();"/>
				
			</div>
<%
				}
				else
					{
%>
						<h4> No data found. </h4>
<%						
					}
		}
		catch(Exception e)
			{
				System.out.println("Exception::"+e);
%>
				<jsp:forward page="../ErrorJSP/Error.jsp"></jsp:forward>
<%
			}
%>

	</body>

<%
		}
}
%>
</html>