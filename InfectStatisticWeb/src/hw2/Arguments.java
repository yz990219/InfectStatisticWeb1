package hw2;

import java.util.ArrayList;

public class Arguments {
	// 五种参数，若命令行中有某参数则对应参数设为true表示激活
	public boolean log;
	public String log_value;
	public boolean out;
	public String out_value;
	public boolean date;
	public String date_value;
	public boolean type;
	public ArrayList<String> type_value;
	public boolean province;
	public ArrayList<String> province_value;

	// 五种函数用于判断五种参数是否激活，返回值为对应Boolean型参数
	public boolean is_log() {
		return log;
	}

	public boolean is_out() {
		return out;
	}

	public boolean is_date() {
		return date;
	}

	public boolean is_type() {
		return type;
	}

	public boolean is_province() {
		return province;
	}
}
