package com.offcn.smbms.utils;


import org.springframework.core.convert.converter.Converter;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class DateConveter implements Converter<String, Date> {
    @Override
    public Date convert(String time) {
        if(time !=null || !time.equals("")){
            String pattern="yyyy/MM/dd";
            if(time.contains("-")){
                pattern=pattern.replaceAll("/","-");
            }
            if(time.contains(":")){
                pattern+=" HH:mm:ss";
            }
            SimpleDateFormat simpleDateFormat=new SimpleDateFormat(pattern);

            try {
                return simpleDateFormat.parse(time);
            } catch (ParseException e) {
                e.printStackTrace();
            }
        }
        return null;
    }
}
