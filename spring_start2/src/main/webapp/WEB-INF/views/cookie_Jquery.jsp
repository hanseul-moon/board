<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <!-- jQuery ���̺귯�� ���� -->
  <script type="text/javascript" src="http://code.jquery.com/jquery-1.8.3.min.js"></script>
  
  <!-- plugin ���� -->
  <script type="text/javascript" src="../jquery.cookie.js"></script>
  <!--// plugin ���� -->

  <script>
    $(document).ready(function(){
        // ����� ��Ű���� �о����
        var c_user_id = $.cookie("userid");
        var c_user_pwd = $.cookie("userpwd");

        //����� ���� �ִٸ� �Է� ��ҿ� �� ���
        if( c_user_id && c_user_pwd ) {
            $("#userid").val(c_user_id);
            $("#userpwd").val(c_user_pwd);

            //üũ�ڽ��� �ٽ� üũ
            $("#autoSave").prop("checked", true);            
        }
        
        $("#autoSave").click(function(e) {            
            if ($(this).is(":checked")) {
                // ����ڿ��� ���忩�� Ȯ���� ��ҽ� üũ�ڽ� ����
                if (!confirm("���� PC���� �α��������� ������ ���, �ٸ� ������� ����� ������ �ֽ��ϴ�. ������ �����Ͻðڽ��ϱ�?")    ) {
                    $("#autoSave").prop("checked", false);                    
                }
            }
        });
        
        $("#btnLogin").click(function(){
            
            if (!$("#userid").val()) { //���̵� �Է����� ������.
                alert("���̵� �Է� ���ּ���!");
                $("#userid").focus();
                return false;
            }
            if (!$("#userpwd").val()) { //�н����带 �Է����� ������.
                alert("�н����带 �Է� ���ּ���!");
                $("#userpwd").focus();
                return false;
            }

            if ($("#autoSave").is(":checked")) {
                //üũ �Ǿ��ִٸ�, �ش� ������ 1�Ⱓ ��ȿ�ϵ��� ��Ű ����
                $.cookie("userid", $("#userid").val(), {
                    "expires" : 365                
                });                        
                $.cookie("userpwd", $("#userpwd").val(), {
                    "expires" : 365
                });
            } else {
                //üũ�� �����Ǿ��ٸ� ��Ű ����.
                $.removeCookie("userid");
                $.removeCookie("userpwd");
            }

            $("#loginForm").submit();
        });
    });
  </script>

 </head>
 <body>
     
     <h1>�α���</h1>
     <form id="loginForm" name="loginForm" method="post" action="">
     <div class="loginBox">
        <div>
            <label for="userid">���̵�</label>
            <input type="text" name="userid" id="userid" size="20" maxlength="20">
        </div>
        <div>
            <label for="userpwd">�н�����</label>
            <input type="password" name="userpwd" id="userpwd" size="20" maxlength="20">
        </div>
        <div>
            <label for="autoSave">���̵�/��й�ȣ ����</label>
            <input type="checkbox" name="autoSave" id="autoSave">
        </div>

        <div>
        <button id="btnLogin">�α���</button>
        </div>
     </div>
     </form>
 </body>
</html>
