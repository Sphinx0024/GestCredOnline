<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="GestCredOnline.WebUI.Pages.login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>GestCred - Online</title>
    <style type="text/css"> 
        @import url('https://fonts.googleapis.com/css?family=Montserrat:400,800');

* {
	box-sizing: border-box;
}

body {
	background: #c2f2bf;
	 
	background: -webkit-linear-gradient(to right, #f7d48a, #c2f2bf);
	background: linear-gradient(to right, #f7d48a, #c2f2bf);
	background-repeat: no-repeat;
	background-size: cover;
	background-position: 0 0;

	display: flex;
	justify-content: center;
	align-items: center;
	flex-direction: column;
	font-family: 'Montserrat', sans-serif;
	height: 100vh;
	margin: -20px 0 50px;
}

h1 {
	font-weight: bold;
	margin: 0;
}

h2 {
	text-align: center;
}

p {
	font-size: 14px;
	font-weight: 100;
	line-height: 20px;
	letter-spacing: 0.5px;
	margin: 20px 0 30px;
}

span {
	font-size: 12px;
}

a {
	color: #34a839;
	font-size: 14px;
	text-decoration: dashed;
	margin: 15px 0;
}

button {
	border-radius: 20px;
	border: 1px solid #34a839;
	background-color: #34a839;
	color: #FFFFFF;
	font-size: 12px;
	font-weight: bold;
	padding: 12px 45px;
	letter-spacing: 1px;
	text-transform: uppercase;
	transition: transform 80ms ease-in;
}

button:active {
	transform: scale(0.95);
}

button:focus {
	outline: none;
}

button.ghost {
	background-color: transparent;
	border-color: #FFFFFF;
}

form {
	background-color: #FFFFFF;
	display: flex;
	align-items: center;
	justify-content: center;
	flex-direction: column;
	padding: 0 50px;
	height: 100%;
	text-align: center;
}

input {
	background-color: #eee;
	border: none;
	padding: 12px 15px;
	margin: 8px 0;
	width: 100%;
}

.container {
	background-color: #fff;
	border-radius: 10px;
  	box-shadow: 0 14px 28px rgba(0,0,0,0.25), 
			0 10px 10px rgba(0,0,0,0.22);
	position: relative;
	overflow: hidden;
	width: 768px;
	max-width: 100%;
	min-height: 480px;
}

.form-container {
	position: absolute;
	top: 0;
	height: 100%;
	transition: all 0.6s ease-in-out;
}

.sign-in-container {
	left: 0;
	width: 50%;
	z-index: 2;
}

.container.right-panel-active .sign-in-container {
	transform: translateX(100%);
}

.sign-up-container {
	left: 0;
	width: 50%;
	opacity: 0;
	z-index: 1;
}

.container.right-panel-active .sign-up-container {
	transform: translateX(100%);
	opacity: 1;
	z-index: 5;
	animation: show 0.6s;
}

@keyframes show {
	0%, 49.99% {
		opacity: 0;
		z-index: 1;
	}
	
	50%, 100% {
		opacity: 1;
		z-index: 5;
	}
}

.overlay-container {
	position: absolute;
	top: 0;
	left: 50%;
	width: 50%;
	height: 100%;
	overflow: hidden;
	transition: transform 0.6s ease-in-out;
	z-index: 100;
}

.container.right-panel-active .overlay-container{
	transform: translateX(-100%);
}

.overlay {
	background: #ff8d00;
	background: -webkit-linear-gradient(to right, #ff8d00, #f7af56);
	background: linear-gradient(to right, #ff8d00, #f7af56);
	background-repeat: no-repeat;
	background-size: cover;
	background-position: 0 0;
	color: #FFFFFF;
	position: relative;
	left: -100%;
	height: 100%;
	width: 200%;
  	transform: translateX(0);
	transition: transform 0.6s ease-in-out;
}

.container.right-panel-active .overlay {
  	transform: translateX(50%);
}

.overlay-panel {
	position: absolute;
	display: flex;
	align-items: center;
	justify-content: center;
	flex-direction: column;
	padding: 0 40px;
	text-align: center;
	top: 0;
	height: 100%;
	width: 50%;
	transform: translateX(0);
	transition: transform 0.6s ease-in-out;
}

.overlay-left {
	transform: translateX(-20%);
}

.container.right-panel-active .overlay-left {
	transform: translateX(0);
}

.overlay-right {
	right: 0;
	transform: translateX(0);
}

.container.right-panel-active .overlay-right {
	transform: translateX(20%);
}

.social-container {
	margin: 20px 0;
}

.social-container a {
	border: 1px solid #DDDDDD;
	border-radius: 50%;
	display: inline-flex;
	justify-content: center;
	align-items: center;
	margin: 0 5px;
	height: 40px;
	width: 40px;
}

footer {
    background-color: #222;
    color: #fff;
    font-size: 14px;
    bottom: 0;
    position: fixed;
    left: 0;
    right: 0;
    text-align: center;
    z-index: 999;
}

footer p {
    margin: 10px 0;
}

footer i {
    color: red;
}

footer a {
    color: #3c97bf;
    text-decoration: none;
}

    </style>

</head>
<body>
   
<div class="container" id="container">
	<div class="form-container sign-up-container">
		<form action="#">
			<h1>BNI Online</h1>
			 
			<span>Votre banque en ligne qui vous donne accès à toutes vos informations . 
				Effectuez toutes vos opérations en temps réel, à votre convenance et en toute sécurité. </span>
			 
			<a href="https://www.bnionline.ci/FR/public/connexion.awp" target="_blank">aller sur BNI Online</a>
		</form>
	</div>
	<div class="form-container sign-in-container">
		<form action="#">
			<h1>Connexion</h1> 
			<span>Saisissez votre racine client vous recevrez le mot de passe de connexion</span>
			<input type="text" id="TxtLogin" placeholder="Votre racine client (ex: 665823)" />
            <span id="spanRacineError"></span>
			<input type="password" id="TxtPwd" placeholder="OTP" /> 
			<button id="BtnConnexion" type="button">Connexion</button>
		</form>
	</div>
	<div class="overlay-container">
		<div class="overlay">
			<div class="overlay-panel overlay-left">
				<h1>Bonjour cher client!</h1>
				<p>Vous pouvez vous connectez pour faire une demande de credit.</p>
				<button class="ghost" id="signIn">Se connecter</button>
			</div>
			<div class="overlay-panel overlay-right">
				<h1>Bonjour cher client !</h1>
				<p>Vous etes client un client BNIOnline? <br /> Connectez vous pour faire des de credits </p>
				<button class="ghost" id="signUp">Aller à BNI Online</button>
			</div>
		</div>
	</div>
</div>

    <script src="../Assets/js/jquery.min.js"></script>
    <script src="../Assets/js/appConfig.js"></script>

    <script type="text/javascript">		

		localStorage.clear();

        function postAjax(url, data, success) {
            //var params = typeof data == 'string' ? data : Object.keys(data).map(
            //    function (k) { return encodeURIComponent(k) + '=' + encodeURIComponent(data[k]) }
            //).join('&');

            var xhr = window.XMLHttpRequest ? new XMLHttpRequest() : new ActiveXObject("Microsoft.XMLHTTP");
            xhr.open('POST', url);
            xhr.onreadystatechange = function () {
                if (xhr.readyState > 3 && xhr.status == 200) { success(xhr.responseText); }
            };
            xhr.setRequestHeader('X-Requested-With', 'XMLHttpRequest');
            xhr.setRequestHeader('Content-Type', 'x-www-form-urlencoded'); // //application/json; charset=utf-8
            xhr.send(data);
            return xhr;
        }
		 
        function getAjax(url, success) {
            var xhr = window.XMLHttpRequest ? new XMLHttpRequest() : new ActiveXObject('Microsoft.XMLHTTP');
            xhr.open('GET', url);
            xhr.onreadystatechange = function () {
                if (xhr.readyState > 3 && xhr.status == 200) success(xhr.responseText);
            };
            xhr.setRequestHeader('X-Requested-With', 'XMLHttpRequest');
            xhr.send();
            return xhr;
        }

		function getUserLogin( txt ) { 
			let c_racine = txt.value;
			let _host = 'https://localhost:44384/api/Client';
			let _url = _host + '/GetClientIdentification?id=' + c_racine;
            getAjax(_url, function (data) {
				const spanRacineError = document.getElementById('spanRacineError'); 
				if (data == 'false') {
					txt.style.backgroundColor = "#f9def3";
					spanRacineError.innerText = "Racine client invalide "
				} else {
                    txt.style.backgroundColor = "#d6f7cf";
					spanRacineError.innerText = "Racine client valide, vous recevrez votre mot de passe ";
                    _url = _host + '/GetAskOTP?id=' + c_racine;
					getAjax(_url, function (data) {
						spanRacineError.innerText = " votre mot de passe vous a été envoyé";
					});
                } 
            });
        } 

        function connexion(txt, pwd) {
			let _host = 'https://localhost:44384';
            let _url = _host + '/token';  //'/api/Client/PostConnexion' // 
			//username: login, password: pwd, grant_type: 'password'
			let PostData = { username: txt, password: pwd, grant_type: 'password' };// { userName: txt, password: pwd };

            $.post(_url, PostData).done(function (data) {
		//	postAjax(_url, JSON.stringify(PostData), function (data) {
				if (data !== null) {
                    localStorage.setItem(appConfig.connectToken, data.access_token);
					localStorage.setItem(appConfig.connectTokenType, data.token_type);
                    localStorage.setItem(appConfig.profileName, data.nomComplet);
                    localStorage.setItem(appConfig.connectConnected, data.racine);

					localStorage.setItem('racine', txt);
					location.href = 'index.aspx';
				}
			});


        }

    </script>

    <script type="text/javascript">	

        const signUpButton = document.getElementById('signUp');
		const signInButton = document.getElementById('signIn');
		const logInbutton = document.getElementById('BtnConnexion');
		const txtLogin = document.getElementById('TxtLogin');
		const txtPwd = document.getElementById('TxtPwd'); 
        const container = document.getElementById('container');
         
        signUpButton.addEventListener('click', () => { container.classList.add("right-panel-active"); });

		signInButton.addEventListener('click', () => { container.classList.remove("right-panel-active"); });

        logInbutton.addEventListener('click', () => { connexion(txtLogin.value, txtPwd.value); });

        txtLogin.addEventListener('blur', () => { getUserLogin(txtLogin); });

		
		 
       
    </script>

</body>
</html>
