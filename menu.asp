<!--#include file="ssi/parametros.asp" -->
<!--#include file="ssi/head.asp" -->
<%
paginaArea = "GeMN APP"
paginaTitulo = "MENU PRINCIPAL"
paginaSubtitulo = ""
paginaIconeTitulo = "chevron-down"
paginaBloqueiaReturn = true
%>
<!--#include file="ssi/cabecalho.asp" -->
<!--#include file="ssi/caminho.asp" -->
<div class="container">
	<!--#include file="ssi/mensagens.asp" -->
	<div class="mq-nav-menu">
		<% if (session("tipoAcesso") = "f") then %>
			<%if  session("primeiroAcesso") = true then 
					session("primeiroAcesso") = false
				%>
				<script>
						window.location.href = "Home_Marina.asp"
				</script>
			<% end if %>

			<a href="painelInicial.asp">
				<div class="mq-nav-item">
					<i class="fa fa-fw fa-home"></i>
					<div>
						<h4>SUA EMPRESA</h4>
						<small>Consulte aqui os dados da sua empresa, embarcações, faturamento, etc.</small>
					</div>
				</div>
			</a>

			<a data-menu="#agendamentosF" data-slider="right" data-grupo="agendamentos" data-close="true" >
				<div class="mq-nav-item">
					<i class="fa fa-fw fa-bullseye"></i>
					<div>
						<h4>AGENDAMENTOS</h4>
						<small>Consulte agendamentos realizados pelos clientes</small>
					</div>
				</div>
			</a>

			<a href = "painelCadastrosClientes.asp">
				<div class="mq-nav-item">
					<i class="fa fa-fw fa-user-circle"></i>
					<div>
						<h4>Cadastro de Clientes</h4>
						<small>Consulte os dados dos seus Clientes</small>
					</div>
				</div>
			</a>

		<% elseif (session("tipoAcesso") = "c") then %>
	
			<a data-menu="#agendamentosC" data-slider="right" data-grupo="agendamentos" data-close="true" >
				<div class="mq-nav-item">
					<i class="fa fa-bullseye"></i>
					<div>
						<h4>AGENDAMENTOS</h4>
						<small>Registre agendamentos de suas embarcações</small>
					</div>
				</div>
			</a>

		<% end if %>

	</div>
	<div class="text-center">
		<button class="mq-btn mq-btn-sm  mq-bg-corPadrao" onclick="window.location.href='logoutScript.asp';">ENCERRAR ACESSO</button>
	</div>
</div>
<% if (session("tipoAcesso") = "f") then %>
	<div id="agendamentosF" class="dataslider mq-bg-cinza-claro" data-hide="true" data-grupo="agendamentos" style="display:none;>
		<h4>Agendamentos</h4>
		<p class="small">Selecione a opção desejada:</p>
		<a href="agendamentos/consulta.asp" class="mq-btn mq-btn-icon w100 mb15 left mq-bg-corPadrao"><i class="fa fa-list mq-cor-primaria"></i> Consulta</a>
	</div>
<% elseif (session("tipoAcesso") = "c") then %>
	<div id="agendamentosC" class="dataslider mq-bg-cinza-claro" data-hide="true" data-grupo="agendamentos" style="display:none;>
		<h4>Agendamentos</h4>
		<p class="small">Selecione a opção desejada:</p>
		<a href="agendamentos/inclusao.asp" class="mq-btn mq-btn-icon w100 mb15 left mq-bg-corPadrao"><i class="fa fa-plus-circle mq-cor-primaria"></i> Inclusão</a>
	</div>
<% end if %>
<!--#include file="ssi/rodape.asp" -->
<!--#include file="ssi/rodapeBase.asp" -->
