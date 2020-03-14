<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=EDGE">
    <title>HTML5 Canvas实现中国地图DEMO演示</title>

    <style>
        #china-map {
            width: 1000px;
            height: 1000px;
            margin: auto;
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
    </style>

    <script type="text/javascript" src="js/jquery.min.js"></script>
    <script type="text/javascript" src="js/echarts.min.js"></script>
    <script type="text/javascript" src="js/map/china.js"></script>

</head>

<body>
    <div style="text-align:center;clear:both;">
        <script src="/gg_bd_ad_720x90.js" type="text/javascript"></script>
        <script src="/follow.js" type="text/javascript"></script>
    </div>
    <button id="back">返回全国</button>
    
    <form action="indexRes.jsp" style = "display:none;" id = "province">     
       <div id="yz" name="yz" >全国</div>
       <input id="province_value" name="province_value" type="text" value="测试">
       <button type="submit">选择</button>
    </form>
        
    <div id="china-map"></div>
    <div id="main" style="width: 600px;height:400px; margin-left: 500px;"></div>



    <script type="text/javascript">
        //折线图使用的JavaScript
        // 基于准备好的dom，初始化echarts实例
        var myChart = echarts.init(document.getElementById('main'));
        var mydate1 = new Array();
        //mydate = ["衬衫", "羊毛衫", "雪纺衫", "子", "高跟鞋", "袜子"];
        mydate1[0] = "11";
        mydate1[1] = "22";
        mydate1[2] = "33";
        mydate1[3] = "44";
        mydate1[4] = "55";
        mydate1[5] = "66";
        // 指定图表的配置项和数据
        var option = {
            title: {
                text: '第一个 ECharts 实例'
            },
            tooltip: {},
            legend: {
                data: ['销量', '疑似']
            },
            xAxis: {
                data: mydate1
            },
            yAxis: {},
            series: [{
                name: '销量',
                type: 'line',
                data: [5, 20, 36, 10, 10, 20]

            }, {
                name: '疑似',
                type: 'line',
                data: [1, 25, 14, 16, 18, 300]

            }]
        };
        // 使用刚指定的配置项和数据显示图表。
        myChart.setOption(option);
    </script>

    <script>
        //地图使用的JavaScript
        var myChart = echarts.init(document.getElementById('china-map'));
        var oBack = document.getElementById("back");
        var provinces = ['shanghai', 'hebei', 'shanxi', 'neimenggu', 'liaoning', 'jilin', 'heilongjiang', 'jiangsu', 'zhejiang', 'anhui', 'fujian', 'jiangxi', 'shandong', 'henan', 'hubei', 'hunan', 'guangdong', 'guangxi', 'hainan', 'sichuan', 'guizhou', 'yunnan', 'xizang', 'shanxi1', 'gansu', 'qinghai', 'ningxia', 'xinjiang', 'beijing', 'tianjin', 'chongqing', 'xianggang', 'aomen'];
        var provincesText = ['上海', '河北', '山西', '内蒙古', '辽宁', '吉林', '黑龙江', '江苏', '浙江', '安徽', '福建', '江西', '山东', '河南', '湖北', '湖南', '广东', '广西', '海南', '四川', '贵州', '云南', '西藏', '陕西', '甘肃', '青海', '宁夏', '新疆', '北京', '天津', '重庆', '香港', '澳门'];
        var seriesData = [{
            name: '北京',
            value: 100
        }, {
            name: '天津',
            value: 0
        }, {
            name: '上海',
            value: 60
        }, {
            name: '重庆',
            value: 0
        }, {
            name: '河北',
            value: 60
        }, {
            name: '河南',
            value: 60
        }, {
            name: '云南',
            value: 0
        }, {
            name: '辽宁',
            value: 0
        }, {
            name: '黑龙江',
            value: 0
        }, {
            name: '湖南',
            value: 60
        }, {
            name: '安徽',
            value: 0
        }, {
            name: '山东',
            value: 60
        }, {
            name: '新疆',
            value: 0
        }, {
            name: '江苏',
            value: 0
        }, {
            name: '浙江',
            value: 111
        }, {
            name: '江西',
            value: 0
        }, {
            name: '湖北',
            value: 60
        }, {
            name: '广西',
            value: 60
        }, {
            name: '甘肃',
            value: 0
        }, {
            name: '山西',
            value: 60
        }, {
            name: '内蒙古',
            value: 0
        }, {
            name: '陕西',
            value: 0
        }, {
            name: '吉林',
            value: 0
        }, {
            name: '福建',
            value: 0
        }, {
            name: '贵州',
            value: 0
        }, {
            name: '广东',
            value: 597
        }, {
            name: '青海',
            value: 0
        }, {
            name: '西藏',
            value: 0
        }, {
            name: '四川',
            value: 60
        }, {
            name: '宁夏',
            value: 0
        }, {
            name: '海南',
            value: 60
        }, {
            name: '台湾',
            value: 0
        }, {
            name: '香港',
            value: 0
        }, {
            name: '澳门',
            value: 0
        }];
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
                title: {
                    text: Chinese_ || pName,
                    left: 'center'
                },
                tooltip: {
                    trigger: 'item',
                    formatter: '{b}<br/>{c}人确诊'
                },
                visualMap: {
                    type: 'piecewise',
                    pieces: [{
                        min: 1000,
                        max: 1000000,
                        label: '大于等于1000人',
                        //color: '#372a28'
                    }, {
                        min: 500,
                        max: 999,
                        label: '确诊500-999人',
                        //color: '#974236'
                    }, {
                        min: 100,
                        max: 499,
                        label: '确诊100-499人',
                        //color: '#ee7263'
                    }, {
                        min: 1,
                        max: 99,
                        label: '确诊1-99人',
                        //color: '#f5bba7'
                    }, ],
                    //不知道拿来干嘛
                    color: ['#974236', '#f5bba7']
                },
                series: [{
                    name: Chinese_ || pName,
                    type: 'map',
                    mapType: pName,
                    roam: false, //是否开启鼠标缩放和平移漫游
                    data: tmpSeriesData,
                    top: "3%", //组件距离容器的距离
                    zoom: 1.1,
                    selectedMode: 'single',

                    label: {
                        normal: {
                            show: true, //显示省份标签
                            textStyle: {
                                color: "#fbfdfe"
                            } //省份标签字体颜色
                        },
                        emphasis: { //对应的鼠标悬浮效果
                            show: true,
                            textStyle: {
                                color: "#323232"
                            }
                        }
                    },
                    itemStyle: {
                        normal: {
                            borderWidth: .5, //区域边框宽度
                            borderColor: '#0550c3', //区域边框颜色
                            areaColor: "#4ea397", //区域颜色

                        },

                        emphasis: {
                            borderWidth: .5,
                            borderColor: '#4b0082',
                            areaColor: "#ece39e",
                        }
                    },
                }]

            };
            myChart.setOption(option);
            myChart.off("click");
            var temp;
            if (pName === "china") { // 全国时，添加click 进入省级
                myChart.on('click', function(param) {
                    console.log(param.name);
                    // 遍历取到provincesText 中的下标  去拿到对应的省js
                    for (var i = 0; i < provincesText.length; i++) {
                        if (param.name === provincesText[i]) {
                            //显示对应省份的方法
                            showProvince(provinces[i], provincesText[i]);
                            document.getElementById("yz").innerHTML = provincesText[i];
                            document.getElementById("province").style.display = "block";
                            document.getElementById("province_value").value = provincesText[i];
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
            loadBdScript('$' + pName + 'JS', './js/map/province/' + pName + '.js', function() {
                initEcharts(Chinese_);
            });
        }
        // 加载对应的JS
        function loadBdScript(scriptId, url, callback) {
            var script = document.createElement("script");
            script.type = "text/javascript";
            if (script.readyState) { //IE
                script.onreadystatechange = function() {
                    if (script.readyState === "loaded" || script.readyState === "complete") {
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