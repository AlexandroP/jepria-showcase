package com.technology.jep.jepriashowcase.request.shared.service;
 
import java.util.List;

import com.google.gwt.user.client.rpc.AsyncCallback;
import com.technology.jep.jepria.shared.field.option.JepOption;
import com.technology.jep.jepria.shared.service.data.JepDataServiceAsync;
 
public interface RequestServiceAsync extends JepDataServiceAsync {
  void getRequestStatus(AsyncCallback<List<JepOption>> callback);
}
