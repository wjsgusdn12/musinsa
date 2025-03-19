package com.hw.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hw.dto.AskDto;
import com.hw.dto.CartDto;
import com.hw.dto.OrderDto;
import com.hw.dto.ProductDto;

@Repository
public class ProductDaoImpl implements ProductDao{

	@Autowired
	SqlSession sqlSession;
	
	@Override
	public List<ProductDto> selectAllProduct() {
		List<ProductDto> listRet = sqlSession.selectList("ProductMapper.selectAllProduct");
		return listRet;
	}

	@Override
	public ProductDto selectProductInfo(int productIdx) {
		ProductDto info = sqlSession.selectOne("ProductMapper.selectProductInfo",productIdx);
		return info;
	}

	@Override
	public List<ProductDto> selectLikedProduct(int memberIdx) {
		List<ProductDto> listRet = sqlSession.selectList("ProductMapper.selectLikedProduct", memberIdx);
		return listRet;
	}

	@Override
	public List<CartDto> selectAllCart(int loginMemberIdx) {
		List<CartDto> listRet = sqlSession.selectList("ProductMapper.selectAllCart", loginMemberIdx);
		return listRet;
	}

	@Override
	public void addLike(int productIdx, int loginMemberIdx) {
		Map<String, Object> value = new HashMap<>();
		value.put("loginMemberIdx", loginMemberIdx);
		value.put("productIdx", productIdx);
		sqlSession.insert("ProductMapper.addLike", value);
	}

	@Override
	public void removeLike(int productIdx, int loginMemberIdx) {
		Map<String, Object> value = new HashMap<>();
		value.put("loginMemberIdx", loginMemberIdx);
		value.put("productIdx", productIdx);
		sqlSession.delete("ProductMapper.removeLike", value);
	}

	@Override
	public void insertCart(int productIdx, int sizeIdx, int quantity, int loginMemberIdx) {
		Map<String, Object> value = new HashMap<>();
		value.put("productIdx", productIdx);
		value.put("sizeIdx", sizeIdx);
		value.put("quantity", quantity);
		value.put("loginMemberIdx", loginMemberIdx);
		sqlSession.insert("ProductMapper.insertCart", value);
	}

	@Override
	public void deleteCart(int cartIdx) {
		Map<String, Object> value = new HashMap<>();
		value.put("cartIdx", cartIdx);
		sqlSession.delete("ProductMapper.deleteCart", value);
	}

	@Override
	public void modifyCart(int productIdx, int deleteSizeIdx, int modifySizeIdx, int quantity, int loginMemberIdx) {
		Map<String, Object> delete = new HashMap<>();
		delete.put("productIdx", productIdx);
		delete.put("deleteSizeIdx", deleteSizeIdx);
		sqlSession.update("ProductMapper.modifyDeleteCart", delete);
		
		Map<String, Object> insert = new HashMap<>();
		insert.put("productIdx", productIdx);
		insert.put("modifySizeIdx", modifySizeIdx);
		insert.put("quantity", quantity);
		insert.put("loginMemberIdx", loginMemberIdx);
	    sqlSession.update("ProductMapper.modifyInsertCart", insert);
	}

	@Override
	public int selectCartQuantity(int loginMemberIdx) {
		return sqlSession.selectOne("ProductMapper.selectCartQuantity", loginMemberIdx);
	}

	@Override
	public void insertAsk(int loginMemberIdx, int productIdx, String title, String content) {
		Map<String, Object> value = new HashMap<>();
		value.put("loginMemberIdx", loginMemberIdx);
		value.put("productIdx", productIdx);
		value.put("title", title);
		value.put("content", content);
		sqlSession.insert("ProductMapper.insertAsk", value);
	}

	@Override
	public List<AskDto> selectProductAsk(int productIdx) {
		return sqlSession.selectList("ProductMapper.selectProductAsk", productIdx);
	}

	@Override
	public void insertOrderDetail(int loginMemberIdx, int productIdx, int sizeIdx, int quantity) {
		Map<String, Object> value = new HashMap<>();
		value.put("loginMemberIdx", loginMemberIdx);
		value.put("productIdx", productIdx);
		value.put("sizeIdx", sizeIdx);
		value.put("quantity", quantity);
		
		sqlSession.insert("ProductMapper.insertOrderDetail", value);
	}

	@Override
	public List<OrderDto> selectAllOrder(int loginMemberIdx) {
		return sqlSession.selectList("ProductMapper.selectAllOrder", loginMemberIdx);
	}

	@Override
	public void deleteOrderProduct(int orderIdx) {
		sqlSession.delete("ProductMapper.deleteOrderProduct", orderIdx);
	}

	@Override
	public List<AskDto> selectMemberAsk(int loginMemberIdx) {
		return sqlSession.selectList("ProductMapper.selectMemberAsk", loginMemberIdx);
	}

}
