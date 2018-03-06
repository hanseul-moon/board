<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false" %>
<%@include file="../include/header.jsp"%>

<html>
<head>   
	<script>
		// 완료 메세지 띄우기
		var result = '${msg}';
		
		if(result == 'SUCCESS'){			
			alert("처리가 완료되었습니다.");
			registCnt = Number(getCookie(ip())) + 1;
			setCookie(ip(), registCnt, 1);
			alert(getCookie(ip()));	
			
		}else if(result == 'MODIFY SUCCESS'){
			alert("처리가 완료되었습니다.");
			
		}else if(result == 'REMOVE SUCCESS'){
			alert("처리가 완료되었습니다.");;	
		}
		
		// 등록 버튼을 클릭 이벤트
		$(document).ready(
			function() {						
				$('#newBtn').on("click", function(evt) {
					location.href = '/board/register?page=${cri.page}&perPageNum=${cri.perPageNum}';	
			});
		});
		
	</script>
</head>
<body class="container" style="background:lightgray;">
	<section class="content">
	<!-- 본문 부분 -->
	<div class="row">
		<div class="col-md-12">
			<div class="box box-primary">
			
				<!-- 본문 게시글 제목  -->
				<div class="box-header">
					<h3 class="box-title">Board</h3>
				</div>
				<div align='right' style='margin-right:10px;'>
					<button id='newBtn' class="btn btn-default">New Board</button>
				</div>
				
				<!--  본문 게시글 내용 -->
				<div class="box-body">			
					<table class="table table-bordered">
						<tr>
							<th style="width: 50px">번호</th>
							<th>제목</th>
							<th style="width: 120px">작성자</th>
							<th style="width: 120px">등록일</th>
							<th style="width: 60px">조회</th>
						</tr>
						
						<c:forEach items="${list}" var="boardVO">
							<tr>
								<td>${boardVO.bno}</td>
								<td><a href='/board/read?bno=${boardVO.bno}&page=${cri.page}&perPageNum=${cri.perPageNum}'>${boardVO.title}</a></td>
								<td>${boardVO.writer}</td>
								<td><fmt:formatDate pattern="yyyy/MM/dd HH:mm" value="${boardVO.regdate}" /></td>
								<td><span class="badge bg-blue">${boardVO.viewcnt}</span></td>
							</tr> 
						</c:forEach>
					</table>
				</div>
			
				<!-- 페이지 표시 -->
				<div class="box-footer">
					<div class="text-center">
						<ul class="pagination">
							
							<c:if test="${pageMaker.prev}">
								<li><a href="listPage${pageMaker.makeQuery(pageMaker.startPage - 1)}">prev</a></li>
							</c:if>
						
							<c:forEach begin="${pageMaker.startPage}" 
										 end="${pageMaker.endPage}" var="idx">	 
								<li
									<c:out value="${pageMaker.cri.page == idx? 'class=active':''}"/>>
									<a href="listPage${pageMaker.makeQuery(idx)}">${idx}</a>
								</li>
							</c:forEach>
							
							<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
								<li><a href="listPage${pageMaker.makeQuery(pageMaker.endPage + 1)}">next</a></li>
							</c:if>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
	</section>
</body>
</html>
<%@include file="../include/footer.jsp"%>
