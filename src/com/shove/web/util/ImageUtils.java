package com.shove.web.util;

import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;

import javax.imageio.ImageIO;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.sun.image.codec.jpeg.JPEGCodec;
import com.sun.image.codec.jpeg.JPEGImageEncoder;
import com.sun.imageio.plugins.common.ImageUtil;

public class ImageUtils {
	private static Log log = LogFactory.getLog(ImageUtil.class);
	public static void miniature(String src, int w, int h) throws Exception{
		log.info("miniature src=" + src +",w=" + w +",h="+h);
		
		log.info("miniature src=" + src +",w=" + w +",h="+h);
		File file=new File(src);
		log.info("file.exists()=" + file.exists());
		if(!file.exists()){
			log.info("图片文件不存在");
			return;
			//throw new Exception("图片文件不存在");
		}
		reduceImg(file.toString(),new File(file.getParent(),"M_"+file.getName()).toString(),w,h);
	}
	/**
	 * 
	 * @description 图像缩放 jpg格式
	 * @param imgsrc
	 *            :原图片文件路径
	 * @param imgdist
	 *            :生成的缩略图片文件路径
	 * @param widthdist
	 *            :生成图片的宽度
	 * @param heightdist
	 *            :生成图片的高度
	 */
	public static void reduceImg(String imgsrc, String imgdist, int widthdist, int heightdist) {
		try {
			File srcfile = new File(imgsrc);
			if (!srcfile.exists()) {
				return;
			}
			// 返回一个 BufferedImage
			Image src = ImageIO.read(srcfile);

			// 构造一个类型为预定义图像类型之一的 BufferedImage
			BufferedImage tag = new BufferedImage((int) widthdist, (int) heightdist, BufferedImage.TYPE_INT_RGB);
			/*
			 * Image.SCALE_SMOOTH 的缩略算法 生成缩略图片的平滑度的 优先级比速度高 生成的图片质量比较好 但速度慢
			 */
			// 绘制指定图像中当前可用的图像。图像的左上角位于此图形上下文坐标空间的 (x, y)。以指定的背景色绘制透明像素。
			// 此操作等同于用给定颜色填充指定图像宽度和高度的矩形，然后在其上绘制图像
			tag.getGraphics().drawImage(
			// 创建此图像的缩放版本
			src.getScaledInstance(widthdist, heightdist, Image.SCALE_SMOOTH), 0, 0, null);
			// 指定输出到的文件
			FileOutputStream out = new FileOutputStream(imgdist);
			/**
			 * This creates an instance of a JPEGImageEncoder that can be used
			 * to encode image data as JPEG Data streams.
			 */
			com.sun.image.codec.jpeg.JPEGImageEncoder encoder = com.sun.image.codec.jpeg.JPEGCodec.createJPEGEncoder(out);
			
			// Encode a BufferedImage as a JPEG data stream.
			encoder.encode(tag);
			out.close();

		} catch (IOException ex) {
			log.error(ex);
			ex.printStackTrace();
		}
	}
}
