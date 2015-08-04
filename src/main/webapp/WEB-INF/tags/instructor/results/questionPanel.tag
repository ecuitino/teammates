<%@ tag description="instructorFeedbackResults - by question" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ tag import="teammates.common.util.Const" %>

<%@ taglib tagdir="/WEB-INF/tags/instructor/results" prefix="results" %>

<%@ attribute name="isShowingAll" type="java.lang.Boolean" required="true" %>
<%@ attribute name="questionIndex" type="java.lang.Integer"%>
<%@ attribute name="isPanelsCollapsed" type="java.lang.Boolean" required="true" %>
<%@ attribute name="questionPanel" type="teammates.ui.template.InstructorFeedbackResultsQuestionTable" required="true" %>


<div class="panel ${questionPanel.panelClass}">
    <div class="panel-heading${isShowingAll ? '' : ' ajax_submit'}">
        <c:if test="${questionPanel.collapsible}">
            <form style="display:none;" id="seeMore-${questionPanel.question.questionNumber}" class="seeMoreForm-${questionPanel.question.questionNumber}" action="<%=Const.ActionURIs.INSTRUCTOR_FEEDBACK_RESULTS_PAGE%>">
                <input type="hidden" name="<%=Const.ParamsNames.COURSE_ID%>" value="${questionPanel.courseId}">
                <input type="hidden" name="<%=Const.ParamsNames.FEEDBACK_SESSION_NAME%>" value="${questionPanel.feedbackSessionName}">
                <input type="hidden" name="<%=Const.ParamsNames.USER_ID%>" value="${data.account.googleId}">
                <input type="hidden" name="<%=Const.ParamsNames.FEEDBACK_RESULTS_GROUPBYTEAM%>" value="${data.groupByTeam}">
                <input type="hidden" name="<%=Const.ParamsNames.FEEDBACK_RESULTS_SORTTYPE%>" value="${data.sortType}">
                <input type="hidden" name="<%=Const.ParamsNames.FEEDBACK_RESULTS_SHOWSTATS%>" value="on" id="showStats-${questionPanel.question.questionNumber}">
                <input type="hidden" name="<%=Const.ParamsNames.FEEDBACK_QUESTION_NUMBER%>" value="${questionPanel.question.questionNumber}">
            </form>
            <div class='display-icon pull-right'>
                <span class="glyphicon ${ isShowingAll && !isPanelsCollapsed ? 'glyphicon-chevron-up' : 'glyphicon-chevron-down'} pull-right"></span>
            </div>
            
        </c:if>
        <c:choose>
            <c:when test="${questionPanel.boldQuestionNumber}">
                <strong>Question ${questionPanel.question.questionNumber}: </strong>
                <div class="inline panel-heading-text">
                    <!--Note: When an element has class text-preserve-space, do not insert and HTML spaces-->
                    <span class="text-preserve-space">${questionPanel.questionText}${questionPanel.additionalInfoText}</span>
                </div>
            </c:when>
            <c:otherwise>
                Question ${questionPanel.question.questionNumber}: 
                <!--Note: When an element has class text-preserve-space, do not insert and HTML spaces-->
                <span class="text-preserve-space">${questionPanel.questionText}${questionPanel.additionalInfoText}</span>
            </c:otherwise>
        </c:choose>
    </div>
    <div <c:if test="${questionPanel.collapsible}">class="${questionPanel.responsesBodyClass}"</c:if>>
        <div class="panel-body padding-0" <c:if test="${questionIndex != null}">id="questionBody-${questionIndex}"</c:if>>
            
            <c:if test="${!questionPanel.questionHasResponses}">
                <div class="col-sm-12">
                    <i class="text-muted">There are no responses for this question.</i>
                </div>
            </c:if>
            
            <c:if test="${isShowingAll && questionPanel.questionHasResponses}">
                <div class="resultStatistics">
                    ${questionPanel.questionStatisticsTable}
                </div>
                <c:if test="${questionPanel.showResponseRows}">
                    <div class="table-responsive">
                        <table class="table table-striped table-bordered dataTable margin-0">
                            <thead class="background-color-medium-gray text-color-gray font-weight-normal">
                                <tr>
                                    <c:forEach items="${questionPanel.columns}" var="thElement">
                                        <th ${thElement.attributesToString}> 
                                            ${thElement.content}
                                            <c:if test="${questionPanel.isColumnSortable[thElement.content]}"><span class="icon-sort unsorted"></span></c:if>
                                        </th>
                                    </c:forEach>
                                </tr>
                            <thead>
                            <tbody>
                                <c:forEach items="${questionPanel.responses}" var="responseRow">
                                    <results:responseRow responseRow="${responseRow}"/>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:if>
            </c:if>
            
        </div>
    </div>
</div>