package com.offcn.smbms.service;

import com.offcn.smbms.pojo.Bill;

import java.util.List;

public interface BillService {
    List<Bill> list(String productName,int providerId,int ispayment);
    int save(Bill bill);
    Bill getById(int id);
    int update(Bill bill);
    int remove(int id);

}
