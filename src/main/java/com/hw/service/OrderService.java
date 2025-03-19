package com.hw.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hw.dao.OrderDao;

@Service
public class OrderService {

    @Autowired
    private OrderDao orderDao;

    // 상태 변경 메서드
    public String updateOrderStatus(Long orderIdx) {
        // 현재 상태 조회
        String currentStatus = orderDao.getOrderStatus(orderIdx);

        String newStatus = null;

        if ("상품 준비중".equals(currentStatus)) {
            newStatus = "배송중";
            orderDao.updateOrderStatus(orderIdx, newStatus);
        } else if ("배송중".equals(currentStatus)) {
            newStatus = "배송완료";
            orderDao.updateOrderStatus(orderIdx, newStatus);
        }

        return newStatus;
    }
}
