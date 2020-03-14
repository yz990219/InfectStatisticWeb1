# 结对第二次作业——某次疫情统计可视化的实现

## 作业链接
[作业链接](https://edu.cnblogs.com/campus/fzu/2020SPRINGS/homework/10460)

## 结对学号
221701405 & 221701430

## 项目介绍

1. 实现通过地图的形式来直观显示疫情的大致分布情况，还可以查看具体省份的疫情统计情况。
    > * 可以选择具体的日期；
    > * 在全国地图上使用不同的颜色代表大概确诊人数区间
    > * 颜色的深浅表示疫情的严重程度，可以直观了解高危区域；
    > * 鼠标移到每个省份会高亮显示；
    > * 点击鼠标会显示该省具体疫情情况；

2. 点击某个省份显示该省疫情的具体情况
    > * 可以选择具体的日期；
    > * 显示该省份对应的感染患者人数、疑似患者人数、治愈人数、死亡人数；
    > * 该省份到目前为止的新增确诊趋势、新增疑似趋势、治愈趋势和死亡趋势；
    > * 绘制该省份的趋势变化曲线图；



## 项目构建及运行

1. 首先使用GitHub进行仓库创建
    > * 创建一个dev分支用于开发
    > * 利用仓库中settings的manage access实现多人合作

2. 采用使用jsp作为主体技术
    > * 首先进行数据统计部分的静态HTML及相关文件的编写
    > * 其次对进行java文件的编写，用于处理数据，将文件放于动态网页工程的java的src部分
    > * 再是使用echarts实现静态数据的地图和折线图
    > * 然后进行第一步和第三步的整合，将整合后的代码放入工程的webcontent文件下的对应jsp文件中，并加上打包好的相关的CSS和JavaScript文件
    > * 最终页面之间使用原页面表单提交和目标页面Java脚本提取的方式进行数据传输，并将静态数据部分使用Java脚本对log文件进行处理并提取显示实现动态数据

3. 最终再次使用GitHub完成开发
    > * 使用pull request将dev分支合并到master分支
    > * 使用release发布1.0.0版本，此次项目告一段落
