<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false" %>
<%@include file="../include/header.jsp"%>

<html>
<head>   
	<script>
		var result = '${msg}';
		
		if(result == 'SUCCESS'){		
			alert("처리가 완료되었습니다.");
			
		}else if(result == 'MODIFY SUCCESS'){
			alert("처리가 완료되었습니다.");
			
		}else if(result == 'REMOVE SUCCESS'){
			alert("처리가 완료되었습니다.");
		}
		
	</script>
</head>
<body>
	<table class="table table-bordered">
		<tr>
			<th style="width: 10px">번호</th>
			<th>제목</th>
			<th>작성자</th>
			<th>등록일</th>
			<th style="width:40px">조회수</th>
		</tr>
		
		<c:forEach items="${list}" var="boardVO">
			<tr>
				<td>${boardVO.bno}</td>
				<td><a href='/my/board/read?bno=${boardVO.bno}'>${boardVO.title}</a></td>
				<td>${boardVO.writer}</td>
				<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm" 
				value="${boardVO.regdate}" /></td>
				<td><span class="badge bg-red">${boardVO.viewcnt}</span></td>
			</tr>
		</c:forEach>
	</table>
</body>
</html>
<%@include file="../include/footer.jsp"%>
