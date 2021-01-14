package com.demo.web;

import java.io.*;
import java.net.Socket;
import java.net.UnknownHostException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class StrategyController {
private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@RequestMapping(value="/migrate")
	public String insertmg() {
		return "migattack";
	}
	
	@RequestMapping(value="/addmig")
	public String doConnect(HttpServletRequest request, HttpServletResponse response) throws IOException {

		String category = request.getParameter("category"); //策略类别
		String switchId = request.getParameter("migid"); //交换机编号
		String migName = request.getParameter("migname"); //名称编号
		String migInPort = request.getParameter("migInPort"); //入端口号
		String migAction = request.getParameter("migAction"); //执行动作
		System.out.println("category :"+category+";"+"switchId :"+switchId+";"+"migInPort :"+migInPort+"migAction :"+migAction );
		StringBuffer str = new StringBuffer();
		str.append(category+",");
		str.append(switchId+",");
		str.append(migName+",");
		str.append(migInPort+",");
		str.append(migAction);
		String st = str.toString();
		System.out.println(st);
//		FileOutputStream fileOutputStream = null;
		File file = new File("/home/mao/Mao/Documents/addFlow.txt");
		try{
			if(!file.exists()){
				file.createNewFile();
			}
			FileWriter fileWritter = new FileWriter(file);
			fileWritter.write(st);
			fileWritter.flush();
			fileWritter.close();
//			fileOutputStream = new FileOutputStream(file);
//			byte[] contentInBytes = st.getBytes();
//			fileOutputStream.write(contentInBytes);
//			fileOutputStream.flush();
//			fileOutputStream.close();
		}catch (Exception e){
			e.printStackTrace();
		}
		
//		 try {
//			Socket ss=new Socket("192.168.32.129",6060);
//	        BufferedReader br=new BufferedReader(new InputStreamReader(ss.getInputStream()));
//	        BufferedWriter bw=new BufferedWriter(new OutputStreamWriter(ss.getOutputStream()));
//
//	        for(int i=0;i<categoryS.length;i++){
//				StringBuffer sb=new StringBuffer();
//				sb.append(categoryS[i]);
//				sb.append(" ");
//				sb.append(migIdS[i]);
//				sb.append(" ");
//				sb.append(migNameS[i]);
//				sb.append(" ");
//				sb.append(migInPortS[i]);
//				sb.append(" ");
//				sb.append(migActionS[i]);
//
//				bw.write(sb.toString());
//				bw.flush();
//			}
//	        bw.close();
//	        br.close();
//	        ss.close();
//		} catch (UnknownHostException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		} catch (IOException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
		 return "success";
	}

}
