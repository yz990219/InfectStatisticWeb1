package hw2;

public class Province {
	public String name;
	public int ip;
	public int sp;
	public int cure;
	public int dead;
	//用于记录四项数据是否全是0
	public boolean isblank() {
		if(ip == 0 && sp == 0 && cure == 0 && dead == 0) {
			return true;
		}else {
			return false;
		}
	}
}
