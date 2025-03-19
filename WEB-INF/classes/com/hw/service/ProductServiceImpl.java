package com.hw.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hw.dao.ProductDao;
import com.hw.dto.AskDto;
import com.hw.dto.CartDto;
import com.hw.dto.OrderDto;
import com.hw.dto.ProductDto;

@Service
public class ProductServiceImpl implements ProductService{

	@Autowired
	ProductDao pDao;
	
	@Override
	public List<ProductDto> selectAllProduct() {
		return pDao.selectAllProduct();
	}

	@Override
	public ProductDto selectProductInfo(int productIdx) {
		return pDao.selectProductInfo(productIdx);
	}

	@Override
	public List<ProductDto> selectLikedProduct(int memberIdx) {
		return pDao.selectLikedProduct(memberIdx);
	}

	@Override
	public List<CartDto> selectAllCart(int loginMemberIdx) {
		return pDao.selectAllCart(loginMemberIdx);
	}

	@Override
	public void addLike(int productIdx, int loginMemberIdx) {
		pDao.addLike(productIdx, loginMemberIdx);
	}

	@Override
	public void removeLike(int productIdx, int loginMemberIdx) {
		pDao.removeLike(productIdx, loginMemberIdx);
	}

	@Override
	public void insertCart(int productIdx, int sizeIdx, int quantity, int loginMemberIdx) {
		pDao.insertCart(productIdx, sizeIdx, quantity, loginMemberIdx);
	}

	@Override
	public void deleteCart(int cartIdx) {
		pDao.deleteCart(cartIdx);
	}

	@Override
	public void modifyCart(int productIdx, int deleteSizeIdx, int modifySizeIdx, int quantity, int loginMemberIdx) {
		pDao.modifyCart(productIdx, deleteSizeIdx, modifySizeIdx, quantity, loginMemberIdx);
	}

	@Override
	public int selectCartQuantity(int loginMemberIdx) {
		return pDao.selectCartQuantity(loginMemberIdx);
	}

	@Override
	public void insertAsk(int loginMemberIdx, int productIdx, String title, String content) {
		pDao.insertAsk(loginMemberIdx, productIdx, title, content);
	}

	@Override
	public List<AskDto> selectProductAsk(int productIdx) {
		return pDao.selectProductAsk(productIdx);
	}

	@Override
	public void insertOrderDetail(int loginMemberIdx, int productIdx, int sizeIdx, int quantity) {
		pDao.insertOrderDetail(loginMemberIdx, productIdx, sizeIdx, quantity);
	}

	@Override
	public List<OrderDto> selectAllOrder(int loginMemberIdx) {
		return pDao.selectAllOrder(loginMemberIdx);
	}

	@Override
	public void deleteOrderProduct(int orderIdx) {
		pDao.deleteOrderProduct(orderIdx);
	}

}
