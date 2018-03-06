<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="../include/header.jsp"%>
<html>
<head>
    <script src="../resources/plugins/jQuery/jQuery-2.1.4.min.js"></script>


	</head>
<body class="container" style="background:lightgray;">
	<div>
		<!-- 본문 부분 -->
		<div class="row">
			<div class="col-md-12">
				<div class="box box-primary">
				
					<!-- 게시글 제목  -->
					<div class="box-header">
						<h3 class="box-title">Register Board</h3>
					</div>
					
					<form role="form" method="post">
						
						<!-- 게시글 내용 -->
						<div class="box-body">
							<div class="form-group">	
								<label for="exampleInputEmail1">Title</label>
								<input type="text" name='title' class="form-control">
							</div>
							<div class="form-group">
								<label for="exampleInputPassword1">Content</label>
								<textarea class="form-control" name="content" rows="3" ></textarea>
							</div>
							<div class="form-group">
								<label for="exampleInputEmail1">Writer</label>
								<input type="text" name="writer" class="form-control">
							</div>	
						</div>
						
						<!-- 게시글 버튼 -->
						<div class="box-footer">
							<button type="submit" id="save" class="btn btn-default">Submit</button>							
							<input type='button' id="cancel" name="cancel" class="btn btn-default" value="Cancel"/>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<script>
	// cancel 버튼 클릭 이벤트
	$(document).ready(function(){
		
		$("#cancel").on("click", function(){
			self.location = "listPage?page=${cri.page}&perPageNum=${cri.perPageNum}";
		});
	});

	</script>
</body>
</html>
