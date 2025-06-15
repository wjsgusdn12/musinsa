package com.hw.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.hw.dto.AskDto;
import com.hw.dto.CartDto;
import com.hw.dto.MemberDto;
import com.hw.dto.OrderDto;
import com.hw.dto.ProductDto;
import com.hw.service.MemberService;
import com.hw.service.OrderService;
import com.hw.service.ProductService;

@Controller
public class HomeController {
	
	@Autowired
	MemberService mService;
	@Autowired
	ProductService pService;
	@Autowired
    OrderService orderService;
	
	@RequestMapping("/")
	public String home() {
		return "login";
	}
	
	@RequestMapping("/cart")
	public String cart(Model model, HttpSession session) {
	    List<CartDto> cartList = pService.selectAllCart((Integer)session.getAttribute("loginMemberIdx"));
	    List<ProductDto> likedList = pService.selectLikedProduct((Integer)session.getAttribute("loginMemberIdx"));
	    int finalPrice = cartList.stream().mapToInt(dto -> Integer.parseInt(dto.getTotalPrice().replace(",", ""))).sum(); // 최종 가격 계산
	    
	    model.addAttribute("cartList", cartList);
	    model.addAttribute("finalPrice", String.format("%,d", finalPrice)); // 999,999,999 처리
	    model.addAttribute("finalQuantity", cartList.size());
	    model.addAttribute("likedList", likedList);
	    return "cart";
	}
	
	@RequestMapping("/deleteOrderProduct")
	@ResponseBody
	public String deleteOrderProduct(int orderIdx) {
		pService.deleteOrderProduct(orderIdx);
		return "success";
	}
	
	@RequestMapping("/detail")
    public String detail(int productIdx, Model model, HttpSession session) {
        Integer isLiked = (Integer) session.getAttribute("isLiked"); // 세션에서 좋아요 상태 가져오기
        ProductDto productInfo = pService.selectProductInfo(productIdx);
        List<ProductDto> likedList = pService.selectLikedProduct((Integer) session.getAttribute("loginMemberIdx"));
        int selectCartQuantity = pService.selectCartQuantity((Integer)session.getAttribute("loginMemberIdx"));
		List<AskDto> selectProductAsk = pService.selectProductAsk(productIdx);
		model.addAttribute("selectProductAsk", selectProductAsk);
        model.addAttribute("selectCartQuantity", selectCartQuantity);
        model.addAttribute("likedList", likedList);
        model.addAttribute("productInfo", productInfo);
        model.addAttribute("isLiked", isLiked != null ? isLiked : 0); // 기본값 0
        return "detail";
    }
	
	@RequestMapping("/deleteCart")
	@ResponseBody
	public void deleteCart(int cartIdx) {
		pService.deleteCart(cartIdx);
	}
	
	@RequestMapping("/deleteMember")
	@ResponseBody
	public String deleteMember(int loginMemberIdx) {
		mService.deleteMember(loginMemberIdx);
		return "success";
	}
	
	@RequestMapping("/find_id")
	public String findId() {
		return "find_id";
	}
	
	@RequestMapping("/find_id_action")
	public String findId(String name, String phone, Model model) {
		String id = mService.selectId(name, phone);
		model.addAttribute("id",id);
		return "find_id_action";
	}
	
	@RequestMapping("/find_pw")
	public String findPw() {
		return "find_pw";
	}
	
	@RequestMapping("/find_pw_action")
	public String findPw(String id, String name, String phone, Model model) {
		String pw = mService.selectPw(id, name, phone);
		model.addAttribute("id", id);
		model.addAttribute("name",name);
		model.addAttribute("phone", phone);
		model.addAttribute("pw", pw);
		return "find_pw_action";
	}
	
	@RequestMapping("/index")
	public String index(Model model, HttpSession session) {
		List<ProductDto> productList = pService.selectAllProduct();
		List<ProductDto> likedList = pService.selectLikedProduct((Integer)session.getAttribute("loginMemberIdx"));
		int selectCartQuantity = pService.selectCartQuantity((Integer)session.getAttribute("loginMemberIdx"));
		model.addAttribute("selectCartQuantity", selectCartQuantity);
		model.addAttribute("likedList", likedList);
		model.addAttribute("productList", productList);
		return "index";
	}
	
	@RequestMapping("/insertAsk")
	@ResponseBody
	public String insertAsk(int productIdx, String title, String content,  HttpSession session) {
		pService.insertAsk((Integer)session.getAttribute("loginMemberIdx"), productIdx, title, content);
		return "success";
	}
	
	@RequestMapping("/insertCart")
	@ResponseBody
	public String insertCart(int productIdx, int sizeIdx, int quantity, Model model, HttpSession session) {
		pService.insertCart(productIdx, sizeIdx, quantity, (Integer)session.getAttribute("loginMemberIdx"));
		return "success";
	}
	
	@RequestMapping("/insertOrderDetail")
	@ResponseBody
	public String insertOrderDetail(int loginMemberIdx, int productIdx, int sizeIdx, int quantity, HttpSession session) {
		pService.insertOrderDetail(loginMemberIdx, productIdx, sizeIdx, quantity);
		return "success";
	}

	@RequestMapping("/deleteCartAfterOrder")
	@ResponseBody
	public String deleteCartAfterOrder(int loginMemberIdx) {
		pService.deleteCartAfterOrder(loginMemberIdx);
		return "success";
	}
	
	@RequestMapping("/join")
	public String join() {
		return "join";
	}
	
	@RequestMapping("/join_action")
	public String joinAction(String email, String id, String pw, String name, String address, String postcode, String detailAddress , String phone, HttpServletRequest request, RedirectAttributes redirectAttributes) {
		
        int checkId = mService.checkId(id);
        address = address +" "+ detailAddress +" ("+ postcode+")";
        if (checkId==1) {
            redirectAttributes.addFlashAttribute("errorMessage", "입력하신 아이디가 중복되었습니다. 다른 아이디를 입력해주세요.");
            return "redirect:/join";  // 다시 회원가입 페이지로 리다이렉트
        }else {
        	mService.insertMember(email, id, pw, name, address, phone);
        	redirectAttributes.addFlashAttribute("successMessage", "회원가입 되었습니다! 로그인을 해주세요.");
            return "redirect:/login";
        }
	}
	
	@RequestMapping("/likes")
	public String likes(Model model, HttpSession session) {
		List<ProductDto> likedList = pService.selectLikedProduct((Integer)session.getAttribute("loginMemberIdx"));
		int selectCartQuantity = pService.selectCartQuantity((Integer)session.getAttribute("loginMemberIdx"));
		model.addAttribute("selectCartQuantity", selectCartQuantity);
		model.addAttribute("likedList", likedList);
		return "likes";
	}
	
	@RequestMapping("/likeProduct")
	@ResponseBody
	public String likeProduct(int productIdx, int loginMemberIdx, boolean likeStatus, HttpSession session) {
		if(likeStatus) {
			pService.addLike(productIdx, (Integer)session.getAttribute("loginMemberIdx"));
		}else {
			pService.removeLike(productIdx, (Integer)session.getAttribute("loginMemberIdx"));
		}
		return "suceess";
	}
	
	@RequestMapping("/login")
	public String login() {
		return "login";
	}
	
	@RequestMapping("/logout")
	public String logout(HttpSession session, HttpServletResponse response) {
	    session.invalidate();  // 세션 무효화
	    return "redirect:/login";  // 로그인 페이지로 리다이렉트
	}

	@RequestMapping("/loginCheck")
	@ResponseBody
	public int loginCheck(String id, String pw, HttpSession session) {
		MemberDto memberDto = mService.selectMemberIdxAndName(id);
		if(memberDto==null) { return -1; }
		session.setAttribute("loginMemberIdx", memberDto.getMemberIdx());
		session.setAttribute("loginMemberName", memberDto.getName());
		session.setAttribute("loginMemberId", memberDto.getId());
		session.setAttribute("loginMemberPhone", memberDto.getPhone());
		session.setAttribute("loginMemberAddress", memberDto.getAddress());
		session.setAttribute("loginMemberEmail", memberDto.getEmail());
	    return mService.loginCheck(id, pw);
	}
	
	@RequestMapping("/modifyCart")
	@ResponseBody
	public String modifyCart(int productIdx, int deleteSizeIdx, int modifySizeIdx, int quantity, int loginMemberIdx) {
	    pService.modifyCart(productIdx, deleteSizeIdx, modifySizeIdx, quantity, loginMemberIdx);
		return "";
	}
	
	@RequestMapping("/modify_pw")
	public String modifyPw(String id, String name, String phone, Model model) {
		model.addAttribute("id", id);
		model.addAttribute("pw", mService.selectPw(id, name, phone));
		return "modify_pw";
	}
	
	@RequestMapping("/modify_member")
	public String modifyMember(String id, Model model) {
		model.addAttribute("id", id);
		return "modify_member";
	}
	
	@RequestMapping("/modify_member_address")
	public String modifyMemberAddress(String id, Model model) {
		model.addAttribute("id", id);
		return "modify_member_address";
	}
	
	@PostMapping("/modifyMemberAction")
	@ResponseBody
	public String modifyMemberAction(String id, String email, String name, String address, String phone, HttpSession session) {
		mService.modifyMember(id, email, name, address, phone);
		session.setAttribute("loginMemberEmail", email);
	    session.setAttribute("loginMemberName", name);
	    session.setAttribute("loginMemberAddress", address);
	    session.setAttribute("loginMemberPhone", phone);
		return "success";
	}

	@PostMapping("/modifyPwAction")
	@ResponseBody
	public String modifyPwAction(String id, String pw) {
		mService.modifyPwAction(id, pw);
		return "success";
	}
	
	@RequestMapping("/my_ask")
	public String myAsk(Model model, HttpSession session) {
		model.addAttribute("loginMemberIdx", (Integer)session.getAttribute("loginMemberIdx"));
		List<AskDto> myAsk = pService.selectMemberAsk((Integer)session.getAttribute("loginMemberIdx"));
		model.addAttribute("myAsk", myAsk);
		return "my_ask";
	}
	
	@RequestMapping("/my_page")
	public String myPage() {
		return "my_page";
	}
	
	@RequestMapping("/order")
	public String order(Model model, HttpSession session) {
	    List<CartDto> cartList = pService.selectAllCart((Integer)session.getAttribute("loginMemberIdx"));
	    List<ProductDto> likedList = pService.selectLikedProduct((Integer)session.getAttribute("loginMemberIdx"));
	    int finalPrice = cartList.stream().mapToInt(dto -> Integer.parseInt(dto.getTotalPrice().replace(",", ""))).sum(); // 최종 가격 계산
	    
	    model.addAttribute("cartList", cartList);
	    model.addAttribute("finalPrice", String.format("%,d", finalPrice)); // 999,999,999 처리
	    model.addAttribute("finalQuantity", cartList.size());
	    model.addAttribute("likedList", likedList);
	    return "order";
	}
	
	@RequestMapping("/order_detail")
	public String orderDetail(Model model, HttpSession session) {
		List<OrderDto> selectAllOrder = pService.selectAllOrder((Integer)session.getAttribute("loginMemberIdx"));
	    model.addAttribute("selectAllOrder", selectAllOrder);
		return "order_detail";
	}
	
	// 세션에 isLiked 값을 저장하는 메소드
    @PostMapping("/saveLikeStatus")
    @ResponseBody
    public void saveLikeStatus(HttpSession session, @RequestParam int isLiked) {
        // 세션에 isLiked 값 저장
        session.setAttribute("isLiked", isLiked);
    }
    
    @PostMapping("/selectMemberIdCheck")
    @ResponseBody
    public int selectMemberIdCheck(String id) {
    	return mService.checkId(id);
    }
    
    @PostMapping("/updateOrderStatus")
    @ResponseBody
    public Map<String, String> updateOrderStatus(@RequestParam("orderIdx") Long orderIdx) {
        Map<String, String> response = new HashMap<>();
        try {
            // 주문 상태 변경 로직
            String newStatus = orderService.updateOrderStatus(orderIdx);
            response.put("status", newStatus);  // 상태 반환
        } catch (Exception e) {
            response.put("status", "error");
        }
        return response;
    }
}
