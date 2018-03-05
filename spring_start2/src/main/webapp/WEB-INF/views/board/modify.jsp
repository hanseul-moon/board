<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="../include/header.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body class="container" style="background:lightgray;">

	<!-- 본문 부분 -->
	<div class="row">
		<div class="col-md-12">
			<div class="box box-primary">
			
				<!-- 본문 게시글 제목  -->
				<div class="box-header">
					<h3 class="box-title">Modify Board</h3>
				</div>

				<!-- 전송할 파라미터 -->
				<form role="form" method="post">
					<input type='hidden' name='page'	   value="${cri.page}"/>
					<input type='hidden' name='perPageNum' value="${cri.perPageNum}"/>
					
					<!-- 본문 게시글 내용 -->
					<div class="box-body">			
						<div class="form-group">
							<label for="exampleInputEmail1">NO</label>
							<input type="text" name='bno' class="form-control" value="${boardVO.bno}" readonly="readonly"/>
						</div>
						<div class="form-group">
							<label for="exampleInputEmail1">Title</label>
							<input type="text" name='title' class="form-control" value="${boardVO.title}"/>
						</div>
						<div class="form-group">
							<label for="exampleInputPassword1">Content</label>
							<textarea class="form-control" name="content" rows="3">${boardVO.content}</textarea>
						</div>
						<div class="form-group">
							<label for="exampleInputEmail1">Writer</label>
							<input type="text" name='writer' class="form-control" value="${boardVO.writer}" readonly="readonly"/>
						</div>
					</div>
				</form>
				
				<!-- 본문 게시글 버튼 -->
				<div class="box-footer">
					<button type="submit" id="save" class="btn btn-default">SAVE</button>
					<button type="submit" id="cancel" class="btn btn-default">CANCEL</button>
				</div>
			</div>
		</div>
	</div>
	<script>
		$(document).ready(function(){
			
			var formObj = $("form[role='form']");
			
			$("#save").on("click", function(){
				formObj.submit();
			});
			
			$("#cancel").on("click", function(){
				self.location = "listPage?page=${cri.page}&perPageNum=${cri.perPageNum}";
			});
		});
	</script>
</body>
</html>
<%@include file="../include/footer.jsp"%>