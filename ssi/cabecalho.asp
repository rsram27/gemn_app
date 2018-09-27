		<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
		<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
		<!--[if lt IE 9]>
			<script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
			<script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
		<![endif]-->

		<!-- Google Analytics -->
		<link href="<%= varApp %>lib/css/estilo.min.css" rel="stylesheet" />
	</head>
	<body>
	<% call cnopen(varDBApp, cn) %>
	<% if (not pgDefault) then 
		%>
		<header>
			<nav class="navbar">
				<div class="navbar-item">
					<img width="40" height="40" src="lib/imgs/icone-72x72.png" />
				</div>
				<div class="navbar-item">
					<ul class="lista">
						<li>
							<a id="menuClick" data-menu="#Menu" data-slider="right" data-grupo="menu" data-close="true">
								<i class="fa fa-bars mq-cor-primaria"></i>
							</a>
						</li>
					</ul>
				</div>
			</nav>
		</header>
		
				<!-- aqui montamos os caminhos que seram colocados nos href do hamburgao -->
		<% 
			if (session("tipoAcesso") = "f") then 
				agendamento ="agendamentos/consulta.asp"
			else 
				agendamento = "agendamentos/inclusao.asp"
			end if 
		%>

			<div id="Menu" class="dataslider mq-bg-cinza-claro" data-grupo="menu" style="display: none;">
				<% 
					'Aqui montamos os agendamentos 
					if (session("tipoAcesso") = "f") then 
						call montaItemDeLista("Home",array("EMPRESA|Home_Marina.asp|fa fa-fw fa-home"))
						call montaItemDeLista("Agendamentos",array("Consulta|" & agendamento & "|fa fa-bullseye"))
						call montaItemDeLista("Clientes",array("Clientes|painelCadastrosClientes.asp|fa fa-fw fa-user-circle"))
					else 
						call montaItemDeLista("Agendamentos",array("Consulta|" & agendamento & "|fa fa-bullseye"))
					end if 
				%>
			</div>

		
		<%
		'Feito por Ronan Vico 
		'Monta um item de lista e seus respectivos sub itens 

		sub montaItemDeLista(TITULO,NomeItem_Href_iconClassFA_SeparadosPorPipe)
			%>
			<div class="mq-nav-menu">
						<u><strong class="text-right"><%=TITULO%></strong></u>
				<%
				for i = 0 to ubound(NomeItem_Href_iconClassFA_SeparadosPorPipe)
					nomeItem = split(NomeItem_Href_iconClassFA_SeparadosPorPipe(i),"|")(0)
					href = chr(34) & replace(split(NomeItem_Href_iconClassFA_SeparadosPorPipe(i),"|")(1),chr(34),"") & chr(34)
					iconClass =chr(34) &  replace(split(NomeItem_Href_iconClassFA_SeparadosPorPipe(i),"|")(2),chr(34),"") & chr(34)
					%>	
					<!-- Aqui montamos a lista do que vai aparecer no hamburgão dos dois-->
						<a href=<%= href %> class="mq-btn mq-btn-icon w100 mb-5 left mq-bg-corPadrao" data-grupo="menu" data-hide="true">
							<i class=<%= iconClass %>></i>
							<%= nomeItem %>
						</a>
				<%
				next 
				%>
			</div>	
			<%
		end sub 
		%>

		<div class="mq-header-titulo">
			<%= paginaArea %>
		</div>

		
	<% end if %>
	
	<main <% if pgDefault then  %> style="height:100vh !important" <% end if %>>



