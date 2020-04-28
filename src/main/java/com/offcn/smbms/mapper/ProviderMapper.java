package com.offcn.smbms.mapper;

import com.offcn.smbms.pojo.Provider;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
@Repository
public interface ProviderMapper {
    Provider getById(int id);
    List<Provider> list(@Param("proName") String proName);
    int save(Provider provider);
    int update(Provider provider);
    int remove(int id);
}
