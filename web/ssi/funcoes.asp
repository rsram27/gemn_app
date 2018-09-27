<%
function plic(byval strTexto)
	if strTexto <> "" then
		Temp = Replace(strTexto, "'", "")
		Temp = Replace(Temp, """", "")
		plic = Temp
	end if
end function

Function plicHtml(byval strTexto)
	if strTexto <> "" then
		plicHtml = Replace(strTexto, "'", "''")
	end if
End Function

'função que protege do sqlinjection
Function FormataSQL(byval strTexto)
	if strTexto <> "" then
		Temp = Replace(strTexto, "'", "''")
		FormataSQL = Replace(Temp, """", """")
	end if
End Function


'funcoes de valores
function cnvvl(byval strvalor)
	if strvalor <> "" and not isnull(strvalor) then
		Temp = Replace(strvalor, ".", "")
		Temp = Replace(Temp, ",", ".")
		cnvvl = Temp
	else
		cnvvl = ""
	end if
end function

'funcoes de data e hora
function cnvdt(byval strdata)
	dim Temp
	if strdata <> "" and not isnull(strdata) then
		Temp = cdate(strdata)
		if varDBType = "MySQL" then
			Temp = year(Temp)&"-"&month(Temp)&"-"&day(Temp)
		elseif varDBType = "SQLServer" then
			Temp = month(Temp)&"/"&day(Temp)&"/"&year(Temp)
		else
			Temp = day(Temp)&"/"&month(Temp)&"/"&year(Temp)
		end if
		cnvdt = Temp
	else
		cnvdt = ""
	end if
end function

function cnvdtPontos(byval strdata)
	dim Temp
	if strdata <> "" and not isnull(strdata) then
		Temp = cdate(strdata)
		cnvdtPontos = completa(day(Temp), 2, 0)&"."& completa(month(Temp), 2, 0)&"."&year(Temp)
	else
		cnvdtPontos = ""
	end if
end function

function cnvhr(byval strhora)
	if strhora <> "" and not isnull(strhora) then
		Hora = completa(hour(strhora),2,"0")
		Minuto = completa(minute(strhora),2,"0")
		Segundo = completa(second(strhora),2,"0")
		cnvhr = Hora&":"&Minuto&":"&Segundo
	else
		cnvhr = ""
	end if
end function

function cnvhrs(byval strhora)
	dim temp
	if strhora <> "" and not isnull(strhora) then
		temp = cnvhr(strhora)
		cnvhrs = left(temp,5)
	else
		cnvhrs = ""
	end if
end function

function viraHora(byval strMinutos)
	dim horaconta, horatirar, hora
	dim minuConta, minuTirar, minu
		
	if strMinutos <> "" then
		'Faz as contas das horas
		horaConta = formatnumber((strMinutos)/60,2)
		horaTirar = instr(horaConta, ",")-1
		hora = left(horaConta,horaTirar)
		'Faz as contas dos minutos
		minuConta = formatnumber((strMinutos-(hora*60)),2)
		minuTirar = instr(minuConta, ",")-1
		minu = left(minuConta,minuTirar)
		'Junta tudo
		viraHora = completa(hora,2,"0")&":"&completa(minu,2,"0")
	end if
end function

function viraMinuto(byval strHora)
	dim totalMin
	if strHora <> "" then
		'Faz as contas das horas
		if instr(strHora, ":") > 0 then
			if instr(strHora, ":") = len(strHora) then
				viraMinuto = left(strHora,len(strHora)-1)
			else
				totalMin = left(strHora,instr(strHora, ":")-1)*60
				totalMin = totalMin + mid(strHora,instr(strHora, ":")+1)
				viraMinuto = totalMin
			end if
		else
			viraMinuto = strHora
		end if
	else
		viraMinuto = 0
	end if
end function

function retmes(byval mes)
	if not isnull(mes) and isnumeric(mes) then
		meses = "Janeiro,Fevereiro,Março,Abril,Maio,Junho,Julho,Agosto,Setembro,Outubro,Novembro,Dezembro"
		arrMeses = split(meses,",")
		retmes = arrMeses(mes-1)
	else
		retmes = ""
	end if
end function

function retdiasem(byval data)
	if not isnull(data) and isdate(data) then
		dias = "Domingo,Segunda-feira,Terça-feira,Quarta-feira,Quinta-feira,Sexta-feira,Sábado"
		arrDias = split(dias,",")
		retdiasem = arrDias(weekday(cdate(data))-1)
	else
		retdiasem = ""
	end if
end function

function retmesnr(byval mes)
	if mes = "Janeiro" then
		nrMes = 1
	elseif mes = "Fevereiro" then
		nrMes = 2
	elseif mes = "Março" then
		nrMes = 3
	elseif mes = "Abril" then
		nrMes = 4
	elseif mes = "Maio" then
		nrMes = 5
	elseif mes = "Junho" then
		nrMes = 6
	elseif mes = "Julho" then
		nrMes = 7
	elseif mes = "Agosto" then
		nrMes = 8
	elseif mes = "Setembro" then
		nrMes = 9
	elseif mes = "Outubro" then
		nrMes = 10
	elseif mes = "Novembro" then
		nrMes = 11
	elseif mes = "Dezembro" then
		nrMes = 12
	end if
	retmesnr = nrMes
end function
	
function retnrmesabr(byval mes)
	if mes = 1 then
		retnrmesabr = "jan"
	elseif mes = 2 then
		retnrmesabr = "fev"
	elseif mes = 3 then
		retnrmesabr = "mar"
	elseif mes = 4 then
		retnrmesabr = "abr"
	elseif mes = 5 then
		retnrmesabr = "mai"
	elseif mes = 6 then
		retnrmesabr = "jun"
	elseif mes = 7 then
		retnrmesabr = "jul"
	elseif mes = 8 then
		retnrmesabr = "ago"
	elseif mes = 9 then
		retnrmesabr = "set"
	elseif mes = 10 then
		retnrmesabr = "out"
	elseif mes = 11 then
		retnrmesabr = "nov"
	elseif mes = 12 then
		retnrmesabr = "dez"
	end if
end function
	
	
function fimmes(byval mes)
	if mes = "2" then
		fimmes = "28"
	elseif mes = "1" or mes = "3" or mes = "5" or mes = "7" or mes = "8" or mes = "10" or mes = "12" then
		fimmes = "31"
	else
		fimmes = "30"
	end if
end function

function criachave(byval tamanho)
	dim chave, letraNumero
	if isnumeric(tamanho) and not isnull(tamanho) then
		while len(chave) < tamanho
			randomize timer
			letraNumero = int(rnd * 3)
			randomize timer
			if letraNumero = 0 then
				chave = chave & chr(int(48 + rnd * 10))
			elseif letraNumero = 1 then
				chave = chave & chr(int(65 + rnd * 26))
			else
				chave = chave & chr(int(97 + rnd * 26))
			end if
		wend
	else
		chave = ""
	end if
	criachave = chave
end function

function criachavenumerica(byval tamanho)
	dim chave, i, letraNumero
	if isnumeric(tamanho) then
		while len(chave) < tamanho
			randomize timer
			chave = chave & chr(int(48 + rnd * 10))
		wend
	end if
	criachavenumerica = chave
end function


Function URLDecode(byval sConvert)
	Dim aSplit
	Dim sOutput
	Dim I
	If IsNull(sConvert) or sConvert = "" Then
	   URLDecode = ""
	   Exit Function
	End If
	
	' convert all pluses to spaces
	sOutput = REPLACE(sConvert, "+", " ")
	
	' next convert %hexdigits to the character
	aSplit = Split(sOutput, "%")
	
	If IsArray(aSplit) Then
	  sOutput = aSplit(0)
	  For I = 0 to UBound(aSplit) - 1
		sOutput = sOutput & _
		  Chr("&H" & Left(aSplit(i + 1), 2)) &_
		  Right(aSplit(i + 1), Len(aSplit(i + 1)) - 2)
	  Next
	End If
	
	URLDecode = sOutput
End Function

function htmlDecode(byval texto)
	texto = replace(texto, "&amp;", "&")
	texto = replace(texto, "&lt;", "<")
	texto = replace(texto, "&gt;", ">")
	texto = replace(texto, "&quot;", """")
	texto = replace(texto, "&apos;", "'")
	
	htmlDecode = texto
end function


'Pega somente o código do vídeo da url do youtube
function pegaCodigoYT(byval url)
	dim regex, grupo, resultado		
	
	set regex = new regexp
	regex.ignoreCase = true
	regex.global = false
	regex.pattern = "(.+?(watch/?\?v=|youtu\.be/|v/|embed/))(.+?)(&|\?|$)"
	
	resultado = ""
	
	resultado = regex.replace(url, "$3")
	
	pegaCodigoYT = resultado
end function

function imagemYT(byval codigo)
	imagemYT = "http://img.youtube.com/vi/" & codigo & "/0.jpg"
end function


' Ordena uma lista de itens
sub ordenarTabela(byval tabela, byval campoId, byval campoPosicao, byval idUtilizado, byval posicaoUtilizada, byval condicoesExtra, byref cn)
	dim ordem, tbl, idAtual, queryBase
	
	ordem = 0
	posicaoUtilizada = cint(posicaoUtilizada)
	
	queryBase = "update " & tabela & " set " & campoPosicao & " = @posicao where " & campoId & " = @id"
	
	set tbl = cn.execute("select " & campoId & " from " & tabela & " where " & campoId & " <> " & idUtilizado & condicoesExtra & " order by " & campoPosicao & " asc, " & campoId & " asc")
	while not tbl.eof
		ordem = ordem + 1
		idAtual = tbl(campoId)
		if ordem = posicaoUtilizada then ordem = ordem + 1
		
		cn.execute replace(replace(queryBase, "@posicao", ordem), "@id", idAtual)
		
		tbl.movenext
	wend
	set tbl = nothing
end sub


function getHTML (byval strUrl, byval dados, byval tipo)
	dim oldTimeout
	oldTimeout = server.ScriptTimeout
	server.ScriptTimeout = 5000
	
	'on error resume next
	Set xmlHttp = Server.Createobject("MSXML2.ServerXMLHTTP.4.0")
	xmlHttp.Open tipo, strUrl, False
	xmlHttp.setRequestHeader "User-Agent", "asp httprequest"
	xmlHttp.setRequestHeader "content-type", "application/x-www-form-urlencoded"
	
	lResolve = 15 * 1000
	lConnect = 15 * 1000
	lSend = 30 * 1000
	lReceive = 60 * 1000

	xmlHttp.setTimeouts lResolve, lConnect, lSend, lReceive
	
	xmlHttp.Send(dados)
	if xmlHttp.status = 200 then
		getHTML = xmlHttp.responseText
	else
		getHTML = "Informações não disponíveis"
	end if
	xmlHttp.abort()
	set xmlHttp = Nothing
	server.ScriptTimeout = oldTimeout
	
	if err.number <> 0 then getHTML = "Informações não disponíveis"
	
	on error goto 0
end function

sub avisaErro(byval mensagem)
	%>
	<noscript>
		<h1><%= replace(replace(mensagem, "\r\n", "<br>"), "\n", "<br>") %></h1>
	</noscript>
	<script type="text/javascript">
		alert("<%= replace(replace(mensagem, """", "'"), vbNewLine, " ") %>");
		history.back();
	</script>
	<%
	cnclose (cn)
	cn2close (cn2)
	response.end
end sub

sub alerta(byval mensagem)
	%>
	<script type="text/javascript">
		alert("<%=mensagem%>");
	</script>
	<%
end sub

sub avisaFecha(byval mensagem)
	%>
	<noscript>
		<h1><%= replace(replace(mensagem, "\r\n", "<br>"), "\n", "<br>") %></h1>
	</noscript>
	<script type="text/javascript">
		alert("<%= replace(replace(mensagem, """", "'"), vbNewLine, " ") %>");
		window.close();
	</script>
	<%
	cnclose
	response.end
end sub

'função que incrementa um contador e retorna seu valor sem incremento
function inc(byref contador)
	inc = contador
	contador = contador + 1
end function

'função que devolve as linhas de um select
function fnGetRows(byval sql, byref cn)
	dim rs, rsResultado
	set rs = server.CreateObject("adodb.recordset")
	
	on error resume next
	
	rs.open sql, cn, 3, 3
	
	if err.number <> 0 then
		response.write err.number & " - " & err.source & " - " & err.description & "<br>"
		response.write sql
		response.end
	end if
	
	if not rs.eof then rsResultado = rs.getRows()
	rs.close
	set rs = nothing
	
	on error goto 0
	
	fnGetRows = rsResultado
end function

'função que devolve as linhas de um select como uma string
function fnGetString(byval sql, byref cn)
	dim rs, rsResultado
	set rs = server.CreateObject("adodb.recordset")
	
	on error resume next
	
	rs.open sql, cn, 3, 3
			
	if err.number <> 0 then
		response.write err.number & " - " & err.source & " - " & err.description & "<br>"
		response.write sql
		response.end
	end if
	
	if not rs.eof then
		rsResultado = rs.getString(,,"",", ","")
		rsResultado = left(rsResultado,len(rsResultado)-2)
	end if
	rs.close
	set rs = nothing
	on error goto 0
	
	fnGetString = rsResultado
end function

'função que devolve um valor de uma consulta
function fnGetOneValue(byval sql, byref cn)
	dim rs, rsResultado
	rsResultado = ""
	set rs = server.CreateObject("adodb.recordset")
	
	on error resume next
	
	rs.open sql, cn, 3, 3
			
	if err.number <> 0 then
		response.write err.number & " - " & err.source & " - " & err.description & "<br>"
		response.write sql
		response.end
	end if
	
	if not rs.eof then rsResultado = rs.fields(0).value
	rs.close
	set rs = nothing
	on error goto 0
	
	fnGetOneValue = rsResultado
end function

'função que vê se tem registros numa query
function fnHasRows(byval sql, byref cn)
	fnHasRows = fnTemRegistro(sql, cn)
end function

function fnTemRegistro(byval sql, byref cn)
	dim rs, rsResultado
	rsResultado = false
	set rs = server.CreateObject("adodb.recordset")
	
	on error resume next
	
	rs.open sql, cn, 3, 3
			
	if err.number <> 0 then
		response.write err.number & " - " & err.source & " - " & err.description & "<br>"
		response.write sql
		response.end
	end if
	
	if not rs.eof then rsResultado = true
	rs.close
	set rs = nothing
	on error goto 0
	
	fnTemRegistro = rsResultado
end function

'função que insere e devolve o ID inserido
function fnNewID(byval sql, byval campo, byval tabela, byref cn)
	dim rs, rsResultado
	cn.execute(sql)
	set rs = cn.execute("select " & campo & " as novoID from " & tabela & " order by " & campo & " desc limit 1")
	if not rs.eof then rsResultado = rs("novoID")
	set rs = nothing
	fnSetGetNewID = rsResultado
end function


'funcoes adicionais
function completa(byval numero, byval casas, byval caractere)
	dim i
	if isnumeric(casas) then
		tamanho = casas - len(cstr(numero))
		for i = 1 to tamanho
			numero = caractere & numero
		next
		completa = numero
	else
		completa = ""
	end if
end function

function completaD(byval numero, byval casas, byval caractere)
	dim i
	if isnumeric(casas) then
		tamanho = casas - len(cstr(numero))
		for i = 1 to tamanho
			numero = numero & caractere
		next
	end if
	completa = numero
end function

sub erroIfNotalid(byval valor, byval mensagem)
	if not isValid(valor) then avisaErro mensagem
end sub

sub erroIfNotValidNumber(byval valor, byval mensagem)
	if not isValidNumber(valor) then avisaErro mensagem
end sub

function ifNotValid(byval valor, byval valorSeInvalido)
	if not isValid(valor) then
		ifNotValid = valorSeInvalido
	else
		ifNotValid = valor
	end if
end function

function ifNotValidNumber(byval valor, byval valorSeInvalido)
	if not isValidNumber(valor) then
		ifNotValidNumber = valorSeInvalido
	else
		ifNotValidNumber = cdbl(valor)
	end if
end function

function formatValid(byval numero, byval casas)
	if isValidNumber(numero) then
		formatValid = formatNumber(numero, casas)
	else
		formatValid = ""
	end if			
end function

function formatValidRound(byval numero, byval casas)
	if isValidNumber(numero) then
		formatValidRound = round(numero, casas)
	else
		formatValidRound = ""
	end if			
end function

' se o número informado for válido, retorna o número formatado com o número de casas decimais informado,
' se não, retorna zero formatado com o número de casas informado
function formatValidZero(byval numero, byval casas)
	if isValidNumber(numero) then
		formatValidZero = formatNumber(numero, casas)
	else
		formatValidZero = formatNumber(0, casas)
	end if			
end function

' retorna true se o valor não é vazio e é um número válido
function isValidNumber(byval valor)
	if vartype(valor) = 14 then valor = ccur(valor)
	isValidNumber = valor <> "" and isNumeric(valor)
end function

' retorna true se o valor não é vazio e é uma data válida
function isValidDate(byval valor)
	isValidDate = valor <> "" and isDate(valor)
end function

' retorna true se o valor informado não é nulo ou vazio, false em caso contrário
function isValid(byval valor)
	dim retorno
	retorno = false
	if not isnull(valor) then
		if trim(valor) <> "" then
			if varType(valor) <> 14 then
				Select case typeName(valor)
					case "Field"
						retorno = isValid(valor.value)
					case else
						retorno = true
				end select
			else
				retorno = isValidNumber(valor)
			end if
		end if
	end if
	isValid = retorno
end function

' retorna o texto "Não" para a string "n" e "Sim" para "s"
function sn(byval texto)
	dim retorna
	if texto = "n" then
		retorna = "Não"
	elseif texto = "s" then
		retorna = "Sim"
	end if
	sn = retorna
end function

' retorna o texto "Não" para falso e "Sim" para verdadeiro"
function tf(byval texto)
	dim retorna
	if texto = false then
		retorna = "Não"
	elseif texto = true then
		retorna = "Sim"
	end if
	tf = retorna
end function

' retorna o texto informado com quebras de linha em HTML
function quebraLinhaBR(byval texto)
	dim retorno
	retorno = texto
	if isValid(texto) then
		retorno = replace(retorno, vbCrLf, "<br />")
		retorno = replace(retorno, vbCr, "<br />")
		retorno = replace(retorno, vbLf, "<br />")
		retorno = replace(retorno, vbTab, "&nbsp;&nbsp;&nbsp;&nbsp;")
	end if
	quebraLinhaBR = retorno
end function

function removeHTML(byval texto)
	dim retorno
		
	retorno = ""
		
	if isValid(texto) then
		dim regex
		set regex = new Regexp
		regex.pattern = "(<[^>]+?>)"
		regex.global = true
		regex.ignoreCase = true
		
		retorno = trim(regex.replace(texto, ""))
			
		set regex = nothing
	end if
		
	removeHTML = retorno
end function

' remove caracteres especiais de um texto e prepara identificadores com espaços
function removeEspeciaisSemHifem(byval texto)
	removeEspeciaisSemHifem = replace(removeEspeciais(texto), "-", " ")
end function

' remove cacacteres especiais de um texto para preparar identificadores
function removeEspeciais(byval texto)
	Dim retorno, caractere, i, regex
	retorno = texto
	
	if isValid(texto) then
		texto = trim(texto)
		
		redim retorno(len(texto))
		
		For i = 1 To Len(texto)
			caractere = Mid(texto, i, 1)
			
			Select Case caractere
				Case "a", "á", "à", "â", "ä", "ã"
					retorno(i - 1) = "a"
				Case "A", "Á", "À", "Â", "Ä", "Ã"
					retorno(i - 1) = "A"
				Case "e", "é", "è", "ê", "ë"
					retorno(i - 1) = "e"
				Case "E", "É", "È", "Ê", "Ë"
					retorno(i - 1) = "E"
				Case "i", "í", "ì", "ï", "î"
					retorno(i - 1) = "i"
				Case "I", "Í", "Ì", "Ï", "Î"
					retorno(i - 1) = "I"
				Case "o", "ó", "ô", "ö", "ò", "õ"
					retorno(i - 1) = "o"
				Case "O", "Ó", "Ô", "Ö", "Ò", "Õ"
					retorno(i - 1) = "O"
				Case "u", "ú", "ù", "û", "ü"
					retorno(i - 1) = "u"
				Case "U", "Ú", "Ù", "Û", "Ü"
					retorno(i - 1) = "U"
				Case "c", "ç"
					retorno(i - 1) = "c"
				Case "C", "Ç"
					retorno(i - 1) = "C"
				Case "ñ", "n"
					retorno(i - 1) = "n"
				Case "Ñ", "N"
					retorno(i - 1) = "N"
				Case "ÿ", "y"
					retorno(i - 1) = "y"
				Case "æ"
					retorno(i - 1) = "ae"
				Case "Æ"
					retorno(i - 1) = "AE"
				Case "œ"
					retorno(i - 1) = "oe"
				Case "Œ"
					retorno(i - 1) = "OE"
				Case ",", "-", " ", "_", "/", "\", "(", ")", "[", "]", "{", "}", "´", "`", "`", "~", "¨", ":", ";", ">", "<", "|", ".", "+", "@", "&", "=", "Ø", "¬", "§"
					retorno(i - 1) = "-"
				Case "?", "!", "#", """", "'", "%", "°", "º", "ª", "*", "$", "€", "¢"
					' caracteres para remover
				Case Else
					retorno(i - 1) = caractere
			End Select
		Next
		retorno = join(retorno, "")
		
		set regex = new regexp
		regex.pattern = "--+"
		regex.global = true
		retorno = regex.replace(retorno, "-")
		regex.pattern = "^-+|-+$"
		retorno = regex.replace(retorno, "")
		set regex = nothing
	end if
	
	removeEspeciais = retorno
End Function

'Funções auxiliares
'Arredonda um número para baixo
function floor(byval numero)
	dim retorno
	retorno = numero
	if isnumeric(numero) and not isempty(numero) then
		retorno = clng(numero)
		if retorno > numero then retorno = retorno - 1
	end if
	floor = retorno
end function

'Arredonda um número para cima
function ceil(byval numero)
	dim retorno
	retorno = numero
	if isnumeric(numero) and not isempty(numero) then
		retorno = clng(numero)
		if retorno < numero then retorno = retorno + 1
	end if
	ceil = retorno
end function

'Retorna o maior de 2 números
function MathMax(byval num1, byval num2)
	dim retorno
	retorno = false
	if not isempty(num1) and isnumeric(num1) and not isempty(num2) and isnumeric(num2) then
		if num1 > num2 then
			retorno = num1
		else
			retorno = num2
		end if
	end if
	MathMax = retorno
end function

'Retorna o menor de 2 números
function MathMin(byval num1, byval num2)
	dim retorno
	retorno = false
	if not isempty(num1) and isnumeric(num1) and not isempty(num2) and isnumeric(num2) then
		if num1 < num2 then
			retorno = num1
		else
			retorno = num2
		end if
	end if
	MathMin = retorno
end function


'Retorna a média de 2 números
function MathMedia(byval num1, byval num2)
	dim retorno, numeros
	retorno = false
	numeros = 0
	if not isempty(num1) and isnumeric(num1) then
		retorno = num1
		numeros = 1
	end if
	if not isempty(num2) and isnumeric(num2) then
		if numeros > 0 then
			retorno = retorno + num2
		else
			retorno = num2
		end if
		numeros = numeros + 1
	end if
	if numeros > 0 then retorno = retorno / numeros
	MathMedia = retorno
end function



' Limite um texto a uma certa quantidade de caracteres
' Se passar do tamanho definido, retorna o texto truncado com reticências
function limitarTexto(byval texto, byval tamanho)
	dim resultado
	if isnull(texto) then
		resultado = ""
	else
		resultado = texto
	end if
	if resultado <> "" then
		if len(resultado) > tamanho then
			resultado = left(resultado, tamanho - 3) & "..."
		end if
	end if
	limitarTexto = resultado
end function


' retorna o último dia do mês
function ultDiaMes(byval mes, byval ano)
	dim data, retorno
	data = cdate("1/" & mes & "/" & ano)
	data = dateAdd("m", 1, data)
	data = dateAdd("d", -1, data)
	retorno = datePart("d", data)
	ultDiaMes = retorno
end function


' ordena um array
Private Sub QuickSort(ByRef C, ByVal First, ByVal Last)
	'
	' Made by Michael Ciurescu (CVMichael from vbforums.com)
	' Original thread: http://www.vbforums.com/showthread.php?t=231925
	'
	Dim Low, High
	Dim MidValue
	
	Low = First
	High = Last
	MidValue = (C((First + Last) \ 2)).name
	
	Do
		While (C(Low)).name < MidValue
			Low = Low + 1
		Wend
		
		While (C(High)).name > MidValue
			High = High - 1
		Wend
		
		If Low <= High Then
			'Swap
			Dim T
			set T = C(Low)
			set C(Low) = C(High)
			set C(High) = T
			
			Low = Low + 1
			High = High - 1
		End If
	Loop While Low <= High
	
	If First < High Then QuickSort C, First, High
	If Low < Last Then QuickSort C, Low, Last
End Sub


' remove o último elemento de um array e retorna o elemento removido
function arrayPop(byval arr)
	dim el, tamanho
	
	tamanho = ubound(arr)
	
	el = arr(ubound(arr))
	
	redim preserve arr(tamanho - 1)
	
	arrayPop = el
end function


' insere um elemento em um array e retorna o array modificado
function arrayPush(byref arr, byval valor)
	dim tamanho
	tamanho = ubound(arr) + 1
	
	redim preserve arr(tamanho)
	
	arr(tamanho) = valor

	arrayPush = arr
end function


' retorna um texto com o valor por extenso
Function Extenso(Valor, MoedaPlural, MoedaSingular)
	Dim StrValor, Negativo
	Dim Buf, Parcial
	Dim Posicao, Unidades
	Dim Dezenas, Centenas, PotenciasSingular
	Dim PotenciasPlural

	Negativo = (Valor < 0)
	Valor = Abs(CDbl(Valor))

	If Valor Then
		Unidades = Array(vbNullString, "Um", "Dois", "Três", "Quatro", "Cinco", "Seis", "Sete", "Oito", "Nove", _
							 "Dez", "Onze", "Doze", "Treze", "Quatorze", "Quinze", "Dezesseis", "Dezessete", "Dezoito", "Dezenove")

		Dezenas = Array(vbNullString, vbNullString, "Vinte", "Trinta", "Quarenta", "Cinqüenta", "Sessenta", "Setenta", "Oitenta", "Noventa")

		Centenas = Array(vbNullString, "Cento", "Duzentos", "Trezentos", "Quatrocentos", "Quinhentos", "Seiscentos", "Setecentos", "Oitocentos", "Novecentos")

		PotenciasSingular = Array(vbNullString, " Mil", " Milhão", " Bilhão", " Trilhão", " Quatrilhão")
		PotenciasPlural = Array(vbNullString, " Mil", " Milhões", " Bilhões", " Trilhões", " Quatrilhões")

		StrValor = completa(Int(Valor), 18, "0")

		For Posicao = 1 To 18 Step 3
			Parcial = Val(Mid(StrValor, Posicao, 3))

			If Parcial Then
				If Parcial = 1 Then
					Buf = "Um" & PotenciasSingular((18 - Posicao) \ 3)

				ElseIf Parcial = 100 Then
					Buf = "Cem" & PotenciasSingular((18 - Posicao) \ 3)

				Else
					Buf = Centenas(Parcial \ 100)
					Parcial = Parcial Mod 100

					If Parcial <> 0 And Buf <> vbNullString Then
						Buf = Buf & " e "
					End If

					If Parcial < 20 Then
						Buf = Buf & Unidades(Parcial)
					Else
						Buf = Buf & Dezenas(Parcial \ 10)
						Parcial = Parcial Mod 10

						If Parcial <> 0 And Buf <> vbNullString Then
							Buf = Buf & " e "
						End If

						Buf = Buf & Unidades(Parcial)
					End If

					Buf = Buf & PotenciasPlural((18 - Posicao) \ 3)
				End If

				If Buf <> vbNullString Then
					If Extenso <> vbNullString Then
						Parcial = Val(Mid(StrValor, Posicao, 3))

						If Posicao = 16 And (Parcial < 100 Or (Parcial Mod 100) = 0) Then
							Extenso = Extenso & " e "
						Else
							Extenso = Extenso & ", "
						End If
					End If

					Extenso = Extenso & Buf
				End If
			End If
		Next

		If Extenso <> vbNullString Then
			If Negativo Then
				Extenso = "Menos " & Extenso
			End If

			If Int(Valor) = 1 Then
				Extenso = Extenso & " " & MoedaSingular
			Else
				Extenso = Extenso & " " & MoedaPlural
			End If
		End If

		Parcial = Int((Valor - Int(Valor)) * 100 + 0.1)

		If Parcial Then
			Buf = Extenso(Parcial, "Centavos", "Centavo")

			If Extenso <> vbNullString Then
				Extenso = Extenso & " e "
			End If

			Extenso = Extenso & Buf
		End If
	End If
End Function


function preparaCSV(byval texto)
	if not isNull(texto) then
		preparaCSV = replace(replace(texto, ";", ","), vbcrlf, " ")
	else
		preparaCSV = ""
	end if
end function


function validaCPFouCNPJ(valor)
	dim regex, numero
	set regex = new regexp
	regex.pattern = "\D"
	regex.global = true
	regex.ignoreCase = true

	numero = regex.replace(valor, "")
	
	set regex = nothing
	
	
	if len(numero) <> 11 and len(numero) <> 14 then
		validaCPFouCNPJ = false
		
	elseif len(numero) = 11 then
		validaCPFouCNPJ = validaCPF(numero)
		
	else
		validaCPFouCNPJ = validaCNPJ(numero)
	end if
end function


function validaCNPJ(varCNPJ)
	Dim RecebeCNPJ, Numero(14), soma, resultado1, resultado2
	RecebeCNPJ = varCNPJ
	
	dim regex
	set regex = new regexp
	regex.pattern = "\D"
	regex.global = true
	regex.ignoreCase = true

	RecebeCNPJ = regex.replace(RecebeCNPJ, "")
	
	set regex = nothing
	
	if len(RecebeCNPJ) <> 14 then
		validaCNPJ = false
	elseif RecebeCNPJ = "00000000000000" or RecebeCNPJ = "11111111111111" then
		validaCNPJ = false
	else
		Numero(1) = Cint(Mid(RecebeCNPJ,1,1))
		Numero(2) = Cint(Mid(RecebeCNPJ,2,1))
		Numero(3) = Cint(Mid(RecebeCNPJ,3,1))
		Numero(4) = Cint(Mid(RecebeCNPJ,4,1))
		Numero(5) = Cint(Mid(RecebeCNPJ,5,1))
		Numero(6) = CInt(Mid(RecebeCNPJ,6,1))
		Numero(7) = Cint(Mid(RecebeCNPJ,7,1))
		Numero(8) = Cint(Mid(RecebeCNPJ,8,1))
		Numero(9) = Cint(Mid(RecebeCNPJ,9,1))
		Numero(10) = Cint(Mid(RecebeCNPJ,10,1))
		Numero(11) = Cint(Mid(RecebeCNPJ,11,1))
		Numero(12) = Cint(Mid(RecebeCNPJ,12,1))
		Numero(13) = Cint(Mid(RecebeCNPJ,13,1))
		Numero(14) = Cint(Mid(RecebeCNPJ,14,1))
		
		soma = Numero(1) * 5 + Numero(2) * 4 + Numero(3) * 3 + Numero(4) * 2 + Numero(5) * 9 + Numero(6) * 8 + Numero(7) * 7 + Numero(8) * 6 + Numero(9) * 5 + Numero(10) * 4 + Numero(11) * 3 + Numero(12) * 2
		soma = soma -(11 * (int(soma / 11)))
		if soma = 0 or soma = 1 then
			resultado1 = 0
		else
			resultado1 = 11 - soma
		end if
		
		if resultado1 = Numero(13) then
			soma = Numero(1) * 6 + Numero(2) * 5 + Numero(3) * 4 + Numero(4) * 3 + Numero(5) * 2 + Numero(6) * 9 + Numero(7) * 8 + Numero(8) * 7 + Numero(9) * 6 + Numero(10) * 5 + Numero(11) * 4 + Numero(12) * 3 + Numero(13) * 2
			soma = soma - (11 * (int(soma/11)))
			
			if soma = 0 or soma = 1 then
				resultado2 = 0
			else
				resultado2 = 11 - soma
			end if
			
			if resultado2 = Numero(14) then
				'CNPJ Válido
				validaCNPJ = true
			else
				validaCNPJ = false
			end if
		else
			validaCNPJ = false
		end if
	end if
end function

function validaCPF(varCPF)
	Dim RecebeCPF, Numero(11), soma, resultado1, resultado2
	RecebeCPF = varCPF

	dim regex
	set regex = new regexp
	regex.pattern = "\D"
	regex.global = true
	regex.ignoreCase = true

	RecebeCNPJ = regex.replace(RecebeCNPJ, "")
	
	set regex = nothing


	if len(RecebeCPF) <> 11 then
		validaCPF = false
	elseif RecebeCPF = "00000000000" or RecebeCPF = "11111111111" then
		validaCPF = false
	else
		Numero(1) = Cint(Mid(RecebeCPF,1,1))
		Numero(2) = Cint(Mid(RecebeCPF,2,1))
		Numero(3) = Cint(Mid(RecebeCPF,3,1))
		Numero(4) = Cint(Mid(RecebeCPF,4,1))
		Numero(5) = Cint(Mid(RecebeCPF,5,1))
		Numero(6) = CInt(Mid(RecebeCPF,6,1))
		Numero(7) = Cint(Mid(RecebeCPF,7,1))
		Numero(8) = Cint(Mid(RecebeCPF,8,1))
		Numero(9) = Cint(Mid(RecebeCPF,9,1))
		Numero(10) = Cint(Mid(RecebeCPF,10,1))
		Numero(11) = Cint(Mid(RecebeCPF,11,1))
		
		soma = 10 * Numero(1) + 9 * Numero(2) + 8 * Numero(3) + 7 * Numero(4) + 6 * Numero(5) + 5 * Numero(6) + 4 * Numero(7) + 3 * Numero(8) + 2 * Numero(9)
		soma = soma -(11 * (int(soma / 11)))

		if soma = 0 or soma = 1 then
			resultado1 = 0
		else
			resultado1 = 11 - soma
		end if
		
		if resultado1 = Numero(10) then
			soma = Numero(1) * 11 + Numero(2) * 10 + Numero(3) * 9 + Numero(4) * 8 + Numero(5) * 7 + Numero(6) * 6 + Numero(7) * 5 + Numero(8) * 4 + Numero(9) * 3 + Numero(10) * 2
			soma = soma -(11 * (int(soma / 11)))
			
			if soma = 0 or soma = 1 then
				resultado2 = 0
			else
				resultado2 = 11 - soma
			end if
			
			if resultado2 = Numero(11) then
				validaCPF = true
			else
				validaCPF = false
			end if
		else 
			validaCPF = false
		end if
	end if
end function


'escreve variáveis na página
sub rw(byval campo)
	response.write eval(campo) & " ----> " & campo & "<BR>"
end sub
sub rwh(byval campo)
	response.write eval(campo) & " ----> " & campo & "<HR>"
end sub

'dar response.end
sub re()
	response.End()
end sub

Public Function convertImageToBase64(filePath)
  Dim inputStream
  Set inputStream = CreateObject("ADODB.Stream")
  inputStream.Open
  inputStream.Type = 1  ' adTypeBinary
  inputStream.LoadFromFile filePath
  Dim bytes: bytes = inputStream.Read
  Dim dom: Set dom = CreateObject("Microsoft.XMLDOM")
  Dim elem: Set elem = dom.createElement("tmp")
  elem.dataType = "bin.base64"
  elem.nodeTypedValue = bytes
  convertImageToBase64 = "data:image/png;base64," & Replace(elem.text, vbLf, "")
End Function

public sub mensagem(byval classe, byval texto)
	dim divAlerta
	divAlerta = "<div class=""alert text-center alert-" & classe & """>" & texto & "</div>"
	response.write divAlerta
end sub
%>