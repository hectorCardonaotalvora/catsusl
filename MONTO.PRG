***********************************************************
* Programa.....: Monto.prg                                *
*                                                         *
* Objetivo.....: convertir un valor numerico              *
*..............: a escritura alfabetica                   *
***********************************************************
param acumu,_vlrMonto
public part_1,part_2,part_3,part_4,colo
SET TALK OFF
store " " to var_cen,var_dec,var_uni
store " " to var_cenmil,var_decmil,var_unimil
store " " to var_cemill,var_demill,var_unmill
var = MTOTALNE
IF VAR<0
   colo="MENOS "
ELSE
   COLO=""
ENDIF
VAR=ABS(VAR)
parte=str(var,13,3)
part_1=substr(parte,1,3)  &&millones
part_2=substr(parte,4,3)  &&miles
part_3=substr(parte,7,3)  &&unidades
part_4=substr(parte,11,2) &&decimal 
store "" to to0,to1,to2,to3
if part_1<>space(3) &&millones
   do base3 with part_1,var_cemill,var_demill,var_unmill
   to3=trim(var_cemill+var_demill+var_unmill)
endif
if part_2<>space(3) &&miles 
   do base2 with part_2,var_cenmil,var_decmil,var_unimil
   to2=trim(var_cenmil+var_decmil+var_unimil)
endif
if part_3<>space(3) .and. part_3<>"000" &&unidades
   part_3=trim(str(val(part_3),3,0))
   do base1 with part_3,var_cen,var_dec,var_uni
   to1=trim(var_cen+var_dec+var_uni)
endif
if part_4<>space(2) .and. part_4<>"00" &&unidades
   part_4=trim(str(val(part_4),2,0))
   do base0 with part_4,var_dec,var_uni
   to0=trim(var_dec+var_uni)
endif
if part_4="00" .or. part_3="000"
   to0="CERO"
endif

_VlrMonto=colo+trim(TO3+" "+TO2+" "+to1)+" PESOS M/CTE CON "+To0+" CENTAVOS"
mletras = _VlrMonto
return

proc base0
param part_4,var_dec,var_uni
Munidbas=" "+part_4
Munidbas2=substr(Munidbas,2,1)
Munidbas3=substr(Munidbas,3,1)
store "" TO var_dec,var_uni
if Munidbas2<>" "
   do dece_bas with var_dec
endif
if Munidbas2=" " .and. Munidbas3<>" "
   do unid_bas with var_uni
endif

proc base1
param part_3,var_cen,var_dec,var_uni
Munidbas=part_3
Munidbas1=substr(Munidbas,1,1)
Munidbas2=substr(Munidbas,2,1)
Munidbas3=substr(Munidbas,3,1)
store "" TO var_cen,var_dec,var_uni
if Munidbas1<>" "
   do cent_bas with var_cen
endif
if Munidbas1=" " .and. Munidbas2<>" "
   do dece_bas with var_dec
endif
if Munidbas1=" " .AND. Munidbas2=" " .and. Munidbas3<>" "
   do unid_bas with var_uni
endif

proc cent_bas
param var_cen
if Munidbas1="1"
   if Munidbas2="0" .and. Munidbas3="0"
      var_cen="CIEN"
   endif
   if Munidbas2="0" .and. Munidbas3<>"0"
      do unid_bas with var_uni
      var_cen="CIENTO "+var_uni
      var_uni=""
   endif
   if Munidbas2<>"0" .and. Munidbas3="0"
      do dece_bas with var_dec
      var_cen="CIENTO "+var_dec
      var_dec=""
   endif
   if Munidbas2<>"0" .and. Munidbas3<>"0"
      do dece_bas with var_dec
      var_cen="CIENTO "+var_dec
      var_dec=""
   endif
endif
if Munidbas1="2"
   var_cen="DOSCIENTOS "
   do cente_com WITH VAR_CEN
endif
if Munidbas1="3"
   var_cen="TRESCIENTOS "
   do cente_com WITH VAR_CEN
endif
if Munidbas1="4"
   var_cen="CUATROCIENTOS "
   do cente_com WITH VAR_CEN
endif
if Munidbas1="5"
   var_cen="QUINIENTOS "
   do cente_com WITH VAR_CEN
endif
if Munidbas1="6"
   var_cen="SEISCIENTOS "
   do cente_com WITH VAR_CEN
endif
if Munidbas1="7"
   var_cen="SETECIENTOS "
   do cente_com WITH VAR_CEN
endif
if Munidbas1="8"
   var_cen="OCHOCIENTOS "
   do cente_com WITH VAR_CEN
endif
if Munidbas1="9"
   var_cen="NOVECIENTOS "
   do cente_com WITH VAR_CEN
endif
RETURN

PROC dece_bas
param var_dec
if Munidbas2="1" .and. Munidbas3="0"
   var_dec="DIEZ"
endif
if Munidbas2="1" .and. Munidbas3="1"
   var_dec="ONCE"
endif
if Munidbas2="1" .and. Munidbas3="2"
   var_dec="DOCE"
endif
if Munidbas2="1" .and. Munidbas3="3"
   var_dec="TRECE"
endif
if Munidbas2="1" .and. Munidbas3="4"
   var_dec="CATORCE"
endif
if Munidbas2="1" .and. Munidbas3="5"
   var_dec="QUINCE"
endif
if Munidbas2="1" .and. Munidbas3="6"
   var_dec="DIECISEIS"
endif
if Munidbas2="1" .and. Munidbas3="7"
   var_dec="DIECISIETE"
endif
if Munidbas2="1" .and. Munidbas3="8"
   var_dec="DIECIOCHO"
endif
if Munidbas2="1" .and. Munidbas3="9"
   var_dec="DIECINUEVE"
endif

if Munidbas2="2" .and. Munidbas3="0"
   var_dec="VEINTE"
endif
if Munidbas2="2" .and. Munidbas3<>"0"
   for numero=1 to 9
       if Munidbas3=str(numero,1,0)
          do unid_bas with var_uni
          var_dec="VEINTI"+var_uni
          VAR_UNI=""
       endif
   endfor
endif

if Munidbas2="3" .and. Munidbas3="0"
   var_dec="TREINTA"
endif
if Munidbas2="3"
   for numero=1 to 9
       if Munidbas3=str(numero,1,0)
          do unid_bas with var_uni
          var_dec="TREINTA Y "+var_uni
          VAR_UNI=""
       endif
   endfor
endif

if Munidbas2="4" .and. Munidbas3="0"
   var_dec="CUARENTA "
endif
if Munidbas2="4" 
   for numero=1 to 9
       if Munidbas3=str(numero,1,0)
          do unid_bas with var_uni
          var_dec="CUARENTA Y "+var_uni
          VAR_UNI=""
       endif
   endfor
endif

if Munidbas2="5" .and. Munidbas3="0"
   var_dec="CINCUENTA "
endif
if Munidbas2="5"
   for numero=1 to 9
       if Munidbas3=str(numero,1,0)
          do unid_bas with var_uni
          var_dec="CINCUENTA Y "+var_uni
          VAR_UNI=""
       endif
   endfor
endif

if Munidbas2="6" .and. Munidbas3="0"
   var_dec="SESENTA "
endif
if Munidbas2="6"
   for numero=1 to 9
       if Munidbas3=str(numero,1,0)
          do unid_bas with var_uni
          var_dec="SESENTA Y "+var_uni
          VAR_UNI=""
       endif
   endfor
endif

if Munidbas2="7" .and. Munidbas3="0"
   var_dec="SETENTA "
endif
if Munidbas2="7"
   for numero=1 to 9
       if Munidbas3=str(numero,1,0)
          do unid_bas with var_uni
          var_dec="SETENTA Y "+var_uni
          VAR_UNI=""
       endif
   endfor
endif

if Munidbas2="8" .and. Munidbas3="0"
   var_dec="OCHENTA "
endif
if Munidbas2="8"
   for numero=1 to 9
       if Munidbas3=str(numero,1,0)
          do unid_bas with var_uni
          var_dec="OCHENTA Y "+var_uni
          VAR_UNI=""
       endif
   endfor
endif

if Munidbas2="9" .and. Munidbas3="0"
   var_dec="NOVENTA "
endif
if Munidbas2="9"
   for numero=1 to 9
       if Munidbas3=str(numero,1,0)
          do unid_bas with var_uni
          var_dec="NOVENTA Y "+var_uni
          VAR_UNI=""
       endif
   endfor
endif

RETURN

proc unid_bas 
param var_uni
if Munidbas3="1"
   var_uni="UN"
endif
if Munidbas3="2"
   var_uni="DOS"
endif
if Munidbas3="3"
   var_uni="TRES"
endif
if Munidbas3="4"
   var_uni="CUATRO"
endif
if Munidbas3="5"
   var_uni="CINCO"
endif
if Munidbas3="6"
   var_uni="SEIS"
endif
if Munidbas3="7"
   var_uni="SIETE"
endif
if Munidbas3="8"
   var_uni="OCHO"
endif
if Munidbas3="9"
   var_uni="NUEVE"
endif
RETURN

PROC CENTE_COM
PARAM VAR_CEN
if Munidbas2="0" .and. Munidbas3="0"
   var_cen=var_cen
endif
if Munidbas2="0" .and. Munidbas3<>"0"
   do unid_bas with var_uni
   var_cen=var_cen+var_uni
   var_uni=""
endif
if Munidbas2<>"0" .and. Munidbas3="0"
   do dece_bas with var_dec
   var_cen=var_cen+var_dec
   var_dec=""
endif
if Munidbas2<>"0" .and. Munidbas3<>"0"
   do dece_bas with var_dec
   var_cen=var_cen+var_dec
   var_dec=""
endif
RETURN

*--valores de mil----------------------------
proc base2
param part_2,var_cenmil,var_decmil,var_unimil
Munidbas=part_2
Munidbas1=substr(Munidbas,1,1)
Munidbas2=substr(Munidbas,2,1)
Munidbas3=substr(Munidbas,3,1)
store "" TO var_cenmil,var_decmil,var_unimil
if Munidbas1<>" " .and. Munidbas1<>"0"
   do cent_bas with var_cen
   var_cenmil=var_cen+" MIL "
endif
if (Munidbas1=" " .and. Munidbas2<>" " .and. Munidbas2<>"0") ;
   .or. (Munidbas2<>"0" .and. Munidbas1="0")
   do dece_bas with var_dec
   var_decmil=var_dec+" MIL "
endif
if (Munidbas1=" " .AND. Munidbas2=" " .and. Munidbas3<>" " .and. Munidbas3<>"0") ;
   .or. (Munidbas1="0" .and. Munidbas2="0")
   do unid_mil with var_unimil
endif

proc unid_mil 
param var_unimil
if Munidbas3="1"
   var_unimil="MIL "
endif
if Munidbas3 >"1" .and. Munidbas3<="9"
   for numero=2 to 9
       if Munidbas3=str(numero,1,0)
          do unid_bas with var_uni
          var_unimil=var_uni+" MIL "
          VAR_UNI=""
       endif
   endfor
endif
RETURN


*--valores de millon--------------------------
proc base3
param part_1,var_cemill,var_demill,var_unmill
Munidbas=part_1
Munidbas1=substr(Munidbas,1,1)
Munidbas2=substr(Munidbas,2,1)
Munidbas3=substr(Munidbas,3,1)
store "" TO var_cemill,var_demill,var_unmill
if Munidbas1<>" "
   do cent_bas with var_cen
   if Munidbas3="1"
      var_cemill=var_cen+" MILLON "
		IF part_2="000" .and. part_3="000"
			var_cemill=var_cen+" MILLON DE"
		ENDIF
   else
      var_cemill=var_cen+" MILLONES "
		IF part_2="000" .and. part_3="000"
	      var_cemill=var_cen+" MILLONES DE"
		ENDIF
   endif
   var_cen=""
endif
if Munidbas1=" " .and. Munidbas2<>" " .and. Munidbas2<>"0"
   do dece_bas with var_dec
   var_demill=var_dec+" MILLONES "
		IF part_2="000" .and. part_3="000"
		   var_demill=var_dec+" MILLONES DE"
		ENDIF
   var_dec=""
endif
if Munidbas1=" " .AND. Munidbas2=" " .and. Munidbas3<>" " .and. Munidbas3<>"0" 
   do unid_bas with var_uni
   if Munidbas3="1"
      var_unmill=var_uni+" MILLON "
		IF part_2="000" .and. part_3="000"
	      var_unmill=var_uni+" MILLON DE"
		ENDIF
   else
      var_unmill=var_uni+" MILLONES "
		IF part_2="000" .and. part_3="000"
	      var_unmill=var_uni+" MILLONES DE"
		ENDIF
   endif
   var_uni=""
endif
RETURN
