<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="databaseActions.Actions"%>
<%@page import="java.io.File"%>
<%@ page import="com.oreilly.servlet.*" %> 
<html>
<%
if (session == null || session.getAttribute("User") == null || !session.getAttribute("User").equals("Administrator")) {
%>
		<script>
			window.open("/Choice/Login.jsp","_top");
		</script>
<%
}

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
				<script src="/Choice/JS/ResponsiveTables/jquery.min.js"></script>
				<script src="/Choice/JS/ResponsiveTables/responsive-tables.js"></script>
		
<%
	try
		{
		File appFolder = new File(application.getRealPath("/"));
		String strApplicationPath = appFolder.toURL().toString();
		strApplicationPath = strApplicationPath.substring(strApplicationPath.indexOf("file:/")+6, strApplicationPath.length());
		strApplicationPath += "/Images/Icons";
		MultipartRequest m = new MultipartRequest(request, strApplicationPath);

%>
		
		<title>Side Navigator links</title>
	</head>

	<body>
		<div id = Formheader class = "Formheader">
		</div>
		
<%
	try
		{
			String strDatabaseTableName = m.getParameter("DatabaseTableName");
			String[] strNames = new String[6];
			String[] strValues = new String[6];
			String[] strDatabaseTableFields = new String[6];
			
			
			String strTempValue = null;
			strNames[0]= "Name";
			strTempValue = m.getParameter("Name");
			strTempValue = strTempValue.trim();
			strTempValue = strTempValue.replace(" ", "_");
			strValues[0]= strTempValue;
			strTempValue = m.getParameter("NameDatabaseTableFieldName");
			strTempValue = strTempValue.trim();
			strDatabaseTableFields[0]= strTempValue;
			
			strNames[1]= "Label";
			strTempValue = m.getParameter("Label");
			strTempValue = strTempValue.trim();
			strValues[1]= strTempValue;
			strTempValue = m.getParameter("LabelDatabaseTableFieldName");
			strTempValue = strTempValue.trim();
			strDatabaseTableFields[1]= strTempValue;
			
			strNames[2]= "Icon";
			strTempValue = m.getOriginalFileName("Icon");
			strTempValue = strTempValue.trim();
			strValues[2]= strTempValue;
			strTempValue = m.getParameter("IconDatabaseTableFieldName");
			strTempValue = strTempValue.trim();
			strDatabaseTableFields[2]= strTempValue;
			
			strNames[3]= "Hyperlink";
			strTempValue = m.getParameter("Hyperlink");
			strTempValue = strTempValue.trim();
			strValues[3]= strTempValue;
			strTempValue = m.getParameter("HyperlinkDatabaseTableFieldName");
			strTempValue = strTempValue.trim();
			strDatabaseTableFields[3]= strTempValue;
			
			String MenuCommand = "Command";
			strNames[4]= "IsMenu";
			strTempValue = m.getParameter("IsMenuHidden");
			strTempValue = strTempValue.trim();
			if(strTempValue.equalsIgnoreCase("true"))
			{
				MenuCommand = "Menu";
			}
			strValues[4]= strTempValue;
			strTempValue = m.getParameter("IsMenuDatabaseTableFieldName");
			strTempValue = strTempValue.trim();
			strDatabaseTableFields[4]= strTempValue;
			

			strNames[5]= "AccessGroups";
			strTempValue = m.getParameter("AccessGroups");
			strTempValue = strTempValue.trim();
			if(strTempValue.equals(""))
			{
				strTempValue = "NA";
			}
			strValues[5]= strTempValue;
			strTempValue = m.getParameter("AccessGroupsDatabaseTableFieldName");
			strTempValue = strTempValue.trim();
			strDatabaseTableFields[5]= strTempValue;
			
			Actions toAdd = new Actions();
			String IsNewEntryAdded = toAdd.AddNewEntry(strDatabaseTableName, strDatabaseTableFields, strValues);

			if(strValues[4].equalsIgnoreCase("true"))
			{

				String[] strValuesForSubMenuMaster = new String[4];
				String[] strDatabaseTableFieldsForSubMenuMaster = new String[4];
				for(int i=0;i<strNames.length-2;i++)
				{
					strValuesForSubMenuMaster[i] = strValues[i];
					strDatabaseTableFieldsForSubMenuMaster[i] = strDatabaseTableFields[i];
				}

				IsNewEntryAdded = toAdd.AddNewEntry("clientsidenavigatorsubmenu", strDatabaseTableFieldsForSubMenuMaster, strValuesForSubMenuMaster);
			}
			
			if(IsNewEntryAdded.equals("true"))
				{
%>
					<script type="text/javascript">
						alert("New <%=MenuCommand%> added to Side Navigator Succesfully!");
						window.open("/Choice/AdminHome.jsp","_top");
					</script>
<%
				}
				else if(IsNewEntryAdded.equals("No DB"))
					{
%>
						<script type="text/javascript">
							alert("Database doesnot exist. Please create database.");
							window.open("/Choice/AdminHome.jsp","_top");
						</script>
					
<%
					}
					else if(IsNewEntryAdded.contains("Duplicate entry"))
						{
%>
							<script type="text/javascript">
								alert("Menu/Command with same name already exists!!");
								window.open("/Choice/AdminHome.jsp","_top");
							</script>
<%
						}
						else
							{
%>
								<script type="text/javascript">
									alert("Something went wrong! Please try again.");
									window.open("/Choice/AdminHome.jsp","_top");
								</script>
<%
						}
						
		}
		catch(Exception e)
			{
				System.out.println("Exception in AddSideNavigatorLinksProcess.jsp ::"+e);
%>
				<jsp:forward page="../ErrorJSP/Error.jsp"></jsp:forward>
<%
			}
		}catch(Exception e)
			{
				System.out.println("Exception in AddSideNavigatorCommandsProcess.jsp ::"+e);
%>
				<jsp:forward page="../ErrorJSP/Error.jsp"></jsp:forward>
<%
			}
%>

	</body>

<%

%>
</html>