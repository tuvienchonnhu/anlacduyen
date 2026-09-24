package com.salesmanager.shop.store.api.v1.product.ai;

import java.util.ArrayList;
import java.util.Base64;
import java.util.List;

/**
 * Yeu cau gui toi mo hinh AI.
 *
 * Cung cap mot lop truu tuong trung lap voi Spring AI (Prompt + Media) de he
 * thong khong phu thuoc truc tiep vao mot nha cung cap AI cu the. Nho do viec
 * them nha cung cap moi (vi du OpenAI) chi can them mot implementation cua
 * {@link AiChatModel}, khong phai sua code nghiep vu.
 */
public class AiChatRequest {

	private final String prompt;
	private final String imageMimeType;
	private final String imageBase64;

	private AiChatRequest(String prompt, String imageMimeType, String imageBase64) {
		this.prompt = prompt;
		this.imageMimeType = imageMimeType;
		this.imageBase64 = imageBase64;
	}

	/** Yeu cau chi co van ban (khong dinh kem anh). */
	public static AiChatRequest text(String prompt) {
		return new AiChatRequest(prompt, null, null);
	}

	/** Yeu cau gom van ban va mot anh (Base64) de AI phan tich thi giac. */
	public static AiChatRequest textAndImage(String prompt, String imageMimeType, String imageBase64) {
		return new AiChatRequest(prompt, imageMimeType, imageBase64);
	}

	public String getPrompt() {
		return prompt;
	}

	public String getImageMimeType() {
		return imageMimeType;
	}

	public String getImageBase64() {
		return imageBase64;
	}

	public boolean hasImage() {
		return imageBase64 != null && !imageBase64.isEmpty();
	}

	/**
	 * Tai lieu tham chieu theo chuan Spring AI (List<Media>).
	 * Tra ve danh sach cac phan media (hien tai toi da mot anh).
	 */
	public List<AiMedia> getMedia() {
		List<AiMedia> media = new ArrayList<>();
		if (hasImage()) {
			String mime = (imageMimeType == null || imageMimeType.isEmpty()) ? "image/jpeg" : imageMimeType;
			media.add(new AiMedia(mime, Base64.getDecoder().decode(imageBase64)));
		}
		return media;
	}

	/** Mot phan media dinh kem (anh) theo chuan Spring AI. */
	public static class AiMedia {

		private final String mimeType;
		private final byte[] data;

		public AiMedia(String mimeType, byte[] data) {
			this.mimeType = mimeType;
			this.data = data;
		}

		public String getMimeType() {
			return mimeType;
		}

		public byte[] getData() {
			return data;
		}
	}
}