package com.technology.jep.jepriashowcase.custom.client.ui.plain;

import static com.technology.jep.jepria.client.JepRiaAutomationConstant.ENTRANCE_PANEL_LOGOUT_BUTTON_ID;
import static com.technology.jep.jepria.client.JepRiaAutomationConstant.LOGGED_IN_USER_ID;
import static com.technology.jep.jepria.client.JepRiaAutomationConstant.LOGIN_BUTTON_ID;
import static com.technology.jep.jepria.client.JepRiaAutomationConstant.LOGIN_PASSWORD_FIELD_ID;
import static com.technology.jep.jepria.client.JepRiaAutomationConstant.LOGIN_USERNAME_FIELD_ID;
import static com.technology.jep.jepriashowcase.custom.client.CustomClientConstant.customText;
import static com.technology.jep.jepriashowcase.custom.client.CustomAutomationConstant.AUTHORIZATION_PANEL_ID;
import static com.technology.jep.jepriashowcase.custom.client.CustomAutomationConstant.CUSTOM_COMBOBOXFIELD_ID;
import static com.technology.jep.jepriashowcase.custom.client.CustomAutomationConstant.ERROR_LABEL_ID;
import static com.technology.jep.jepriashowcase.custom.client.CustomAutomationConstant.LOADING_AUTHORIZATION_PANEL_ID;
import static com.technology.jep.jepriashowcase.custom.client.CustomAutomationConstant.LOGIN_PANEL_ID;
import static com.technology.jep.jepriashowcase.custom.client.CustomAutomationConstant.LOGOUT_PANEL_ID;
import static com.technology.jep.jepriashowcase.custom.client.CustomAutomationConstant.CUSTOM_AUTHENTICATION_SERVLET_BUTTON_ID;
import static com.technology.jep.jepriashowcase.custom.shared.ui.JepRiaShowcaseCustomPageElements.BOTTOM_ELEMENT;
import static com.technology.jep.jepriashowcase.custom.shared.ui.JepRiaShowcaseCustomPageElements.CURRENT_USER_ELEMENT;
import static com.technology.jep.jepriashowcase.custom.shared.ui.JepRiaShowcaseCustomPageElements.EMBEDDED_ELEMENT;
import static com.technology.jep.jepriashowcase.custom.shared.ui.JepRiaShowcaseCustomPageElements.FULL_SCREEN_ELEMENT;
import static com.technology.jep.jepriashowcase.custom.shared.ui.JepRiaShowcaseCustomPageElements.RIGHT_ELEMENT;
import static com.technology.jep.jepriashowcase.custom.shared.ui.JepRiaShowcaseCustomPageElements.SEARCH_ELEMENT;
import static com.technology.jep.jepriashowcase.custom.shared.ui.JepRiaShowcaseCustomPageElements.TOP_ELEMENT;

import java.util.ArrayList;

import com.google.gwt.dom.client.Style.FontWeight;
import com.google.gwt.dom.client.Style.Unit;
import com.google.gwt.event.dom.client.ClickEvent;
import com.google.gwt.event.dom.client.ClickHandler;
import com.google.gwt.event.dom.client.FocusEvent;
import com.google.gwt.event.dom.client.FocusHandler;
import com.google.gwt.event.shared.HandlerRegistration;
import com.google.gwt.user.client.DOM;
import com.google.gwt.user.client.ui.DeckPanel;
import com.google.gwt.user.client.ui.HasHorizontalAlignment;
import com.google.gwt.user.client.ui.HasVerticalAlignment;
import com.google.gwt.user.client.ui.HorizontalPanel;
import com.google.gwt.user.client.ui.Label;
import com.google.gwt.user.client.ui.PasswordTextBox;
import com.google.gwt.user.client.ui.RootPanel;
import com.google.gwt.user.client.ui.TextBox;
import com.google.gwt.user.client.ui.VerticalPanel;
import com.google.gwt.user.client.ui.Widget;
import com.technology.jep.jepria.client.ui.plain.PlainModuleViewImpl;
import com.technology.jep.jepria.client.util.JepClientUtil;
import com.technology.jep.jepria.client.widget.field.multistate.JepComboBoxField;
import com.technology.jep.jepria.client.widget.field.multistate.JepTextField;
import com.technology.jep.jepria.shared.field.option.JepOption;
import com.technology.jep.jepria.shared.util.JepRiaUtil;
import com.technology.jep.jepriashowcase.custom.client.CustomAutomationConstant;
import com.technology.jep.jepriashowcase.custom.client.ui.auto.IdentifiedButton;

public class CustomModuleViewImpl extends PlainModuleViewImpl implements CustomModuleView {
  private IdentifiedButton fullScreenButton;
  private IdentifiedButton errorButton;
  private IdentifiedButton zIndexDialog;
  private IdentifiedButton embeddedButton;
  private IdentifiedButton authorizationButton;
  private IdentifiedButton exitButton;
  private IdentifiedButton currentUserButton;
  private IdentifiedButton searchButton;
  private IdentifiedButton transactionButton;
  private IdentifiedButton goToUrlButton;
  private IdentifiedButton authenticationServletButton;
  
  private Label errorLabel, currentUserLabel;
  private TextBox loginTextBox;
  private PasswordTextBox passwordTextBox;
  
  private DeckPanel authorizationPanel;
  private VerticalPanel loginAndPasswordPanel, currentUserPanel, loadingIndicatorPanel;
  
  private JepTextField urlTextField;
  private JepComboBoxField comboBoxField;
  
  /**
   * Уникальный идентификатор для идентификатора загрузки.
   */
  public static final String LAYER_ID = DOM.createUniqueId();
  
  public CustomModuleViewImpl() {
    
    fullScreenButton = new IdentifiedButton(
        customText.custom_fullScreenButton(),
        CustomAutomationConstant.CUSTOM_MAINPAGE_FULLSCREEN_MODULES_BUTTON_ID);
    
    add(fullScreenButton, FULL_SCREEN_ELEMENT);
    
    errorButton = new IdentifiedButton(
        customText.custom_errorButton(),
        CustomAutomationConstant.CUSTOM_MAINPAGE_ERROR_DIALOG_BUTTON_ID);
    
    add(errorButton, TOP_ELEMENT);
    
    zIndexDialog = new IdentifiedButton(
        customText.custom_zindexDialog_button(),
        CustomAutomationConstant.CUSTOM_Z_INDICES_DIALOG_BUTTON_ID);
    
    add(zIndexDialog, TOP_ELEMENT);
    
    embeddedButton = new IdentifiedButton(
        customText.custom_embeddedButton(),
        CustomAutomationConstant.CUSTOM_MAINPAGE_EMBEDDED_MODULES_BUTTON_ID);
    
    add(embeddedButton, EMBEDDED_ELEMENT);
    
    authorizationPanel = createAuthorizationalPanel();
    add(authorizationPanel, RIGHT_ELEMENT);
    
    currentUserButton = new IdentifiedButton(
        customText.custom_currentUser(),
        CustomAutomationConstant.CUSTOM_MAINPAGE_CURRENT_USER_BUTTON_ID);
    
    
    
    add(currentUserButton, CURRENT_USER_ELEMENT);
    
    transactionButton = new IdentifiedButton(
        customText.custom_transactionButton(),
        CustomAutomationConstant.CUSTOM_TRANSACTION_BUTTON_ID);
    
    add(transactionButton, CURRENT_USER_ELEMENT);
    
    urlTextField = new JepTextField(
        CustomAutomationConstant.CUSTOM_URL_TEXTFIELD_ID,
        customText.custom_urlLabel());
    
    add(urlTextField, CURRENT_USER_ELEMENT);
    
    goToUrlButton = new IdentifiedButton(
        customText.custom_goToUrlButton(),
        CustomAutomationConstant.CUSTOM_GOTOURL_BUTTON_ID);
    
    add(goToUrlButton, CURRENT_USER_ELEMENT);

    searchButton = new IdentifiedButton(
        customText.custom_searchButton(),
        CustomAutomationConstant.CUSTOM_MAINPAGE_SEARCH_FORM_BUTTON_ID);
    
    add(searchButton, SEARCH_ELEMENT);
    
    comboBoxField = new JepComboBoxField(
        CustomAutomationConstant.CUSTOM_COMBOBOXFIELD_ID,
        customText.custom_comboBoxLabel());
    comboBoxField.setLabelWidth(200);
    comboBoxField.setOptions(new ArrayList<JepOption>() {{
      add(new JepOption("option1", 1));
      add(new JepOption("option2", 2));
      add(new JepOption("option3", 3));
      add(new JepOption("option4", 4));
      add(new JepOption("option5", 5));
      add(new JepOption("option6", 6));
      add(new JepOption("option7", 7));
      add(new JepOption("option8", 8));
      add(new JepOption("option9", 9));
      add(new JepOption("option10", 10));
    }});
    
    add(comboBoxField, BOTTOM_ELEMENT);
    
  }
  
  /**
   * Привязка виджета к идентификатору элемента в DOM-дереве.
   * 
   * @param widget      привязываемый виджет
   * @param elementId      идентификатор элемента DOM-дерева
   * @return флаг наличия элемента в DOM-дереве
   */
    private boolean add(Widget widget, String elementId) {
    RootPanel element = RootPanel.get(elementId);
    if (element != null) {
      element.add(widget);
    }
    return (element != null);
  }

  
  @Override
  public void addFullScreenButtonClickHandler(ClickHandler clickHandler) {
    fullScreenButton.addClickHandler(clickHandler);
  }

  @Override
  public void addErrorButtonClickHandler(ClickHandler clickHandler) {
    errorButton.addClickHandler(clickHandler);
  }
  
  @Override
  public void addZIndexButtonClickHandler(ClickHandler clickHandler) {
    zIndexDialog.addClickHandler(clickHandler);
  }

  @Override
  public void addEmbeddedButtonClickHandler(ClickHandler clickHandler) {
    embeddedButton.addClickHandler(clickHandler);
  }

  @Override
  public void addSearchButtonClickHandler(ClickHandler clickHandler) {
    searchButton.addClickHandler(clickHandler);
  }
  
  @Override
  public void addCurrentUserButtonClickHandler(ClickHandler clickHandler) {
    currentUserButton.addClickHandler(clickHandler);
  }

  @Override
  public void addAuthenticationServletButtonClickHandler(ClickHandler clickHandler) {
    authenticationServletButton.addClickHandler(clickHandler);
  }

  @Override
  public void addAuthorizationButtonClickHandler(final ClickHandler clickHandler) {
    authorizationButton.addClickHandler(new ClickHandler() {
      public void onClick(ClickEvent event) {
        authorizationButton.setEnabled(false);
        clickHandler.onClick(event);
      }
    });
  }
  
  @Override
  public void addExitButtonClickHandler(ClickHandler clickHandler) {
    exitButton.addClickHandler(clickHandler);
  }

  @Override
  public HandlerRegistration addGoToUrlButtonClickHandler(ClickHandler clickHandler) {
    return goToUrlButton.addClickHandler(clickHandler);
  }

  @Override
  public HandlerRegistration addTransactionButtonClickHandler(ClickHandler clickHandler) {
    return transactionButton.addClickHandler(clickHandler);
  }

  @Override
  public Credential getUserCredential(){
    String login = loginTextBox.getValue();
    String password = passwordTextBox.getValue();
    return JepRiaUtil.isEmpty(login) || JepRiaUtil.isEmpty(password) ? null :
            new Credential(login, password);
  }
  
  @Override
  public void showOrClearError(String errorText){
    errorLabel.setText(errorText);
  }
  
  @Override
  public void setUsername(String username){
    currentUserLabel.setText(username);
  }
  
  @Override
  public void toggleAuthorizationPanel(){
    int visibleWidgetIndex = authorizationPanel.getVisibleWidget(),
      authorizationPanelIndex = authorizationPanel.getWidgetIndex(loginAndPasswordPanel),
      currentUsernamePanelIndex = authorizationPanel.getWidgetIndex(currentUserPanel);
    
//    authorizationPanel.showWidget(currentWidgetIndex == authorizationPanelIndex ? currentUsernamePanelIndex : authorizationPanelIndex);
    authorizationPanel.showWidget(visibleWidgetIndex == authorizationPanelIndex ? currentUsernamePanelIndex : authorizationPanelIndex);
//    currentWidgetIndex = authorizationPanel.getVisibleWidget();
    authorizationButton.setEnabled(true);
  }
  
  int currentWidgetIndex;
  
  @Override
  public void showLoadingIndicator(){
    JepClientUtil.showLoadingPanel(LAYER_ID, customText.custom_loadingText_authorizationProcess(), null);
    currentWidgetIndex = authorizationPanel.getVisibleWidget();
    authorizationPanel.showWidget(authorizationPanel.getWidgetIndex(loadingIndicatorPanel));
  }
  
  @Override
  public void hideLoadingIndicator(){
    JepClientUtil.hideLoadingPanel(LAYER_ID);
    authorizationPanel.showWidget(currentWidgetIndex);
  }
  
  @Override
  public void clearCredential() {
    loginTextBox.setValue(null);
    passwordTextBox.setValue(null);
  }
  
  private DeckPanel createAuthorizationalPanel(){
    String labelWidth = 55 + Unit.PX.getType(),
        fieldWidth = 170 + Unit.PX.getType(),
          labelHeight = 14 + Unit.PX.getType(),
            logonButtonWidth = 115 + Unit.PX.getType(),
              imageSize = 32 + Unit.PX.getType();
    
    DeckPanel authorizationPanel = new DeckPanel();
    authorizationPanel.getElement().getStyle().setPaddingTop(50, Unit.PX);
    authorizationPanel.getElement().setId(AUTHORIZATION_PANEL_ID);
    //------
    loginAndPasswordPanel = new VerticalPanel();
    loginAndPasswordPanel.getElement().setId(LOGIN_PANEL_ID);
    errorLabel = new Label();
    errorLabel.setHeight(labelHeight);
    errorLabel.getElement().setId(ERROR_LABEL_ID);
    errorLabel.getElement().getStyle().setColor("red");
    errorLabel.getElement().getStyle().setFontSize(10, Unit.PX);
    loginAndPasswordPanel.add(errorLabel);
    
    HorizontalPanel loginPanel = new HorizontalPanel();
    loginPanel.setVerticalAlignment(HasVerticalAlignment.ALIGN_MIDDLE);
    HorizontalPanel passwordPanel = new HorizontalPanel();
    passwordPanel.setVerticalAlignment(HasVerticalAlignment.ALIGN_MIDDLE);
    
    Label loginLabel = new Label(customText.custom_loginLabel());
    
    loginLabel.setHorizontalAlignment(HasHorizontalAlignment.ALIGN_RIGHT);
    loginLabel.setWidth(labelWidth);
    loginPanel.add(loginLabel);
    loginTextBox = new TextBox();
    loginTextBox.getElement().setId(LOGIN_USERNAME_FIELD_ID);
    
    FocusHandler focusHandler = new FocusHandler() {
      @Override
      public void onFocus(FocusEvent event) {
        authorizationButton.setEnabled(true);
      }
    };
    loginTextBox.addFocusHandler(focusHandler);
    loginTextBox.setWidth(fieldWidth);
    loginPanel.add(loginTextBox);
    
    Label passwordLabel = new Label(customText.custom_passwordLabel());
    passwordLabel.setHorizontalAlignment(HasHorizontalAlignment.ALIGN_RIGHT);
    passwordLabel.setWidth(labelWidth);
    passwordPanel.add(passwordLabel);
    passwordTextBox = new PasswordTextBox();
    passwordTextBox.getElement().setId(LOGIN_PASSWORD_FIELD_ID);
    
    passwordTextBox.addFocusHandler(focusHandler);
    passwordTextBox.setWidth(fieldWidth);
    passwordPanel.add(passwordTextBox);
    
    loginAndPasswordPanel.add(loginPanel);
    loginAndPasswordPanel.add(passwordPanel);
    
    authorizationButton = new IdentifiedButton(
        customText.custom_authorizationButton(),
        LOGIN_BUTTON_ID);
    authorizationButton.setWidth(logonButtonWidth);
    loginAndPasswordPanel.add(authorizationButton);
    loginAndPasswordPanel.setCellHorizontalAlignment(authorizationButton, HasHorizontalAlignment.ALIGN_CENTER);
    
    authenticationServletButton = new IdentifiedButton(
        customText.custom_authenticationServletButton(),
        CustomAutomationConstant.CUSTOM_AUTHENTICATION_SERVLET_BUTTON_ID);
    authenticationServletButton.setWidth(logonButtonWidth);
    loginAndPasswordPanel.add(authenticationServletButton);
    loginAndPasswordPanel.setCellHorizontalAlignment(authenticationServletButton, HasHorizontalAlignment.ALIGN_CENTER);
    
    authorizationPanel.add(loginAndPasswordPanel);
    ///----
    currentUserPanel = new VerticalPanel();
    currentUserPanel.getElement().setId(LOGOUT_PANEL_ID);
    currentUserPanel.setVerticalAlignment(HasVerticalAlignment.ALIGN_MIDDLE);
    currentUserLabel = new Label();
    currentUserLabel.getElement().setId(LOGGED_IN_USER_ID);
    
    currentUserLabel.getElement().getStyle().setFontWeight(FontWeight.BOLD);
    currentUserPanel.add(currentUserLabel);
    exitButton = new IdentifiedButton(
        customText.custom_exitButton(),
        ENTRANCE_PANEL_LOGOUT_BUTTON_ID);
    
    currentUserPanel.add(exitButton);  
    authorizationPanel.add(currentUserPanel);
    
    loadingIndicatorPanel = new VerticalPanel();
    loadingIndicatorPanel.getElement().setId(LOADING_AUTHORIZATION_PANEL_ID);
//    loadingIndicatorPanel.setHeight("100px");
//    loadingIndicatorPanel.getElement().getStyle().setBackgroundImage("url(images/loading.gif)");
//    loadingIndicatorPanel.getElement().getStyle().setProperty("backgroundPosition", "center center");
//    loadingIndicatorPanel.getElement().getStyle().setProperty("backgroundRepeat", "no-repeat");
    authorizationPanel.add(loadingIndicatorPanel);
    
    authorizationPanel.showWidget(authorizationPanel.getWidgetIndex(loginAndPasswordPanel));
    
    return authorizationPanel;
  }

  @Override
  public String getUrlTextFieldValue() {
    return urlTextField.getValue();
  }

  @Override
  public boolean isUrlTextFieldValid() {
    return urlTextField.isValid();
  }

  @Override
  public void setUrlTextFieldAllowBlank(boolean allowBlank) {
    urlTextField.setAllowBlank(allowBlank);
  }
}