package kr.or.ih.api.web;

import java.io.IOException;
import java.io.PrintWriter;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.util.Date;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.or.ih.api.entity.User;
import kr.or.ih.api.service.LoginService;
import tm.massmail.sendapi.ThunderMassMailSender;
import tm.massmail.sendapi.ThunderMassMail;



@Controller
public class LoginController
{
	@Autowired
	private LoginService service;
	
	// 로그인 페이지
	@RequestMapping("/login")
	public ModelAndView Login(ModelAndView mv)
	{
		mv.setViewName("login/login");
		
		return mv;
	}
	
	// 로그인 페이지
	@RequestMapping("/loginForm")
	public void LoginForm(ModelAndView mv, HttpServletRequest request, HttpServletResponse response, @RequestParam("user_username") String user_username, @RequestParam("user_password") String user_password) throws IOException
	{
		HttpSession session = request.getSession();
		
		User user = service.SelectUser(user_username, user_password);
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		if(user == null)
		{
			out.println("<script>");
			out.println("alert('계정 정보가 일치하지 않습니다.')");
			out.println("location.href='/digit/login'");
			out.println("</script>");
		}
		else
		{
			if(user.getUser_status() == 0)
			{
				out.println("<script>");
				out.println("location.href='/digit/login'");
				out.println("alert('관리자의 승인을 대기중입니다.')");
				out.println("</script>");
			}
			else
			{
				session.setAttribute("user", user);
				
				out.println("<script>");
				out.println("location.href='/digit/home'");
				out.println("</script>");
			}
		}
	}
	
	@RequestMapping("/logout")
	public ModelAndView Logout(ModelAndView mv, HttpSession session)
	{
		session.invalidate();
		
		mv.setViewName("redirect:/karyotype_list");
		//mv.setViewName("redirect:/index.html");
		
		return mv;
	}
	
	@ResponseBody
	@RequestMapping("checkUsername")
	public int CheckUsername(@RequestParam("user_username") String user_username)
	{
		int result = service.CheckUsername(user_username);
		
		if(result == 0)
		{
			return 0;
		}
		else
		{
			return 1;
		}
	}
	
	@ResponseBody
	@RequestMapping("oldcheckUsername")
	public int OldCheckUsername(@RequestParam("user_username") String user_username, @RequestParam("old_password") String old_password)
	{		
		int result = service.OldCheckUsername(user_username, old_password);
		System.out.println("result : " + result);
		if(result == 0)
		{
			return 0;
		}
		else
		{
			return 1;
		}
	}
	
	
	
	
	// 회원가입
	@ResponseBody
	@RequestMapping("join")
	public int Join(@RequestParam("user_username") String user_username, @RequestParam("user_password") String user_password)
	{
		int result = service.Join(user_username, user_password);
		
		if(result == 0)
		{
			return 0;
		}
		else
		{
			 String sender_username = "ymjeong@koat.or.kr";
			 ThunderMassMailSender tms = new ThunderMassMailSender();
             ThunderMassMail tm = new ThunderMassMail();
             tm.setThunderMailURL("192.168.50.42:8080");               
             tm.setWriter("seedcenter");

             tm.setMailTitle(user_username +"님의 이용 신청 정보가 등록 되었습니다.");                        
             tm.setSenderEmail("ymjeong@koat.or.kr");                  
             tm.setSenderName("디지털육종정보화시스템");                        
             tm.setReceiverName("ymjeong@koat.or.kr");                              

             tm.setContentType("content");
             tm.setMailContent("신규 회원 " + user_username +"이 사용 신청을 하였습니다. 관리자로 로그인 후 활성화 해 주시기 바랍니다. <br><br><a href='https://seedcenter.koat.or.kr/digit/'>https://seedcenter.koat.or.kr/digit/</a>" );

             tm.setTargetType("string");
             tm.setTargetString("이메일,고객명,휴대폰Æ"+sender_username+","+sender_username+","+"000-000-0000Æ");
             tm.setFileOneToOne("[$email]≠["+sender_username+"]ø[$name]≠["+sender_username+"]ø[$cellPhone]≠[000-000-0000]");
             String result_mail = tms.send(tm); 
             
			return 1;
		}
	}
	
	@ResponseBody
	@RequestMapping("updatePassword")
	public int UpdatePassword(@RequestParam("user_username") String user_username, @RequestParam("user_password") String user_password)
	{
		int result = service.UpdatePassword(user_username, user_password);
		
		if(result == 0)
		{
			return 0;
		}
		else
		{
			return 1;
		}
	}
	
	public int roledice()
	{
		Random numGen = null;
		 
		try
		{
			numGen = SecureRandom.getInstance("SHA1PRNG");
		}
		catch(NoSuchAlgorithmException e) 
		{
        	System.out.println("난수 생성 Error");
		}
		
		if(numGen == null)
		{
			return 0;
		}
		
	    return (numGen.nextInt(35)) + 1;
	}
	

	// 비밀번호 찾기
	@ResponseBody
	@RequestMapping("findPassword")
	public String FindPassword(@RequestParam("user_username") String user_username)
	{
		String result = "";
		
		int chk_username = service.CheckUsername(user_username);
		
		if(chk_username != 0)
		{
			char[] charSet = new char[] { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', '!', '@', '#', '$', '%', '^', '&' };
			
			for(int i = 0; i < 8; i++)
			{
				result += charSet[roledice()];
			}
			
			Random rand = new Random();
			String rst = Integer.toString(rand.nextInt(8) + 1);
			for(int i=0; i < 7; i++){
				rst += Integer.toString(rand.nextInt(9));
			}
			
		  	 //int update_password = service.UpdatePassword(user_username, "1234");	
			
			 int update_password = service.UpdatePassword(user_username, rst);
			
			 ThunderMassMailSender tms = new ThunderMassMailSender();
             ThunderMassMail tm = new ThunderMassMail();
             tm.setThunderMailURL("192.168.50.42:8080");               
             tm.setWriter("seedcenter");

             tm.setMailTitle("안녕하세요 " + user_username +"님");                        
             tm.setSenderEmail("ymjeong@koat.or.kr");                  
             tm.setSenderName("디지털육종정보화시스템");                        
             tm.setReceiverName(user_username);                              

             tm.setContentType("content");
             tm.setMailContent(user_username+" 계정의 비밀번호가 "+rst+"로 초기화 되었습니다.<br><br><a href='https://seedcenter.koat.or.kr/digit/'>https://seedcenter.koat.or.kr/digit/</a>로 이동 후 로그인 해 주시기 바랍니다." );

             tm.setTargetType("string");
             tm.setTargetString("이메일,고객명,휴대폰Æ"+user_username+","+user_username+","+"000-000-0000Æ");
             tm.setFileOneToOne("[$email]≠["+user_username+"]ø[$name]≠["+user_username+"]ø[$cellPhone]≠[000-000-0000]");
             String result_mail = tms.send(tm);              		
		}
		
		return result;
	}
	
	// 로그인 페이지
	@ResponseBody
	@RequestMapping("/check_login")
	public int LoginForm2(HttpServletRequest request)
	{
		HttpSession session = request.getSession();
		
		int result = 0;
		
		if(session.getAttribute("user") == null)
		{
			result = 1;
		}
		
		return result;
	}
}