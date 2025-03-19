package com.hw.musinsa;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.hw.dto.CartDto;
import com.hw.dto.ProductDto;
import com.hw.service.MemberService;
import com.hw.service.ProductService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations= {"file:src/main/webapp/WEB-INF/spring/root-context.xml"})
public class ProductDaoTest {
	@Autowired
	ProductService pSvc;
	@Autowired
	MemberService mSvc;
	
//	@Test
//	public void testProductList() throws Exception{
//		List<ProductDto> list = svc.selectAllProduct();
//		List<CartDto> cList = svc.selectAllCart();
//		
//		for(CartDto dto : cList){
//			System.out.println(dto.getProductIdx());
//		}
//	}
	
	@Test
	public void test() throws Exception{
		try{
			pSvc.deleteCart(19);
			System.out.println("삭제성공");
		}catch(Exception e) {
			
		}
	}
	
}
