package hw2;

import java.util.ArrayList;

public class Arguments {
	// ���ֲ�����������������ĳ�������Ӧ������Ϊtrue��ʾ����
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

	// ���ֺ��������ж����ֲ����Ƿ񼤻����ֵΪ��ӦBoolean�Ͳ���
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
