<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false" %>
<%@include file="../include/header.jsp"%>
<html>
<head>
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
</head>
<body class="container" style="background:lightgray;">
<section class="content">

	<!-- 본문 부분 -->
	<div class="row">
		<div class="col-md-12">
			<div class="box box-primary">
			
				<!-- 본문 게시글 제목  -->
				<div class="box-header">
					<h3 class="box-title">Read Board</h3>
				</div>
				
				<form role="form" action="modifyPage" method="post">
					<input type='hidden' name='bno' value="${boardVO.bno}"> 
					<input type='hidden' name='page' value="${cri.page}"> 
					<input type='hidden' name='perPageNum' value="${cri.perPageNum}">
				</form>
				
				<!-- 본문 게시글 내용 -->
				<div class="box-body">
					<div class="form-group">
						<label for="exampleInputEmail1">Title</label> 
						<input type="text" name='title' class="form-control" value="${boardVO.title}" readonly="readonly">
					</div>
					<div class="form-group">
						<label for="exampleInputPassword1">Content</label>
						<textarea class="form-control" name="content" rows="3" readonly="readonly">${boardVO.content}</textarea>
					</div>
					<div class="form-group">
						<label for="exampleInputEmail1">Writer</label> 
						<input type="text" name="writer" class="form-control" value="${boardVO.writer}" readonly="readonly">
					</div>
				</div>
				
				<!-- 본문 게시글 버튼 -->
				<div class="box-footer">
					<button type="submit" class="btn btn-default" id="modifyBtn">Modify</button>
					<button type="submit" class="btn btn-default" id="removeBtn">Delete</button>
					<button type="submit" class="btn btn-default" id="goListBtn">List</button>
				</div>
			</div>
		</div>
	</div>

	<!-- 댓글 부분 -->
	<div class="row">
		<div class="col-md-12">
			<div class="box">
			
				<!-- 댓글 타이틀 -->
				<div class="box-header">
					<h3 class="box-title">New Reply Register</h3>
				</div>
				
				<!-- 댓글 내용 -->
				<div class="box-body">
					<label for="exampleInputEmail1">Replyer</label> 
					<input class="form-control" type="text"id="newReplyWriter"> 
					<label for="exampleInputEmail1">Writer</label> 
					<input class="form-control" type="text"id="newReplyText">

				</div>
				
				<!-- 해당 댓글 버튼 -->
				<div class="box-footer">
					<button type="button" class="btn btn-default" id="replyAddBtn">New Reply</button>
				</div>
			</div>

			<!-- 지난 댓글 목록 -->
			<ul class="timeline">
				<li class="time-label" id="repliesDiv"><span class="bg-blue">Reply List </span></li>
			</ul>

			<div class='text-center'>
				<ul id="pagination" class="pagination pagination-sm no-margin "></ul>
			</div>
		</div>
	</div>

	<!-- 댓글 수정/삭제 Modal창 부분 -->
	<div id="modifyModal" class="modal modal-primary fade" role="dialog">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title"></h4>
				</div>
				
				<!-- 댓글 내용 -->
				<div class="modal-body" data-rno>
					<p><input type="text" id="replytext" class="form-control"></p>
				</div>
				
				<!-- 댓글 버튼 -->
				<div class="modal-footer">
					<button type="button" class="btn btn-default" id="replyModBtn">Modify</button>
					<button type="button" class="btn btn-default" id="replyDelBtn">Delete</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
				</div>
			</div>
		</div>
	</div>      
</section>

<script id="template" type="text/x-handlebars-template">
{{#each .}}
<li class="replyLi" data-rno={{rno}}>
<i class="fa fa-comments bg-blue"></i>
 <div class="timeline-item" >
  <span class="time">
    <i class="fa fa-clock-o"></i>{{prettifyDate regdate}}
  </span>
  <h3 class="timeline-header"><strong>{{rno}}</strong> -{{replyer}}</h3>
  <div class="timeline-body">{{replytext}} </div>
    <div class="timeline-footer">
     <a class="btn btn-primary btn-xs" 
	    data-toggle="modal" data-target="#modifyModal">Modify</a>
    </div>
  </div>			
</li>
{{/each}}
</script>

<script>
	Handlebars.registerHelper("prettifyDate", function(timeValue) {
		var dateObj = new Date(timeValue);
		var year = dateObj.getFullYear();
		var month = dateObj.getMonth() + 1;
		var date = dateObj.getDate();
		return year + "/" + month + "/" + date;
	});

	var printData = function(replyArr, target, templateObject) {

		var template = Handlebars.compile(templateObject.html());

		var html = template(replyArr);
		$(".replyLi").remove();
		target.after(html);

	}

	var bno = ${boardVO.bno};	//게시물 번호
	
	var replyPage = 1;			//초기 댓글 페이지 번호

	// 특정 게시물의 페이징 처리를 위한 함수
	function getPage(pageInfo) {	//pageInfo : 댓글페이지 번호

		$.getJSON(pageInfo, function(data) {
			printData(data.list, $("#repliesDiv"), $('#template'));
			printPaging(data.pageMaker, $(".pagination"));

			$("#modifyModal").modal('hide');
		});
	}

	var printPaging = function(pageMaker, target) {

		var str = "";

		if (pageMaker.prev) {
			str += "<li><a href='" + (pageMaker.startPage - 1)
					+ "'> << </a></li>";
		}

		for (var i = pageMaker.startPage, len = pageMaker.endPage; i <= len; i++) {
			var strClass = pageMaker.cri.page == i ? 'class=active' : '';
			str += "<li "+strClass+"><a href='"+i+"'>" + i + "</a></li>";
		}

		if (pageMaker.next) {
			str += "<li><a href='" + (pageMaker.endPage + 1)
					+ "'> >> </a></li>";
		}

		target.html(str);
	};

	// 댓글 목록의 size 체크, 댓글이 1개 이상이면 1페이지 댓글 목록을 가져온다.
	$("#repliesDiv").on("click", function() {

		if ($(".timeline li").size() > 1) {
			return;
		}
		getPage("/replies/" + bno + "/1"); 

	});
	

	// 댓글 페이지 번호 클릭 이벤트
	$(".pagination").on("click", "li a", function(event){
		
		event.preventDefault();
		
		replyPage = $(this).attr("href");
		
		getPage("/replies/"+bno+"/"+replyPage);
		
	});
	
	
	// 댓글 등록 버튼 클릭이벤트
	$("#replyAddBtn").on("click",function(){
		 
		 var replyerObj = $("#newReplyWriter");
		 var replytextObj = $("#newReplyText");
		 var replyer = replyerObj.val();
		 var replytext = replytextObj.val();
		
		  
		  $.ajax({
				type:'post',
				url:'/replies/',
				headers: { 
				      "Content-Type": "application/json",
				      "X-HTTP-Method-Override": "POST" },
				dataType:'text',
				data: JSON.stringify({bno:bno, replyer:replyer, replytext:replytext}),
				success:function(result){
					console.log("result: " + result);
					if(result == 'SUCCESS'){
						alert("등록 되었습니다.");
						replyPage = 1;
						getPage("/replies/"+bno+"/"+replyPage );
						replyerObj.val("");
						replytextObj.val("");
					}
			}});
	});

	
	// 댓글 내의 버튼 클릭했을 때 modal창 띄우기
	$(".timeline").on("click", ".replyLi", function(event){
		
		var reply = $(this);
		
		$("#replytext").val(reply.find('.timeline-body').text());
		$(".modal-title").html(reply.attr("data-rno"));
		
	});
	
	
	// 댓글 수정 버튼 클릭이벤트
	$("#replyModBtn").on("click",function(){
		  
		  var rno = $(".modal-title").html();
		  var replytext = $("#replytext").val();
		  
		  $.ajax({
				type:'put',
				url:'/replies/'+rno,
				headers: { 
				      "Content-Type": "application/json",
				      "X-HTTP-Method-Override": "PUT" },
				data:JSON.stringify({replytext:replytext}), 
				dataType:'text', 
				success:function(result){
					console.log("result: " + result);
					if(result == 'SUCCESS'){
						alert("수정 되었습니다.");
						getPage("/replies/"+bno+"/"+replyPage );
					}
			}});
	});

	
	// 댓글 삭제 버튼 클릭이벤트
	$("#replyDelBtn").on("click",function(){
		  
		  var rno = $(".modal-title").html();
		  var replytext = $("#replytext").val();
		  
		  $.ajax({
				type:'delete',
				url:'/replies/'+rno,
				headers: { 
				      "Content-Type": "application/json",
				      "X-HTTP-Method-Override": "DELETE" },
				dataType:'text', 
				success:function(result){
					console.log("result: " + result);
					if(result == 'SUCCESS'){
						alert("삭제 되었습니다.");
						getPage("/replies/"+bno+"/"+replyPage );
					}
			}});
	});
	
</script>


<script>
$(document).ready(function(){
	
	var formObj = $("form[role='form']");
	
	console.log(formObj);
	
	$("#modifyBtn").on("click", function(){
		formObj.attr("action", "/board/modifyMobile");
		formObj.attr("method", "get");		
		formObj.submit();
	});
	
	$("#removeBtn").on("click", function(){
		formObj.attr("action", "/board/remove");
		formObj.submit();
	});
	
	$("#goListBtn ").on("click", function(){
		formObj.attr("method", "get");
		formObj.attr("action", "/board/listMobile");
		formObj.submit();
	});
	
});
</script>
</body>
</html>

<%@include file="../include/footer.jsp"%>
