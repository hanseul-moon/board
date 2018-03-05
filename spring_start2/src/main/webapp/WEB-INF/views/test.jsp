<%@ page session="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<html>
<head>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js" type="text/javascript"></script>
<script>
	function getAllList(){
		
		$.getJSON("replies/all/" + bno, function(data){
			console.log(data.length);
			
			$(data).each(
				function(){
				str += "<li data-rno='"+ this.rno +"' class='replyLi'>"
					+ this.rno + ":" + this.replytext
					+ "</li>";
				});
			
			$("#replies").html(str);
		});
		
		/* $("#replyAddBtn").on("click", function(){
			
			var replyer = $("#newReplyWriter").val();
			var replytext = $("#newReplyText").val();
			
			$.ajax({
				type : 'post',
				url : '/replies',
				headers : {
					"Content-Type" : "application/json",
					"X-HTTP-Method-Override" : "POST" },
				dataType : 'text',
				data : JSON.stringify({
					bno : bno,
					replyer : replyer,
					replytext : replytext
				}),
				success : function(result) {
					
					if(result == 'SUCCESS'){
						alert("등록 되었습니다.");
					}
				}
			});
		});  */
	}
	
	
	$("#replyAddBtn").on("click", function() {

		var replyer = $("#newReplyWriter").val();
		var replytext = $("#newReplyText").val();

		$.ajax({
			type : 'post',
			url : '/replies',
			headers : {
				"Content-Type" : "application/json",
				"X-HTTP-Method-Override" : "POST"
			},
			dataType : 'text',
			data : JSON.stringify({
				bno : bno,
				replyer : replyer,
				replytext : replytext
			}),
			success : function(result) {

				if (result == 'SUCCESS') {

					alert("등록 되었습니다.");
					getAllList();

				}
			}
		});
	});
	
	
	
 	
</script>	
</head>
<body>
	<h2>Ajax Test Page</h2>
	
	<div>
		<div>
			REPLYER <input type='text' name='replyer' id='newReplyWriter'>
		</div>
		<div>
			REPLY TEXT <input type='text' name='replytext' id='newReplyText'>
		</div>
		<button id="replyAddBtn">ADD REPLY</button>
	</div>
</body>
</html>