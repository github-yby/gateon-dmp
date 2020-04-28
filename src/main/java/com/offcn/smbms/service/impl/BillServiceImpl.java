package com.offcn.smbms.service.impl;

import com.offcn.smbms.mapper.BillMapper;
import com.offcn.smbms.pojo.Bill;
import com.offcn.smbms.service.BillService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
@Service
public class BillServiceImpl implements BillService {
    @Autowired
    private BillMapper billMapper;
    @Override
    public List<Bill> list(String productName,int providerId,int ispayment) {

        return billMapper.list(productName,providerId,ispayment);
    }

    @Override
    public int save(Bill bill) {
        return billMapper.save(bill);
    }

    @Override
    public Bill getById(int id) {
        return billMapper.getById(id);
    }

    @Override
    public int update(Bill bill) {
        return billMapper.update(bill);
    }

    @Override
    public int remove(int id) {
        return billMapper.remove(id);
    }
}
