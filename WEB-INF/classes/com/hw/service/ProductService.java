package com.hw.service;

import java.util.List;

import com.hw.dto.AskDto;
import com.hw.dto.CartDto;
import com.hw.dto.OrderDto;
import com.hw.dto.ProductDto;

public interface ProductService {
	List<ProductDto> selectAllProduct();
	ProductDto selectProductInfo(int productIdx);
	List<ProductDto> selectLikedProduct(int memberIdx);
	List<CartDto> selectAllCart(int loginMemberIdx);
	void addLike(int productIdx, int loginMemberIdx);
	void removeLike(int productIdx, int loginMemberIdx);
	void insertCart(int productIdx, int sizeIdx, int quantity, int loginMemberIdx);
	void deleteCart(int cartIdx);
	void modifyCart(int productIdx, int deleteSizeIdx, int modifySizeIdx, int quantity, int loginMemberIdx);
	int selectCartQuantity(int loginMemberIdx);
	void insertAsk(int loginMemberIdx, int productIdx, String title, String content);
	List<AskDto> selectProductAsk(int productIdx);
	void insertOrderDetail(int loginMemberIdx, int productIdx, int sizeIdx, int quantity);
	List<OrderDto> selectAllOrder(int loginMemberIdx);
	void deleteOrderProduct(int orderIdx);
}
