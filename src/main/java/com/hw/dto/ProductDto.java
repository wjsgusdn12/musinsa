package com.hw.dto;

public class ProductDto {
	private int productIdx;
	private String name;
	private String img;
	private String price;
	private String brand;
	private String description;
	
	public ProductDto() {}
	
	public ProductDto(int productIdx, String name, String img, String price, String brand, String description) {
		this.productIdx = productIdx;
		this.name = name;
		this.img = img;
		this.price = price;
		this.brand = brand;
		this.description = description;
	}
	
	public int getProductIdx() {
		return productIdx;
	}
	public void setProductIdx(int productIdx) {
		this.productIdx = productIdx;
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
	public String getPrice() {
		return price;
	}
	public void setPrice(String price) {
		this.price = price;
	}
	public String getBrand() {
		return brand;
	}
	public void setBrand(String brand) {
		this.brand = brand;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	
}
