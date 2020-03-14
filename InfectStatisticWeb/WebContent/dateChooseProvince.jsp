<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="hw2.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.File"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=EDGE">
<title><%=request.getParameter("province_value")%>省详情日期选择</title>
<link href="css/dateChoose.css" rel="stylesheet">

</head>
<body>


	<div class="datechoose">
		<form class="form" action="province.jsp" id="province">

			
			<%
				ArrayList<String> fileNameList = new ArrayList<String>();
				String[] temp;
				String path = "D:\\InfectStatisticWeb1\\InfectStatisticWeb\\WebContent\\log\\";
				File name = new File(path);
				temp = name.list();
				if (name.isDirectory()) {
					for (int i = 0; i < temp.length; i++) {
						fileNameList.add(temp[i]);
					}
				}
			%>
			<div>
				<h1 style="color: #ffffff;">请选择数据截止日期</h1>
			</div>
			<div>
				<select name="date">
					<%
						for (int i = 0; i < fileNameList.size(); i++) {
					%>
					<option
						value="<%=fileNameList.get(i).substring(0, fileNameList.get(i).length() - 8)%>">
						<%=fileNameList.get(i).substring(0, fileNameList.get(i).length() - 8)%>
					</option>
					<%
						}
					%>
				</select>
			</div>
			<input id="province_value" name="province_value" type="text"
				value="<%=request.getParameter("province_value")%>" style="display: none;">
			<div style="margin-top: 20px">
				<button type="submit">确定</button>
			</div>
		</form>


	</div>



</body>
</html>