package com.salesmanager.shop.utils;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;
import com.salesmanager.core.model.catalog.category.Category;
import com.salesmanager.core.model.catalog.category.CategoryDescription;
import com.salesmanager.core.model.reference.language.Language;

public class CategoryUtils {


  public static com.salesmanager.shop.admin.model.catalog.Category readableCategoryConverter(Category category, Language language) {
    com.salesmanager.shop.admin.model.catalog.Category readableCategory = new com.salesmanager.shop.admin.model.catalog.Category();
    readableCategory.setCategory(category);

    List<CategoryDescription> descriptions = new ArrayList<CategoryDescription>(category.getDescriptions());

    //descriptions
    //.stream();
    //.filter(desc -> desc.getLanguage().getCode().equals(language.getCode()));


    readableCategory.setDescriptions(descriptions);
    return readableCategory;
  }

  public static List<com.salesmanager.shop.admin.model.catalog.Category> readableCategoryListConverter(List<Category> categories, Language language) {

    List<com.salesmanager.shop.admin.model.catalog.Category> readableCategories =
        categories.stream()
         .map(cat -> readableCategoryConverter(cat, language))
         .collect(Collectors.toList());

    return readableCategories;

  }

  /**
   * Chon ten danh muc dung voi ngon ngu Admin dang hien thi.
   *
   * Mo ta danh muc duoc luu trong Set<CategoryDescription> nen thu tu cua no
   * khong duoc bao dam. Neu lay "descriptions[0].name" (hoac phan tu dau tien
   * cua Set) thi ten danh muc tren giao dien se hien thi lan lon nhieu ngon ngu
   * tuy theo du lieu tra ve tu database. Vi vay:
   * - Uu tien ban dich dung voi ngon ngu hien thi
   * - Neu khong co thi fallback ve mo ta dau tien
   * - Neu danh muc khong co mo ta nao thi dung code cua danh muc
   */
  public static CategoryDescription localizedDescription(Category category, Language language) {
    if(category==null || category.getDescriptions()==null || category.getDescriptions().isEmpty()) {
      return null;
    }
    if(language!=null) {
      for(CategoryDescription desc : category.getDescriptions()) {
        if(desc.getLanguage()!=null && desc.getLanguage().getId()!=null
            && language.getId()!=null
            && desc.getLanguage().getId().equals(language.getId())) {
          return desc;
        }
      }
      for(CategoryDescription desc : category.getDescriptions()) {
        if(desc.getLanguage()!=null && desc.getLanguage().getCode()!=null
            && language.getCode()!=null
            && desc.getLanguage().getCode().equals(language.getCode())) {
          return desc;
        }
      }
    }
    return category.getDescriptions().iterator().next();
  }

  public static String localizedName(Category category, Language language) {
    CategoryDescription description = localizedDescription(category, language);
    if(description!=null) {
      return description.getName();
    }
    return category!=null ? category.getCode() : "";
  }

  /**
   * Chuyen danh sach danh muc thanh du lieu don gian de ve cay danh muc bang
   * JSTL: id, id danh muc cha, ten theo ngon ngu hien thi. Nho vay JSP khong
   * phai phu thuoc vao "descriptions[0].name" nua.
   */
  public static List<Map<String,Object>> categoryLabels(List<Category> categories, Language language) {
    List<Map<String,Object>> labels = new ArrayList<Map<String,Object>>();
    if(categories==null) {
      return labels;
    }
    for(Category category : categories) {
      Map<String,Object> label = new LinkedHashMap<String,Object>();
      label.put("id", category.getId());
      label.put("parentId", category.getParent()!=null ? category.getParent().getId() : -1L);
      label.put("name", localizedName(category, language));
      labels.add(label);
    }
    return labels;
  }

  /**
   * Cac danh muc co the duoc chon lam danh muc cha cua "current":
   * bo chinh no va toan bo danh muc con (chau) cua no de tranh vong lap cay.
   */
  public static List<Category> parentCandidates(List<Category> categories, Category current) {
    if(categories==null) {
      return new ArrayList<Category>();
    }
    if(current==null || current.getId()==null) {
      return categories;
    }
    Set<Long> excludedIds = new HashSet<Long>();
    excludedIds.add(current.getId());
    for(Category category : categories) {
      if(isChildOf(current, category)) {
        excludedIds.add(category.getId());
      }
    }
    List<Category> candidates = new ArrayList<Category>();
    for(Category category : categories) {
      if(!excludedIds.contains(category.getId())) {
        candidates.add(category);
      }
    }
    return candidates;
  }

  /**
   * Tra ve true khi "child" nam ben duoi "parent" (dua vao lineage).
   */
  public static boolean isChildOf(Category parent, Category child) {
    if(parent==null || child==null || parent.getId()==null || child.getLineage()==null) {
      return false;
    }
    return child.getLineage().contains("/" + parent.getId() + "/");
  }

}
