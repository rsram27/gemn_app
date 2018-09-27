<%
Function Decodifica(ByVal strNome)
    Dim i 
    Dim intRnd 
    Dim intLetra 
    Dim strCod

    intRnd = Asc(Mid(strNome, 3, 1))
    If InStr("€‚ƒ„…†‡ˆ‰Š‹ŒŽ‘’“”•–—˜™š›œžŸ ¡¢£¤¥¦§¨©ª«¬­®¯°±²³´µ¶·¸¹º»¼½¾¿ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ×ØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõö÷øùúûüýþÿ", Left(strNome, 1)) <> 0 Then
        strNome = Left(strNome, 2) & Mid(strNome, 4, Len(strNome))
    End If

    For i = 1 To Len(strNome)
        intLetra = Asc(Mid(strNome, i, 1))
        If intLetra = 33 Then
            i = i + 1
            intLetra = Asc(Mid(strNome, i, 1)) + intRnd
        Else
            intLetra = intLetra - intRnd
        End If
        If intLetra > 0 Then
            strCod = strCod & Chr(intLetra)
        Else
            strCod = strCod & Mid(strNome, i, 1)
        End If
    Next
    Decodifica = strCod
    Exit Function

End Function
%>