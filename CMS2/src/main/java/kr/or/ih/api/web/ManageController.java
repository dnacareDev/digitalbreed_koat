package kr.or.ih.api.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.or.ih.api.entity.Counts;
import kr.or.ih.api.entity.Notice;
import kr.or.ih.api.entity.User;
import kr.or.ih.api.service.HomeService;
import kr.or.ih.api.service.ManageService;

import kr.or.ih.api.entity.User;
import kr.or.ih.api.service.LoginService;
import tm.massmail.sendapi.ThunderMassMailSender;
import tm.massmail.sendapi.ThunderMassMail;


@Controller
public class ManageController
{
	@Autowired
	private ManageService service;
	
	@Autowired
	private HomeService homeService;
	
	@RequestMapping("/manage_list")
	public ModelAndView ManageList(ModelAndView mv, HttpServletRequest request)
	{
		HttpSession session = request.getSession();
		
		if(session.getAttribute("user") == null)
		{
			mv.setViewName("redirect:/login");
		}
		else
		{
			User user = (User)session.getAttribute("user");
			
			if(user.getUser_type() == 0)
			{
				List<Notice> notice = homeService.SelectNotice(user.getUser_username());
				
				mv.addObject("notice", notice);
				
				mv.setViewName("manage/manage_list");
			}
			else
			{
				mv.setViewName("home/home");
			}
		}
		
		return mv;
	}
	
	@ResponseBody
	@RequestMapping("/selectManage")
	public Map<String, Object> SelectManage()
	{
		Map<String, Object> result = new HashMap<String, Object>();
		
		List<Counts> counts = service.SelectManage();
		
		result.put("counts", counts);
		
		return result;
	}
	
	@ResponseBody
	@RequestMapping("updateUserStatus")
	public int UpdateUserStatus(@RequestParam("user_username") String user_username, @RequestParam("user_status") int user_status)
	{
		int result = service.UpdateUserStatus(user_username, user_status);
		
		System.out.println("user_status : "+user_status);
		
		if(user_status==1) {
			
				 ThunderMassMailSender tms = new ThunderMassMailSender();
	             ThunderMassMail tm = new ThunderMassMail();
	             tm.setThunderMailURL("192.168.50.42:8080");               
	             tm.setWriter("seedcenter");

	 	         tm.setMailTitle(user_username +"님의 디지털육종 정보시스템의 사용 신청이 완료되었습니다");                        
	             tm.setSenderEmail("ymjeong@koat.or.kr");                  
	             tm.setSenderName("디지털육종정보화시스템");                        
	             tm.setReceiverName(user_username);                              

	             tm.setContentType("content");
		         tm.setMailContent("신규 회원 " + user_username +" 님의  사용 신청이 완료되었습니다. <br><br>아래 주소에서 로그인하실 수 있습니다.<br><br><a href='https://seedcenter.koat.or.kr/digit/'>https://seedcenter.koat.or.kr/digit/</a>" );

	             tm.setTargetType("string");
	             tm.setTargetString("이메일,고객명,휴대폰Æ"+user_username+","+user_username+","+"000-000-0000Æ");
	             tm.setFileOneToOne("[$email]≠["+user_username+"]ø[$name]≠["+user_username+"]ø[$cellPhone]≠[000-000-0000]");
	             String result_mail = tms.send(tm); 
	        
		}
		return result;
	}
}