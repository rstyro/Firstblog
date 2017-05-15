package com.lrs.util;

import org.apache.log4j.Logger;

public class MyLogger {
	protected Logger logger;

	private MyLogger() {}
	private MyLogger(Logger logger){
		this.logger=logger;
	}
	
	public static MyLogger getLogger(Class<?> classObject){
		return new MyLogger(Logger.getLogger(classObject));
	}
	
	public static MyLogger getLogger(String loggerName){
		return new MyLogger(Logger.getLogger(loggerName));
	}
	public void debug(Object obj){
		logger.debug(obj);
	}
	public void debug(Object obj,Throwable e){
		logger.debug(obj,e);
	}
	
	public void info(Object obj){
		logger.info(obj);
	}
	
	public void info(Object obj,Throwable e){
		logger.info(obj,e);
	}
	
	public void warn(Object obj){
		logger.warn(obj);
	}
	
	public void warn(Object obj,Throwable e){
		logger.warn(obj,e);
	}
	
	public void error(Object obj){
		logger.error(obj);
	}
	
	public void error(Object obj,Throwable e){
		logger.error(obj,e);
	}
	
	public void fatal(Object obj,Throwable e){
		logger.fatal(obj,e);
	}
	
	public String getName(){
		return logger.getName();
	}
	public Logger getLog4jLogger(){
		return logger;
	}
	
	public boolean equals(MyLogger newLogger){
		return logger.equals(newLogger.getLog4jLogger());
	}
	
}
