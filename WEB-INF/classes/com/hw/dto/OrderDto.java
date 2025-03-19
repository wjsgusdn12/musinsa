package com.hw.dto;

public class OrderDto {
	private int orderIdx;
	private String img;
	private String brand;
	private String name;
	private String sizeName;
	private int productIdx;
	private int quantity;
	private String totalPrice;
	private String orderDate;
	private String status;
	
	public OrderDto() {}
	
	public OrderDto(int orderIdx, String img, String brand, String name, String sizeName, int productIdx, int quantity,
			String totalPrice, String orderDate, String status) {
		this.orderIdx = orderIdx;
		this.img = img;
		this.brand = brand;
		this.name = name;
		this.sizeName = sizeName;
		this.productIdx = productIdx;
		this.quantity = quantity;
		this.totalPrice = totalPrice;
		this.orderDate = orderDate;
		this.status = status;
	}
	
	public int getOrderIdx() {
		return orderIdx;
	}
	public void setOrderIdx(int orderIdx) {
		this.orderIdx = orderIdx;
	}
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
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
	public String getSizeName() {
		return sizeName;
	}
	public void setSizeName(String sizeName) {
		this.sizeName = sizeName;
	}
	public int getProductIdx() {
		return productIdx;
	}
	public void setProductIdx(int productIdx) {
		this.productIdx = productIdx;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	public String getTotalPrice() {
		return totalPrice;
	}
	public void setTotalPrice(String totalPrice) {
		this.totalPrice = totalPrice;
	}
	public String getOrderDate() {
		return orderDate;
	}
	public void setOrderDate(String orderDate) {
		this.orderDate = orderDate;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	
}
