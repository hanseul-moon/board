<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@include file="../include/header.jsp"%>

<head>
<script type="text/javascript" src="http://jsgetip.appspot.com"></script>	<!-- ip 가져오는 import -->
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
	if(getCookie(ip()) == undefined){
		setCookie(ip(), 0, 1);
		ipCheck = true;
		
	}else{		
		 registCnt = Number(getCookie(ip()));
		if(registCnt >= 3){
			ipCheck = false;
			alert('글은 하루에 3개만 올릴 수 있습니다. \n24시간 후에 작성하세요.');
			location.href='list';			
		}
	}    
</script>
</head>
<!-- Main content -->
<body class="container" style="background:lightgray;">

<section class="content">
	<div class="row">
		<!-- left column -->
		<div class="col-md-12">
			<!-- general form elements -->
			<div class="box box-primary">
				<div class="box-header">
				<br>
					<h3 class="box-title">새 개시글 작성</h3>
				</div>
				<!-- /.box-header -->

				<form role="form" method="post">
					<div class="box-body">
						<div class="form-group">
							<label for="exampleInputEmail1">제목</label> <input type="text"
								name='title' class="form-control">
						</div>
						<div class="form-group">
							<label for="exampleInputPassword1">내용</label>
							<textarea class="form-control" name="content" rows="3"></textarea>
						</div>
						<div class="form-group">
							<label for="exampleInputEmail1">작성자</label> <input type="text"
								name="writer" class="form-control">
						</div>
					</div>
					<!-- /.box-body -->

					<div class="box-footer">
						<button type="submit" class="btn btn-primary">글쓰기</button>
					</div>
				</form>


			</div>
			<!-- /.box -->
		</div>
		<!--/.col (left) -->

	</div>
	<!-- /.row -->
</section>
<!-- /.content -->
</body>
</html>

<%@include file="../include/footer.jsp"%>
