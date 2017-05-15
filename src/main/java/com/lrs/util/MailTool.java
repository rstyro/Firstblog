package com.lrs.util;

import java.security.GeneralSecurityException;
import java.util.Properties;

import javax.mail.Address;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import com.sun.mail.util.MailSSLSocketFactory;
public class MailTool {
	
	protected MyLogger log = MyLogger.getLogger(this.getClass());
	
	/**
	 * 给自己发邮件
	 * @param message
	 */
	 public void sendMailToMe(String message){
		 Properties props = new Properties();
		    // 开启debug调试
		    props.setProperty("mail.debug", "true");
		    // 发送服务器需要身份验证
		    props.setProperty("mail.smtp.auth", "true");
		    // 设置邮件服务器主机名
		    props.setProperty("mail.host", "smtp.qq.com");
		    // 发送邮件协议名称
		    props.setProperty("mail.transport.protocol", "smtp");
		    MailSSLSocketFactory sf;
		    Transport transport =null;
			try {
				sf = new MailSSLSocketFactory();
				sf.setTrustAllHosts(true);
				props.put("mail.smtp.ssl.enable", "true");
				props.put("mail.smtp.ssl.socketFactory", sf);
			    Session session = Session.getInstance(props);
			    Message msg = new MimeMessage(session);
			    msg.setSubject("@Me");
			    StringBuilder builder = new StringBuilder();
			    builder.append(message);
			    builder.append("\n\n 时间: " + DateUtil.getTime());
//			    msg.setText(builder.toString());
			    msg.setFrom(new InternetAddress("1006059906@qq.com"));
			    msg.setContent(builder.toString(), "text/html;charset=utf-8"); // 设置邮件格式  
			    transport = session.getTransport();
			    transport.connect("smtp.qq.com", "1006059906@qq.com", "jhcyazlccaewbefd");
			    transport.sendMessage(msg, new Address[] { new InternetAddress("1006059906@qq.com")});
			    System.out.println("发送成功");
			    System.out.println("210550028@qq.com");
			} catch (GeneralSecurityException e) {
				log.info("ssl 验证错误");
				e.printStackTrace();
			}catch (Exception e) {
				log.info("程序异常", e);
			}finally{
				if(transport != null){
					try {
						transport.close();
					} catch (MessagingException e) {
						log.info("transport 关闭异常", e);
						e.printStackTrace();
					}
				}
			}
			log.info("邮件发送成功!");
	 }
	 
	 /**
	  * 发送验证码
	  * @param message
	  */
	 public void sendEmail(String message,String title,String toAddress){
		 Properties props = new Properties();
		 // 开启debug调试
		 props.setProperty("mail.debug", "false");
		 // 发送服务器需要身份验证
		 props.setProperty("mail.smtp.auth", "true");
		 // 设置邮件服务器主机名
		 props.setProperty("mail.host", "smtp.qq.com");
		 // 发送邮件协议名称
		 props.setProperty("mail.transport.protocol", "smtp");
		 MailSSLSocketFactory sf;
		 Transport transport =null;
		 try {
			 sf = new MailSSLSocketFactory();
			 sf.setTrustAllHosts(true);
			 props.put("mail.smtp.ssl.enable", "true");
			 props.put("mail.smtp.ssl.socketFactory", sf);
			 Session session = Session.getInstance(props);
			 Message msg = new MimeMessage(session);
			 msg.setSubject(title);
			 StringBuilder builder = new StringBuilder();
			 builder.append(message);
			 builder.append("\n\n 时间: " + DateUtil.getTime());
//			    msg.setText(builder.toString());
			 msg.setFrom(new InternetAddress("1006059906@qq.com"));
			 msg.setContent(builder.toString(), "text/html;charset=utf-8"); // 设置邮件格式  
			 transport = session.getTransport();
			 transport.connect("smtp.qq.com", "1006059906@qq.com", "jhcyazlccaewbefd");
			 transport.sendMessage(msg, new Address[] { new InternetAddress(toAddress)});
		 } catch (GeneralSecurityException e) {
			 log.info("ssl 验证错误");
			 e.printStackTrace();
		 }catch (Exception e) {
			 log.info("程序异常", e);
		 }finally{
			 if(transport != null){
				 try {
					 transport.close();
				 } catch (MessagingException e) {
					 log.info("transport 关闭异常", e);
					 e.printStackTrace();
				 }
			 }
		 }
		 log.info("邮件发送成功!");
	 }
}
