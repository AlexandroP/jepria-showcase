package com.technology.jep.jepriashowcase.custom.client.ui.plain;

import com.google.gwt.event.dom.client.ClickHandler;
import com.google.gwt.event.shared.HandlerRegistration;
import com.technology.jep.jepria.client.ui.plain.PlainModuleView;

public interface CustomModuleView extends PlainModuleView {

  void addFullScreenButtonClickHandler(ClickHandler clickHandler);
  
  void addErrorButtonClickHandler(ClickHandler clickHandler);
  
  void addZIndexButtonClickHandler(ClickHandler clickHandler);
  
  void addEmbeddedButtonClickHandler(ClickHandler clickHandler);

  void addSearchButtonClickHandler(ClickHandler clickHandler);

  void addAuthorizationButtonClickHandler(ClickHandler clickHandler);
  
  void addExitButtonClickHandler(ClickHandler clickHandler);
  
  Credential getUserCredential();
  
  String getUrlTextFieldValue();
  
  boolean isUrlTextFieldValid();
  
  void setUrlTextFieldAllowBlank(boolean allowBlank);
  
  void showOrClearError(String errorText);
  
  void toggleAuthorizationPanel();
  
  void showLoadingIndicator();
  
  void hideLoadingIndicator();
  
  void setUsername(String username);
  
  void clearCredential();
  
  void addCurrentUserButtonClickHandler(ClickHandler clickHandler);

  HandlerRegistration addGoToUrlButtonClickHandler(ClickHandler clickHandler);
  
  HandlerRegistration addTransactionButtonClickHandler(ClickHandler clickHandler);

  void addAuthenticationServletButtonClickHandler(ClickHandler clickHandler);
}
