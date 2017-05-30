package com.lrs.util;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URL;
import java.net.URLConnection;


public class UploadUtil {

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
	 * 保存图片通过url
	 * @param urlString
	 * @param filename
	 * @throws Exception
	 */
	public static void saveImgByUrl(String urlString, String filename) throws Exception {
	    createFile(filename);
		// 构造URL
	    URL url = new URL(urlString);
	    // 打开连接
	    URLConnection con = url.openConnection();
	    // 输入流
	    InputStream is = con.getInputStream();
	    // 1K的数据缓冲
	    byte[] bs = new byte[1024];
	    // 读取到的数据长度
	    int len;
	    // 输出的文件流
	    OutputStream os = new FileOutputStream(filename);
	    // 开始读取
	    while ((len = is.read(bs)) != -1) {
	      os.write(bs, 0, len);
	    }
	    // 完毕，关闭所有链接
	    os.close();
	    is.close();
	}
		
	public static void main(String[] args) {
		try {
			long bet2 = System.currentTimeMillis();
			saveImgByUrl("http://lrshuai.top/upload/user/default.png", "d://ddd/aaa/"+MyUtil.random(8)+".jpg");
			System.out.println("end="+(System.currentTimeMillis()-bet2)+" ms");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
}