; Automatize a digitação de coisas como datas, CPFs, CNPJs e números aleatórios.
; Autor: Gustavo Moraes <gustavomdsantos@pm.me>
;
; AutoHotKey Beginner Tutorial: https://www.autohotkey.com/docs/Tutorial.htm
; AutoHotKey Key list: https://autohotkey.com/docs/KeyList.htm
; AutoHotKey Hotkeys: https://www.autohotkey.com/docs/Hotkeys.htm

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance Force
scriptName = Auto-Typer (by gustavosotnas)

; Digita automaticamente a data de hoje (Today).
^!t::
	Send, %A_DD%/%A_MM%/%A_YYYY%
return

; Gera CPFs aleatorios validos.
^!f::
	; Geramos valores aleatórios para os primeiros nove dígitos
	Random, n1, 0, 9
	Random, n2, 0, 9
	Random, n3, 0, 9
	Random, n4, 0, 9
	Random, n5, 0, 9
	Random, n6, 0, 9
	Random, n7, 0, 9
	Random, n8, 0, 9
	Random, n9, 0, 9
	; Calculamos o primeiro dígito verificador
	d1 := n9 * 2 + n8 * 3 + n7 * 4 + n6 * 5 + n5 * 6 + n4 * 7 + n3 * 8 + n2 * 9 + n1 * 10
	d1 := 11 - (Mod(d1, 11))
	if (d1 > 9) {
		d1 := 0
	}
	; Calculamos o segundo dígito verificador
	d2 := d1 * 2 + n9 * 3 + n8 * 4 + n7 * 5 + n6 * 6 + n5 * 7 + n4 * 8 + n3 * 9 + n2 * 10 + n1 * 11
	d2 := 11 - (Mod(d2, 11))
	if (d2 > 9) {
		d2 := 0
	}
	SendInput %n1%%n2%%n3%%n4%%n5%%n6%%n7%%n8%%n9%%d1%%d2%
return

; Gera CNPJs aleatorios validos.
^!j::
    ; Geramos valores aleatórios para os primeiros oito dígitos
    Random, n1, 0, 9
    Random, n2, 0, 9
    Random, n3, 0, 9
    Random, n4, 0, 9
    Random, n5, 0, 9
    Random, n6, 0, 9
    Random, n7, 0, 9
    Random, n8, 0, 9
    n9 := 0
    n10 := 0
    n11 := 0
    n12 := 1
    ; Calculamos o primeiro dígito verificador
    d1 := n12 * 2 + n11 * 3 + n10 * 4 + n9 * 5 + n8 * 6 + n7 * 7 + n6 * 8 + n5 * 9 + n4 * 2 + n3 * 3 + n2 * 4 + n1 * 5
    d1 := 11 - (Mod(d1, 11))
    if (d1 > 9) {
        d1 := 0
    }
    ; Calculamos o segundo dígito verificador
    d2 := d1 * 2 + n12 * 3 + n11 * 4 + n10 * 5 + n9 * 6 + n8 * 7 + n7 * 8 + n6 * 9 + n5 * 2 + n4 * 3 + n3 * 4 + n2 * 5 + n1 * 6
    d2 := 11 - (Mod(d2, 11))
    if (d2 > 9) {
        d2 := 0
    }
    Send %n1%%n2%%n3%%n4%%n5%%n6%%n7%%n8%%n9%%n10%%n11%%n12%%d1%%d2%
return

; Gera numeros aleatorios de 9 digitos. Util para gerar numeros de NFs de terceiros ficticios.
^!n::
	Random, randomNumber, 0, 999999999
	Send %randomNumber%
return

; Remove todas as ocorrencias de caracteres que nao sejam numericos (util para remover mascaras de numeros de telefone, CPF, CNPJ, etc).
^!r::
	selectedText := getSelectedText()
	filteredText := RegExReplace(selectedText, "[^0-9]+", "")

	MsgBox, 4, Removedor de mascaras do %scriptName%, DIFF DO TEXTO SELECIONADO:`n`nAntes:    %selectedText%`nDepois:  %filteredText%`n`nConfirma as mudancas?

	IfMsgBox Yes
		Send %filteredText%
return

; ============================= FUNÇÕES AUXILIARES =============================

getSelectedText() {
	clipboardOld := Clipboard        ; backup clipboard
	Send, ^c                         ; copy selected text to clipboard
	text := Clipboard                ; store selected text
	Clipboard := clipboardOld        ; restore clipboard contents
	return text
}
