package com.technology.jep.jepriashowcase.supplier.client.ui.wizard;

import com.google.gwt.core.client.GWT;
import com.google.gwt.place.shared.Place;
import com.technology.jep.jepria.client.ui.wizard.BlockClientFactory;
import com.technology.jep.jepria.client.ui.wizard.BlockClientFactoryImpl;
import com.technology.jep.jepria.client.ui.wizard.BlockPresenter;
import com.technology.jep.jepria.client.ui.wizard.BlockView;
import com.technology.jep.jepria.shared.service.data.JepDataServiceAsync;
import com.technology.jep.jepriashowcase.supplier.shared.service.SupplierService;
import com.technology.jep.jepriashowcase.supplier.shared.service.SupplierServiceAsync;

public class SupplierFirstBlockClientFactory<S extends SupplierServiceAsync> extends BlockClientFactoryImpl<S> {
  
  public static BlockView supplierBlockViewImpl = new SupplierFirstBlockViewImpl();
  public static BlockClientFactory<JepDataServiceAsync> instance = null;
 
  public SupplierFirstBlockClientFactory() {
  }
 
  static public BlockClientFactory<JepDataServiceAsync> getInstance() {
    if(instance == null) {
      instance = GWT.create(SupplierFirstBlockClientFactory.class);
    }
    return instance;
  }
 
  public S getService() {
    if(service == null) {
      service = (S) GWT.create(SupplierService.class);
    }
    return service;
  }

  public BlockView getView() {
    return supplierBlockViewImpl;
  }

  public BlockPresenter createPresenter(Place place) {
    return new SupplierFirstBlockPresenter<S>(place, this);
  }
}