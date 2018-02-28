<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <!-- jQuery 라이브러리 참조 -->
  <script type="text/javascript" src="http://code.jquery.com/jquery-1.8.3.min.js"></script>
  
  <!-- plugin 참조 -->
  <script type="text/javascript" src="../jquery.cookie.js"></script>
  <!--// plugin 참조 -->

  <script>
    $(document).ready(function(){
        // 저장된 쿠키값을 읽어오기
        var c_user_id = $.cookie("userid");
        var c_user_pwd = $.cookie("userpwd");

        //저장된 값이 있다면 입력 요소에 값 출력
        if( c_user_id && c_user_pwd ) {
            $("#userid").val(c_user_id);
            $("#userpwd").val(c_user_pwd);

            //체크박스는 다시 체크
            $("#autoSave").prop("checked", true);            
        }
        
        $("#autoSave").click(function(e) {            
            if ($(this).is(":checked")) {
                // 사용자에게 저장여부 확인후 취소시 체크박스 해제
                if (!confirm("공용 PC에서 로그인정보를 저장할 경우, 다른 사람에게 노출될 위험이 있습니다. 정보를 저장하시겠습니까?")    ) {
                    $("#autoSave").prop("checked", false);                    
                }
            }
        });
        
        $("#btnLogin").click(function(){
            
            if (!$("#userid").val()) { //아이디를 입력하지 않으면.
                alert("아이디를 입력 해주세요!");
                $("#userid").focus();
                return false;
            }
            if (!$("#userpwd").val()) { //패스워드를 입력하지 않으면.
                alert("패스워드를 입력 해주세요!");
                $("#userpwd").focus();
                return false;
            }

            if ($("#autoSave").is(":checked")) {
                //체크 되어있다면, 해당 정보를 1년간 유효하도록 쿠키 저장
                $.cookie("userid", $("#userid").val(), {
                    "expires" : 365                
                });                        
                $.cookie("userpwd", $("#userpwd").val(), {
                    "expires" : 365
                });
            } else {
                //체크가 해제되었다면 쿠키 삭제.
                $.removeCookie("userid");
                $.removeCookie("userpwd");
            }

            $("#loginForm").submit();
        });
    });
  </script>

 </head>
 <body>
     
     <h1>로그인</h1>
     <form id="loginForm" name="loginForm" method="post" action="">
     <div class="loginBox">
        <div>
            <label for="userid">아이디</label>
            <input type="text" name="userid" id="userid" size="20" maxlength="20">
        </div>
        <div>
            <label for="userpwd">패스워드</label>
            <input type="password" name="userpwd" id="userpwd" size="20" maxlength="20">
        </div>
        <div>
            <label for="autoSave">아이디/비밀번호 저장</label>
            <input type="checkbox" name="autoSave" id="autoSave">
        </div>

        <div>
        <button id="btnLogin">로그인</button>
        </div>
     </div>
     </form>
 </body>
</html>
