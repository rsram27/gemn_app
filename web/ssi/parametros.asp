<%
response.Buffer = true
response.charset = "utf-8"
Session.LCID = 1046
Session.TimeOut = 120
server.ScriptTimeout = 90
	
' configuração principal
varTelaAbertura = false
msg = plic(trim(request("msg")))
varTitle = "GeMN - APP"
varNomeApp = "GeMN - Gestão de Marinas e Náutica" 
varDominioWWW = lcase(request.ServerVariables("SERVER_NAME"))
varDominio = replace(varDominioWWW, "www.", "") 
varPastaWeb = server.MapPath("/") 

' configurações de banco de dados
varDBServer = "54.233.190.107" 
varDBUser = "root" 
varDBPwd = "fatr102030"
varDBApp = "gemn_app" 'database DB
varDBVersion = "5.3 ANSI" '3.51 ou 5.1
varDBType = "MySQL"
	
' configurações de caminho
varPaginaASPAtual = replace(request.ServerVariables("SCRIPT_NAME"), "\", "/")
varPaginaASPAtual = right(varPaginaASPAtual, len(varPaginaASPAtual) - instrRev(varPaginaASPAtual, "/"))
if varPaginaASPAtual = "" then varPaginaASPAtual = "./"
varApp = "http://" & varDominio &"/"
varSite = "http://www.gemn.com.br"
	
' configurações de ambiente
varAmbiente = "producao"
if request.ServerVariables("SERVER_NAME") = "localhost" or request.ServerVariables("SERVER_NAME") = "dt" or request.ServerVariables("SERVER_NAME") = "pc" or request.ServerVariables("SERVER_NAME") = "will-note" then
	varAmbiente = "desenvolvimento"
end if

if varAmbiente = "desenvolvimento" then
	nomePastaLocal = "asp"
	varApp = "http://" & request.ServerVariables("SERVER_NAME") & "/" & nomePastaLocal & "/"
	varDisparaEmail = true
	varEmailForcado = true
	if request.ServerVariables("SERVER_NAME") = "will-note" then
		varEmailForcadoPara = "wiliam@fabricadetempo.com.br"
	elseif request.ServerVariables("SERVER_NAME") = "pc" then
		varEmailForcadoPara = "paulocesar@fabricadetempo.com.br"
	else
		varEmailForcadoPara = "dalton@fabricadetempo.com.br"
	end if
end if
	
'configuração para disparo de e-mail
varRemetentePadrao = "alerta@fabricadetempo.com.br"
varDestinatarioPadrao = "contato@gemn.com.br"
varSMTP = "smtplw.com.br"
varAutenticaSMTP = true
varFromSMTP = "alerta@fabricadetempo.com.br"
varLoginSMTP = "fabricadetempo2"
varSenhaSMTP = "zbolAtSU0883"
varSMTPToken = "9cd43ae0ff7d4011986be3f60a96ac73"
varDisparaEmail = true
varEmailForcado = false
varEmailForcadoPara = ""
varMensagemCabecalho = "<html><head></head><body style=""font-family:Arial; font-size:13px; width:750px;"">" _
					& "<div style=""padding:20px; background-color:#FAFAFA; border-bottom:2px solid #CECECE;"">" _
					& "<img src=""" & varApp & "lib/imgs/logotipo.png"" style=""width:150px;"" />" _
					& "</div>" _
					& "<div style=""padding:10px 20px; background-color:#FFFFFF; text-align:justify;"">"
varMensagemRodape =    "</div>" _
					 & "<div style=""padding:20px; background-color:#FAFAFA; border-top:2px solid #CECECE;"">" _
					 & "<b>" & varNomeApp & "</b>" _
					 & "<br>" _
					 & "<p style=""font-family:Arial; font-size:11px; font-style:italic; margin-bottom:0;"">Enviado às: " & now() & "</p>" _
					 & "</div>" _
					 & "</body></html>"

'conexao com banco de dados
function cnopen(byval nomeBanco, byref cn) 
	if varDBServer <> "" then
		Set cn = Server.CreateObject("ADODB.Connection")
		cn.Open("DRIVER={MySQL ODBC "&varDBVersion&" Driver};SERVER="&varDBServer&";PORT=3306;DATABASE="&nomeBanco&";USER="&varDBUser&";PASSWORD="&varDBPwd&";OPTION=3;")
	end if
end function 
	
function cnclose(byref cn) 
	if varDBServer <> "" and typename(cn) = "Connection" then
		if cn.state <> 0 then cn.close
		set cn = nothing
	end if
end function 

sub protecao()
	if session("appLoggedGemn") = False then
		response.redirect varApp & "?msg=t"
	end if
end sub
%>
<!--#include file="funcoes.asp" -->
