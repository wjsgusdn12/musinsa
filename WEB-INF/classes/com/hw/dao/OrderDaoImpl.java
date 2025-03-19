package com.hw.dao;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class OrderDaoImpl implements OrderDao {

    @Autowired
    private SqlSession sqlSession;

    @Override
    public String getOrderStatus(Long orderIdx) {
        return sqlSession.selectOne("ProductMapper.getOrderStatus", orderIdx);
    }

    @Override
    public void updateOrderStatus(Long orderIdx, String status) {
    	Map<String, Object> value = new HashMap<>();
    	value.put("orderIdx", orderIdx);
    	value.put("status", status);
        sqlSession.update("ProductMapper.updateOrderStatus", value);
    }
}