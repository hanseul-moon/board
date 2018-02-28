<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page session="false"%>
<%@include file="../include/header.jsp"%>
<head>
<script type="text/javascript" src="http://jsgetip.appspot.com"></script>	<!-- ip 가져오는 import -->
</head>
<body class="container" style="background:lightgray;">
<!-- Main content -->
<section class="content">
<script>

	function setCookie(cookie_name, value, days) {
		  var exdate = new Date();
		  exdate.setDate(exdate.getDate() + days);
		  // 설정 일수만큼 현재시간에 만료값으로 지정
	
		  var cookie_value = escape(value) + ((days == null) ? '' : ';    expires=' + exdate.toUTCString());
		  document.cookie = cookie_name + '=' + cookie_value;
	}
	
	 function getCookie(cookie_name) {
		  var x, y;
		  var val = document.cookie.split(';');
	
		  for (var i = 0; i < val.length; i++) {
			  x = val[i].substr(0, val[i].indexOf('='));
			  y = val[i].substr(val[i].indexOf('=') + 1);
			  x = x.replace(/^\s+|\s+$/g, ''); // 앞과 뒤의 공백 제거하기
			  if (x == cookie_name) {
			    return unescape(y); // unescape로 디코딩 후 값 리턴
			  }
		  }
	} 
	
	var ipCheck = true;
	var registCnt = 0;
	
	function registCk(){
		if(getCookie(ip()) == undefined){
			setCookie(ip(), 0, 1);
			ipCheck = true;
			
		}else{		
			registCnt = Number(getCookie(ip()));
			if(registCnt >= 3){
				ipCheck = false;
				location.href='list';							
			}
		} 
	}
</script>
	<div class="row">
		<!-- left column -->
		<div class="col-md-12">
			<!-- general form elements -->
			<div class='box'>
				<div class="box-header with-border">
					<h3 class="box-title">게시판</h3>
				</div>
				<div class='box-body'>

					<select name="searchType">
						<option value="n"
							<c:out value="${cri.searchType == null?'selected':''}"/>>
							---</option>
						<option value="t"
							<c:out value="${cri.searchType eq 't'?'selected':''}"/>>
							Title</option>
						<option value="c"
							<c:out value="${cri.searchType eq 'c'?'selected':''}"/>>
							Content</option>
						<option value="w"
							<c:out value="${cri.searchType eq 'w'?'selected':''}"/>>
							Writer</option>
						<option value="tc"
							<c:out value="${cri.searchType eq 'tc'?'selected':''}"/>>
							Title OR Content</option>
						<option value="cw"
							<c:out value="${cri.searchType eq 'cw'?'selected':''}"/>>
							Content OR Writer</option>
						<option value="tcw"
							<c:out value="${cri.searchType eq 'tcw'?'selected':''}"/>>
							Title OR Content OR Writer</option>
					</select> <input type="text" name='keyword' id="keywordInput"
						value='${cri.keyword }'>
					<button id='searchBtn'>검색</button>
					<button id='newBtn' onclick='registCk();'>새 글 쓰기</button>

				</div>
			</div>


			<div class="box">
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
								<td><a
									href='/sboard/readPage${pageMaker.makeSearch(pageMaker.cri.page) }&bno=${boardVO.bno}'>
										${boardVO.title} </a></td>
								<td>${boardVO.writer}</td>
								<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm"
										value="${boardVO.regdate}" /></td>
								<c:if test="${boardVO.viewcnt > 9999}">
								<td><span class="badge bg-red">9999+</span></td>
								</c:if>
								<c:if test="${boardVO.viewcnt <= 9999}">
								<td><span class="badge bg-red">${boardVO.viewcnt }</span></td>
								</c:if>
							</tr>

						</c:forEach>

					</table>
				</div>
				<!-- /.box-body -->


				<div class="box-footer">

					<div class="text-center">
						<ul class="pagination">

							<c:if test="${pageMaker.prev}">
								<li><a
									href="list${pageMaker.makeSearch(pageMaker.startPage - 1) }">&laquo;</a></li>
							</c:if>

							<c:forEach begin="${pageMaker.startPage }"
								end="${pageMaker.endPage }" var="idx">
								<li
									<c:out value="${pageMaker.cri.page == idx?'class =active':''}"/>>
									<a href="list${pageMaker.makeSearch(idx)}">${idx}</a>
								</li>
							</c:forEach>

							<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
								<li><a
									href="list${pageMaker.makeSearch(pageMaker.endPage +1) }">&raquo;</a></li>
							</c:if>

						</ul>
					</div>

				</div>
				<!-- /.box-footer-->
			</div>
		</div>
		<!--/.col (left) -->

	</div>
	<!-- /.row -->
<!-- /.content -->

<script>
	var result = '${msg}';

	if (result == 'SUCCESS') {
	
		alert("처리가 완료되었습니다.");
		registCnt = Number(getCookie(ip())) + 1;
		setCookie(ip(), registCnt, 1);
		alert(getCookie(ip()));		
	}
</script>

<script>
	$(document).ready(
			function() {

				$('#searchBtn').on(
						"click",
						function(event) {

							self.location = "list"
									+ '${pageMaker.makeQuery(1)}'
									+ "&searchType="
									+ $("select option:selected").val()
									+ "&keyword=" + $('#keywordInput').val();

						});

				$('#newBtn').on("click", function(evt) {

					self.location = "register";

				});

			});
</script>


</section>
</body>
</html>