package com.lrs.util;

import java.awt.AlphaComposite;
import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics2D;
import java.awt.Image;
import java.awt.RenderingHints;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.imageio.ImageIO;
import javax.swing.ImageIcon;

import com.sun.image.codec.jpeg.JPEGCodec;
import com.sun.image.codec.jpeg.JPEGImageEncoder;

@SuppressWarnings("restriction")
public class ImageUtils {

	/** */
	/**
	 * 把图片印刷到图片上
	 * 
	 * @param pressImg
	 *            -- 水印文件
	 * @param targetImg
	 *            -- 目标文件
	 * @param drection
	 *            --水印位置， <0.5 -- 左上角， =0.5 -- 中间 >0.5 -- 右下角
	 * @param alpha
	 *            --透明度
	 */
	public final static void pressImage(String pressImg, String targetImg, float drection, float alpha) {
		try {
			// 目标文件
			float Alpha = alpha;
			File _file = new File(targetImg);
			Image src = ImageIO.read(_file);
			int wideth = src.getWidth(null);
			int height = src.getHeight(null);
			BufferedImage image = new BufferedImage(wideth, height, BufferedImage.TYPE_INT_RGB);
			Graphics2D g = image.createGraphics();
			g.drawImage(src, 0, 0, wideth, height, null);
			// 水印文件
			File _filebiao = new File(pressImg);
			Image src_biao = ImageIO.read(_filebiao);
			int wideth_biao = src_biao.getWidth(null);
			int height_biao = src_biao.getHeight(null);
			g.setComposite(AlphaComposite.getInstance(AlphaComposite.SRC_ATOP, Alpha));
			if (drection < 0.5) {
				g.drawImage(src_biao, 50, 50, wideth_biao, height_biao, null);
			} else if (drection == 0.5) {
				g.drawImage(src_biao, wideth / 2, height / 2, null);
			} else {
				g.drawImage(src_biao, wideth - wideth_biao - 50, height - height_biao - 50, null);
			}
			// 水印文件结束
			g.dispose();
			FileOutputStream out = new FileOutputStream(targetImg);
			JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(out);
			encoder.encode(image);
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	/**
	 * 图片水印，保留原图生成新的图片水印 
	 * @param pressImg
	 * @param targetImg
	 * @param newPath
	 * @param drection
	 * @param alpha
	 */
	public final static void pressImage(String pressImg, String targetImg,String newPath, float drection, float alpha) {
		try {
			OutputStream os = null;
			// 目标文件
			float Alpha = alpha;
			File _file = new File(targetImg);
			Image src = ImageIO.read(_file);
			int wideth = src.getWidth(null);
			int height = src.getHeight(null);
			BufferedImage image = new BufferedImage(wideth, height, BufferedImage.TYPE_INT_RGB);
			Graphics2D g = image.createGraphics();
			g.drawImage(src, 0, 0, wideth, height, null);
			// 水印文件
			File _filebiao = new File(pressImg);
			Image src_biao = ImageIO.read(_filebiao);
			int wideth_biao = src_biao.getWidth(null);
			int height_biao = src_biao.getHeight(null);
			g.setComposite(AlphaComposite.getInstance(AlphaComposite.SRC_ATOP, Alpha));
			if (drection < 0.5) {
				g.drawImage(src_biao, 50, 50, wideth_biao, height_biao, null);
			} else if (drection == 0.5) {
				g.drawImage(src_biao, wideth / 2, height / 2, null);
			} else {
				g.drawImage(src_biao, wideth - wideth_biao - 50, height - height_biao - 50, null);
			}
			// 水印文件结束
			g.dispose();
			os = new FileOutputStream(newPath);
			// 生成图片
			ImageIO.write(image, "JPG", os);
			os.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/** */
	/**
	 * 打印文字水印图片
	 * 
	 * @param pressText
	 *            --文字
	 * @param targetImg
	 *            -- 目标图片
	 * @param fontName
	 *            -- 字体名
	 * @param fontStyle
	 *            -- 字体样式
	 * @param color
	 *            -- 字体颜色
	 * @param fontSize
	 *            -- 字体大小
	 * @param x
	 *            -- 偏移量
	 * @param y
	 */

	public static void pressText(String pressText, String targetImg, String fontName, int fontStyle, Color color,
			int fontSize, float drection, float alpha) {
		try {
			System.out.println(pressText.length());
			float Alpha = alpha;
			File _file = new File(targetImg);
			Image src = ImageIO.read(_file);
			int wideth = src.getWidth(null);
			int height = src.getHeight(null);
			BufferedImage image = new BufferedImage(wideth, height, BufferedImage.TYPE_INT_RGB);
			Graphics2D g = image.createGraphics();

			g.drawImage(src, 0, 0, wideth, height, null);
			g.setColor(color);
			g.setFont(new Font(fontName, fontStyle, fontSize));
			g.setComposite(AlphaComposite.getInstance(AlphaComposite.SRC_ATOP, Alpha));
			if (drection < 0.5) {
				g.drawString(pressText, fontSize, fontSize);
			} else if (drection == 0.5) {
				g.drawString(pressText, wideth / 2, height / 2);
			} else {
				//(中文)和 (文字的大小)是1:1的关系，字符是2:1的关系
				g.drawString(pressText, wideth - (getTextLength(pressText)*fontSize)-fontSize, height - fontSize);
			}
			g.dispose();
			FileOutputStream out = new FileOutputStream(targetImg);
			JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(out);
			encoder.encode(image);
			out.close();
		} catch (Exception e) {
			System.out.println(e);
		}
	}

	/**
	 * 给图片添加图片水印、可设置水印的旋转角度
	 * 
	 * @param filePath
	 *            原图片地址
	 * @param newPath
	 *            新图片地址
	 * @param logoPath
	 *            水印图片地址
	 * @param degree
	 *            旋转的度数(-180到180的整数)
	 * @param alpha
	 *            透明度：alpha 必须是范围 [0.0, 1.0] 之内（包含边界值）的一个浮点数字
	 */
	public static void rotateImage(String filePath, String newPath, String logoPath, int degree, String alpha) {
		OutputStream os = null;
		try {
			if (!"".equals(filePath)) {
				Image srcImg = ImageIO.read(new File(filePath));
				BufferedImage buffImg = new BufferedImage(srcImg.getWidth(null), srcImg.getHeight(null),
						BufferedImage.TYPE_INT_RGB);

				// 得到画笔对象
				Graphics2D g = buffImg.createGraphics();

				// 设置对线段锯齿状边缘处理
				g.setRenderingHint(RenderingHints.KEY_INTERPOLATION, RenderingHints.VALUE_INTERPOLATION_BILINEAR);

				g.drawImage(srcImg.getScaledInstance(srcImg.getWidth(null), srcImg.getHeight(null), Image.SCALE_SMOOTH),
						0, 0, null);

				// 设置水印图片旋转
				g.rotate(Math.toRadians(degree), 0, 0);

				// 水印图片的路径，水印一般格式是gif，png,这种图片可以设置透明度
				ImageIcon imgIcon = new ImageIcon(logoPath);

				// 得到Image对象
				Image img = imgIcon.getImage();

				// 原图片的宽高
				int width = srcImg.getWidth(null);
				int height = srcImg.getHeight(null);

				// 水印图片的宽高
				int width1 = img.getWidth(null);
				int height1 = img.getHeight(null);
				

				// 透明度
				if (alpha == null || alpha.equals("")) {
					alpha = "1";
				}
				g.setComposite(AlphaComposite.getInstance(AlphaComposite.SRC_ATOP, Float.parseFloat(alpha)));
				
				int x = -width/2;
				int y = -height/2;
				while(x < width*2){
					y = -height/2;
					while(y<height*1.5){
						g.drawImage(img, x, y, null);
						y +=height1 + 300;
					}
					x += width1+300;
				}
				// 表示水印图片的位置
//				g.drawImage(img, (width - width1) / 2, (height - height1) / 2, width1, height1, null);

				g.dispose();

				os = new FileOutputStream(newPath);

				// 生成图片
				ImageIO.write(buffImg, "JPG", os);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (null != os) {
					os.close();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
	/**
	 * 获取文本长度
	 * @param text
	 * @return
	 */
	public static int getTextLength(String text){
		int length = text.length();
		for(int i=0;i<text.length();i++){
			String s = String.valueOf(text.charAt(i));
			if(s.getBytes().length > 1){
				length++;
			}
		}
		length = length%2 == 0?length/2:length/2+1;//是以中文的长度为标准获取
		return length;
	}
	
	  /** 
     * 从HTML源码中提取图片路径，最后以一个 String 类型的 List 返回，如果不包含任何图片，则返回一个 size=0　的List 
     * 需要注意的是，此方法只会提取以下格式的图片：.jpg|.bmp|.eps|.gif|.mif|.miff|.png|.tif|.tiff|.svg|.wmf|.jpe|.jpeg|.dib|.ico|.tga|.cut|.pic 
     * @param htmlCode HTML源码 
     * @return <img>标签 src 属性指向的图片地址的List集合 
     * @author Carl He 
     */  
    public static List<String> getImageSrc(String htmlCode) {  
        List<String> imageSrcList = new ArrayList<String>();  
        Pattern p = Pattern.compile("<img\\b[^>]*\\bsrc\\b\\s*=\\s*('|\")?([^'\"\n\r\f>]+(\\.jpg|\\.bmp|\\.eps|\\.gif|\\.mif|\\.miff|\\.png|\\.tif|\\.tiff|\\.svg|\\.wmf|\\.jpe|\\.jpeg|\\.dib|\\.ico|\\.tga|\\.cut|\\.pic)\\b)[^>]*>", Pattern.CASE_INSENSITIVE);  
        Matcher m = p.matcher(htmlCode);  
        String quote = null;  
        String src = null;  
        while (m.find()) {  
            quote = m.group(1);  
            src = (quote == null || quote.trim().length() == 0) ? m.group(2).split("\\s+")[0] : m.group(2);  
            imageSrcList.add(src);  
        }  
        return imageSrcList;  
    }  
	

	public static void main(String[] args) {
//		pressImage("E:\\watermark.png", "E:\\test1.jpg", 1f, 0.5f);
		pressImage("E:\\watermark.png", "E:\\test.jpg","E:\\test1.jpg", 1f, 0.5f);
//		pressText("www.tyro.com", "E:\\test1.jpg", "隶书", 36, Color.white, 36, 0.5f, 0.5f);
		rotateImage("E:\\test.jpg", "E:\\test2.jpg", "E:\\watermark.png", 30,"0.5");
		System.out.print("添加成功");
	}
}
