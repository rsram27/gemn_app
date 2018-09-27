<!--#include file="ssi/parametros.asp" -->
<!--#include file="loginSenhaDecodifica.asp" -->
<% 
login = plic(trim(request("login")))
senha = plic(trim(request("senha")))

if not isValid(login) then avisaerro "Informação obrigatória: Login"
if not isValid(senha) then avisaerro "Informação obrigatória: Senha"
if len(empresa) > 50 then avisaerro "Informe no máximo 50 caracteres no campo: Empresa"
if len(login) > 50 then avisaerro "Informe no máximo 50 caracteres no campo: Login"
if len(senha) > 50 then avisaerro "Informe no máximo 50 caracteres no campo: Senha"

call cnopen(varDBApp, cn)

sql = "select senhalogin, registro, nomeusuario, email, tipoacesso " _
	& "from view_usuarios " _
	& "where acessoapp = 1 and email = '" & login & "'"
rsdados = fngetrows(sql, cn)
if (isarray(rsdados)) then
	
	r = 0
	c = 0
	senhalogin = rsdados(inc(c), r)
	idUsuario = rsdados(inc(c), r)
	nomeUsuario = rsdados(inc(c), r)
	emailUsuario = rsdados(inc(c), r)
	tipoAcesso = rsdados(inc(c), r)

	senhaDecodificada = Decodifica(senhalogin)

	if (senhaDecodificada <> senha) then

		session("appLoggedGemn") = false
	
		call cnclose(cn)
		response.redirect "login.asp?msg=fs"

	else

		session("idUsuario") = idUsuario
		session("nomeUsuario") = nomeUsuario
		session("emailUsuario") = emailUsuario
		session("tipoAcesso") = tipoAcesso
		session("primeiroAcesso") = true
		session("appLoggedGemn") = true

		call cnclose(cn)
		response.redirect "menu.asp"

	end if

else
	
	session("appLoggedGemn") = false
	
	call cnclose(cn)
	response.redirect "login.asp?msg=dne"

end if
%>
