package hw2;

import java.util.ArrayList;

import hw2.CommandLine;

public class CommandLineAnalysis {
	public CommandLine analysis(ArrayList<String> commandline) {
		
		CommandLine command_line = new CommandLine();
		command_line.command = new Command();
		command_line.command.type = commandline.get(0);
		command_line.arguments = new Arguments();
		command_line.arguments.type_value = new ArrayList<String>();
		command_line.arguments.province_value = new ArrayList<String>();

		// 进行命令行解析
		for (int i = 0; i < commandline.size(); i++) {
			String temp = commandline.get(i);

			switch (temp) {
			case "list":
				command_line.command.type = "list";
				break;
			case "-log":
				command_line.arguments.log = true;
				command_line.arguments.log_value = commandline.get(i + 1);
				break;
			case "-date":
				command_line.arguments.date = true;
				command_line.arguments.date_value = commandline.get(i + 1);
				break;
			case "-out":
				command_line.arguments.out = true;
				command_line.arguments.out_value = commandline.get(i + 1);
				break;
			case "-type":
				// 由于type和province都有可能有多个参数所以特殊处理
				command_line.arguments.type = true;
				for (int j = i + 1; j < commandline.size(); j++) {
					char temp_char = commandline.get(j).charAt(0);
					// 如果开头不是-，则代表还是参数值;若是-，则说明已经到了下一个参数
					if (temp_char != '-') {
						command_line.arguments.type_value.add(commandline.get(j));
					} else {
						// 由于此时commandline.get(j)已经是下一个参数了
						// 所以把i设为j-1，那么下一轮switch的temp就是下一个参数
						i = j - 1;
						break;
					}
				}
				break;
			case "-province":
				command_line.arguments.province = true;
				for (int j = i + 1; j < commandline.size(); j++) {
					char temp_char = commandline.get(j).charAt(0);
					// 如果开头不是-，则代表还是参数值;若是-，则说明已经到了下一个参数
					if (temp_char != '-') {
						command_line.arguments.province_value.add(commandline.get(j));
					} else {
						// 由于此时commandline.get(j)已经是下一个参数了
						// 所以把i设为j-1，那么下一轮switch的temp就是下一个参数
						i = j - 1;
						break;
					}
				}
				break;
			default:
				break;
			}
		}
		return command_line;
	}
}
