<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport"
	content="width=device-width,height=device-height,inital-scale=1.0,maximum-scale=1.0,user-scalable=no;">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta name="format-detection" content="telephone=no">

<title>幸运大转盘抽奖</title>
<link href="files/activity-style.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="files/jquery.min.js"></script>
<script type="text/javascript" src="files/jQueryRotate.2.2.js"></script>
<script type="text/javascript" src="files/jquery.easing.min.js"></script>
<script type="text/javascript">
	$(function() {
		$("#inner").click(function() {
			lottery();
		});
	});
	function lottery() {
		$.ajax({
			type : 'POST',
			url : 'AwardServlet',
			dataType : 'json',
			cache : false,
			error : function() {
				alert('出错了！');
				return false;
			},

			success : function(json) {
				$("#inner").unbind('click').css("cursor", "default");
				var angle = parseInt(json.angle); //角度 
				var msg = json.msg; //提示信息
				$("#outer").rotate({ //inner内部指针转动，outer外部转盘转动
					duration : 5000, //转动时间 
					angle : 0, //开始角度 
					animateTo : 3600 + angle, //转动角度 
					easing : $.easing.easeOutSine, //动画扩展 
					callback : function() {
						var con = confirm(msg + '\n还要再来一次吗？');
						if (con) {
							lottery();
						} else {
							return false;
						}
					}
				});
			}
		});
	}
</script>
</head>

<body class="activity-lottery-winning">

	<div class="main">
		<script type="text/javascript">
			var loadingObj = new loading(document.getElementById('loading'), {
				radius : 20,
				circleLineWidth : 8
			});
			loadingObj.show();
		</script>

		<div id="outercont">
			<div id="outer-cont" style="overflow:hidden;">
				<div id="outer">
					<img src="files/activity-lottery-1.png" width="310px">
				</div>
			</div>
			<div id="inner-cont">
				<div id="inner">
					<img src="files/activity-lottery-2.png">
				</div>
			</div>
		</div>
	</div>

</body>
</html>