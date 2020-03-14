package hw2;

public class Command {
	// 命令的类型，目前只有list
	public String type;

	// 判断是否为list命令
	public boolean is_list() {
		if (this.type.equals("list")) {
			return true;
		} else {
			return false;
		}
	}
}
