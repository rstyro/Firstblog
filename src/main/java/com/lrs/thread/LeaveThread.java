package com.lrs.thread;

import com.lrs.util.MailTool;
import com.lrs.util.MyLogger;

public class LeaveThread implements Runnable {
	private String message;
	private boolean isend = false;
	int index=0;
	private MyLogger log = MyLogger.getLogger(this.getClass());
	
	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}


	public boolean isIsend() {
		return isend;
	}

	public void setIsend(boolean isend) {
		this.isend = isend;
	}

	public int getIndex() {
		return index;
	}

	public void setIndex(int index) {
		this.index = index;
	}

	public LeaveThread(String message) {
		this.message=message;
	}
	
	@Override
	public void run() {
		if(!isIsend()){
			try {
				MailTool mailTool = new MailTool();
				mailTool.sendMailToMe(getMessage());
				this.setIsend(true);
				log.info("send mail is success");
			} catch (Exception e) {
				log.error("send mail err:"+e.getMessage(), e);
				index++;
				setIndex(index);
				if(getIndex() > 10){
					this.setIsend(true);
				}
			}
		}
	}


}
