<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="index" value="0"  /> 
[
<c:forEach items="${reply}" var="r" >
   <c:if test="${index!=0}">,</c:if>
   <c:set var="index" value="${index+1}"  /> 
   {"content":"${r.content}","writer":"${r.writer}"}
</c:forEach>
]