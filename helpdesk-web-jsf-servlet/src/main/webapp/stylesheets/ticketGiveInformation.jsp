<%@include file="_include.jsp"%>
<%@ taglib prefix="fck" uri="http://www.fck-faces.org/fck-faces"%>
<e:page stringsVar="msgs" menuItem=""
	locale="#{sessionController.locale}"
	authorized="#{ticketController.userCanGiveInformation}">
	<%@include file="_navigation.jsp"%>

	<e:form 
		freezeScreenOnSubmit="#{sessionController.freezeScreenOnSubmit}" 
		showSubmitPopupText="#{sessionController.showSubmitPopupText}" 
		showSubmitPopupImage="#{sessionController.showSubmitPopupImage}" 
		id="ticketActionForm" enctype="multipart/form-data" >
		<e:panelGrid columns="2" width="100%" columnClasses="colLeft,colRight">
			<e:section value="#{msgs['TICKET_ACTION.TITLE.GIVE_INFORMATION']}" >
				<f:param value="#{ticketController.ticket.id}" />
			</e:section>
			<%@include file="_ticketActionCancel.jsp"%>
		</e:panelGrid>
		<e:messages />
		<e:panelGrid columns="3" width="100%" columnClasses="colLeftMax,colRightNowrap,colRightNowrap">
			<e:paragraph value="#{msgs['TICKET_ACTION.TEXT.GIVE_INFORMATION']}" />
			<%@include file="_ticketActionResponses.jsp"%>
			<%@include file="_ticketActionUpload.jsp"%>
		</e:panelGrid>
		<fck:editor  
			id="actionMessage" 
			value="#{ticketController.actionMessage}" 
			toolbarSet="actionMessage" />
		<e:panelGrid columns="2" columnClasses="colLeftNowrap,colRightMaxNowrap" width="100%" >
			<h:panelGroup id="mainButtonGroup" style="position: absolute; white-space: nowrap;" >
				<h:panelGroup style="cursor: pointer" onclick="simulateLinkClick('ticketActionForm:actionButton');" >
					<e:bold value="#{msgs['TICKET_ACTION.BUTTON.GIVE_INFORMATION']} " />
					<t:graphicImage value="/media/images/add.png" />
				</h:panelGroup>
				<e:commandButton 
					id="actionButton" style="display: none"
					value="#{msgs['TICKET_ACTION.BUTTON.GIVE_INFORMATION']}"
					action="#{ticketController.doGiveInformation}" />
			</h:panelGroup>
			<h:panelGroup>
				<%@include file="_ticketActionScope.jsp"%>
				<h:panelGroup rendered="#{ticketController.userCanSetNoAlert}" >
					<e:selectBooleanCheckbox id="noAlert"
						value="#{ticketController.noAlert}" />
					<e:text value=" #{msgs['TICKET_ACTION.TEXT.NO_ALERT']} " />
				</h:panelGroup>
				<%@include file="_ticketActionPreviewButton.jsp"%>
			</h:panelGroup>
		</e:panelGrid>
		<%@include file="_ticketActionPreview.jsp"%>
		<%@include file="_ticketActionHistory.jsp"%>
	</e:form>
	<t:aliasBean alias="#{controller}" value="#{null}" >
		<%@include file="_signature.jsp"%>
	</t:aliasBean>
	<%@include file="_ticketActionJavascript.jsp"%>
</e:page>

