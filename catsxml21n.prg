**********************************************************************************************************************
*  D&D.M.S - DISENO & DESARROLLO MANTENIMIENTO DE SOFWARE                 
*  C.A.T.S - Control Administrativo Total Sistematizado.                  
*            Sistema Contable                                             
*  HECTOR FABIO CARDONA OTALVORA                                          
**********************************************************************************************************************
* factura electronica                                                                                2018.10.30  06:00
* STRING XML
* Prepara archivo XML                                                                                2018.11.19  06:25
* tipo 1juridico 2 natural                                                                           2018.12.04  18:19
* revision                                                                                           2019.02.13  16:44
* ite 21 22/prefijo ftec700000000                                                                         05.31  16:18
* mat. mercantil adq si no tiene lo quito -ac. iva en tim 2 -tot 5= 3 y 7 = 5                             06.14  17:00
* fecha expedido                                                                                          07.11  17:50  
* se quita barrio del adq,icr -pone la medida del producto                                                07,30  18:00
* v 21                                                                                                    10.11  15:03
* razonemp x nomemp en naturales no juridicos -empresa                                                    11.04  08:00
* se quita pcr qta ata                                                                                    11.27  16:30
* ctrxxemp adq detalles tributarios                                                                       11:29  17:59
* v 21 p correr validado                                                                             2020.01.23  19:20
* v 21 p correr validado/AC IVA                                                                           03.30  17:56
* cantidad iva sin decimales - decimales en numericos 2                                                   04.10  11:03
* nota credito iva con decimales - cantidad con decimales ite 3                                           04.15  18:31
* nro de fra cruce p tomar el cufe                                                                        05.13  06:37
* tabla cufe                                                                                              05:29  06:42
* substr 3 char basura que tare el cufe                                                                   09:19  12:10
* traer el iae1 2 3 4                                                                                     20:09  10:55
* nodo ICR - verificar si blanco no lo pongo                                                              10.12  09:08
* nodo ICR - no lo esta aceptando el integrador                                                           10.20  07:01
* fecha de resolucion                                                                                     11.04  05:56
* traer mcrdocfe - doc. cruce                                                                        2021.04.07  16:18
* nodo IMP IVA 0.00 poner su base p q sume con los Gr  y sea = a subneto                             2021.08.25  19:58
* seleccion de unidad D: or C:                                                                            10.13  15:05
* precres en ICC DRF                                                                                      10.20  09:19	
* catsusl                                                                                                 11.12  14:15
**********************************************************************************************************************
PROCEDURE catsxml21n

LOCAL filenamexml

IF mmidf <> "P"
	filenamexml = ('D:' + sys(2003) + '\fcecats\' + ALLTRIM(fcec05n.precres) +ALLTRIM(fcec05n.sfra)+'.xml')
ELSE
	filenamexml = ('C:' + sys(2003) + '\fcecats\' + ALLTRIM(fcec05n.precres) +ALLTRIM(fcec05n.sfra)+'.xml')
ENDIF

*Borra Archivo para crearlo de nuevo
DELETE FILE &filenamexml

IF FILE(filenamexml)  && Existe el archivo?
	gnFileXml = FOPEN(filenamexml,12)  && Si, abrirlo lectura-escritura
ELSE
	gnFileXml  = FCREATE(filenamexml)  && No, crearlo
ENDIF

SELECT cufedd

Mcufe = " "

Mcufe = ALLTRIM(SUBSTR(cufe,4,100))

MESSAGEBOX("MSG: CUFE: "+Mcufe, mopok, mtitcua)

IF SUBSTR(Mcufe,1,1) <> " "

IF gnFileXml  < 0  && Comprobar error al abrir el archivo
	WAIT WINDOW 'No se puede abrir o crear el archivo'
ELSE
*!*		SELECT fcec05n   &&&-- Deberia se tu tabla lista que contiene tus datos de factura
*!*		nTotFacs = RECCOUNT()

	*- Se agregale linea por linea del archivo

*!*	FPUTS(gnFileXml,'<?xml version="1.0" encoding="UTF-8" standalone="yes"?>')
*!*	FPUTS(gnFileXml,'<?xml version="1.0" encoding="ISO-8859-1"?>')
*!*	FPUTS(gnFileXml,'<XMLData xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema>">')
*!*	FPUTS(gnFileXml,'<Product Name="CATS" Version="90"/>')
	
	FPUTS(gnFileXml,'<?xml version="1.0" encoding="UTF-8"?>')
		
	SELECT fcec05n
	GOTO TOP
	
*!*	DO WHILE !EOF()
	**.- Inicio Encabezado 
		FPUTS(gnFileXml,'<NOTA xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">')
		
			FPUTS(gnFileXml,'<ENC>')
				FPUTS(gnFileXml,'<ENC_1>'+"NC"+'</ENC_1>')
				FPUTS(gnFileXml,'<ENC_2>'+ALLTRIM(fcec05n.nitemp)+'</ENC_2>')
				FPUTS(gnFileXml,'<ENC_3>'+ALLTRIM(fcec05n.nit)+'</ENC_3>')
				FPUTS(gnFileXml,'<ENC_4>'+ALLTRIM(fcec05n.veresq)+'</ENC_4>')
				FPUTS(gnFileXml,'<ENC_5>'+ALLTRIM(fcec05n.esqdian)+'</ENC_5>')
				FPUTS(gnFileXml,'<ENC_6>'+ALLTRIM(fcec05n.precres)+ALLTRIM(fcec05n.sfra)+'</ENC_6>')
				FPUTS(gnFileXml,'<ENC_7>'+SUBSTR(fcec05n.expedido,1,4)+"-"+SUBSTR(fcec05n.expedido,5,2)+"-"+SUBSTR(fcec05n.expedido,7,2)+'</ENC_7>')
				FPUTS(gnFileXml,'<ENC_8>'+TIME()+"-05:00"+'</ENC_8>')
				FPUTS(gnFileXml,'<ENC_9>'+ALLTRIM(fcec05n.tipdoc)+'</ENC_9>')
				FPUTS(gnFileXml,'<ENC_10>'+ALLTRIM(fcec05n.divisa)+'</ENC_10>')
				FPUTS(gnFileXml,'<ENC_15>'+ALLTRIM(STR(fcec05n.nitem))+'</ENC_15>')
				FPUTS(gnFileXml,'<ENC_16>'+SUBSTR(fcec05n.vencido,1,4)+"-"+SUBSTR(fcec05n.vencido,5,2)+"-"+SUBSTR(fcec05n.vencido,7,2)+'</ENC_16>')
				FPUTS(gnFileXml,'<ENC_20>'+ALLTRIM(fcec05n.dambient)+'</ENC_20>')
				FPUTS(gnFileXml,'<ENC_21>'+ALLTRIM(fcec05n.optipo)+'</ENC_21>')
			FPUTS(gnFileXml,'</ENC>')
			
	 *enc_9 1 = Factura
	**.- Finaliza Encabezado 
	
		**.- Inicia Emisor
			
			FPUTS(gnFileXml,'<EMI>')
				FPUTS(gnFileXml,'<EMI_1>'+ALLTRIM(fcec05n.idtpeemp)+'</EMI_1>')
				FPUTS(gnFileXml,'<EMI_2>'+ALLTRIM(fcec05n.nitemp)+'</EMI_2>')
				FPUTS(gnFileXml,'<EMI_3>'+ALLTRIM(fcec05n.idtpiemp)+'</EMI_3>')
				FPUTS(gnFileXml,'<EMI_4>'+ALLTRIM(fcec05n.grupoemp)+'</EMI_4>')
				
*!*				IF SUBSTR(fcec05n.idtpeemp,1,1) = "1"
*!*				IF SUBSTR(fcec05n.razonemp,1,1) <> " "
					FPUTS(gnFileXml,'<EMI_6>'+ALLTRIM(fcec05n.razonemp)+'</EMI_6>')
*!*				ELSE
*!*					FPUTS(gnFileXml,'<EMI_6>'+ALLTRIM(fcec05n.nomemp)+" "+ALLTRIM(fcec05n.apl1emp)+" "+ALLTRIM(fcec05n.apl2emp)+'</EMI_6>')
*!*				ENDIF
				IF SUBSTR(fcec05n.nomcoemp,1,1) <> " "
					FPUTS(gnFileXml,'<EMI_7>'+ALLTRIM(fcec05n.nomcoemp)+'</EMI_7>')
				ENDIF
				
*!*					IF SUBSTR(fcec05n.idtpeemp,1,1) = "2"
*!*						FPUTS(gnFileXml,'<EMI_8>'+ALLTRIM(fcec05n.nomemp)+'</EMI_8>')
*!*						FPUTS(gnFileXml,'<EMI_9>'+ALLTRIM(fcec05n.apl1emp)+" "+ALLTRIM(fcec05n.apl2emp)+'</EMI_9>')
*!*					ENDIF
				
				FPUTS(gnFileXml,'<EMI_10>'+ALLTRIM(fcec05n.diremp)+'</EMI_10>')
				FPUTS(gnFileXml,'<EMI_11>'+ALLTRIM(fcec05n.cdptoemp)+'</EMI_11>')
*!*					FPUTS(gnFileXml,'<EMI_12>'+ALLTRIM(fcec05n.mpioemp)+'</EMI_12>')
				FPUTS(gnFileXml,'<EMI_13>'+ALLTRIM(fcec05n.mpioemp)+'</EMI_13>')
				FPUTS(gnFileXml,'<EMI_14>'+ALLTRIM(fcec05n.cpostemp)+'</EMI_14>')
				FPUTS(gnFileXml,'<EMI_15>'+ALLTRIM(fcec05n.cpaisemp)+'</EMI_15>')
*!*					FPUTS(gnFileXml,'<EMI_17>'+ALLTRIM(fcec05n.matccemp)+'</EMI_17>')
*!*					FPUTS(gnFileXml,'<EMI_18>'+ALLTRIM(fcec05n.diremp)+'</EMI_18>')
				FPUTS(gnFileXml,'<EMI_19>'+ALLTRIM(fcec05n.dptoemp)+'</EMI_19>')
*!*					FPUTS(gnFileXml,'<EMI_20>'+ALLTRIM(fcec05n.ciuemp)+'</EMI_20>')
				FPUTS(gnFileXml,'<EMI_21>'+ALLTRIM(fcec05n.npaisemp)+'</EMI_21>')
				FPUTS(gnFileXml,'<EMI_22>'+ALLTRIM(fcec05n.dvemp)+'</EMI_22>')
				FPUTS(gnFileXml,'<EMI_23>'+ALLTRIM(fcec05n.cmpioemp)+'</EMI_23>')

*!*					IF SUBSTR(fcec05n.razonemp,1,1) <> " "
				FPUTS(gnFileXml,'<EMI_24>'+ALLTRIM(fcec05n.razonemp)+'</EMI_24>')
*!*					ELSE
*!*						FPUTS(gnFileXml,'<EMI_24>'+ALLTRIM(fcec05n.nomemp)+" "+ALLTRIM(fcec05n.apl1emp)+" "+ALLTRIM(fcec05n.apl2emp)+'</EMI_24>')
*!*					ENDIF
				FPUTS(gnFileXml,'<EMI_25>'+ALLTRIM(fcec05n.ciiuemp)+'</EMI_25>')
				
				FPUTS(gnFileXml,'<TAC>')
					FPUTS(gnFileXml,'<TAC_1>'+ALLTRIM(fcec05n.ruto1emp)+'</TAC_1>')
				FPUTS(gnFileXml,'</TAC>')
												
				***DATOS CLIENTE ***
				FPUTS(gnFileXml,'<DFE>')
					FPUTS(gnFileXml,'<DFE_1>'+ALLTRIM(fcec05n.cmpioemp)+'</DFE_1>')
					FPUTS(gnFileXml,'<DFE_2>'+ALLTRIM(fcec05n.cdptoemp)+'</DFE_2>')
					FPUTS(gnFileXml,'<DFE_3>'+ALLTRIM(fcec05n.cpaisemp)+'</DFE_3>')
					FPUTS(gnFileXml,'<DFE_4>'+ALLTRIM(fcec05n.cpostemp)+'</DFE_4>')
					FPUTS(gnFileXml,'<DFE_5>'+ALLTRIM(fcec05n.npaisemp)+'</DFE_5>')
					FPUTS(gnFileXml,'<DFE_6>'+ALLTRIM(fcec05n.dptoemp)+'</DFE_6>')
					FPUTS(gnFileXml,'<DFE_7>'+ALLTRIM(fcec05n.ciuemp)+'</DFE_7>')
					FPUTS(gnFileXml,'<DFE_8>'+ALLTRIM(fcec05n.diremp)+'</DFE_8>')
				FPUTS(gnFileXml,'</DFE>')
						
				***MAT CCIO ***
*!*					IF SUBSTR(fcec05n.idtpeemp,1,1) = "1"
				FPUTS(gnFileXml,'<ICC>')
					FPUTS(gnFileXml,'<ICC_1>'+ALLTRIM(fcec05n.matccemp)+'</ICC_1>')
*!*						FPUTS(gnFileXml,'<ICC_2>'+ALLTRIM(fcec05n.mpioemp)+'</ICC_2>')
*!*						FPUTS(gnFileXml,'<ICC_3>'+ALLTRIM(fcec05n.ciuccemp)+'</ICC_3>')
*!*						FPUTS(gnFileXml,'<ICC_5>'+ALLTRIM(fcec05n.dptccemp)+'</ICC_5>')
*!*						FPUTS(gnFileXml,'<ICC_6>'+ALLTRIM(fcec05n.dirccemp)+'</ICC_6>')
*!*						FPUTS(gnFileXml,'<ICC_7>'+ALLTRIM(fcec05n.paiccemp)+'</ICC_7>')
*!*						FPUTS(gnFileXml,'<ICC_8>'+ALLTRIM(fcec05n.npaccemp)+'</ICC_8>')
					FPUTS(gnFileXml,'<ICC_9>'+ALLTRIM(SUBSTR(fcec05n.precres,1,4))+'</ICC_9>')
				FPUTS(gnFileXml,'</ICC>')
*!*					ENDIF
*!*						
				***CONTACTO EMISOR ***
				FPUTS(gnFileXml,'<CDE>')
					FPUTS(gnFileXml,'<CDE_1>'+ALLTRIM(fcec05n.tpconemp)+'</CDE_1>')
					FPUTS(gnFileXml,'<CDE_2>'+ALLTRIM(fcec05n.nmconemp)+'</CDE_2>')
					FPUTS(gnFileXml,'<CDE_3>'+ALLTRIM(fcec05n.tlconemp)+'</CDE_3>')
					FPUTS(gnFileXml,'<CDE_4>'+ALLTRIM(fcec05n.emconemp)+'</CDE_4>')
				FPUTS(gnFileXml,'</CDE>')
				
				FPUTS(gnFileXml,'<GTE>')
					FPUTS(gnFileXml,'<GTE_1>'+ALLTRIM(fcec05n.ctri01emp)+'</GTE_1>')
					FPUTS(gnFileXml,'<GTE_2>'+ALLTRIM(fcec05n.dtri01emp)+'</GTE_2>')
				FPUTS(gnFileXml,'</GTE>')
			
			FPUTS(gnFileXml,'</EMI>')
		**.- Fin Emisor
 		
 		**.- Inicia ADQuiriente	
			FPUTS(gnFileXml,'<ADQ>')
				FPUTS(gnFileXml,'<ADQ_1>'+ALLTRIM(fcec05n.idtpeadq)+'</ADQ_1>')
				FPUTS(gnFileXml,'<ADQ_2>'+ALLTRIM(fcec05n.nit)+'</ADQ_2>')
				FPUTS(gnFileXml,'<ADQ_3>'+ALLTRIM(fcec05n.idtpiadq)+'</ADQ_3>')
				FPUTS(gnFileXml,'<ADQ_4>'+ALLTRIM(fcec05n.idregadq)+'</ADQ_4>')
			*verificar si es juridico natural
				IF SUBSTR(fcec05n.idtpeadq,1,1) = "1"
					FPUTS(gnFileXml,'<ADQ_6>'+ALLTRIM(fcec05n.razon)+'</ADQ_6>')
				ELSE
					FPUTS(gnFileXml,'<ADQ_6>'+ALLTRIM(fcec05n.nom1)+" "+ALLTRIM(fcec05n.apl1)+" "+ALLTRIM(fcec05n.apl2)+'</ADQ_6>')
				ENDIF
*!*				FPUTS(gnFileXml,'<ADQ_7>'+ALLTRIM(fcec05n.nomcom)+'</ADQ_7>')
				IF SUBSTR(fcec05n.idtpeadq,1,1) = "2"
					FPUTS(gnFileXml,'<ADQ_8>'+ALLTRIM(fcec05n.nom1)+'</ADQ_8>')
					FPUTS(gnFileXml,'<ADQ_9>'+ALLTRIM(fcec05n.apl1)+" "+ALLTRIM(fcec05n.apl2)+'</ADQ_9>')
				ENDIF
				FPUTS(gnFileXml,'<ADQ_10>'+ALLTRIM(fcec05n.direcc)+'</ADQ_10>')
				FPUTS(gnFileXml,'<ADQ_11>'+ALLTRIM(fcec05n.coddpto)+'</ADQ_11>')
*				FPUTS(gnFileXml,'<ADQ_12>'+ALLTRIM(fcec05n.mpio)+'</ADQ_12>')
				FPUTS(gnFileXml,'<ADQ_13>'+ALLTRIM(fcec05n.mpio)+'</ADQ_13>')
				FPUTS(gnFileXml,'<ADQ_14>'+ALLTRIM(fcec05n.cpostal)+'</ADQ_14>')
				FPUTS(gnFileXml,'<ADQ_15>'+ALLTRIM(fcec05n.cpaisadq)+'</ADQ_15>')
				
*!*					IF SUBSTR(fcec05n.matccadq,1,1) <> " "
*!*						FPUTS(gnFileXml,'<ADQ_17>'+ALLTRIM(fcec05n.matccadq)+'</ADQ_17>')
*!*					ENDIF
*!*					FPUTS(gnFileXml,'<ADQ_18>'+ALLTRIM(fcec05n.direcc)+'</ADQ_18>')
				FPUTS(gnFileXml,'<ADQ_19>'+ALLTRIM(fcec05n.dpto)+'</ADQ_19>')
*!*					FPUTS(gnFileXml,'<ADQ_20>'+ALLTRIM(fcec05n.ciud)+'</ADQ_20>')
				FPUTS(gnFileXml,'<ADQ_21>'+ALLTRIM(fcec05n.npaisadq)+'</ADQ_21>')
				FPUTS(gnFileXml,'<ADQ_22>'+ALLTRIM(fcec05n.dv)+'</ADQ_22>')
				FPUTS(gnFileXml,'<ADQ_23>'+ALLTRIM(fcec05n.coddpto)+ALLTRIM(fcec05n.codmpio)+'</ADQ_23>')
				FPUTS(gnFileXml,'<ADQ_24>'+ALLTRIM(fcec05n.nit)+'</ADQ_24>')
 		 		
				FPUTS(gnFileXml,'<TCR>')
				FPUTS(gnFileXml,'<TCR_1>'+ALLTRIM(fcec05n.ruto1adq)+'</TCR_1>')
				FPUTS(gnFileXml,'</TCR>')
				
				FPUTS(gnFileXml,'<ILA>')
				IF SUBSTR(fcec05n.idtpeadq,1,1) = "1"
					FPUTS(gnFileXml,'<ILA_1>'+ALLTRIM(fcec05n.razon)+'</ILA_1>')
				ENDIF
				IF SUBSTR(fcec05n.idtpeadq,1,1) = "2"
					FPUTS(gnFileXml,'<ILA_1>'+ALLTRIM(fcec05n.nom1)+" "+ALLTRIM(fcec05n.apl1)+'</ILA_1>')
				ENDIF
				FPUTS(gnFileXml,'<ILA_2>'+ALLTRIM(fcec05n.nit)+'</ILA_2>')
				FPUTS(gnFileXml,'<ILA_3>'+ALLTRIM(fcec05n.idtpiadq)+'</ILA_3>')
				FPUTS(gnFileXml,'<ILA_4>'+ALLTRIM(fcec05n.idtpeadq)+'</ILA_4>')
				FPUTS(gnFileXml,'</ILA>')
				
				FPUTS(gnFileXml,'<DFA>')
				FPUTS(gnFileXml,'<DFA_1>'+ALLTRIM(fcec05n.cpaisadq)+'</DFA_1>')
				FPUTS(gnFileXml,'<DFA_2>'+ALLTRIM(fcec05n.coddpto)+'</DFA_2>')
				FPUTS(gnFileXml,'<DFA_3>'+ALLTRIM(fcec05n.cpostal)+'</DFA_3>')
				FPUTS(gnFileXml,'<DFA_4>'+ALLTRIM(fcec05n.coddpto)+ALLTRIM(fcec05n.codmpio)+'</DFA_4>')
				FPUTS(gnFileXml,'<DFA_5>'+ALLTRIM(fcec05n.npaisadq)+'</DFA_5>')
				FPUTS(gnFileXml,'<DFA_6>'+ALLTRIM(fcec05n.dpto)+'</DFA_6>')
				FPUTS(gnFileXml,'<DFA_7>'+ALLTRIM(fcec05n.mpio)+'</DFA_7>')
				FPUTS(gnFileXml,'<DFA_8>'+ALLTRIM(fcec05n.direcc)+'</DFA_8>')
				FPUTS(gnFileXml,'</DFA>')
								
				***camara de ccio adquiriente
*!*					IF SUBSTR(fcec05n.idtpeadq,1,1) = "1"
*!*						IF SUBSTR(fcec05n.matccadq,1,1) <> " "
*!*							FPUTS(gnFileXml,'<ICR>')
*!*							FPUTS(gnFileXml,'<ICR_1>'+ALLTRIM(fcec05n.matccadq)+'</ICR_1>')
*!*							FPUTS(gnFileXml,'</ICR>')
*!*						ENDIF
*!*					ENDIF
								
*!*				CONTACTO ADQUIRIENTE
				FPUTS(gnFileXml,'<CDA>')
					FPUTS(gnFileXml,'<CDA_1>'+ALLTRIM(fcec05n.tpconta)+'</CDA_1>')
					FPUTS(gnFileXml,'<CDA_2>'+ALLTRIM(fcec05n.nomconta)+'</CDA_2>')
					FPUTS(gnFileXml,'<CDA_3>'+ALLTRIM(fcec05n.telconta)+'</CDA_3>')
					FPUTS(gnFileXml,'<CDA_4>'+ALLTRIM(fcec05n.emaconta)+'</CDA_4>')
				FPUTS(gnFileXml,'</CDA>')
*!*				* fin contacto
				
				FPUTS(gnFileXml,'<GTA>')
					FPUTS(gnFileXml,'<GTA_1>'+ALLTRIM(fcec05n.ctri01adq)+'</GTA_1>')
					FPUTS(gnFileXml,'<GTA_2>'+ALLTRIM(fcec05n.dtri01adq)+'</GTA_2>')
				FPUTS(gnFileXml,'</GTA>')
			
			FPUTS(gnFileXml,'</ADQ>')
		**.- Fin Adquiriente
			
 		**.- Inicio Datos Documento -totales
			FPUTS(gnFileXml,'<TOT>')
				FPUTS(gnFileXml,'<TOT_1>'+ALLTRIM(STR((fcec05n.subtotal),11,2))+'</TOT_1>')
				FPUTS(gnFileXml,'<TOT_2>'+ALLTRIM(fcec05n.divisa)+'</TOT_2>')
				FPUTS(gnFileXml,'<TOT_3>'+ALLTRIM(STR((fcec05n.subneto),11,2))+'</TOT_3>')
				FPUTS(gnFileXml,'<TOT_4>'+ALLTRIM(fcec05n.divisa)+'</TOT_4>')
				FPUTS(gnFileXml,'<TOT_5>'+ALLTRIM(STR(fcec05n.total,11,2))+'</TOT_5>')
				FPUTS(gnFileXml,'<TOT_6>'+ALLTRIM(fcec05n.divisa)+'</TOT_6>')
				FPUTS(gnFileXml,'<TOT_7>'+ALLTRIM(STR(fcec05n.total,11,2))+'</TOT_7>')
				FPUTS(gnFileXml,'<TOT_8>'+ALLTRIM(fcec05n.divisa)+'</TOT_8>')
*!*				FPUTS(gnFileXml,'<Tot_9>'+ALLTRIM(STR(fcec05n.desc1,9,4))+'</Tot_9>')
*!*				FPUTS(gnFileXml,'<Tot_10>'+ALLTRIM(fcec05n.divisa)+'</Tot_10>')
*!*				FPUTS(gnFileXml,'<Tot_11>'+ALLTRIM(STR(fcec05n.cargos,9,4))+'</Tot_11>')
*!*				FPUTS(gnFileXml,'<Tot_12>'+ALLTRIM(fcec05n.divisa)+'</Tot_12>')
*!*				FPUTS(gnFileXml,'<Tot_13>'+ALLTRIM(STR(fcec05n.anticipo,9,4))+'</Tot_13>')
*!*				FPUTS(gnFileXml,'<Tot_14>'+ALLTRIM(fcec05n.divisa)+'</Tot_14>')
*!*				FPUTS(gnFileXml,'<Tot_15>'+ALLTRIM(STR(fcec05n.redondeo,9,4))+'</Tot_15>')
*!*				FPUTS(gnFileXml,'<Tot_16>'+ALLTRIM(fcec05n.divisa)+'</Tot_16>')
			FPUTS(gnFileXml,'</TOT>')
			
			Mvlraciv = 0.00
			Mvlracbv = 0.00
			Mporiva  = 0.00
			Mvlraciv0 = 0.00
			Mvlracbv0 = 0.00
			Mporiva0  = 0.00
			
			SELECT fced05n
			SCAN ALL
				
	 			IF fced05n.vlriva > 0
					
					Mvlraciv = Mvlraciv + fced05n.vlriva
					
					Mvlracbv = Mvlracbv + fced05n.vlcanuni
					
					Mporiva = fced05n.poriva
					
				ELSE
					
					Mvlracbv0 = Mvlracbv0 + fced05n.vlcanuni
					
					Mvlraciv0 = 0.00
					
					Mporiva0 = 0.00
				
				ENDIF
			ENDSCAN
			
*.*	 		IF Mvlraciv > 0
				FPUTS(gnFileXml,'<TIM>')
					FPUTS(gnFileXml,'<TIM_1>'+"false"+'</TIM_1>')
					FPUTS(gnFileXml,'<TIM_2>'+ALLTRIM(STR(Mvlraciv,11,2))+'</TIM_2>')
					FPUTS(gnFileXml,'<TIM_3>'+ALLTRIM(fcec05n.divisa)+'</TIM_3>')
			
	 		*** EL 01 TRAER DESDE EL PROG  ver como POR SI
					IF Mvlracbv > 0
						FPUTS(gnFileXml,'<IMP>')
						FPUTS(gnFileXml,'<IMP_1>'+"01"+'</IMP_1>')
						FPUTS(gnFileXml,'<IMP_2>'+ALLTRIM(STR(Mvlracbv,11,2))+'</IMP_2>')
						FPUTS(gnFileXml,'<IMP_3>'+ALLTRIM(fcec05n.divisa)+'</IMP_3>')
						FPUTS(gnFileXml,'<IMP_4>'+ALLTRIM(STR(Mvlraciv,11,2))+'</IMP_4>')
						FPUTS(gnFileXml,'<IMP_5>'+ALLTRIM(fcec05n.divisa)+'</IMP_5>')
						FPUTS(gnFileXml,'<IMP_6>'+ALLTRIM(STR(Mporiva,11,3))+'</IMP_6>')
						FPUTS(gnFileXml,'</IMP>')
					ENDIF
					IF Mvlracbv0 > 0
						FPUTS(gnFileXml,'<IMP>')
						FPUTS(gnFileXml,'<IMP_1>'+"01"+'</IMP_1>')
						FPUTS(gnFileXml,'<IMP_2>'+ALLTRIM(STR(Mvlracbv0,11,2))+'</IMP_2>')
						FPUTS(gnFileXml,'<IMP_3>'+ALLTRIM(fcec05n.divisa)+'</IMP_3>')
						FPUTS(gnFileXml,'<IMP_4>'+ALLTRIM(STR(Mvlraciv0,11,2))+'</IMP_4>')
						FPUTS(gnFileXml,'<IMP_5>'+ALLTRIM(fcec05n.divisa)+'</IMP_5>')
						FPUTS(gnFileXml,'<IMP_6>'+ALLTRIM(STR(Mporiva0,11,3))+'</IMP_6>')
						FPUTS(gnFileXml,'</IMP>')
					ENDIF
				FPUTS(gnFileXml,'</TIM>')
*.*			ENDIF

*!*		 			*** EL false es pr impto -iva si fuera true es x retenciones
*!*		 			
*!*		 			IF fced05n.vlriva > 0
*!*						Mvlraciv = Mvlraciv + fced05n.vlriva
*!*						
*!*						Mvlracbv = Mvlracbv + fced05n.vlcanuni
*!*						
*!*						Mporiva = fced05n.poriva
*!*					ENDIF
*!*				ENDSCAN
*!*				
*!*		 		IF Mvlraciv > 0
*!*					FPUTS(gnFileXml,'<TIM>')
*!*						FPUTS(gnFileXml,'<TIM_1>'+"false"+'</TIM_1>')
*!*						FPUTS(gnFileXml,'<TIM_2>'+ALLTRIM(STR(Mvlraciv,11,2))+'</TIM_2>')
*!*						FPUTS(gnFileXml,'<TIM_3>'+ALLTRIM(fcec05n.divisa)+'</TIM_3>')
*!*				
*!*		 		*** EL 01 TRAER DESDE EL PROG  ver como POR SI
*!*				
*!*						FPUTS(gnFileXml,'<IMP>')
*!*						FPUTS(gnFileXml,'<IMP_1>'+"01"+'</IMP_1>')
*!*						FPUTS(gnFileXml,'<IMP_2>'+ALLTRIM(STR(Mvlracbv,11,2))+'</IMP_2>')
*!*						FPUTS(gnFileXml,'<IMP_3>'+ALLTRIM(fcec05n.divisa)+'</IMP_3>')
*!*						FPUTS(gnFileXml,'<IMP_4>'+ALLTRIM(STR(Mvlraciv,11,2))+'</IMP_4>')
*!*						FPUTS(gnFileXml,'<IMP_5>'+ALLTRIM(fcec05n.divisa)+'</IMP_5>')
*!*						FPUTS(gnFileXml,'<IMP_6>'+ALLTRIM(STR(Mporiva,11,3))+'</IMP_6>')
*!*						FPUTS(gnFileXml,'</IMP>')
*!*					FPUTS(gnFileXml,'</TIM>')
*!*				ENDIF
			
*.* descuentos
*!*			FPUTS(gnFileXml,'<Dsc>')
*!*			FPUTS(gnFileXml,'	<Dsc_1>'+"false"+'</Dsc_1>')
*!*			FPUTS(gnFileXml,'	<Dsc_2>'+ALLTRIM(STR(pordesc1))+'</Dsc_2>')
*!*			FPUTS(gnFileXml,'	<Dsc_3>'+ALLTRIM(STR(fcec05n.desc1))+'</Dsc_3>')
*!*			FPUTS(gnFileXml,'	<Dsc_4>'+ALLTRIM(fcec05n.divisa)+'</Dsc_4>')
*!*			FPUTS(gnFileXml,'	<Dsc_5>'+"19"+'</Dsc_5>')
*!*			FPUTS(gnFileXml,'	<Dsc_8>'+ALLTRIM(fcec05n.divisa)+'</Dsc_8>')
*!*			FPUTS(gnFileXml,'	<Dsc_9>'+"1"+'</Dsc_9>')
*!*			FPUTS(gnFileXml,'</Dsc>')
			
			*.* resolucion 
			FPUTS(gnFileXml,'<DRF>')
				FPUTS(gnFileXml,'<DRF_1>'+ALLTRIM(fcec05n.numres)+'</DRF_1>')
				FPUTS(gnFileXml,'<DRF_2>'+ALLTRIM(fcec05n.finicres)+'</DRF_2>')
				FPUTS(gnFileXml,'<DRF_3>'+ALLTRIM(fcec05n.ffincres)+'</DRF_3>')
				FPUTS(gnFileXml,'<DRF_4>'+ALLTRIM(SUBSTR(fcec05n.precres,1,4))+'</DRF_4>')
				FPUTS(gnFileXml,'<DRF_5>'+ALLTRIM(fcec05n.docicres)+'</DRF_5>')
				FPUTS(gnFileXml,'<DRF_6>'+ALLTRIM(fcec05n.docfcres)+'</DRF_6>')
			FPUTS(gnFileXml,'</DRF>')
			
			*** VERIFICAR SI VA IVA
*!*				FPUTS(gnFileXml,'<ITD>')
*!*					FPUTS(gnFileXml,'<ITD_1>'+ALLTRIM(STR(fcec05n.iva,9,4))+'</ITD_1>')
*!*					FPUTS(gnFileXml,'<ITD_2>'+ALLTRIM(fcec05n.divisa)+'</ITD_2>')
*!*					FPUTS(gnFileXml,'<ITD_3>'+ALLTRIM(STR(fcec05n.totrets,9,4))+'</ITD_3>')
*!*					FPUTS(gnFileXml,'<ITD_4>'+ALLTRIM(fcec05n.divisa)+'</ITD_4>')
*!*					FPUTS(gnFileXml,'<ITD_5>'+ALLTRIM(STR(fcec05n.total,9,4))+'</ITD_5>')
*!*					FPUTS(gnFileXml,'<ITD_6>'+ALLTRIM(fcec05n.divisa)+'</ITD_6>')
*!*				FPUTS(gnFileXml,'</ITD>')
			*** VERIFICAR SI VA IVA
			
			*** VERIFICAR SI VA receptor de pago
*!*				FPUTS(gnFileXml,'<RCP>')
*!*					FPUTS(gnFileXml,'<RCP_1>'+ALLTRIM(fcec05n.nitemp)+'</RCP_1>')
*!*					FPUTS(gnFileXml,'<RCP_2>'+ALLTRIM(fcec05n.idtpiemp)+'</RCP_2>')
*!*					FPUTS(gnFileXml,'<RCP_3>'+ALLTRIM((fcec05n.idregemp))+'</RCP_3>')
*!*					
*!*					IF SUBSTR(fcec05n.idtpeemp,1,1) = "1"
*!*						FPUTS(gnFileXml,'<RCP_4>'+ALLTRIM(fcec05n.razonemp)+'</RCP_4>')
*!*					ENDIF
*!*					FPUTS(gnFileXml,'<RCP_5>'+ALLTRIM(fcec05n.nomcoemp)+'</RCP_5>')
*!*					IF SUBSTR(fcec05n.idtpeemp,1,1) = "2"
*!*						FPUTS(gnFileXml,'<RCP_6>'+ALLTRIM(fcec05n.nomemp)+'</RCP_6>')
*!*						FPUTS(gnFileXml,'<RCP_7>'+ALLTRIM(fcec05n.apl1emp)+" "+ALLTRIM(fcec05n.apl2emp)+'</RCP_7>')
*!*					ENDIF

*!*					FPUTS(gnFileXml,'<RCP_8>'+ALLTRIM(fcec05n.diremp)+'</RCP_8>')
*!*					FPUTS(gnFileXml,'<RCP_9>'+ALLTRIM(fcec05n.dptoemp)+'</RCP_9>')
*!*					FPUTS(gnFileXml,'<RCP_10>'+ALLTRIM(fcec05n.mpioemp)+'</RCP_10>')
*!*					FPUTS(gnFileXml,'<RCP_11>'+ALLTRIM(fcec05n.ciuemp)+'</RCP_11>')
*!*	*				FPUTS(gnFileXml,'<RCP_12>'+ALLTRIM(fcec05n.)+'</RCP_12>')
*!*					FPUTS(gnFileXml,'<RCP_13>'+ALLTRIM(fcec05n.cpaisemp)+'</RCP_13>')
*!*					
*!*					FPUTS(gnFileXml,'<PCR>')
*!*						FPUTS(gnFileXml,'<PCR_1>'+ALLTRIM(fcec05n.ruto1adq)+'</PCR_1>')
*!*					FPUTS(gnFileXml,'</PCR>')
*!*				FPUTS(gnFileXml,'</RCP>')
			*** VERIFICAR SI VA
			
*!*					FPUTS(gnFileXml,'<PCR>')
*!*					FPUTS(gnFileXml,'<PCR_1>'+ALLTRIM(fcec05n.ruto1emp)+'</PCR_1>')
*!*					FPUTS(gnFileXml,'</PCR>')
*!*					FPUTS(gnFileXml,'<QTA>')
*!*					FPUTS(gnFileXml,'<QTA_1>'+ALLTRIM(fcec05n.ruto1emp)+'</QTA_1>')
*!*					FPUTS(gnFileXml,'</QTA>')
*!*					FPUTS(gnFileXml,'<ATA>')
*!*					FPUTS(gnFileXml,'<ATA_1>'+ALLTRIM(fcec05n.ruto1emp)+'</ATA_1>')
*!*					FPUTS(gnFileXml,'</ATA>')
				
*!*				FPUTS(gnFileXml,'<Ref>')
*!*					FPUTS(gnFileXml,'<Ref_1>'+""+'</Ref_1>')
*!*					FPUTS(gnFileXml,'<Ref_2>'+ +'</Ref_2>')
*!*					FPUTS(gnFileXml,'<Ref_3>'+ +'</Ref_3>')
*!*					FPUTS(gnFileXml,'<Ref_4>'+ +'</Ref_4>')
*!*				FPUTS(gnFileXml,'</Ref>')

				IF SUBSTR(fcec05n.nota1emp,1,1) <> " "
					FPUTS(gnFileXml,'<NOT>')
					FPUTS(gnFileXml,'<NOT_1>'+ALLTRIM(fcec05n.nota1emp)+'</NOT_1>')
					FPUTS(gnFileXml,'</NOT>')
				ENDIF
				
*!*					IF SUBSTR(fcec05n.nota2emp,1,1) <> " "
*!*						FPUTS(gnFileXml,'<NOT>')
*!*						FPUTS(gnFileXml,'<NOT_1>'+ALLTRIM(fcec05n.nota2emp)+'</NOT_1>')
*!*						FPUTS(gnFileXml,'</NOT>')
*!*					ENDIF
*!*					IF SUBSTR(fcec05n.nota3emp,1,1) <> " "
*!*						FPUTS(gnFileXml,'<NOT>')
*!*						FPUTS(gnFileXml,'<NOT_1>'+ALLTRIM(fcec05n.nota3emp)+'</NOT_1>')
*!*						FPUTS(gnFileXml,'</NOT>')
*!*					ENDIF
*!*					IF SUBSTR(fcec05n.nota4emp,1,1) <> " "
*!*						FPUTS(gnFileXml,'<NOT>')
*!*						FPUTS(gnFileXml,'<NOT_1>'+ALLTRIM(fcec05n.nota4emp)+'</NOT_1>')
*!*						FPUTS(gnFileXml,'</NOT>')
*!*					ENDIF
				
				IF SUBSTR(fcec05n.ordenc,1,1) <> " "
					FPUTS(gnFileXml,'<ORC>')
					FPUTS(gnFileXml,'<ORC_1>'+ALLTRIM(fcec05n.ordenc)+'</ORC_1>')
					FPUTS(gnFileXml,'</ORC>')
				ENDIF

					*** EL REF PARA CUFE

					FPUTS(gnFileXml,'<REF>')
					FPUTS(gnFileXml,'<REF_1>'+"IV"+'</REF_1>')
					FPUTS(gnFileXml,'<REF_2>'+ALLTRIM(fcec05n.prefres) +ALLTRIM(mcrdocfe)+'</REF_2>')
					FPUTS(gnFileXml,'<REF_4>'+ALLTRIM(Mcufe)+'</REF_4>')
					FPUTS(gnFileXml,'<REF_5>'+"CUFE-SHA384"+'</REF_5>')
					FPUTS(gnFileXml,'</REF>')
				
					*** EL MEP 1 "METODO DE PAGO 1 NO DEFINIDO" TRAER DESDE EL PROG ver como POR SI		
				
				FPUTS(gnFileXml,'<MEP>')
					FPUTS(gnFileXml,'<MEP_1>'+"1"+'</MEP_1>')
					IF fcec05n.diascr > 0
						FPUTS(gnFileXml,'<MEP_2>'+"2"+'</MEP_2>')
					ELSE
						FPUTS(gnFileXml,'<MEP_2>'+"1"+'</MEP_2>')
					ENDIF
					FPUTS(gnFileXml,'<MEP_3>'+SUBSTR(fcec05n.vencido,1,4)+"-"+SUBSTR(fcec05n.vencido,5,2)+"-"+SUBSTR(fcec05n.vencido,7,2)+'</MEP_3>')
				FPUTS(gnFileXml,'</MEP>')
			
 			**.- Fin Datos Documento
 	 		
			SELECT fced05n
*!*			FPUTS(gnFileXml,'<Ddetalle>')
			SCAN ALL
			FPUTS(gnFileXml,'<ITE>')
				FPUTS(gnFileXml,'<ITE_1>'+ALLTRIM(STR(fced05n.secc))+'</ITE_1>')
				FPUTS(gnFileXml,'<ITE_3>'+ALLTRIM(STR(fced05n.cantidad,11,2))+'</ITE_3>')
				FPUTS(gnFileXml,'<ITE_4>'+ALLTRIM(fced05n.medida)+'</ITE_4>')
				FPUTS(gnFileXml,'<ITE_5>'+ALLTRIM(STR(fced05n.vlcanuni,11,2))+'</ITE_5>')
				FPUTS(gnFileXml,'<ITE_6>'+ALLTRIM(fced05n.divisa)+'</ITE_6>')
				FPUTS(gnFileXml,'<ITE_7>'+ALLTRIM(STR(fced05n.vlunit,11,2))+'</ITE_7>')
				FPUTS(gnFileXml,'<ITE_8>'+ALLTRIM(fced05n.divisa)+'</ITE_8>')
*!*				FPUTS(gnFileXml,'<ITE_10>'+ALLTRIM(fced05n.descrip)+'</ITE_10>')
				FPUTS(gnFileXml,'<ITE_11>'+ALLTRIM(fced05n.descrip)+'</ITE_11>')
*!*				FPUTS(gnFileXml,'<ITE_19>'+ALLTRIM(STR(fced05n.vlcanuni,9,4))+'</ITE_19>')
*!*				FPUTS(gnFileXml,'<ITE_20>'+ALLTRIM(fced05n.divisa)+'</ITE_20>')
*!*				FPUTS(gnFileXml,'<ITE_21>'+ALLTRIM(STR(fced05n.vlcanuni+fced05n.vlriva,9,4))+'</ITE_21>')
*!*				FPUTS(gnFileXml,'<ITE_22>'+ALLTRIM(fced05n.divisa)+'</ITE_22>')
				FPUTS(gnFileXml,'<ITE_27>'+ALLTRIM(STR(fced05n.cantidad,9,0))+'</ITE_27>')
				FPUTS(gnFileXml,'<ITE_28>'+ALLTRIM(fced05n.medida)+'</ITE_28>')
				
				IF SUBSTR(fced05n.lote,1,1) <> " "
					FPUTS(gnFileXml,'<LOT>')
						FPUTS(gnFileXml,'<LOT_1>'+iae11+" Reg. Invima "+ALLTRIM(fced05n.reginvim)+'</LOT_1>')
						FPUTS(gnFileXml,'<LOT_2>'+SUBSTR(fced05n.fvlote,1,4)+"-"+SUBSTR(fced05n.fvlote,5,2)+"-"+SUBSTR(fced05n.fvlote,7,2)+'</LOT_2>')
					FPUTS(gnFileXml,'</LOT>')
				ENDIF
				
				*** TAER DESDE PRG ver como PORSI ok
				
				FPUTS(gnFileXml,'<IAE>')
					FPUTS(gnFileXml,'<IAE_1>'+ALLTRIM(fced05n.iae1)+'</IAE_1>')
					FPUTS(gnFileXml,'<IAE_2>'+ALLTRIM(fced05n.iae2)+'</IAE_2>')
					FPUTS(gnFileXml,'<IAE_3>'+ALLTRIM(fced05n.iae3)+'</IAE_3>')
					FPUTS(gnFileXml,'<IAE_4>'+ALLTRIM(fced05n.iae4)+'</IAE_4>')
				FPUTS(gnFileXml,'</IAE>')
				
				FPUTS(gnFileXml,'<TII>')
					FPUTS(gnFileXml,'<TII_1>'+ALLTRIM(STR(fced05n.vlriva,11,2))+'</TII_1>')
					FPUTS(gnFileXml,'<TII_2>'+ALLTRIM(fcec05n.divisa)+'</TII_2>')
					FPUTS(gnFileXml,'<TII_3>'+"false"+'</TII_3>')
						FPUTS(gnFileXml,'<IIM>')
							FPUTS(gnFileXml,'<IIM_1>'+"01"+'</IIM_1>')
							FPUTS(gnFileXml,'<IIM_2>'+ALLTRIM(STR(fced05n.vlriva,11,2))+'</IIM_2>')
							FPUTS(gnFileXml,'<IIM_3>'+ALLTRIM(fced05n.divisa)+'</IIM_3>')
							FPUTS(gnFileXml,'<IIM_4>'+ALLTRIM(STR(fced05n.vlcanuni,11,2))+'</IIM_4>')
							FPUTS(gnFileXml,'<IIM_5>'+ALLTRIM(fced05n.divisa)+'</IIM_5>')
							FPUTS(gnFileXml,'<IIM_6>'+ALLTRIM(STR(fced05n.poriva,6,3))+'</IIM_6>')
						FPUTS(gnFileXml,'</IIM>')
				FPUTS(gnFileXml,'</TII>')
			FPUTS(gnFileXml,'</ITE>')
			
			ENDSCAN
				 	
		FPUTS(gnFileXml,'</NOTA>')
ENDIF

ENDIF

=FCLOSE(gnFileXml )  && Cerrar archivo

