package com.demo.web;

import com.demo.entity.AttackInfo;
import com.demo.service.AttackService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.io.*;
import java.net.ServerSocket;
import java.net.Socket;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
public class AttackController {
	private static Socket socket;
	private static volatile Map<String, String> attInfoMap = new HashMap<String, String>();
	private static List<AttackInfo> defaultAttackInfoList = new ArrayList<AttackInfo>();

//	static {
//		String attMsg1 = "00:00:00:00:00:00:00:01,1,00:00:00:00:00:11,00:00:00:00:00:13,8.89.100.119,10.0.0.3#####139265288";
//		String attMsg2 = "00:00:00:00:00:00:00:01,3,00:00:00:00:00:13,00:00:00:00:00:13,9.88.100.159,10.0.0.3#####139265288";
//		String attMsg3 = "00:00:00:00:00:00:00:02,1,00:00:00:00:00:15,00:00:00:00:00:13,8.88.101.118,10.0.0.3#####139265288";
//		String attMsg4 = "00:00:00:00:00:00:00:01,3,00:00:00:00:00:13,00:00:00:00:00:13,8.88.100.159,10.0.0.3#####139265288";
//		String[] tmp1 = attMsg1.split(",");
//		attInfoMap.put(tmp1[0]+","+tmp1[1],attMsg1);
//		String[] tmp2 = attMsg2.split(",");
//		attInfoMap.put(tmp2[0]+","+tmp2[1],attMsg2);
//		String[] tmp3 = attMsg3.split(",");
//		attInfoMap.put(tmp3[0]+","+tmp3[1],attMsg3);
//		String[] tmp4 = attMsg4.split(",");
//		attInfoMap.put(tmp4[0]+","+tmp4[1],attMsg4);
//	}

	static {
		new Thread(new Runnable() {
			public void run() {
				FileInputStream fileInputStream = null;
				InputStreamReader inputStreamReader = null;
				BufferedReader bufferedReader = null;
				try {
					while (true) {
						File file = new File("/home/mao/Mao/Documents/check1.txt");
						if(file.isFile() && file.exists()){
							fileInputStream = new FileInputStream(file);
							inputStreamReader = new InputStreamReader(fileInputStream);
							bufferedReader = new BufferedReader(inputStreamReader);

							String lineStr;
							while((lineStr = bufferedReader.readLine()) != null){
								String[] tmp = lineStr.split(",");
								attInfoMap.put(tmp[0]+","+tmp[1],lineStr);
							}
						}
					}
				} catch (Exception e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				}finally {
					try {
						bufferedReader.close();
						inputStreamReader.close();
						fileInputStream.close();
					} catch (IOException e) {
						e.printStackTrace();
					}

				}
			}
		}).start();
	}

	@Autowired
	private AttackService attackService;

	private Logger logger = LoggerFactory.getLogger(this.getClass());


	//跳转到攻击检测界面
	@RequestMapping(value="toAttackDetection")
	public String bandwidth(Model model) {

		AttackInfo attackInfo = new AttackInfo();

		attackInfo.setSwitchId("---- 待检测 ----");
		attackInfo.setInPort(0);
		attackInfo.setSrcMac("---- 待检测 ----");
		attackInfo.setDstMac("---- 待检测 ----");
		attackInfo.setSrcIp("---- 待检测 ----");
		attackInfo.setDstIp("---- 待检测 ----");
		attackInfo.setAttackTime("---- 待检测 ----");

		if(defaultAttackInfoList.size()==0){
			defaultAttackInfoList.add(attackInfo);
		}
		model.addAttribute("attackInfoList",defaultAttackInfoList);

		return "attackDetectionPage";
	}

	//查询攻击记录
	@RequestMapping(value="attackList")
	public String logger(ModelMap map, @RequestParam(defaultValue="1",required=true,value="pageNo")int pageNo) {
		int pageSize=5;//每页显示记录数
		//流表的分页查询
		PageHelper.startPage(pageNo, pageSize);
		//Service层的接口-查询
		List<AttackInfo> flowList  = attackService.queryAll();
		PageInfo<AttackInfo> pageInfo=new PageInfo<AttackInfo>(flowList);
		//封装到数据模型
		map.addAttribute("pageInfo", pageInfo);
		return "attackPage";
	}

	//删除攻击记录
	@RequestMapping("/deleteAttackInfo")
	@ResponseBody
	public String deleteAttackInfo(int attackInfoId){
		if(attackInfoId<0) return "notexist";
		int i = attackService.deleteAttackInfo(attackInfoId);
		String msg;
		if(i>0){
			msg = "true";
		}else{
			msg = "false";
		}
		return msg;
	}

	//检测攻击
	@RequestMapping("/attackDetection")
	public String attackDetection(Model model) throws IOException {

		List<AttackInfo> attackInfoList = new ArrayList<AttackInfo>();

		if(attInfoMap.size()>0){
			Collection<String> attInfos = attInfoMap.values();
			for (String attInfo : attInfos) {
				String msgFront = attInfo.split("#####")[0];
				String[] attList = msgFront.split(",");

				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				String curryTime = sdf.format((new Date()));

				AttackInfo attackInfo = new AttackInfo();
				attackInfo.setSwitchId("00:00:00:00:00:00:00:0" + attList[0]);
				attackInfo.setInPort(Integer.parseInt(attList[1]));
				attackInfo.setSrcMac(attList[2]);
				attackInfo.setDstMac(attList[3]);
				attackInfo.setSrcIp(attList[4]);
				attackInfo.setDstIp(attList[5]);
				attackInfo.setAttackTime(curryTime);

				attackInfoList.add(attackInfo);
				attackService.addAttackInfo(attackInfo);
			}
			model.addAttribute("attackInfoList",attackInfoList);
			attInfoMap.clear();
		}else{
			model.addAttribute("attackInfoList",defaultAttackInfoList);
		}

		return "attackDetectionPage";
	}
}

