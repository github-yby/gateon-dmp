package com.offcn.smbms.service.impl;

import com.offcn.smbms.mapper.ProviderMapper;
import com.offcn.smbms.pojo.Provider;
import com.offcn.smbms.service.ProviderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class ProviderServiceImpl implements ProviderService {
    @Autowired
    private ProviderMapper providerMapper;
    @Override
    public List<Provider> list(String proName) {

        return providerMapper.list(proName);
    }

    @Override
    public int save(Provider provider) {
        return providerMapper.save(provider);
    }

    @Override
    public Provider getById(int id) {
        return providerMapper.getById(id);
    }

    @Override
    public int update(Provider provider) {
        return providerMapper.update(provider);
    }

    @Override
    public int remove(int id) {
        return providerMapper.remove(id);
    }
}
