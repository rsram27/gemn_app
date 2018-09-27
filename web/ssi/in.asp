<!--#include file="parametros.asp" -->
<!--#include file="../loginSenhaDecodifica.asp" -->
<% 
call cnopen(varDBApp, cn)
'sql = "select senhalogin, registro, email, empresa, tipoacesso " _
'	& "from view_usuarios " _
'	& "where acessoapp = 1"
'rsdados = fngetrows(sql, cn)
'if (isarray(rsdados)) then
'	
'	for r = 0 to ubound(rsdados,2)
'		c = 0
'		senhalogin = rsdados(inc(c), r)
'		idUsuario = rsdados(inc(c), r)
'		email = rsdados(inc(c), r)
'		empresa = rsdados(inc(c), r)
'		tipoacesso = rsdados(inc(c), r)
'
'		senhaDecodificada = Decodifica(senhalogin)
'
'		response.write idUsuario & " | " & email & " | " & senhaDecodificada & " | " & empresa & " | " & tipoacesso & "<br>"
'	next
'end if
call cnclose(cn)
response.write now()
%>
