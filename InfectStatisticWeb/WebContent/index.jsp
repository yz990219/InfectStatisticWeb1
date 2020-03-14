<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="hw2.*"%>
<%@ page import="java.util.*"%>
<!DOCTYPE html>
<%
	String date = request.getParameter("date");
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
<title>全国疫情地图</title>
<link href="css/styles.css" type="text/css" rel="stylesheet" />
<style>
#china-map {
	width: 1000px;
	height: 1000px;
	margin-top: 840px;
	margin-left: 100px;
}

#map {
	
}

#province {
	
}

#dataview {
	
}

#box {
	display: none;
	background-color: goldenrod;
	width: 180px;
	height: 30px;
}

#box-title {
	display: block;
}

#button {
	position: absolute;
}

#buttons {
	margin-left: -126px;
	margin-top: -970px;
}
</style>
<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" src="js/echarts.min.js"></script>
<script type="text/javascript" src="js/map/china.js"></script>
</head>
<body>
	<div id="dateview">
		<div id="pic">
			<img id="pic_box"
				src="https://static.ws.126.net/163/f2e/news/virus_report/static/images/banner.53e59fc.png" />
			<div class="text1 " style="display: none; visibility: hidden">
				<p></p>
			</div>
		</div>

		<div id="tit">
			<div class="text2 ">
				<p>
					<span>疫情统计</span>
				</p>
			</div>
		</div>


		<div id="background">
			<div id="background_box"></div>
			<div class="text1 " style="display: none; visibility: hidden">
				<p></p>
			</div>
		</div>


		<div id="sp">
			<div class="text2 ">
				<p>
					<span>累计疑似</span>
				</p>
			</div>
		</div>

		<div id="ip">
			<div class="text2 ">
				<p>
					<span>累计确诊</span>
				</p>
			</div>
		</div>

		<div id="dead">
			<div class="text2 ">
				<p>
					<span>累计死亡</span>
				</p>
			</div>
		</div>

		<div id="cure">
			<div class="text2 ">
				<p>
					<span>累计治愈</span>
				</p>
			</div>
		</div>

		<div id="ips">
			<div class="text2 ">
				<p style="font-size: 72px;">
					<span style="color: #EC808D;"><%=cmd_run.get_province("全国").ip %></span>
				</p>

			</div>
		</div>

		<div id="deads">
			<div class="text2 ">
				<p style="font-size: 72px;">
					<span style="color: #7F7F7F;"><%=cmd_run.get_province("全国").dead %></span>
				</p>

			</div>
		</div>

		<div id="cures">
			<div class="text2 ">
				<p style="font-size: 72px;">
					<span style="color: #D9001B;"><%=cmd_run.get_province("全国").cure %></span>
				</p>

			</div>
		</div>

		<div id="sps">
			<div class="text2 ">
				<p style="font-size: 72px;">
					<span style="color: #66A9C5;"><%=cmd_run.get_province("全国").sp %></span>
				</p>

			</div>
		</div>

		<div id="date">
			<div class="text2 ">
				<p>
					<span>更新至<%=date%></span>
				</p>
			</div>
		</div>

		<div id="data">
			<div class="text2 ">
				<p>
					<span>总数据统计</span>
				</p>
			</div>
		</div>
	</div>
	<div id="map">
		<h1 style="text-align: center;"><%=date%>疫情
		</h1>
		<div id="china-map"></div>
	</div>
	<div id="buttons">
		<button id="back">返回全国</button>
		<h1><%=date%>疫情
		</h1>
		<form action="dateChooseProvince.jsp" style="display: none;"
			id="province">
			<span>是否查看</span> <span id="yz" name="yz" style="font-size: 20px;">全国</span>
			<span>详细数据</span> <input id="province_value" name="province_value"
				type="text" value="测试" style="display: none;">

			<button type="submit">确定</button>
		</form>

	</div>
	<script>
		//地图使用的JavaScript
		var myChart = echarts.init(document.getElementById('china-map'));
		var oBack = document.getElementById("back");
		var provinces = [ 'shanghai', 'hebei', 'shanxi', 'neimenggu',
				'liaoning', 'jilin', 'heilongjiang', 'jiangsu', 'zhejiang',
				'anhui', 'fujian', 'jiangxi', 'shandong', 'henan', 'hubei',
				'hunan', 'guangdong', 'guangxi', 'hainan', 'sichuan',
				'guizhou', 'yunnan', 'xizang', 'shanxi1', 'gansu', 'qinghai',
				'ningxia', 'xinjiang', 'beijing', 'tianjin', 'chongqing',
				'xianggang', 'aomen' ];
		var provincesText = [ '上海', '河北', '山西', '内蒙古', '辽宁', '吉林', '黑龙江', '江苏',
				'浙江', '安徽', '福建', '江西', '山东', '河南', '湖北', '湖南', '广东', '广西',
				'海南', '四川', '贵州', '云南', '西藏', '陕西', '甘肃', '青海', '宁夏', '新疆',
				'北京', '天津', '重庆', '香港', '澳门' ];
		var seriesData = [ {
			name : '北京',
			value :
	<%=cmd_run.get_province("北京").ip%>
		}, {
			name : '天津',
			value :
	<%=cmd_run.get_province("天津").ip%>
		}, {
			name : '上海',
			value :
	<%=cmd_run.get_province("上海").ip%>
		}, {
			name : '重庆',
			value :
	<%=cmd_run.get_province("重庆").ip%>
		}, {
			name : '河北',
			value :
	<%=cmd_run.get_province("河北").ip%>
		}, {
			name : '河南',
			value :
	<%=cmd_run.get_province("河南").ip%>
		}, {
			name : '云南',
			value :
	<%=cmd_run.get_province("云南").ip%>
		}, {
			name : '辽宁',
			value :
	<%=cmd_run.get_province("辽宁").ip%>
		}, {
			name : '黑龙江',
			value :
	<%=cmd_run.get_province("黑龙江").ip%>
		}, {
			name : '湖南',
			value :
	<%=cmd_run.get_province("湖南").ip%>
		}, {
			name : '安徽',
			value :
	<%=cmd_run.get_province("安徽").ip%>
		}, {
			name : '山东',
			value :
	<%=cmd_run.get_province("山东").ip%>
		}, {
			name : '新疆',
			value :
	<%=cmd_run.get_province("新疆").ip%>
		}, {
			name : '江苏',
			value :
	<%=cmd_run.get_province("江苏").ip%>
		}, {
			name : '浙江',
			value :
	<%=cmd_run.get_province("浙江").ip%>
		}, {
			name : '江西',
			value :
	<%=cmd_run.get_province("江西").ip%>
		}, {
			name : '湖北',
			value :
	<%=cmd_run.get_province("湖北").ip%>
		}, {
			name : '广西',
			value :
	<%=cmd_run.get_province("广西").ip%>
		}, {
			name : '甘肃',
			value :
	<%=cmd_run.get_province("甘肃").ip%>
		}, {
			name : '山西',
			value :
	<%=cmd_run.get_province("山西").ip%>
		}, {
			name : '内蒙古',
			value :
	<%=cmd_run.get_province("内蒙古").ip%>
		}, {
			name : '陕西',
			value :
	<%=cmd_run.get_province("陕西").ip%>
		}, {
			name : '吉林',
			value :
	<%=cmd_run.get_province("吉林").ip%>
		}, {
			name : '福建',
			value :
	<%=cmd_run.get_province("福建").ip%>
		}, {
			name : '贵州',
			value :
	<%=cmd_run.get_province("贵州").ip%>
		}, {
			name : '广东',
			value :
	<%=cmd_run.get_province("广东").ip%>
		}, {
			name : '青海',
			value :
	<%=cmd_run.get_province("青海").ip%>
		}, {
			name : '西藏',
			value :
	<%=cmd_run.get_province("西藏").ip%>
		}, {
			name : '四川',
			value :
	<%=cmd_run.get_province("四川").ip%>
		}, {
			name : '宁夏',
			value :
	<%=cmd_run.get_province("宁夏").ip%>
		}, {
			name : '海南',
			value :
	<%=cmd_run.get_province("海南").ip%>
		}, {
			name : '台湾',
			value :
	<%=cmd_run.get_province("台湾").ip%>
		}, {
			name : '香港',
			value :
	<%=cmd_run.get_province("香港").ip%>
		}, {
			name : '澳门',
			value :
	<%=cmd_run.get_province("澳门").ip%>
		} ];
		oBack.onclick = function() {
			document.getElementById("yz").innerHTML = "中国";
			document.getElementById("province").style.display = "none";
			initEcharts("china", "中国");
		};
		initEcharts("china", "中国");
		// 初始化echarts
		function initEcharts(pName, Chinese_) {
			var tmpSeriesData = pName === "china" ? seriesData : [];

			var option = {
				title : {
					text : Chinese_ || pName,
					left : 'center'
				},
				tooltip : {
					trigger : 'item',
					formatter : '{b}<br/>{c}人确诊'
				},
				visualMap : {
					type : 'piecewise',
					pieces : [ {
						min : 1000,
						max : 1000000,
						label : '大于等于1000人',
					//color: '#372a28'
					}, {
						min : 500,
						max : 999,
						label : '确诊500-999人',
					//color: '#974236'
					}, {
						min : 100,
						max : 499,
						label : '确诊100-499人',
					//color: '#ee7263'
					}, {
						min : 1,
						max : 99,
						label : '确诊1-99人',
					//color: '#f5bba7'
					}, ],

					color : [ '#974236', '#f5bba7' ]
				},
				series : [ {
					name : Chinese_ || pName,
					type : 'map',
					mapType : pName,
					roam : false, //是否开启鼠标缩放和平移漫游
					data : tmpSeriesData,
					top : "3%", //组件距离容器的距离
					zoom : 1.1,
					selectedMode : 'single',

					label : {
						normal : {
							show : true, //显示省份标签
							textStyle : {
								color : "#fbfdfe"
							}
						//省份标签字体颜色
						},
						emphasis : { //对应的鼠标悬浮效果
							show : true,
							textStyle : {
								color : "#323232"
							}
						}
					},
					itemStyle : {
						normal : {
							borderWidth : .5, //区域边框宽度
							borderColor : '#0550c3', //区域边框颜色
							areaColor : "#ece39e", //区域颜色

						},

						emphasis : {
							borderWidth : .5,
							borderColor : '#4b0082',
							areaColor : "#00F5FF",
						}
					},
				} ]

			};
			myChart.setOption(option);
			myChart.off("click");
			var temp;
			if (pName === "china") { // 全国时，添加click 进入省级
				myChart
						.on(
								'click',
								function(param) {
									console.log(param.name);
									// 遍历取到provincesText 中的下标  去拿到对应的省js
									for (var i = 0; i < provincesText.length; i++) {
										if (param.name === provincesText[i]) {
											//显示对应省份的方法
											showProvince(provinces[i],
													provincesText[i]);
											document.getElementById("yz").innerHTML = provincesText[i];
											document.getElementById("province").style.display = "block";
											document
													.getElementById("province_value").value = provincesText[i];
											break;
										}
									}
									if (param.componentType === 'series') {
										var provinceName = param.name;
										$('#box').css('display', 'block');
										$("#box-title").html(provinceName);
									}
								});
			} else { // 省份，添加双击 回退到全国
				myChart.on("dblclick", function() {
					document.getElementById("yz").innerHTML = "中国";
					document.getElementById("province").style.display = "none";
					initEcharts("china", "中国");
				});
			}
		}
		// 展示对应的省
		function showProvince(pName, Chinese_) {
			//这写省份的js都是通过在线构建工具生成的，保存在本地，需要时加载使用即可，最好不要一开始全部直接引入。
			loadBdScript('$' + pName + 'JS', './js/map/province/' + pName
					+ '.js', function() {
				initEcharts(Chinese_);
			});
		}
		// 加载对应的JS
		function loadBdScript(scriptId, url, callback) {
			var script = document.createElement("script");
			script.type = "text/javascript";
			if (script.readyState) { //IE
				script.onreadystatechange = function() {
					if (script.readyState === "loaded"
							|| script.readyState === "complete") {
						script.onreadystatechange = null;
						callback();
					}
				};
			} else { // Others
				script.onload = function() {
					callback();
				};
			}
			script.src = url;
			script.id = scriptId;
			document.getElementsByTagName("head")[0].appendChild(script);
		};
	</script>
</body>
</html>