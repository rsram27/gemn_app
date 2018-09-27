<div class="mq-caminho">
	<div class="mq-caminho-item">
		<a <% if (isvalid(paginaLinkCaminho)) then %> href="<%= paginaLinkCaminho %>"<% end if %> class="mq-iconeCaminho <% if (not paginaBloqueiaReturn) then %>mq-return<% end if %>"><i class="fa fa-<% if (isvalid(paginaIconeTitulo)) then %><%= paginaIconeTitulo %><% else %><% end if %>"></i></a>
		<h1><%= paginaTitulo %>
			<span><%= paginaSubtitulo %></span>
		</h1>
	</div>
	<div class="mq-caminho-item"></div>
</div>