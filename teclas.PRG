LPARAMETERS nKeyCode, nShiftAltCtrl

*MESSAGEBOX("nShift="+TRANSFORM(nShiftAltCtrl)+CHR(13)+"nKeyCode="+TRANSFORM(nKeyCode))

IF nShiftAltCtrl=2
	DO case
		CASE nkeyCode=94	&& F1
			this.Value="Presionó Tecla Función [Ctrl+F1]"
		CASE nKeyCode=95	&& F2
			this.Value="Presionó Tecla Función [Ctrl+F2]"
		CASE nKeyCode=96	&& F3
			this.Value="Presionó Tecla Función [Ctrl+F3]"
	ENDCASE
ENDIF

* Alternativamente, para un tratamiento más general.

LPARAMETERS nKeyCode, nShiftAltCtrl

IF nShiftAltCtrl=2.and.Between(nKeyCode,94,96)
        Thisform.GetFunc(1000*nShiftAltCtrl + nKeyCode , this)
ENDIF

&& Metodo del form llamado "GetFunc"

LPARAMETERS xnTecla , xoObjeto
DO case
	CASE xnTecla=2094
		xoObjeto.Value="Valor, return de función o Proc Para Ctrl+F1"
	CASE xnTecla=2095
		xoObjeto.Value="Valor, return de Función o Proc para Ctrl+F2"
	CASE xnTecla=2096
		xoObjeto.value="Valor, return de Func. para Ctrl+F3"
	CASE xnTecla=1084
		xoObjeto.Value="Valor, return de función o Proc Para shift+F1"
	CASE xnTecla=1085
		xoObjeto.Value="Valor, return de Función o Proc para Shift+F2"
	CASE xnTecla=1086
		xoObjeto.value="Valor, return de Func. para Shift+F3"
ENDCASE
