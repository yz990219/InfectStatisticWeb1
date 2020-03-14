package hw2;

import java.util.ArrayList;
import hw2.Command;
import hw2.Arguments;
public class CommandLine {
	public Command command;
	public Arguments arguments;
	

	public void test() {
		System.out.println("command:" + command.type );
		System.out.println("arguments.log:" + arguments.log + "," + arguments.log_value);	
		System.out.println("arguments.date:" + arguments.date + "," + arguments.date_value);	
		System.out.println("arguments.out:" + arguments.out + "," + arguments.out_value);
		System.out.println("arguments.type:" + arguments.type + "," + arguments.type_value);
		System.out.println("arguments.province:" + arguments.province + "," + arguments.province_value);
	}
	
	
	
	

}
