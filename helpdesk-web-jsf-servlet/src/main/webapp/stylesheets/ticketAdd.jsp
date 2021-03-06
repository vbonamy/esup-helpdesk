<%@include file="_include.jsp"%>
<%@ taglib prefix="fck" uri="http://www.fck-faces.org/fck-faces"%>
<e:page stringsVar="msgs" menuItem=""
	locale="#{sessionController.locale}" >
	<%@include file="_navigation.jsp"%>

	<h:panelGroup rendered="#{not ticketController.userCanAdd}" >
		<%@include file="_auth.jsp"%>
	</h:panelGroup>
	<e:form 
		freezeScreenOnSubmit="#{sessionController.freezeScreenOnSubmit}" 
		showSubmitPopupText="#{sessionController.showSubmitPopupText}" 
		showSubmitPopupImage="#{sessionController.showSubmitPopupImage}" 
		id="ticketActionForm" rendered="#{ticketController.userCanAdd}" enctype="multipart/form-data" >

		<e:panelGrid columns="2" width="100%" columnClasses="colLeft,colRight">
			<e:section value="#{msgs['TICKET_ACTION.TITLE.ADD']}" />
			<h:panelGroup>
				<h:panelGroup style="cursor: pointer" onclick="simulateLinkClick('ticketActionForm:cancelButton');" >
					<e:bold value="#{msgs['_.BUTTON.CANCEL']} " />
					<t:graphicImage value="/media/images/back.png"
						alt="#{msgs['_.BUTTON.CANCEL']}" 
						title="#{msgs['_.BUTTON.CANCEL']}" />
				</h:panelGroup>
				<e:commandButton style="display: none" id="cancelButton" action="#{controlPanelController.enter}"
					value="#{msgs['_.BUTTON.CANCEL']}" immediate="true" />
			</h:panelGroup>
		</e:panelGrid>

		<e:messages />

		<h:panelGroup rendered="#{ticketController.showAddHelp}">
			<e:paragraph value="#{msgs['TICKET_ACTION.TEXT.ADD.HELP.TOP.1']}" rendered="#{msgs['TICKET_ACTION.TEXT.ADD.HELP.TOP.1'] != ''}" />
			<e:li value="#{msgs['TICKET_ACTION.TEXT.ADD.HELP.STEP.1']}" />
			<e:li value="#{msgs['TICKET_ACTION.TEXT.ADD.HELP.STEP.2']}" />
			<e:paragraph value="#{msgs['TICKET_ACTION.TEXT.ADD.HELP.BOTTOM.1']}" rendered="#{msgs['TICKET_ACTION.TEXT.ADD.HELP.BOTTOM.1'] != ''}" />
			<e:paragraph value="#{msgs['TICKET_ACTION.TEXT.ADD.HELP.BOTTOM.2']}" rendered="#{msgs['TICKET_ACTION.TEXT.ADD.HELP.BOTTOM.2'] != ''}" />
			<e:selectBooleanCheckbox 
				value="#{ticketController.skipAddHelp}" 
				onchange="javascript:{simulateLinkClick('ticketActionForm:gotoChooseCategoryButton');}" />
			<e:text value="#{msgs['TICKET_ACTION.TEXT.ADD.HELP.SKIP']}" />
			<t:htmlTag value="br" />
			<h:panelGroup>
				<h:panelGroup style="cursor: pointer" onclick="simulateLinkClick('ticketActionForm:gotoChooseCategoryButton');" >
					<e:bold value="#{msgs['_.BUTTON.NEXT']} " />
					<t:graphicImage value="/media/images/next.png"
						alt="#{msgs['_.BUTTON.NEXT']}" 
						title="#{msgs['_.BUTTON.NEXT']}" />
				</h:panelGroup>
				<e:commandButton style="display: none" id="gotoChooseCategoryButton" 
					value="#{msgs['_.BUTTON.NEXT']}" 
					action="continue" >
					<t:updateActionListener value="false" property="#{ticketController.showAddHelp}" />
				</e:commandButton>
			</h:panelGroup>
		</h:panelGroup>

		<h:panelGroup rendered="#{not ticketController.showAddHelp and ticketController.addTargetCategory == null}">
			<h:panelGroup
				rendered="#{ticketController.addTree == null}">
				<e:paragraph value="#{msgs['TICKET_ACTION.TEXT.ADD.NO_TARGET']}" />
			</h:panelGroup>
			<h:panelGroup
				rendered="#{ticketController.addTree != null}">
				<t:tree2 id="tree" value="#{ticketController.addTree}"
					var="node" varNodeToggler="t" clientSideToggle="true"
					showRootNode="true">
					<f:facet name="root">
						<h:panelGroup >
							<t:graphicImage value="/media/images/root-opened.png" rendered="#{t.nodeExpanded}" />
							<t:graphicImage value="/media/images/root-closed.png" rendered="#{!t.nodeExpanded}" />
							<e:italic value=" #{msgs['TICKET_ACTION.TEXT.ADD.ROOT_LABEL']}" />
						</h:panelGroup>
					</f:facet>
					<f:facet name="department">
						<h:panelGroup>
							<t:graphicImage value="#{departmentIconUrlProvider[node.department]}" />
							<e:text value=" #{msgs['TICKET_ACTION.TEXT.ADD.DEPARTMENT_LABEL']}">
								<f:param value="#{node.department.label}" />
								<f:param value="#{node.department.xlabel}" />
							</e:text>
						</h:panelGroup>
					</f:facet>
					<f:facet name="category">
						<h:panelGroup>
							<h:panelGroup style="cursor: pointer" onclick="simulateLinkClick('ticketActionForm:tree:#{node.identifier}:#{node.category.addNewTickets or node.leaf ? 'chooseCategoryButton' : 't2'}');" >
								<t:graphicImage value="#{categoryIconUrlProvider[node.category]}" />
								<e:bold value=" #{msgs['TICKET_ACTION.TEXT.ADD.CATEGORY_LABEL']}" >
									<f:param value="#{node.description}" />
								</e:bold>
							</h:panelGroup>
							<e:commandButton id="chooseCategoryButton" style="display: none" value="->" 
								action="#{ticketController.addChooseCategory}" 
								rendered="#{node.category.addNewTickets or node.leaf}" >
								<t:updateActionListener value="#{node.department}"
									property="#{ticketController.addTargetDepartment}" />
								<t:updateActionListener value="#{node.category}"
									property="#{ticketController.addTargetCategory}" />
							</e:commandButton>
						</h:panelGroup>
					</f:facet>
				</t:tree2>
			</h:panelGroup>
		</h:panelGroup>
		
		<h:panelGroup rendered="#{not ticketController.showAddHelp and ticketController.addTargetCategory != null}">
			<e:panelGrid columns="2" columnClasses="colLeftNowrap,colLeftMax" width="100%" >
				<h:panelGroup>
					<e:panelGrid columns="2" columnClasses="colLeftNowrap,colLeftNowrap" >
						<e:text value="#{msgs['TICKET_ACTION.TEXT.ADD.TARGET_CATEGORY']} " />
						<h:panelGroup>
							<h:panelGroup style="cursor: pointer" onclick="simulateLinkClick('ticketActionForm:changeCategoryButton');" >
								<t:graphicImage value="#{categoryIconUrlProvider[ticketController.addTargetCategory]}" />
								<e:bold value=" #{ticketController.addTargetDepartment.label} - #{ticketController.addTargetCategory.label}" />
							</h:panelGroup>
							<e:italic value=" #{msgs['TICKET_ACTION.TEXT.ADD.TARGET_CATEGORY_HELP']} " />
							<e:commandButton id="changeCategoryButton" style="display: none" 
								value="#{msgs['TICKET_ACTION.BUTTON.CHANGE_TARGET_CATEGORY']}"
								action="#{ticketController.add}" />	
						</h:panelGroup>
						<e:text value="#{msgs['TICKET_ACTION.TEXT.ADD.LABEL_PROMPT']} " />
						<e:inputText id="label" 
							value="#{ticketController.ticketLabel}" size="50"
							onkeypress="if (event.keyCode == 13) { focusFckEditor('ticketActionForm:actionMessage'); return false;}" />
					</e:panelGrid>
					<h:panelGroup>
					</h:panelGroup>
				</h:panelGroup>
				<h:panelGroup>
					<h:panelGroup rendered="#{ticketController.addFaqTree != null}" >
						<e:subSection value="#{msgs['TICKET_ACTION.TEXT.ADD.FAQ_LINKS']}" />
						<t:tree2 id="faqTree" value="#{ticketController.addFaqTree}"
							var="node" varNodeToggler="t" clientSideToggle="true" 
							showRootNode="true" >
							<f:facet name="root">
								<h:panelGroup>
									<h:panelGroup style="white-space: nowrap" >
										<t:graphicImage value="/media/images/root-opened.png" rendered="#{t.nodeExpanded}" />
										<t:graphicImage value="/media/images/root-closed.png" rendered="#{!t.nodeExpanded}" />
										<e:italic value=" #{msgs['TICKET_ACTION.TEXT.ADD.FAQ_LINKS_HELP']}" />
									</h:panelGroup>
								</h:panelGroup>
							</f:facet>
							<f:facet name="faq">
								<h:panelGroup>
									<h:panelGroup style="cursor: pointer; white-space: nowrap" 
										onclick="showHideElement('ticketActionForm:faqTree:#{node.identifier}:faqContent');return false;">
				                        <t:graphicImage value="/media/images/faq.png" rendered="#{node.leaf}" />
				                        <t:graphicImage value="/media/images/faq-container-#{t.nodeExpanded?'opened':'closed'}.png" rendered="#{not node.leaf}" />
										<e:bold value=" #{node.faq.label} " />
										<t:graphicImage value="/media/images/show.png" />
									</h:panelGroup>
									<e:text id="faqContent" escape="false" 
										style="display: none" value="#{node.faq.content}" />
								</h:panelGroup>
							</f:facet>
						</t:tree2>
						<t:htmlTag value="hr" />
					</h:panelGroup>
					<e:panelGrid columns="1" columnClasses="colRightMaxNowrap" width="100%" >
						<h:panelGroup style="cursor: pointer" 
							onclick="javascript:{showHideElement('ticketActionForm:advanced');showHideElement('ticketActionForm:showAdvanced');showHideElement('ticketActionForm:hideAdvanced');return false;}" >
							<h:panelGroup id="showAdvanced" >
								<e:bold value="#{msgs['TICKET_ACTION.TEXT.ADD.SHOW_ADVANCED']} " />
								<t:graphicImage value="/media/images/show.png" />
							</h:panelGroup>
							<h:panelGroup id="hideAdvanced" style="display: none" >
								<e:bold value="#{msgs['TICKET_ACTION.TEXT.ADD.HIDE_ADVANCED']} " />
								<t:graphicImage value="/media/images/hide.png" />
							</h:panelGroup>
						</h:panelGroup>
					</e:panelGrid>
					<e:panelGrid columns="2" columnClasses="colLeftNowrap,colLeftNowrap" id="advanced" style="display: none" >
						<e:outputLabel for="scope" value="#{msgs['TICKET_ACTION.TEXT.ADD.SCOPE_PROMPT']} " />
						<h:panelGroup>
							<e:selectOneMenu id="scope" 
								value="#{ticketController.ticketScope}" >
								<f:selectItems value="#{ticketController.ticketScopeItems}" />
							</e:selectOneMenu>
							<e:italic value=" #{msgs['TICKET_ACTION.TEXT.ADD.SCOPE_HELP']}" >
								<f:param value="#{msgs[ticketScopeI18nKeyProvider[ticketController.addTargetCategory.effectiveDefaultTicketScope]]}" />
							</e:italic>
						</h:panelGroup>
						<e:outputLabel 
							for="priority" 
							value="#{msgs['TICKET_ACTION.TEXT.ADD.PRIORITY_PROMPT']} " />
						<h:panelGroup>
							<e:selectOneMenu id="priority" 
								value="#{ticketController.ticketPriority}" >
								<f:selectItems value="#{ticketController.ticketPriorityItems}" />
							</e:selectOneMenu>
							<e:italic value=" #{msgs['TICKET_ACTION.TEXT.ADD.PRIORITY_HELP']}" >
								<f:param value="#{msgs[priorityI18nKeyProvider[ticketController.addTargetCategory.effectiveDefaultTicketPriority]]}" />
							</e:italic>
						</h:panelGroup>
						<e:outputLabel 
							for="origin" 
							value="#{msgs['TICKET_ACTION.TEXT.ADD.ORIGIN_PROMPT']} " />
						<h:panelGroup id="origin">
							<e:selectOneMenu  
								value="#{ticketController.ticketOrigin}" 
								rendered="#{ticketController.userCanSetOrigin}" >
								<f:selectItems value="#{ticketController.originItems}" />
							</e:selectOneMenu>
							<e:text value="#{msgs[originI18nKeyProvider[ticketController.ticketOrigin]]}" 
								rendered="#{not ticketController.userCanSetOrigin}" />
						</h:panelGroup>
						<e:outputLabel 
							for="owner" 
							value="#{msgs['TICKET_ACTION.TEXT.ADD.OWNER_PROMPT']} "
							rendered="#{ticketController.userCanSetOwner}" />
						<h:panelGroup 
							rendered="#{ticketController.userCanSetOwner}" >
							<e:inputText id="owner" value="#{ticketController.ldapUid}" size="50" 
								onkeypress="if (event.keyCode == 13) { return false;}" />
							<h:panelGroup rendered="#{domainService.useLdap}" >
								<h:panelGroup style="cursor: pointer" onclick="simulateLinkClick('ticketActionForm:ldapSearchButton');" >
									<e:bold value=" #{msgs['_.BUTTON.LDAP']} " />
									<t:graphicImage value="/media/images/search.png"
										alt="#{msgs['_.BUTTON.LDAP']}" 
										title="#{msgs['_.BUTTON.LDAP']}" />
								</h:panelGroup>
								<e:commandButton style="display:none"
									id="ldapSearchButton" action="#{ldapSearchController.firstSearch}"
									value="#{msgs['_.BUTTON.LDAP']}" >
									<t:updateActionListener value="#{ticketController}"
										property="#{ldapSearchController.caller}" />
									<t:updateActionListener value="userSelectedToTicketAdd"
										property="#{ldapSearchController.successResult}" />
									<t:updateActionListener value="cancelToTicketAdd"
										property="#{ldapSearchController.cancelResult}" />
								</e:commandButton>
							</h:panelGroup>
							<t:htmlTag value="br" />
							<e:italic value=" #{domainService.useLdap ? msgs['TICKET_ACTION.TEXT.ADD.OWNER_HELP_LDAP'] : msgs['TICKET_ACTION.TEXT.ADD.OWNER_HELP_NO_LDAP']}" />
						</h:panelGroup>
					</e:panelGrid>
				</h:panelGroup>
			</e:panelGrid>
			<t:htmlTag value="hr" />
			<e:panelGrid columns="2" width="100%" columnClasses="colLeftMax,colRightNowrap">
				<h:panelGroup>
					<e:paragraph value="#{msgs['TICKET_ACTION.TEXT.ADD.TOP']}" 
						rendered="#{ticketController.addFaqTree == null}" />
					<e:paragraph value="#{msgs['TICKET_ACTION.TEXT.ADD.TOP_FAQ_LINKS']}" 
						rendered="#{ticketController.addFaqTree != null}" />
				</h:panelGroup>
				<%@include file="_ticketActionUpload.jsp"%>
			</e:panelGrid>
			<fck:editor  
				id="actionMessage" 
				value="#{ticketController.actionMessage}" 
				toolbarSet="actionMessage" />
			<e:panelGrid columns="2" width="100%" columnClasses="colLeft,colRight" >
				<h:panelGroup id="mainButtonGroup" style="position: absolute; white-space: nowrap;" >
					<h:panelGroup style="cursor: pointer" onclick="simulateLinkClick('ticketActionForm:addButton');" >
						<e:bold value="#{msgs['TICKET_ACTION.BUTTON.ADD']} " />
						<t:graphicImage value="/media/images/save.png" />
					</h:panelGroup>
					<e:commandButton id="addButton" style="display: none" 
						value="#{msgs['TICKET_ACTION.BUTTON.ADD']}"
						action="#{ticketController.doAdd}" />	
				</h:panelGroup>
				<h:panelGroup>
					<%@include file="_ticketActionPreviewButton.jsp"%>
				</h:panelGroup>
			</e:panelGrid>
			<%@include file="_ticketActionPreview.jsp"%>
		</h:panelGroup>

	</e:form>
	<t:aliasBean alias="#{controller}" value="#{ticketController}" >
		<%@include file="_signature.jsp"%>
	</t:aliasBean>
	<%@include file="_ticketActionJavascript.jsp" %>
</e:page>

