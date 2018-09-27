<div class="mq-caminho">
	<div class="mq-caminho-item">
		<a<% if (isvalid(paginaLinkCaminho)) then %> href="<%= paginaLinkCaminho %>"<% end if %> class="mq-iconeCaminho <% if (not paginaBloqueiaReturn) then %>mq-return<% end if %>"><i class="fa fa-<% if (isvalid(paginaIconeTitulo)) then %><%= paginaIconeTitulo %><% else %>chevron-left<% end if %>"></i></a>
		<h1><%= paginaTitulo %>
			<span><%= paginaSubtitulo %></span>
		</h1>
	</div>
	<div class="mq-caminho-item">
		<% if (isvalid(paginaImagem)) then %>
			<div style="margin-left:15px;">
				<img src="<%= paginaImagem %>" class="img-circle" height="50" />
			</div>
		<% end if %>
	</div>
</div>