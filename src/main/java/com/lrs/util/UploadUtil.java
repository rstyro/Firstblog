package com.lrs.util;

import java.io.File;
import java.io.IOException;

import javax.servlet.http.HttpSession;


public class UploadUtil {

	@SuppressWarnings("unused")
	private static final String UPLOAD_FOLDER_ROOT = "upload";
	 
	public static final String USERTYPE_USER = "user";

	public static final String USERTYPE_ADMIN = "admin";

	public static final String FILETYPE_IMG = "image";
	
	public static final String FILETYPE_VIDEO = "video";
	
	public static final String FILETYPE_FILE = "file";

	private static String SEPARATOR;
	
	private static final String SEPARATOR_HTTP = "/";
	
	/**
	 * 创建文件，如果文件夹不存在将被创建
	 * @param destFileName 文件路径
	 */
	public static File createFile(String destFileName) {  
        File file = new File(destFileName);  
        if(file.exists()) return null;
        if (destFileName.endsWith(File.separator)) return null;
        if(!file.getParentFile().exists()) {
            if(!file.getParentFile().mkdirs()) return null;
        }
        try {
            if (file.createNewFile()) return file;
            return null;
        } catch (IOException e) {
            e.printStackTrace();
            return null;
        }
    }
	
	/**
	 * 删除文件
	 * @param httpUrl 数据库存的文件地址
	 */
	public static boolean deleteFile(HttpSession session, String httpUrl){
		if(httpUrl == null || "".equals(httpUrl)) return false;
		String filePath = session.getServletContext().getRealPath("") + httpUrl.replace(SEPARATOR_HTTP, SEPARATOR);
	    File file = new File(filePath);
	    if(!file.exists()){
	    	return false;
	    }else{
	        if (!file.isFile()){
	        	return false;
	        }
	        file.delete();
	    }
		return true;
	}
	
	public static String getFileType(String contentType){
		String type = contentType.substring(0, contentType.lastIndexOf("/"));
		if("image".equals(type)){
			return FILETYPE_IMG;
		}else if("video".equals(type)){
			return FILETYPE_VIDEO;
		}
		return FILETYPE_FILE;
	}
	
}