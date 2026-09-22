package com.salesmanager.core.business.services.reference.init;

import com.salesmanager.core.business.exception.ServiceException;

public interface InitializationDatabase {
	
	boolean isEmpty() throws ServiceException;
	
	void populate(String name) throws ServiceException;

}
