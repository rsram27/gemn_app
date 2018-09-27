<!--#include file="ssi/parametros.asp" -->
<!--#include file="ssi/head.asp" -->
<% pgDefault = true %>
<!--#include file="ssi/cabecalho.asp" -->
<div class="container">
	<div class="mq-center mb45 logo-entrada">
		<img src="lib/imgs/logotipo.png" height="70" />
	</div>

	<div class="text-center">
		<h4>Login</h4>
	</div>

	<!--#include file="ssi/mensagens.asp" -->
	<form action="loginScript.asp" method="post" >
		<div class="mq-form-item">
			<i class="fa fa-envelope fa-fw"></i>
			<div>
				<label>E-mail:</label>
				<input type="email" name="login" required maxlength="50" class="form-control" />
			</div>
		</div>
		<div class="mq-form-item">
			<i class="fa fa-lock fa-fw"></i>
			<div>
				<label>Senha:</label>
				<input type="password" name="senha" required maxlength="50" class="form-control" />
			</div>
		</div>
		<div class="text-center">
			<button class="mq-btn w75">ENTRAR</button>
		</div>
	</form>

</div>
<!--#include file="ssi/rodape.asp" -->
<!--#include file="ssi/rodapeBase.asp" -->
