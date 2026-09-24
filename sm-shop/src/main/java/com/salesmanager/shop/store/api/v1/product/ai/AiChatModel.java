package com.salesmanager.shop.store.api.v1.product.ai;

/**
 * Lop truu tuong cho mo hinh AI (tuong duong ChatModel cua Spring AI).
 *
 * Toan bo nghiep vu (vi du: tao mo ta san pham, dich) chi lam viec voi
 * interface
 * nay. Viec chon Gemini hay OpenAI duoc quyet dinh o tang cau hinh
 * (Admin > Configuration > AI Configuration) va do
 * {@link AiChatModelFactory} khoi tao. Do do KHONG can thay doi code Java khi
 * doi nha cung cap AI.
 */
public interface AiChatModel {

	/**
	 * Ten nha cung cap de hien thi/log (vi du: "gemini", "openai").
	 */
	String getProvider();

	/**
	 * Goi mo hinh va tra ve noi dung van ban.
	 *
	 * @param request yeu cau gom prompt (+ tuy chon anh)
	 * @return noi dung van ban AI tra ve, hoac null neu khong co du lieu
	 * @throws AiException khi cau hinh thieu hoac goi API that bai
	 */
	AiChatResponse call(AiChatRequest request) throws AiException;
}