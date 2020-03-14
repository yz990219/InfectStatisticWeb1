<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="hw2.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.File"%>
<!DOCTYPE html>
<%
	String date = request.getParameter("date");
	String province = request.getParameter("province_value");
	//System.out.println(date);
	//用于测试用的自组命令行，记得注释掉再把commandline_analysis.analysis(commandline_test);
	//改成commandline_analysis.analysis(cmdline);
	ArrayList<String> commandline_test = new ArrayList<String>();
	commandline_test.add("list");
	commandline_test.add("-log");
	commandline_test.add("D:\\InfectStatisticWeb1\\InfectStatisticWeb\\WebContent\\log\\");
	commandline_test.add("-out");
	commandline_test.add("D:\\InfectStatistic-main\\221701430\\result\\test.txt");
	commandline_test.add("-date");
	commandline_test.add(date);
	CommandLineAnalysis commandline_analysis = new CommandLineAnalysis();
	CommandLine commandline = commandline_analysis.analysis(commandline_test);
	//测试用
	CommandLineRun cmd_run = new CommandLineRun(commandline);
%>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=EDGE">
<title><%=province%>省详细信息</title>
<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" src="js/echarts.min.js"></script>
</head>
<body>
	<h1>你的选择是<%=province%>日期是：<%=date%></h1>
	<div id="main" style="width: 1000px; height: 400px; margin-left: 500px;"></div>



	<script type="text/javascript">
		//折线图使用的JavaScript
		// 基于准备好的dom，初始化echarts实例
		var myChart = echarts.init(document.getElementById('main'));
		var date = new Array();
		var data_ip = new Array();
		var data_sp = new Array();
		var data_cure = new Array();
		var data_dead = new Array();
		<%
			for(int i = 0;i<cmd_run.filename_list.size();i++){
				String file = cmd_run.filename_list.get(i).substring(0, cmd_run.filename_list.get(i).length() - 8);
		%>
				date[<%=i %>] = "<%=file %>";
				data_ip[<%=i %>] = "<%=cmd_run.getInfoByDate(file).getProvince(province).ip%>";
				data_sp[<%=i %>] = "<%=cmd_run.getInfoByDate(file).getProvince(province).sp%>";
				data_cure[<%=i %>] = "<%=cmd_run.getInfoByDate(file).getProvince(province).cure%>";
				data_dead[<%=i %>] = "<%=cmd_run.getInfoByDate(file).getProvince(province).dead%>";
		<%
			}
		%>
		
		// 指定图表的配置项和数据
		var option = {
			title : {
				text : '第一个 ECharts 实例'
			},
			tooltip : {
				trigger: 'axis',
	            backgroundColor: '#0D1B42',
	        },
			legend : {
				data : [ '新增确诊', '新增疑似' , '新增治愈', '新增死亡']
			},
			xAxis : {
				data : date,
				name : '日期'
			},
			yAxis : {
				name : '人数'
			},
			series : [ {
				name : '新增确诊',
				type : 'line',
				data : data_ip

			}, {
				name : '新增疑似',
				type : 'line',
				data : data_sp

			}, {
				name : '新增治愈',
				type : 'line',
				data : data_cure

			}, {
				name : '新增死亡',
				type : 'line',
				data : data_dead

			} ]
		};
		// 使用刚指定的配置项和数据显示图表。
		myChart.setOption(option);
	</script>

</body>
</html>