package email;

import java.util.Random;

import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import main.UserService;

@Controller
public class EmailController {

	@Autowired
	private JavaMailSender mailSender;
	@Autowired
	UserService userservice;
	
	@RequestMapping(value = "/email", method = RequestMethod.GET)
	public String emailPage() {
		
		return "email";
	}
	
	@RequestMapping(value = "/email", method = RequestMethod.POST)
	@ResponseBody
	public String emailCheck(String email) {
		System.out.println(userservice.checkUser(email));
		return userservice.checkUser(email);
	}
	
	@RequestMapping(value="/sendCode", method=RequestMethod.POST)
    public String sendEmailAction (HttpSession session, String email) throws Exception {
 
       int random = new Random().nextInt(100000) + 10000; // 10000 ~ 99999 
             
        String joinCode = String.valueOf(random); 
        session.setAttribute("joinCode", joinCode);  
        session.setAttribute("email", email);
       MimeMessage message = mailSender.createMimeMessage();
       MimeMessageHelper messageHelper = new MimeMessageHelper(message, "UTF-8");
       try {      
            messageHelper.setSubject("[인증] 오늘뭐해먹지 가입인증 메일입니다.");
            messageHelper.setText("인증번호는 "+joinCode+" 입니다.");
            messageHelper.setTo(email);
            message.setRecipients(MimeMessage.RecipientType.TO , InternetAddress.parse(email));
            mailSender.send(message);
            
            System.out.println("메세지 전송완료");
            
       }catch(MessagingException e) {
           System.out.println("에러남");
           e.printStackTrace();
       }      
          
        return "sendCode";
    }

}
