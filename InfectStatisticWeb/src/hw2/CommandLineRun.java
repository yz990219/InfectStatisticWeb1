package hw2;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.util.ArrayList;
import java.util.Collections;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import hw2.CommandLine;
import hw2.Province;
import hw2.IncreaseInfo;

public class CommandLineRun {
	public CommandLine commandline;
	public File file_read;
	public File file_write;
	// 以下为存放各省累积数据的列表
	public ArrayList<Province> province_list;
	// 以下为存放各省新增数据的列表
	public ArrayList<IncreaseInfo> increaseList;
	// 以下为全国数据
	public int ip;
	public int sp;
	public int cure;
	public int dead;
	// 以下为需要处理的文件名列表
	public ArrayList<String> filename_list;

	public CommandLineRun(CommandLine cmdline) throws IOException {
		if (!cmdline.command.is_list()) {
			System.err.println("错误命令！");
			System.exit(0);
		}
		// cmdline.test();
		// 初始化全国总数据和各省总数据
		ip = 0;
		sp = 0;
		cure = 0;
		dead = 0;
		creat_provinces_list();
		creat_filename_list(cmdline.arguments.log_value, cmdline.arguments.date_value);
		increaseList = new ArrayList<IncreaseInfo>();
		// 这里记得要改成参数值！！！！！！！！！！
		for (int i = 0; i < filename_list.size(); i++) {
			file_read = new File(cmdline.arguments.log_value + filename_list.get(i));
			if (file_read != null) {
				process_data(file_read);
			}
		}
		country_total();
		// print_file(cmdline);
	}

	// 用于处理单个文件的
	public void process_data(File f) throws IOException {
		BufferedReader reader = new BufferedReader(new InputStreamReader(new FileInputStream(f), "GBK"));
		String temp;
		IncreaseInfo incInfo = new IncreaseInfo();
		incInfo.date = f.getName().substring(0, f.getName().length()-8);
		
		// 用于正则表达式匹配
		String type_1 = "(\\W+) (新增 感染患者) (\\d+)(人)";
		String type_2 = "(\\W+) (新增 疑似患者) (\\d+)(人)";
		String type_3 = "(\\W+) (感染患者 流入) (\\W+) (\\d+)(人)";
		String type_4 = "(\\W+) (疑似患者 流入) (\\W+) (\\d+)(人)";
		String type_5 = "(\\W+) (死亡) (\\d+)(人)";
		String type_6 = "(\\W+) (治愈) (\\d+)(人)";
		String type_7 = "(\\W+) (疑似患者 确诊感染) (\\d+)(人)";
		String type_8 = "(\\W+) (排除 疑似患者) (\\d+)(人)";

		ArrayList<String> type_list = new ArrayList<String>();
		type_list.add(type_1);
		type_list.add(type_2);
		type_list.add(type_3);
		type_list.add(type_4);
		type_list.add(type_5);
		type_list.add(type_6);
		type_list.add(type_7);
		type_list.add(type_8);

		// 进行数据读取并匹配，最后进行统计
		while ((temp = reader.readLine()) != null) {
			if (temp.isEmpty()) {
				continue;
			}
			if (temp.charAt(0) == '/') {
				continue;
			}
			// 用于记录文件某行匹配的是哪一模式
			char flag = '0';
			Pattern pattern;
			Matcher matcher;
			//System.out.println(temp);
			// 数据匹配
			for (int i = 0; i < 8; i++) {
				pattern = Pattern.compile(type_list.get(i));
				matcher = pattern.matcher(temp);
				if (matcher.find()) {
					flag = (char) (48 + (i + 1));
					break;
				} else {
					continue;
				}
			}
			// 测试用++++++++++++++++++++++++++++++++++++++++++++++++++
			// System.out.println(temp);

			// 数据处理
			pattern = Pattern.compile(type_list.get((int) (flag - 48) - 1));
			matcher = pattern.matcher(temp);
			Province p, p1, p2;
			Province pi;
			if (matcher.find()) {
				switch (flag) {
				// (\\W+) (新增 感染患者) (\\d+)(人)
				case '1':
					//累积数据
					p = get_province(matcher.group(1));
					p.ip += Integer.parseInt(matcher.group(3));
					//新增数据
					pi = incInfo.getProvince(matcher.group(1));
					pi.ip = Integer.parseInt(matcher.group(3));
					break;
				// (\\W+) (新增 疑似患者) (\\d+)(人)
				case '2':
					//累积数据
					p = get_province(matcher.group(1));
					p.sp += Integer.parseInt(matcher.group(3));
					//新增数据
					pi = incInfo.getProvince(matcher.group(1));
					pi.sp = Integer.parseInt(matcher.group(3));
					break;
				// (\\W+) (感染患者 流入) (\\W+) (\\d+)(人)
				case '3':
					p1 = get_province(matcher.group(1));
					p2 = get_province(matcher.group(3));
					p1.ip -= Integer.parseInt(matcher.group(4));
					p2.ip += Integer.parseInt(matcher.group(4));
					break;
				// (\\W+) (疑似患者 流入) (\\W+) (\\d+)(人)
				case '4':
					p1 = get_province(matcher.group(1));
					p2 = get_province(matcher.group(3));
					p1.sp -= Integer.parseInt(matcher.group(4));
					p2.sp += Integer.parseInt(matcher.group(4));
					break;
				// (\\W+) (死亡) (\\d+)(人)
				case '5':
					//累积数据
					p = get_province(matcher.group(1));
					p.dead += Integer.parseInt(matcher.group(3));
					p.ip -= Integer.parseInt(matcher.group(3));
					//新增数据
					pi = incInfo.getProvince(matcher.group(1));
					pi.dead = Integer.parseInt(matcher.group(3));
					break;
				// (\\W+) (治愈) (\\d+)(人)
				case '6':
					//累积数据
					p = get_province(matcher.group(1));
					p.cure += Integer.parseInt(matcher.group(3));
					p.ip -= Integer.parseInt(matcher.group(3));
					//新增数据
					pi = incInfo.getProvince(matcher.group(1));
					pi.cure = Integer.parseInt(matcher.group(3));
					break;
				// (\\W+) (疑似患者 确诊感染) (\\d+)(人)
				case '7':
					p = get_province(matcher.group(1));
					p.ip += Integer.parseInt(matcher.group(3));
					p.sp -= Integer.parseInt(matcher.group(3));
					break;
				// (\\W+) (排除 疑似患者) (\\d+)(人)
				case '8':
					p = get_province(matcher.group(1));
					p.sp -= Integer.parseInt(matcher.group(3));
					break;
				default:
					break;
				}
			} else {
				System.out.println("NO MATCH");
			}
			

		}
//		System.out.println("正在处理文件：" + f.getName()+"以下为该日期各省份新增ip数据：");
//		System.out.println("该日期为：" + incInfo.date);
//		for(int i = 0;i < incInfo.provinceList.size();i++) {
//			System.out.println("name：" + incInfo.provinceList.get(i).name +
//					" ip：" + incInfo.provinceList.get(i).ip +
//					" sp：" + incInfo.provinceList.get(i).sp);
//		}
		increaseList.add(incInfo);
	}

	// 创建排序好的省份列表
	public void creat_provinces_list() {
		province_list = new ArrayList<Province>();
		String[] provinces = { "全国", "安徽", "澳门", "北京", "重庆", "福建", "甘肃", "广东", "广西", "贵州", "海南", "河北", "河南", "黑龙江",
				"湖北", "湖南", "吉林", "江苏", "江西", "辽宁", "内蒙古", "宁夏", "青海", "山东", "山西", "陕西", "上海", "四川", "台湾", "天津", "西藏",
				"香港", "新疆", "云南", "浙江" };
		for (int i = 0; i < provinces.length; i++) {
			Province province = new Province();
			province.name = provinces[i];
			province.ip = 0;
			province.sp = 0;
			province.cure = 0;
			province.dead = 0;
			province_list.add(province);
		}
	}

	// 使用日期在新增信息列表获取省新增信息
	public IncreaseInfo getInfoByDate(String date) {
		for(int i = 0;i < increaseList.size();i++) {
			if(increaseList.get(i).date.equals(date)) {
				return increaseList.get(i);
			}
		}
		return null;
 	}

	// 使用省名在省列表中获取省对象
	public Province get_province(String pname) {
		for (int i = 0; i < province_list.size(); i++) {
			if (pname.equals(province_list.get(i).name)) {
				return province_list.get(i);
			}
		}
		System.out.println("该省不存在");
		return null;
	}

	// 全国总数据统计
	public void country_total() {
		// 从第一个省开始累加
		for (int i = 1; i < province_list.size(); i++) {
			province_list.get(0).ip += province_list.get(i).ip;
			province_list.get(0).sp += province_list.get(i).sp;
			province_list.get(0).cure += province_list.get(i).cure;
			province_list.get(0).dead += province_list.get(i).dead;
		}
	}

	// 创建需要读取的文件名列表
	public void creat_filename_list(String path, String date) {
		filename_list = new ArrayList<String>();
		String[] temp;
		int index = -1;
		// path 即为log的参数值
		File name = new File(path);
		temp = name.list();
		// 若date无要求则为log文件夹下所有文件
		if (date == null) {
			if (name.isDirectory()) {
				for (int i = 0; i < temp.length; i++) {
					filename_list.add(temp[i]);
				}
			}
		} else {// 若date有要求则为date前的所有文件
			if (name.isDirectory()) {
				// 由于list()的返回值是排好序的
				for (int i = 0; i < temp.length; i++) {
					// 如果列表中为22 24 26 而date为25的情况
					if ((temp[i].compareTo((date + ".log.txt")) > 0)) {
						index = i - 1;
						break;
					}
					// 如果列表中为22 24 26 而date为26的情况
					else if ((temp[i].compareTo((date + ".log.txt")) == 0)) {
						index = i;
						break;
					}
				}
				if (index == -1) {
					System.err.println("日期超出范围");
					if (name.isDirectory()) {
						for (int i = 0; i < temp.length; i++) {
							filename_list.add(temp[i]);
						}
					}
				} else {
					for (int i = 0; i <= index; i++) {
						filename_list.add(temp[i]);
					}
				}

			}
		}
		Collections.sort(filename_list);
		// System.out.println(filename_list);
	}

	// 按要求输出到文件
	public void print_file(CommandLine commandline) throws IOException {
		// 构造输出流
		String path = commandline.arguments.out_value;
		file_write = new File(path);
		BufferedWriter writer = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(file_write), "UTF-8"));

		// 按条件输出
		Province temp_province = new Province();
		// 有对省份进行要求
		if (commandline.arguments.province) {
			for (int i = 0; i < commandline.arguments.province_value.size(); i++) {
				// 获取符合要求的省份
				temp_province = get_province(commandline.arguments.province_value.get(i));
				// 打印这个省份需要的数据
				// 当没有要求type时
				if (!commandline.arguments.type) {
					writer.write(temp_province.name + " 感染患者" + temp_province.ip + "人" + " 疑似患者" + temp_province.sp
							+ "人" + " 治愈" + temp_province.cure + "人" + " 死亡" + temp_province.dead + "人");
					writer.write("\n");
				} else {// 有要求type时
					writer.write(temp_province.name + " ");
					for (int j = 0; j < commandline.arguments.type_value.size(); j++) {
						if (commandline.arguments.type_value.get(j).equals("ip")) {
							writer.write("感染患者" + temp_province.ip + "人 ");
						}
						if (commandline.arguments.type_value.get(j).equals("sp")) {
							writer.write("疑似患者" + temp_province.sp + "人 ");
						}
						if (commandline.arguments.type_value.get(j).equals("cure")) {
							writer.write("治愈" + temp_province.cure + "人 ");
						}
						if (commandline.arguments.type_value.get(j).equals("dead")) {
							writer.write("死亡" + temp_province.dead + "人 ");
						}
					}
					writer.write("\n");
				}
			}
		} else {// 没有对省份进行要求
			for (int i = 0; i < province_list.size(); i++) {
				// 如果某省四种数据全为0就不做输出
				if (province_list.get(i).isblank()) {
					continue;
				}
				temp_province = province_list.get(i);
				// 打印这个省份需要的数据
				// 当没有要求type时
				if (!commandline.arguments.type) {
					writer.write(temp_province.name + " 感染患者" + temp_province.ip + "人" + " 疑似患者" + temp_province.sp
							+ "人" + " 治愈" + temp_province.cure + "人" + " 死亡" + temp_province.dead + "人");
					writer.write("\n");
				} else {// 有要求type时
					writer.write(temp_province.name + " ");
					for (int j = 0; j < commandline.arguments.type_value.size(); j++) {
						if (commandline.arguments.type_value.get(j).equals("ip")) {
							writer.write("感染患者" + temp_province.ip + "人 ");
						}
						if (commandline.arguments.type_value.get(j).equals("sp")) {
							writer.write("疑似患者" + temp_province.sp + "人 ");
						}
						if (commandline.arguments.type_value.get(j).equals("cure")) {
							writer.write("治愈" + temp_province.cure + "人 ");
						}
						if (commandline.arguments.type_value.get(j).equals("dead")) {
							writer.write("死亡" + temp_province.dead + "人 ");
						}
					}
					writer.write("\n");
				}
			}
		}
		writer.write("// 该文档并非真实数据，仅供测试使用\n");
		writer.close();
	}
}
