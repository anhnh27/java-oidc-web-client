<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>callback</title>
<script src="https://code.jquery.com/jquery-3.4.1.min.js" integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo=" crossorigin="anonymous"></script>
</head>
<body>
	<script type="text/javascript">
		function setCookie(cname, cvalue, tokenLifeTime) {
			var d = new Date();
			d.setTime(d.getTime() + tokenLifeTime);
			var expires = "expires=" + d.toUTCString();
			document.cookie = cname + "=" + cvalue + ";" + expires + ";path=/";
		}

		$(document).ready(function() {
			var hash = window.location.hash.substr(1);
			var params = hash.split('&')
						.reduce(
							function(result, item) {
								var parts = item.split('=');
								result[parts[0]] = parts[1];
								return result;
							}, {});

			$.post("https://mobile.legend-park.com/connect/token", {
				grant_type : "authorization_code",
				client_id : "31b7732e-733b-4081-91ff-290879dd0d65b",
				client_secret : "3d73bc46-d313-4155-8074-8cb1c13ada03",
				code : params.code,
				redirect_uri : "http://localhost:8080/oidc-web-client/signin-oidc"
			}).done(function(data) {
				console.log(data);
				setCookie("id_token", data.id_token, data.expires_in);
				setCookie("access_token", data.access_token, data.expires_in);
				window.location.replace("http://localhost:8080/oidc-web-client/home");
			});
		});
	</script>
	<h3>processing...</h3>
</body>
</html>