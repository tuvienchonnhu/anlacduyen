package com.salesmanager.shop.application.config;


import java.util.Arrays;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.config.PropertiesFactoryBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.ClassPathResource;

@Configuration
public class ShopizerPropertiesConfig {

  @Bean
  public List<String> templates() {
    return Arrays.asList("bootstrap", "generic", "exoticamobilia", "december");
  }

  /**
   * Danh sach template kem nhan hien thi cho dropdown "Theme" trong Admin > Store > Branding.
   * Dung LinkedHashMap de giu dung thu tu khai bao (tem template bi sap xep lai).
   * Form binding ghi nhan gia tri (key) vao store.storeTemplate.
   */
  @Bean
  public Map<String, String> templateOptions() {
    Map<String, String> options = new LinkedHashMap<String, String>();
    options.put("generic", "Generic");
    options.put("december", "December");
    options.put("exoticamobilia", "Exoticamobilia");
    options.put("bootstrap", "Bootstrap");
    return options;
  }

  @Bean(name = "shopizer-properties")
  public PropertiesFactoryBean mapper() {
    PropertiesFactoryBean bean = new PropertiesFactoryBean();
    bean.setLocation(new ClassPathResource("shopizer-properties.properties"));
    return bean;
  }
}
