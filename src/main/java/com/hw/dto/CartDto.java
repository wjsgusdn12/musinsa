package com.hw.dto;

public class CartDto {
	private int cartIdx;
	private int productIdx;
	private String brand;
	private String name;
	private String img;
	private String sizeName;
	private String quantity;
	private String totalPrice;
	
	public CartDto() {}
	
	public CartDto(int cartIdx, int productIdx, String brand, String name, String img, String sizeName, String quantity,
			String totalPrice) {
		this.cartIdx = cartIdx;
		this.productIdx = productIdx;
		this.brand = brand;
		this.name = name;
		this.img = img;
		this.sizeName = sizeName;
		this.quantity = quantity;
		this.totalPrice = totalPrice;
	}
	
	public int getCartIdx() {
		return cartIdx;
	}
	public void setCartIdx(int cartIdx) {
		this.cartIdx = cartIdx;
	}
	public int getProductIdx() {
		return productIdx;
	}
	public void setProductIdx(int productIdx) {
		this.productIdx = productIdx;
	}
	public String getBrand() {
		return brand;
	}
	public void setBrand(String brand) {
		this.brand = brand;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
	}
	public String getSizeName() {
		return sizeName;
	}
	public void setSizeName(String sizeName) {
		this.sizeName = sizeName;
	}
	public String getQuantity() {
		return quantity;
	}
	public void setQuantity(String quantity) {
		this.quantity = quantity;
	}
	public String getTotalPrice() {
		return totalPrice;
	}
	public void setTotalPrice(String totalPrice) {
		this.totalPrice = totalPrice;
	}
	
}
