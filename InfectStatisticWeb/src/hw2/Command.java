package hw2;

public class Command {
	// ��������ͣ�Ŀǰֻ��list
	public String type;

	// �ж��Ƿ�Ϊlist����
	public boolean is_list() {
		if (this.type.equals("list")) {
			return true;
		} else {
			return false;
		}
	}
}
