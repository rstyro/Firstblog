package com.lrs.thread;

import com.lrs.util.MailTool;
import com.lrs.util.MyLogger;

/**
 * 发送验证码线程
 * @author tyro
 *
 */
public class EmailThread implements Runnable {

	private String toAddress;
	private String title;
	private String message;
	private int index;
	private boolean end;
	
	private MyLogger log = MyLogger.getLogger(this.getClass());
	
	
	public int getIndex() {
		return index;
	}
	public void setIndex(int index) {
		this.index = index;
	}
	public boolean isEnd() {
		return end;
	}
	public void setEnd(boolean end) {
		this.end = end;
	}
	public String getToAddress() {
		return toAddress;
	}
	public void setToAddress(String toAddress) {
		this.toAddress = toAddress;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}

	public EmailThread() {
		super();
	}
	
	public EmailThread(String toAddress, String title, String message) {
		super();
		this.toAddress = toAddress;
		this.title = title;
		this.message = message;
		this.end=false;
		this.index=0;
	}
	
	@Override
	public void run() {
		if(!isEnd()){
			System.out.println("?");
			try {
				MailTool mailTool = new MailTool();
				mailTool.sendEmail(getMessage(), getTitle(), getToAddress());
				this.setEnd(true);
				log.info("send mail is success");
			} catch (Exception e) {
				log.error("send mail err:"+e.getMessage(), e);
				this.setEnd(true);
				throw new RuntimeException("发送邮件失败",e);
			}
		}else{
			System.out.println("!!!");
		}
	}

}
