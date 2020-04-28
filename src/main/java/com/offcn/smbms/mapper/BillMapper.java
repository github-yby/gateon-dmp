package com.offcn.smbms.mapper;

import com.offcn.smbms.pojo.Bill;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
@Repository
public interface BillMapper {
    List<Bill> list(@Param("productName") String productName, @Param("providerId")int providerId, @Param("ispayment")int ispayment);
    int save(Bill bill);
    Bill getById(int id);
    int update(Bill bill);
    int remove(int id);

}
