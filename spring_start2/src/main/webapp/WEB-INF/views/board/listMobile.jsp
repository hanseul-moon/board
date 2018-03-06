<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false" %>
<%@include file="../include/header.jsp"%>

<html>
<head>   
<link rel="stylesheet" href="https://unpkg.com/onsenui/css/onsenui.css">
<link rel="stylesheet" href="https://unpkg.com/onsenui/css/onsen-css-components.min.css">
<script src="https://unpkg.com/onsenui/js/onsenui.min.js"></script>
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
					location.href = '/board/registerMobile?page=${cri.page}&perPageNum=${cri.perPageNum}';	
			});
		});
		
	</script>
</head>
<body class="container" style="background:lightgray;" style="width:100%">
	<ons-page>
		<ons-toolbar>
			<div class="center">Board</div><br>
				<div id="toolbar-right" class="right">
          			<ons-toolbar-button>
           				<ons-icon id="newBtn" icon="ion-compose, material:"></ons-icon>
					</ons-toolbar-button>
       			</div>
		</ons-toolbar>		
				
		<li class="list-item list-item--tappable">
			<div class="list-item__center">&emsp;Title</div>
			<div class="list-item__right">
				<div class="list-item__label">Writer&emsp;&emsp;&emsp;&emsp;&emsp;Date&emsp;&emsp;</div>
			</div>
		</li>						
						
		<ons-list modifier="inset">
			<ul class="list">  
		   	  	<c:forEach items="${list}" var="boardVO">
		   	  		<a href='/board/readMobile?bno=${boardVO.bno}&page=${cri.page}&perPageNum=${cri.perPageNum}'>
		   	  		<li class="list-item list-item--tappable" id='list'>
						<div class="list-item__center">${boardVO.title}</div>				
						<div class="list-item__right">
							<div class="list-item__label">${boardVO.writer}&emsp;&emsp;
							<fmt:formatDate pattern="yyyy/MM/dd" value="${boardVO.regdate}"/></div>
						</div>
					</li>
		   	  		</a>
				</c:forEach>
			</ul>
		</ons-list>

		<!-- 페이지 표시 -->
		<div class="box-footer">
			<div class="text-center">
				<ul class="pagination pagination-sm">
					
					<c:if test="${pageMaker.prev}">
						<li><a href="listMobile${pageMaker.makeQuery(pageMaker.startPage - 1)}">&lt;</a></li>
					</c:if>
				
					<c:forEach begin="${pageMaker.startPage}" 
								 end="${pageMaker.endPage}" var="idx">	 
						<li
							<c:out value="${pageMaker.cri.page == idx? 'class=active':''}"/>>
							<a href="listMobile${pageMaker.makeQuery(idx)}">${idx}</a>
						</li>
					</c:forEach>
					
					<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
						<li><a href="listMobile${pageMaker.makeQuery(pageMaker.endPage + 1)}">&gt;</a></li>
					</c:if>
				</ul>
			</div>
		</div>
		</ons-page>

</body>
</html>
