package com.hw.dao;

public interface OrderDao {
    String getOrderStatus(Long orderIdx); // 현재 상태를 가져오는 메서드
    void updateOrderStatus(Long orderIdx, String status); // 주문 상태를 업데이트하는 메서드
}