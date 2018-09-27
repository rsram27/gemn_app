<!--#include file="ssi/parametros.asp" -->
<%
if not varTelaAbertura then
	response.redirect "login.asp?msg=" & plic(trim(request("msg")))
end if
%>
<!--#include file="ssi/head.asp" -->
<% pgDefault = true %>
<link href="lib/plugin/slick/slick.css" rel="stylesheet" />
<link href="lib/plugin/slick/slick-theme.css" rel="stylesheet" />
<!--#include file="ssi/cabecalho.asp" -->
<div class="container">
	<div class="mq-center logo-entrada">
		<img src="lib/imgs/logotipo.png" height="70" />
	</div>

	<!--#include file="ssi/mensagens.asp" -->

	<div class="inicio">
		<% 
		for x = 0 to 4 
			inicioImg= "lib/imgs/u5.png"
			inicioTitulo = "Chamada"
			inicioResumo = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse in turpis arcu."
			%>
			<div class="item">
				<div>
					<img src="lib/imgs/u5.png"  class="img-circle" />
					<h4>Chamada <%= x %></h4>
					<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse in turpis arcu.</p>
				</div>
			</div>
			<% 
		next 
		%>
	</div>
	<div class="text-center">
		<a class="mq-btn w75" href="login.asp">Iniciar</a>
	</div>
</div>
<!--#include file="ssi/rodape.asp" -->
<script src="lib/plugin/slick/slick.min.js"></script>
<script type="text/javascript">
	$('.inicio').slick({
		dots: true,
		prevArrow: false,
		nextArrow: false
	});
</script>
<!--#include file="ssi/rodapeBase.asp" -->
