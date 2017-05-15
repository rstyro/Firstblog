package com.lrs.thread;

import com.lrs.util.HttpUtils;

/**
 * 刷新缓存的线程
 * @author tyro
 *
 */
public class ReloadThread implements Runnable{

	/**
	 * 刷新的url
	 */
	private String reloadPath;
	private boolean end=false;
	
	public boolean isEnd() {
		return end;
	}
	public void setEnd(boolean end) {
		this.end = end;
	}
	public String getReloadPath() {
		return reloadPath;
	}
	public void setReloadPath(String reloadPath) {
		this.reloadPath = reloadPath;
	}
	public ReloadThread() {}
	
	public ReloadThread(String reloadPath) {
		this.reloadPath=reloadPath;
	}
	

	@Override
	public void run() {
		if(!isEnd()){
			try {
				HttpUtils.getInstance().sendGetMethod(getReloadPath());
			} catch (Exception e) {
				e.printStackTrace();
			}
			setEnd(true);
		}
	}

}
