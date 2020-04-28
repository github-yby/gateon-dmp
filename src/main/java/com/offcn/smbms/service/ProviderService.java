package com.offcn.smbms.service;

import com.offcn.smbms.pojo.Provider;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public interface ProviderService {
    List<Provider> list(String proName);

    int save(Provider provider);

    Provider getById(int id);

    int update(Provider provider);

    int remove(int id);
}
