package com.salesmanager.core.business.utils;

import java.awt.Graphics2D;
import java.awt.RenderingHints;
import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;

import javax.imageio.ImageIO;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * Resize anh san pham ve kich thuoc toi da cho phep (chieu rong/chieu cao).
 *
 * Muc dich: thay vi tu choi anh qua lon, tu dong thu nho anh ve kich thuoc
 * phu hop de Admin van co the luu san pham binh thuong. Anh giu nguyen ti le
 * khung hinh (khong bien dang) va dinh dang goc (JPG/PNG...).
 */
public class ProductImageResizeUtils {

	private static final Logger LOGGER = LoggerFactory.getLogger(ProductImageResizeUtils.class);

	private ProductImageResizeUtils() {
	// lop tien ich - khong khoi tao
	}

	/**
	 * Doc anh goc va tra ve anh da duoc thu nho neu vuot qua kich thuoc toi da.
	 * Neu anh da nam trong gioi han (hoac khong doc duoc bang ImageIO) thi tra ve
	 * chinh bytes goc.
	 *
	 * @param originalBytes bytes cua anh goc
	 * @param maxWidth  chieu rong toi da (<=0 de bo qua)
	 * @param maxHeight chieu cao toi da (<=0 de bo qua)
	 * @return bytes cua anh (da thu nho neu can), cung dinh dang voi anh goc
	 */
	public static byte[] resize(byte[] originalBytes, int maxWidth, int maxHeight) {

		if (originalBytes == null || originalBytes.length == 0) {
			return originalBytes;
	}
		if (maxWidth <= 0 && maxHeight <= 0) {
			return originalBytes;
	}

		try {
			BufferedImage originalImage = ImageIO.read(new ByteArrayInputStream(originalBytes));
			if (originalImage == null) {
				// khong phai dinh dang anh ma ImageIO doc duoc -> giu nguyen
				return originalBytes;
			}

			int originalWidth = originalImage.getWidth();
			int originalHeight = originalImage.getHeight();

			if (originalWidth <= 0 || originalHeight <= 0) {
				return originalBytes;
			}

			// Tinh ti le thu nho: phai thoa ca 2 gioi han (rong & cao)
			double widthRatio = (maxWidth > 0) ? (double) maxWidth / originalWidth : 1d;
			double heightRatio = (maxHeight > 0) ? (double) maxHeight / originalHeight : 1d;

			// Chi thu nho, khong phong to -> lay ti le nho nhat, toi da la 1
			double ratio = Math.min(1d, Math.min(widthRatio, heightRatio));

			if (ratio >= 1d) {
				// anh da nam trong gioi han
				return originalBytes;
			}

			int targetWidth = Math.max(1, (int) Math.round(originalWidth * ratio));
			int targetHeight = Math.max(1, (int) Math.round(originalHeight * ratio));

			LOGGER.info("Thu nho anh san pham tu {}x{} xuong {}x{}", originalWidth, originalHeight,
					targetWidth, targetHeight);

			BufferedImage resizedImage = new BufferedImage(targetWidth, targetHeight, imageType(originalImage));
			Graphics2D graphics = resizedImage.createGraphics();
			try {
				graphics.setRenderingHint(RenderingHints.KEY_INTERPOLATION,
						RenderingHints.VALUE_INTERPOLATION_BILINEAR);
				graphics.setRenderingHint(RenderingHints.KEY_RENDERING, RenderingHints.VALUE_RENDER_QUALITY);
				graphics.setRenderingHint(RenderingHints.KEY_ANTIALIASING, RenderingHints.VALUE_ANTIALIAS_ON);
				graphics.drawImage(originalImage, 0, 0, targetWidth, targetHeight, null);
			} finally {
				graphics.dispose();
			}

			ByteArrayOutputStream output = new ByteArrayOutputStream();
			// Giu dinh dang goc neu nhan dien duoc, mac dinh PNG cho anh co alpha
			String format = detectFormat(originalBytes);
			if (!ImageIO.write(resizedImage, format, output)) {
				// format khong duoc ho tro -> ghi lai dang PNG
				output.reset();
				ImageIO.write(resizedImage, "png", output);
			}
			return output.toByteArray();

	} catch (Exception e) {
			LOGGER.error("Khong the thu nho anh san pham, giu nguyen anh goc", e);
			return originalBytes;
	}
	}

	/**
	 * Xac dinh kieu pixel phu hop de tao BufferedImage dich.
	 * Voi anh co kenh alpha (PNG trong suot) phai dung kieu ARGB, neu khong
	 * phan trong suot se bi doi thanh mau den.
	 */
	private static int imageType(BufferedImage originalImage) {
		int type = originalImage.getType();
		if (type == BufferedImage.TYPE_CUSTOM) {
			// mot so anh JPEG/PNG doc len co type CUSTOM -> chon theo kenh alpha
			return originalImage.getColorModel().hasAlpha()
					? BufferedImage.TYPE_INT_ARGB
					: BufferedImage.TYPE_INT_RGB;
	}
		return type;
	}

	/**
	 * Doan dinh dang anh dua tren cac byte magic header (JPEG/PNG/GIF/BMP/WEBP).
	 * Tra ve ten dinh dang ma ImageIO hieu, mac dinh "jpg".
	 */
	private static String detectFormat(byte[] bytes) {
		if (bytes.length >= 3
				&& (bytes[0] & 0xFF) == 0xFF
				&& (bytes[1] & 0xFF) == 0xD8
				&& (bytes[2] & 0xFF) == 0xFF) {
			return "jpg";
	}
		if (bytes.length >= 8
				&& (bytes[0] & 0xFF) == 0x89
				&& bytes[1] == 'P' && bytes[2] == 'N' && bytes[3] == 'G') {
			return "png";
	}
		if (bytes.length >= 3 && bytes[0] == 'G' && bytes[1] == 'I' && bytes[2] == 'F') {
			return "gif";
	}
		if (bytes.length >= 2 && bytes[0] == 'B' && bytes[1] == 'M') {
			return "bmp";
	}
		if (bytes.length >= 12
				&& bytes[0] == 'R' && bytes[1] == 'I' && bytes[2] == 'F' && bytes[3] == 'F'
				&& bytes[8] == 'W' && bytes[9] == 'E' && bytes[10] == 'B' && bytes[11] == 'P') {
			return "webp";
	}
		return "jpg";
	}
}
