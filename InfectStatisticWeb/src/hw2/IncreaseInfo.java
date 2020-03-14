package hw2;
import java.util.ArrayList;

import hw2.Province;
public class IncreaseInfo {
	public ArrayList<Province> provinceList ;
	public String date;
	
	public IncreaseInfo() {
		String[] provinces = { "全国", "安徽", "澳门", "北京", "重庆", "福建", "甘肃", "广东", "广西", "贵州", "海南", "河北", "河南", "黑龙江",
				"湖北", "湖南", "吉林", "江苏", "江西", "辽宁", "内蒙古", "宁夏", "青海", "山东", "山西", "陕西", "上海", "四川", "台湾", "天津", "西藏",
				"香港", "新疆", "云南", "浙江" };
		provinceList = new ArrayList<Province>();
		for (int i = 0; i < provinces.length; i++) {
			Province province = new Province();
			province.name = provinces[i];
			province.ip = 0;
			province.sp = 0;
			province.cure = 0;
			province.dead = 0;
			provinceList.add(province);
		}
		date = "";
	}
	public Province getProvince(String pname) {
		for (int i = 0; i < provinceList.size(); i++) {
			if (pname.equals(provinceList.get(i).name)) {
				return provinceList.get(i);
			}
		}
		System.out.println("该省不存在");
		return null;
	}
}
