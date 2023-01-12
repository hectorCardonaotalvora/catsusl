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
* cantidad iva sin decimales - decimales en numericos 2                                                   04.14  17:41
* lote paso a IEI - traigo los datos iae                                                                  09.20  10:48
* nodo IEI - es por fuera del nodo TII si dentro ITE                                                      09.30  19:25
* nodo ICR - verificar si blanco no lo pongo                                                              10.12  09:07
* nodo IMP IVA 0.00 poner su base p q sume con los Gr  y sea = a subneto                             2021.08.25  19:35
* resolucion quito espacios en blanco                                                                2021.10.06  16:13
* seleccion de unidad D: or C:                                                                            10.11  12:13
* catsusl                                                                                                 10.28  13:17
**********************************************************************************************************************
PROCEDURE catsxml21

LOCAL filenamexml

IF mmidf <> "P"
	filenamexml = ('D:' + sys(2003) + '\fcecats\' + ALLTRIM(fcec05c.prefres) +ALLTRIM(fcec05c.sfra)+'.xml')
ELSE
	filenamexml = ('C:' + sys(2003) + '\fcecats\' + ALLTRIM(fcec05c.prefres) +ALLTRIM(fcec05c.sfra)+'.xml')
ENDIF

*Borra Archivo para crearlo de nuevo
DELETE FILE &filenamexml


IF FILE(filenamexml)  && Existe el archivo?
	gnFileXml = FOPEN(filenamexml,12)  && Si, abrirlo lectura-escritura
ELSE
	gnFileXml  = FCREATE(filenamexml)  && No, crearlo
ENDIF
 
IF gnFileXml  < 0  && Comprobar error al abrir el archivo
	WAIT WINDOW 'No se puede abrir o crear el archivo'
ELSE
*!*		SELECT fcec05c   &&&-- Deberia se tu tabla lista que contiene tus datos de factura
*!*		nTotFacs = RECCOUNT()

	*- Se agregale linea por linea del archivo

*!*	FPUTS(gnFileXml,'<?xml version="1.0" encoding="UTF-8" standalone="yes"?>')
*!*	FPUTS(gnFileXml,'<?xml version="1.0" encoding="ISO-8859-1"?>')
*!*	FPUTS(gnFileXml,'<XMLData xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema>">')
*!*	FPUTS(gnFileXml,'<Product Name="CATS" Version="90"/>')
	
	FPUTS(gnFileXml,'<?xml version="1.0" encoding="UTF-8"?>')
		
	SELECT fcec05c
	GOTO TOP
	
*!*	DO WHILE !EOF()
	**.- Inicio Encabezado 
		FPUTS(gnFileXml,'<FACTURA xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">')
		
			FPUTS(gnFileXml,'<ENC>')
				FPUTS(gnFileXml,'<ENC_1>'+"INVOIC"+'</ENC_1>')
				FPUTS(gnFileXml,'<ENC_2>'+ALLTRIM(fcec05c.nitemp)+'</ENC_2>')
				FPUTS(gnFileXml,'<ENC_3>'+ALLTRIM(fcec05c.nit)+'</ENC_3>')
				FPUTS(gnFileXml,'<ENC_4>'+ALLTRIM(fcec05c.veresq)+'</ENC_4>')
				FPUTS(gnFileXml,'<ENC_5>'+ALLTRIM(fcec05c.esqdian)+'</ENC_5>')
				FPUTS(gnFileXml,'<ENC_6>'+ALLTRIM(fcec05c.prefres)+ALLTRIM(fcec05c.sfra)+'</ENC_6>')
				FPUTS(gnFileXml,'<ENC_7>'+SUBSTR(fcec05c.expedido,1,4)+"-"+SUBSTR(fcec05c.expedido,5,2)+"-"+SUBSTR(fcec05c.expedido,7,2)+'</ENC_7>')
				FPUTS(gnFileXml,'<ENC_8>'+TIME()+"-05:00"+'</ENC_8>')
				FPUTS(gnFileXml,'<ENC_9>'+ALLTRIM(fcec05c.tipdoc)+'</ENC_9>')
				FPUTS(gnFileXml,'<ENC_10>'+ALLTRIM(fcec05c.divisa)+'</ENC_10>')
				FPUTS(gnFileXml,'<ENC_15>'+ALLTRIM(STR(fcec05c.nitem))+'</ENC_15>')
				FPUTS(gnFileXml,'<ENC_16>'+SUBSTR(fcec05c.vencido,1,4)+"-"+SUBSTR(fcec05c.vencido,5,2)+"-"+SUBSTR(fcec05c.vencido,7,2)+'</ENC_16>')
				FPUTS(gnFileXml,'<ENC_20>'+ALLTRIM(fcec05c.dambient)+'</ENC_20>')
				FPUTS(gnFileXml,'<ENC_21>'+ALLTRIM(fcec05c.optipo)+'</ENC_21>')
			FPUTS(gnFileXml,'</ENC>')
			
	 *enc_9 1 = Factura
	**.- Finaliza Encabezado 
	
		**.- Inicia Emisor
			
			FPUTS(gnFileXml,'<EMI>')
				FPUTS(gnFileXml,'<EMI_1>'+ALLTRIM(fcec05c.idtpeemp)+'</EMI_1>')
				FPUTS(gnFileXml,'<EMI_2>'+ALLTRIM(fcec05c.nitemp)+'</EMI_2>')
				FPUTS(gnFileXml,'<EMI_3>'+ALLTRIM(fcec05c.idtpiemp)+'</EMI_3>')
				FPUTS(gnFileXml,'<EMI_4>'+ALLTRIM(fcec05c.grupoemp)+'</EMI_4>')
				
*!*				IF SUBSTR(fcec05c.idtpeemp,1,1) = "1"
*!*				IF SUBSTR(fcec05c.razonemp,1,1) <> " "
					FPUTS(gnFileXml,'<EMI_6>'+ALLTRIM(fcec05c.razonemp)+'</EMI_6>')
*!*				ELSE
*!*					FPUTS(gnFileXml,'<EMI_6>'+ALLTRIM(fcec05c.nomemp)+" "+ALLTRIM(fcec05c.apl1emp)+" "+ALLTRIM(fcec05c.apl2emp)+'</EMI_6>')
*!*				ENDIF
				IF SUBSTR(fcec05c.nomcoemp,1,1) <> " "
					FPUTS(gnFileXml,'<EMI_7>'+ALLTRIM(fcec05c.nomcoemp)+'</EMI_7>')
				ENDIF
				
*!*					IF SUBSTR(fcec05c.idtpeemp,1,1) = "2"
*!*						FPUTS(gnFileXml,'<EMI_8>'+ALLTRIM(fcec05c.nomemp)+'</EMI_8>')
*!*						FPUTS(gnFileXml,'<EMI_9>'+ALLTRIM(fcec05c.apl1emp)+" "+ALLTRIM(fcec05c.apl2emp)+'</EMI_9>')
*!*					ENDIF
				
				FPUTS(gnFileXml,'<EMI_10>'+ALLTRIM(fcec05c.diremp)+'</EMI_10>')
				FPUTS(gnFileXml,'<EMI_11>'+ALLTRIM(fcec05c.cdptoemp)+'</EMI_11>')
*!*					FPUTS(gnFileXml,'<EMI_12>'+ALLTRIM(fcec05c.mpioemp)+'</EMI_12>')
				FPUTS(gnFileXml,'<EMI_13>'+ALLTRIM(fcec05c.mpioemp)+'</EMI_13>')
				FPUTS(gnFileXml,'<EMI_14>'+ALLTRIM(fcec05c.cpostemp)+'</EMI_14>')
				FPUTS(gnFileXml,'<EMI_15>'+ALLTRIM(fcec05c.cpaisemp)+'</EMI_15>')
*!*					FPUTS(gnFileXml,'<EMI_17>'+ALLTRIM(fcec05c.matccemp)+'</EMI_17>')
*!*					FPUTS(gnFileXml,'<EMI_18>'+ALLTRIM(fcec05c.diremp)+'</EMI_18>')
				FPUTS(gnFileXml,'<EMI_19>'+ALLTRIM(fcec05c.dptoemp)+'</EMI_19>')
*!*					FPUTS(gnFileXml,'<EMI_20>'+ALLTRIM(fcec05c.ciuemp)+'</EMI_20>')
				FPUTS(gnFileXml,'<EMI_21>'+ALLTRIM(fcec05c.npaisemp)+'</EMI_21>')
				FPUTS(gnFileXml,'<EMI_22>'+ALLTRIM(fcec05c.dvemp)+'</EMI_22>')
				FPUTS(gnFileXml,'<EMI_23>'+ALLTRIM(fcec05c.cmpioemp)+'</EMI_23>')

*!*					IF SUBSTR(fcec05c.razonemp,1,1) <> " "
				FPUTS(gnFileXml,'<EMI_24>'+ALLTRIM(fcec05c.razonemp)+'</EMI_24>')
*!*					ELSE
*!*						FPUTS(gnFileXml,'<EMI_24>'+ALLTRIM(fcec05c.nomemp)+" "+ALLTRIM(fcec05c.apl1emp)+" "+ALLTRIM(fcec05c.apl2emp)+'</EMI_24>')
*!*					ENDIF
				FPUTS(gnFileXml,'<EMI_25>'+ALLTRIM(fcec05c.ciiuemp)+'</EMI_25>')
				
				FPUTS(gnFileXml,'<TAC>')
					FPUTS(gnFileXml,'<TAC_1>'+ALLTRIM(fcec05c.ruto1emp)+'</TAC_1>')
				FPUTS(gnFileXml,'</TAC>')
												
				***DATOS CLIENTE ***
				FPUTS(gnFileXml,'<DFE>')
					FPUTS(gnFileXml,'<DFE_1>'+ALLTRIM(fcec05c.cmpioemp)+'</DFE_1>')
					FPUTS(gnFileXml,'<DFE_2>'+ALLTRIM(fcec05c.cdptoemp)+'</DFE_2>')
					FPUTS(gnFileXml,'<DFE_3>'+ALLTRIM(fcec05c.cpaisemp)+'</DFE_3>')
					FPUTS(gnFileXml,'<DFE_4>'+ALLTRIM(fcec05c.cpostemp)+'</DFE_4>')
					FPUTS(gnFileXml,'<DFE_5>'+ALLTRIM(fcec05c.npaisemp)+'</DFE_5>')
					FPUTS(gnFileXml,'<DFE_6>'+ALLTRIM(fcec05c.dptoemp)+'</DFE_6>')
					FPUTS(gnFileXml,'<DFE_7>'+ALLTRIM(fcec05c.ciuemp)+'</DFE_7>')
					FPUTS(gnFileXml,'<DFE_8>'+ALLTRIM(fcec05c.diremp)+'</DFE_8>')
				FPUTS(gnFileXml,'</DFE>')
						
				***MAT CCIO ***
*!*					IF SUBSTR(fcec05c.idtpeemp,1,1) = "1"
				FPUTS(gnFileXml,'<ICC>')
					FPUTS(gnFileXml,'<ICC_1>'+ALLTRIM(fcec05c.matccemp)+'</ICC_1>')
*!*						FPUTS(gnFileXml,'<ICC_2>'+ALLTRIM(fcec05c.mpioemp)+'</ICC_2>')
*!*						FPUTS(gnFileXml,'<ICC_3>'+ALLTRIM(fcec05c.ciuccemp)+'</ICC_3>')
*!*						FPUTS(gnFileXml,'<ICC_5>'+ALLTRIM(fcec05c.dptccemp)+'</ICC_5>')
*!*						FPUTS(gnFileXml,'<ICC_6>'+ALLTRIM(fcec05c.dirccemp)+'</ICC_6>')
*!*						FPUTS(gnFileXml,'<ICC_7>'+ALLTRIM(fcec05c.paiccemp)+'</ICC_7>')
*!*						FPUTS(gnFileXml,'<ICC_8>'+ALLTRIM(fcec05c.npaccemp)+'</ICC_8>')
					FPUTS(gnFileXml,'<ICC_9>'+ALLTRIM(SUBSTR(fcec05c.prefres,1,4))+'</ICC_9>')
				FPUTS(gnFileXml,'</ICC>')
*!*					ENDIF
*!*						
				***CONTACTO EMISOR ***
				FPUTS(gnFileXml,'<CDE>')
					FPUTS(gnFileXml,'<CDE_1>'+ALLTRIM(fcec05c.tpconemp)+'</CDE_1>')
					FPUTS(gnFileXml,'<CDE_2>'+ALLTRIM(fcec05c.nmconemp)+'</CDE_2>')
					FPUTS(gnFileXml,'<CDE_3>'+ALLTRIM(fcec05c.tlconemp)+'</CDE_3>')
					FPUTS(gnFileXml,'<CDE_4>'+ALLTRIM(fcec05c.emconemp)+'</CDE_4>')
				FPUTS(gnFileXml,'</CDE>')
				
				FPUTS(gnFileXml,'<GTE>')
					FPUTS(gnFileXml,'<GTE_1>'+ALLTRIM(fcec05c.ctri01emp)+'</GTE_1>')
					FPUTS(gnFileXml,'<GTE_2>'+ALLTRIM(fcec05c.dtri01emp)+'</GTE_2>')
				FPUTS(gnFileXml,'</GTE>')
			
			FPUTS(gnFileXml,'</EMI>')
		**.- Fin Emisor
 		
 		**.- Inicia ADQuiriente	
			FPUTS(gnFileXml,'<ADQ>')
				FPUTS(gnFileXml,'<ADQ_1>'+ALLTRIM(fcec05c.idtpeadq)+'</ADQ_1>')
				FPUTS(gnFileXml,'<ADQ_2>'+ALLTRIM(fcec05c.nit)+'</ADQ_2>')
				FPUTS(gnFileXml,'<ADQ_3>'+ALLTRIM(fcec05c.idtpiadq)+'</ADQ_3>')
				FPUTS(gnFileXml,'<ADQ_4>'+ALLTRIM(fcec05c.idregadq)+'</ADQ_4>')
			*verificar si es juridico natural
				IF SUBSTR(fcec05c.idtpeadq,1,1) = "1"
					FPUTS(gnFileXml,'<ADQ_6>'+ALLTRIM(fcec05c.razon)+'</ADQ_6>')
				ELSE
					FPUTS(gnFileXml,'<ADQ_6>'+ALLTRIM(fcec05c.nom1)+" "+ALLTRIM(fcec05c.apl1)+" "+ALLTRIM(fcec05c.apl2)+'</ADQ_6>')
				ENDIF
*!*				FPUTS(gnFileXml,'<ADQ_7>'+ALLTRIM(fcec05c.nomcom)+'</ADQ_7>')
				IF SUBSTR(fcec05c.idtpeadq,1,1) = "2"
					FPUTS(gnFileXml,'<ADQ_8>'+ALLTRIM(fcec05c.nom1)+'</ADQ_8>')
					FPUTS(gnFileXml,'<ADQ_9>'+ALLTRIM(fcec05c.apl1)+" "+ALLTRIM(fcec05c.apl2)+'</ADQ_9>')
				ENDIF
				FPUTS(gnFileXml,'<ADQ_10>'+ALLTRIM(fcec05c.direcc)+'</ADQ_10>')
				FPUTS(gnFileXml,'<ADQ_11>'+ALLTRIM(fcec05c.coddpto)+'</ADQ_11>')
*				FPUTS(gnFileXml,'<ADQ_12>'+ALLTRIM(fcec05c.mpio)+'</ADQ_12>')
				FPUTS(gnFileXml,'<ADQ_13>'+ALLTRIM(fcec05c.mpio)+'</ADQ_13>')
				FPUTS(gnFileXml,'<ADQ_14>'+ALLTRIM(fcec05c.cpostal)+'</ADQ_14>')
				FPUTS(gnFileXml,'<ADQ_15>'+ALLTRIM(fcec05c.cpaisadq)+'</ADQ_15>')
*!*					IF SUBSTR(fcec05c.matccadq,1,1) <> " "
*!*						FPUTS(gnFileXml,'<ADQ_17>'+ALLTRIM(fcec05c.matccadq)+'</ADQ_17>')
*!*					ENDIF
*!*					FPUTS(gnFileXml,'<ADQ_18>'+ALLTRIM(fcec05c.direcc)+'</ADQ_18>')
				FPUTS(gnFileXml,'<ADQ_19>'+ALLTRIM(fcec05c.dpto)+'</ADQ_19>')
*!*					FPUTS(gnFileXml,'<ADQ_20>'+ALLTRIM(fcec05c.ciud)+'</ADQ_20>')
				FPUTS(gnFileXml,'<ADQ_21>'+ALLTRIM(fcec05c.npaisadq)+'</ADQ_21>')
				FPUTS(gnFileXml,'<ADQ_22>'+ALLTRIM(fcec05c.dv)+'</ADQ_22>')
				FPUTS(gnFileXml,'<ADQ_23>'+ALLTRIM(fcec05c.coddpto)+ALLTRIM(fcec05c.codmpio)+'</ADQ_23>')
				FPUTS(gnFileXml,'<ADQ_24>'+ALLTRIM(fcec05c.nit)+'</ADQ_24>')
 		 		
				FPUTS(gnFileXml,'<TCR>')
				FPUTS(gnFileXml,'<TCR_1>'+ALLTRIM(fcec05c.ruto1adq)+'</TCR_1>')
				FPUTS(gnFileXml,'</TCR>')
				
				FPUTS(gnFileXml,'<ILA>')
				IF SUBSTR(fcec05c.idtpeadq,1,1) = "1"
					FPUTS(gnFileXml,'<ILA_1>'+ALLTRIM(fcec05c.razon)+'</ILA_1>')
				ENDIF
				IF SUBSTR(fcec05c.idtpeadq,1,1) = "2"
					FPUTS(gnFileXml,'<ILA_1>'+ALLTRIM(fcec05c.nom1)+" "+ALLTRIM(fcec05c.apl1)+'</ILA_1>')
				ENDIF
				FPUTS(gnFileXml,'<ILA_2>'+ALLTRIM(fcec05c.nit)+'</ILA_2>')
				FPUTS(gnFileXml,'<ILA_3>'+ALLTRIM(fcec05c.idtpiadq)+'</ILA_3>')
				FPUTS(gnFileXml,'<ILA_4>'+ALLTRIM(fcec05c.idtpeadq)+'</ILA_4>')
				FPUTS(gnFileXml,'</ILA>')
				
				FPUTS(gnFileXml,'<DFA>')
				FPUTS(gnFileXml,'<DFA_1>'+ALLTRIM(fcec05c.cpaisadq)+'</DFA_1>')
				FPUTS(gnFileXml,'<DFA_2>'+ALLTRIM(fcec05c.coddpto)+'</DFA_2>')
				FPUTS(gnFileXml,'<DFA_3>'+ALLTRIM(fcec05c.cpostal)+'</DFA_3>')
				FPUTS(gnFileXml,'<DFA_4>'+ALLTRIM(fcec05c.coddpto)+ALLTRIM(fcec05c.codmpio)+'</DFA_4>')
				FPUTS(gnFileXml,'<DFA_5>'+ALLTRIM(fcec05c.npaisadq)+'</DFA_5>')
				FPUTS(gnFileXml,'<DFA_6>'+ALLTRIM(fcec05c.dpto)+'</DFA_6>')
				FPUTS(gnFileXml,'<DFA_7>'+ALLTRIM(fcec05c.mpio)+'</DFA_7>')
				FPUTS(gnFileXml,'<DFA_8>'+ALLTRIM(fcec05c.direcc)+'</DFA_8>')
				FPUTS(gnFileXml,'</DFA>')
				
				***camara de ccio adquiriente
				IF SUBSTR(fcec05c.idtpeadq,1,1) = "1"
					IF SUBSTR(fcec05c.matccadq,1,1) <> " "
						FPUTS(gnFileXml,'<ICR>')
						FPUTS(gnFileXml,'<ICR_1>'+ALLTRIM(fcec05c.matccadq)+'</ICR_1>')
						FPUTS(gnFileXml,'</ICR>')
					ENDIF
				ENDIF
								
*!*				CONTACTO ADQUIRIENTE
				FPUTS(gnFileXml,'<CDA>')
					FPUTS(gnFileXml,'<CDA_1>'+ALLTRIM(fcec05c.tpconta)+'</CDA_1>')
					FPUTS(gnFileXml,'<CDA_2>'+ALLTRIM(fcec05c.nomconta)+'</CDA_2>')
					FPUTS(gnFileXml,'<CDA_3>'+ALLTRIM(fcec05c.telconta)+'</CDA_3>')
					FPUTS(gnFileXml,'<CDA_4>'+ALLTRIM(fcec05c.emaconta)+'</CDA_4>')
				FPUTS(gnFileXml,'</CDA>')
*!*				* fin contacto
				
				FPUTS(gnFileXml,'<GTA>')
					FPUTS(gnFileXml,'<GTA_1>'+ALLTRIM(fcec05c.ctri01adq)+'</GTA_1>')
					FPUTS(gnFileXml,'<GTA_2>'+ALLTRIM(fcec05c.dtri01adq)+'</GTA_2>')
				FPUTS(gnFileXml,'</GTA>')
			
			FPUTS(gnFileXml,'</ADQ>')
		**.- Fin Adquiriente
			
 		**.- Inicio Datos Documento -totales
			FPUTS(gnFileXml,'<TOT>')
				FPUTS(gnFileXml,'<TOT_1>'+ALLTRIM(STR((fcec05c.subtotal),11,2))+'</TOT_1>')
				FPUTS(gnFileXml,'<TOT_2>'+ALLTRIM(fcec05c.divisa)+'</TOT_2>')
				FPUTS(gnFileXml,'<TOT_3>'+ALLTRIM(STR((fcec05c.subneto),11,2))+'</TOT_3>')
				FPUTS(gnFileXml,'<TOT_4>'+ALLTRIM(fcec05c.divisa)+'</TOT_4>')
				FPUTS(gnFileXml,'<TOT_5>'+ALLTRIM(STR(fcec05c.total,11,2))+'</TOT_5>')
				FPUTS(gnFileXml,'<TOT_6>'+ALLTRIM(fcec05c.divisa)+'</TOT_6>')
				FPUTS(gnFileXml,'<TOT_7>'+ALLTRIM(STR(fcec05c.total,11,2))+'</TOT_7>')
				FPUTS(gnFileXml,'<TOT_8>'+ALLTRIM(fcec05c.divisa)+'</TOT_8>')
*!*				FPUTS(gnFileXml,'<Tot_9>'+ALLTRIM(STR(fcec05c.desc1,9,4))+'</Tot_9>')
*!*				FPUTS(gnFileXml,'<Tot_10>'+ALLTRIM(fcec05c.divisa)+'</Tot_10>')
*!*				FPUTS(gnFileXml,'<Tot_11>'+ALLTRIM(STR(fcec05c.cargos,9,4))+'</Tot_11>')
*!*				FPUTS(gnFileXml,'<Tot_12>'+ALLTRIM(fcec05c.divisa)+'</Tot_12>')
*!*				FPUTS(gnFileXml,'<Tot_13>'+ALLTRIM(STR(fcec05c.anticipo,9,4))+'</Tot_13>')
*!*				FPUTS(gnFileXml,'<Tot_14>'+ALLTRIM(fcec05c.divisa)+'</Tot_14>')
*!*				FPUTS(gnFileXml,'<Tot_15>'+ALLTRIM(STR(fcec05c.redondeo,9,4))+'</Tot_15>')
*!*				FPUTS(gnFileXml,'<Tot_16>'+ALLTRIM(fcec05c.divisa)+'</Tot_16>')
			FPUTS(gnFileXml,'</TOT>')
			
			Mvlraciv = 0.00
			Mvlracbv = 0.00
			Mporiva  = 0.00
			Mvlraciv0 = 0.00
			Mvlracbv0 = 0.00
			Mporiva0  = 0.00
			
			SELECT fced05c
			SCAN ALL
				
	 			*** EL false es pr impto -iva si fuera true es x retenciones
	 			
	 			IF fced05c.vlriva > 0
					
					Mvlraciv = Mvlraciv + fced05c.vlriva
					
					Mvlracbv = Mvlracbv + fced05c.vlcanuni
					
					Mporiva = fced05c.poriva
					
				ELSE
					
					Mvlracbv0 = Mvlracbv0 + fced05c.vlcanuni
					
					Mvlraciv0 = 0.00
					
					Mporiva0 = 0.00
				
				ENDIF
			ENDSCAN
			
*.*	 		IF Mvlraciv > 0
				FPUTS(gnFileXml,'<TIM>')
					FPUTS(gnFileXml,'<TIM_1>'+"false"+'</TIM_1>')
					FPUTS(gnFileXml,'<TIM_2>'+ALLTRIM(STR(Mvlraciv,11,2))+'</TIM_2>')
					FPUTS(gnFileXml,'<TIM_3>'+ALLTRIM(fcec05c.divisa)+'</TIM_3>')
			
	 		*** EL 01 TRAER DESDE EL PROG  ver como POR SI
					IF Mvlracbv > 0
						FPUTS(gnFileXml,'<IMP>')
						FPUTS(gnFileXml,'<IMP_1>'+"01"+'</IMP_1>')
						FPUTS(gnFileXml,'<IMP_2>'+ALLTRIM(STR(Mvlracbv,11,2))+'</IMP_2>')
						FPUTS(gnFileXml,'<IMP_3>'+ALLTRIM(fcec05c.divisa)+'</IMP_3>')
						FPUTS(gnFileXml,'<IMP_4>'+ALLTRIM(STR(Mvlraciv,11,2))+'</IMP_4>')
						FPUTS(gnFileXml,'<IMP_5>'+ALLTRIM(fcec05c.divisa)+'</IMP_5>')
						FPUTS(gnFileXml,'<IMP_6>'+ALLTRIM(STR(Mporiva,11,3))+'</IMP_6>')
						FPUTS(gnFileXml,'</IMP>')
					ENDIF
					IF Mvlracbv0 > 0
						FPUTS(gnFileXml,'<IMP>')
						FPUTS(gnFileXml,'<IMP_1>'+"01"+'</IMP_1>')
						FPUTS(gnFileXml,'<IMP_2>'+ALLTRIM(STR(Mvlracbv0,11,2))+'</IMP_2>')
						FPUTS(gnFileXml,'<IMP_3>'+ALLTRIM(fcec05c.divisa)+'</IMP_3>')
						FPUTS(gnFileXml,'<IMP_4>'+ALLTRIM(STR(Mvlraciv0,11,2))+'</IMP_4>')
						FPUTS(gnFileXml,'<IMP_5>'+ALLTRIM(fcec05c.divisa)+'</IMP_5>')
						FPUTS(gnFileXml,'<IMP_6>'+ALLTRIM(STR(Mporiva0,11,3))+'</IMP_6>')
						FPUTS(gnFileXml,'</IMP>')
					ENDIF
				FPUTS(gnFileXml,'</TIM>')
*.*			ENDIF
			
*.* descuentos
*!*			FPUTS(gnFileXml,'<Dsc>')
*!*			FPUTS(gnFileXml,'	<Dsc_1>'+"false"+'</Dsc_1>')
*!*			FPUTS(gnFileXml,'	<Dsc_2>'+ALLTRIM(STR(pordesc1))+'</Dsc_2>')
*!*			FPUTS(gnFileXml,'	<Dsc_3>'+ALLTRIM(STR(fcec05c.desc1))+'</Dsc_3>')
*!*			FPUTS(gnFileXml,'	<Dsc_4>'+ALLTRIM(fcec05c.divisa)+'</Dsc_4>')
*!*			FPUTS(gnFileXml,'	<Dsc_5>'+"19"+'</Dsc_5>')
*!*			FPUTS(gnFileXml,'	<Dsc_8>'+ALLTRIM(fcec05c.divisa)+'</Dsc_8>')
*!*			FPUTS(gnFileXml,'	<Dsc_9>'+"1"+'</Dsc_9>')
*!*			FPUTS(gnFileXml,'</Dsc>')
			
			*.* resolucion 
			FPUTS(gnFileXml,'<DRF>')
				FPUTS(gnFileXml,'<DRF_1>'+ALLTRIM(fcec05c.numres)+'</DRF_1>')
				FPUTS(gnFileXml,'<DRF_2>'+ALLTRIM(fcec05c.finires)+'</DRF_2>')
				FPUTS(gnFileXml,'<DRF_3>'+ALLTRIM(fcec05c.ffinres)+'</DRF_3>')
				FPUTS(gnFileXml,'<DRF_4>'+ALLTRIM(SUBSTR(fcec05c.prefres,1,4))+'</DRF_4>')
				FPUTS(gnFileXml,'<DRF_5>'+ALLTRIM(fcec05c.docires)+'</DRF_5>')
				FPUTS(gnFileXml,'<DRF_6>'+ALLTRIM(fcec05c.docfres)+'</DRF_6>')
			FPUTS(gnFileXml,'</DRF>')
			
			*** VERIFICAR SI VA IVA
*!*				FPUTS(gnFileXml,'<ITD>')
*!*					FPUTS(gnFileXml,'<ITD_1>'+ALLTRIM(STR(fcec05c.iva,9,4))+'</ITD_1>')
*!*					FPUTS(gnFileXml,'<ITD_2>'+ALLTRIM(fcec05c.divisa)+'</ITD_2>')
*!*					FPUTS(gnFileXml,'<ITD_3>'+ALLTRIM(STR(fcec05c.totrets,9,4))+'</ITD_3>')
*!*					FPUTS(gnFileXml,'<ITD_4>'+ALLTRIM(fcec05c.divisa)+'</ITD_4>')
*!*					FPUTS(gnFileXml,'<ITD_5>'+ALLTRIM(STR(fcec05c.total,9,4))+'</ITD_5>')
*!*					FPUTS(gnFileXml,'<ITD_6>'+ALLTRIM(fcec05c.divisa)+'</ITD_6>')
*!*				FPUTS(gnFileXml,'</ITD>')
			*** VERIFICAR SI VA IVA
			
			*** VERIFICAR SI VA receptor de pago
*!*				FPUTS(gnFileXml,'<RCP>')
*!*					FPUTS(gnFileXml,'<RCP_1>'+ALLTRIM(fcec05c.nitemp)+'</RCP_1>')
*!*					FPUTS(gnFileXml,'<RCP_2>'+ALLTRIM(fcec05c.idtpiemp)+'</RCP_2>')
*!*					FPUTS(gnFileXml,'<RCP_3>'+ALLTRIM((fcec05c.idregemp))+'</RCP_3>')
*!*					
*!*					IF SUBSTR(fcec05c.idtpeemp,1,1) = "1"
*!*						FPUTS(gnFileXml,'<RCP_4>'+ALLTRIM(fcec05c.razonemp)+'</RCP_4>')
*!*					ENDIF
*!*					FPUTS(gnFileXml,'<RCP_5>'+ALLTRIM(fcec05c.nomcoemp)+'</RCP_5>')
*!*					IF SUBSTR(fcec05c.idtpeemp,1,1) = "2"
*!*						FPUTS(gnFileXml,'<RCP_6>'+ALLTRIM(fcec05c.nomemp)+'</RCP_6>')
*!*						FPUTS(gnFileXml,'<RCP_7>'+ALLTRIM(fcec05c.apl1emp)+" "+ALLTRIM(fcec05c.apl2emp)+'</RCP_7>')
*!*					ENDIF

*!*					FPUTS(gnFileXml,'<RCP_8>'+ALLTRIM(fcec05c.diremp)+'</RCP_8>')
*!*					FPUTS(gnFileXml,'<RCP_9>'+ALLTRIM(fcec05c.dptoemp)+'</RCP_9>')
*!*					FPUTS(gnFileXml,'<RCP_10>'+ALLTRIM(fcec05c.mpioemp)+'</RCP_10>')
*!*					FPUTS(gnFileXml,'<RCP_11>'+ALLTRIM(fcec05c.ciuemp)+'</RCP_11>')
*!*	*				FPUTS(gnFileXml,'<RCP_12>'+ALLTRIM(fcec05c.)+'</RCP_12>')
*!*					FPUTS(gnFileXml,'<RCP_13>'+ALLTRIM(fcec05c.cpaisemp)+'</RCP_13>')
*!*					
*!*					FPUTS(gnFileXml,'<PCR>')
*!*						FPUTS(gnFileXml,'<PCR_1>'+ALLTRIM(fcec05c.ruto1adq)+'</PCR_1>')
*!*					FPUTS(gnFileXml,'</PCR>')
*!*				FPUTS(gnFileXml,'</RCP>')
			*** VERIFICAR SI VA
			
*!*					FPUTS(gnFileXml,'<PCR>')
*!*					FPUTS(gnFileXml,'<PCR_1>'+ALLTRIM(fcec05c.ruto1emp)+'</PCR_1>')
*!*					FPUTS(gnFileXml,'</PCR>')
*!*					FPUTS(gnFileXml,'<QTA>')
*!*					FPUTS(gnFileXml,'<QTA_1>'+ALLTRIM(fcec05c.ruto1emp)+'</QTA_1>')
*!*					FPUTS(gnFileXml,'</QTA>')
*!*					FPUTS(gnFileXml,'<ATA>')
*!*					FPUTS(gnFileXml,'<ATA_1>'+ALLTRIM(fcec05c.ruto1emp)+'</ATA_1>')
*!*					FPUTS(gnFileXml,'</ATA>')
				
*!*				FPUTS(gnFileXml,'<Ref>')
*!*					FPUTS(gnFileXml,'<Ref_1>'+""+'</Ref_1>')
*!*					FPUTS(gnFileXml,'<Ref_2>'+ +'</Ref_2>')
*!*					FPUTS(gnFileXml,'<Ref_3>'+ +'</Ref_3>')
*!*					FPUTS(gnFileXml,'<Ref_4>'+ +'</Ref_4>')
*!*				FPUTS(gnFileXml,'</Ref>')

				IF SUBSTR(fcec05c.nota1emp,1,1) <> " "
					FPUTS(gnFileXml,'<NOT>')
					FPUTS(gnFileXml,'<NOT_1>'+ALLTRIM(fcec05c.nota1emp)+'</NOT_1>')
					FPUTS(gnFileXml,'</NOT>')
				ENDIF
				
*!*					IF SUBSTR(fcec05c.nota2emp,1,1) <> " "
*!*						FPUTS(gnFileXml,'<NOT>')
*!*						FPUTS(gnFileXml,'<NOT_1>'+ALLTRIM(fcec05c.nota2emp)+'</NOT_1>')
*!*						FPUTS(gnFileXml,'</NOT>')
*!*					ENDIF
*!*					IF SUBSTR(fcec05c.nota3emp,1,1) <> " "
*!*						FPUTS(gnFileXml,'<NOT>')
*!*						FPUTS(gnFileXml,'<NOT_1>'+ALLTRIM(fcec05c.nota3emp)+'</NOT_1>')
*!*						FPUTS(gnFileXml,'</NOT>')
*!*					ENDIF
*!*					IF SUBSTR(fcec05c.nota4emp,1,1) <> " "
*!*						FPUTS(gnFileXml,'<NOT>')
*!*						FPUTS(gnFileXml,'<NOT_1>'+ALLTRIM(fcec05c.nota4emp)+'</NOT_1>')
*!*						FPUTS(gnFileXml,'</NOT>')
*!*					ENDIF
				
				IF SUBSTR(fcec05c.ordenc,1,1) <> " "
					FPUTS(gnFileXml,'<ORC>')
					FPUTS(gnFileXml,'<ORC_1>'+ALLTRIM(fcec05c.ordenc)+'</ORC_1>')
					FPUTS(gnFileXml,'</ORC>')
				ENDIF
				
					*** EL MEP 1 "METODO DE PAGO 1 NO DEFINIDO" TRAER DESDE EL PROG ver como POR SI		
				
				FPUTS(gnFileXml,'<MEP>')
					FPUTS(gnFileXml,'<MEP_1>'+"1"+'</MEP_1>')
					IF fcec05c.diascr > 0
						FPUTS(gnFileXml,'<MEP_2>'+"2"+'</MEP_2>')
					ELSE
						FPUTS(gnFileXml,'<MEP_2>'+"1"+'</MEP_2>')
					ENDIF
					FPUTS(gnFileXml,'<MEP_3>'+SUBSTR(fcec05c.vencido,1,4)+"-"+SUBSTR(fcec05c.vencido,5,2)+"-"+SUBSTR(fcec05c.vencido,7,2)+'</MEP_3>')
				FPUTS(gnFileXml,'</MEP>')
			
 			**.- Fin Datos Documento
 	 		
			SELECT fced05c
*!*			FPUTS(gnFileXml,'<Ddetalle>')
			SCAN ALL
			FPUTS(gnFileXml,'<ITE>')
				FPUTS(gnFileXml,'<ITE_1>'+ALLTRIM(STR(fced05c.secc))+'</ITE_1>')
				FPUTS(gnFileXml,'<ITE_3>'+ALLTRIM(STR(fced05c.cantidad,11,2))+'</ITE_3>')
				FPUTS(gnFileXml,'<ITE_4>'+ALLTRIM(fced05c.medida)+'</ITE_4>')
				FPUTS(gnFileXml,'<ITE_5>'+ALLTRIM(STR(fced05c.vlcanuni,11,2))+'</ITE_5>')
				FPUTS(gnFileXml,'<ITE_6>'+ALLTRIM(fced05c.divisa)+'</ITE_6>')
				FPUTS(gnFileXml,'<ITE_7>'+ALLTRIM(STR(fced05c.vlunit,11,2))+'</ITE_7>')
				FPUTS(gnFileXml,'<ITE_8>'+ALLTRIM(fced05c.divisa)+'</ITE_8>')
*!*				FPUTS(gnFileXml,'<ITE_10>'+ALLTRIM(fced05c.descrip)+'</ITE_10>')
				FPUTS(gnFileXml,'<ITE_11>'+ALLTRIM(fced05c.descrip)+'</ITE_11>')
*!*				FPUTS(gnFileXml,'<ITE_19>'+ALLTRIM(STR(fced05c.vlcanuni,9,4))+'</ITE_19>')
*!*				FPUTS(gnFileXml,'<ITE_20>'+ALLTRIM(fced05c.divisa)+'</ITE_20>')
*!*				FPUTS(gnFileXml,'<ITE_21>'+ALLTRIM(STR(fced05c.vlcanuni+fced05c.vlriva,9,4))+'</ITE_21>')
*!*				FPUTS(gnFileXml,'<ITE_22>'+ALLTRIM(fced05c.divisa)+'</ITE_22>')
				FPUTS(gnFileXml,'<ITE_27>'+ALLTRIM(STR(fced05c.cantidad,11,0))+'</ITE_27>')
				FPUTS(gnFileXml,'<ITE_28>'+ALLTRIM(fced05c.medida)+'</ITE_28>')
								
				*** TAER DESDE PRG ver como PORSI ok
				
				FPUTS(gnFileXml,'<IAE>')
					FPUTS(gnFileXml,'<IAE_1>'+ALLTRIM(fced05c.iae1)+'</IAE_1>')
					FPUTS(gnFileXml,'<IAE_2>'+ALLTRIM(fced05c.iae2)+'</IAE_2>')
					FPUTS(gnFileXml,'<IAE_3>'+ALLTRIM(fced05c.iae3)+'</IAE_3>')
					FPUTS(gnFileXml,'<IAE_4>'+ALLTRIM(fced05c.iae4)+'</IAE_4>')
				FPUTS(gnFileXml,'</IAE>')
				
				FPUTS(gnFileXml,'<TII>')
					FPUTS(gnFileXml,'<TII_1>'+ALLTRIM(STR(fced05c.vlriva,11,2))+'</TII_1>')
					FPUTS(gnFileXml,'<TII_2>'+ALLTRIM(fcec05c.divisa)+'</TII_2>')
					FPUTS(gnFileXml,'<TII_3>'+"false"+'</TII_3>')
						FPUTS(gnFileXml,'<IIM>')
							FPUTS(gnFileXml,'<IIM_1>'+"01"+'</IIM_1>')
							FPUTS(gnFileXml,'<IIM_2>'+ALLTRIM(STR(fced05c.vlriva,11,2))+'</IIM_2>')
							FPUTS(gnFileXml,'<IIM_3>'+ALLTRIM(fced05c.divisa)+'</IIM_3>')
							FPUTS(gnFileXml,'<IIM_4>'+ALLTRIM(STR(fced05c.vlcanuni,11,2))+'</IIM_4>')
							FPUTS(gnFileXml,'<IIM_5>'+ALLTRIM(fced05c.divisa)+'</IIM_5>')
							FPUTS(gnFileXml,'<IIM_6>'+ALLTRIM(STR(fced05c.poriva,6,3))+'</IIM_6>')
						FPUTS(gnFileXml,'</IIM>')
					
				FPUTS(gnFileXml,'</TII>')
				
				IF SUBSTR(fced05c.lote,1,1) <> " " .OR. SUBSTR(fced05c.reginvim,1,1) <> " "
					FPUTS(gnFileXml,'<IEI>')
						IF SUBSTR(fced05c.lote,1,1) <> " " 
							FPUTS(gnFileXml,'<IEI_1>'+"Lote "+ALLTRIM(fced05c.lote)+"F.Vto "+SUBSTR(fced05c.fvlote,1,4)+"-"+SUBSTR(fced05c.fvlote,5,2)+"-"+SUBSTR(fced05c.fvlote,7,2)+'</IEI_1>')
						ENDIF
						IF SUBSTR(fced05c.reginvim,1,1) <> " "
							FPUTS(gnFileXml,'<IEI_2>'+" Reg. Invima "+ALLTRIM(fced05c.reginvim)+'</IEI_2>')
						ENDIF
					FPUTS(gnFileXml,'</IEI>')
				ENDIF
				
			FPUTS(gnFileXml,'</ITE>')
			
			ENDSCAN
			
*!*			USE IN fced05c
*!*			FPUTS(gnFileXml,'</Ddetalle>')
	 	
		FPUTS(gnFileXml,'</FACTURA>')
	** FINALIZA LA FACTURA
*!*  FPUTS(gnFileXml,'</XMLData>')
	 
*!*		SELECT fced05c
*!*		IF .NOT. EOF()
*!*			SKIP
*!*		ELSE
*!*			EXIT
*!*		ENDIF
*!*	ENDDO
ENDIF

=FCLOSE(gnFileXml )  && Cerrar archivo

*!*WAIT WINDOW "MSG: FIN PROCESO "

			*-Si el valor es Exento
*!*				IF fcec05c.Iva = 0.00
*!*					FPUTS(gnFileXml,'<VlrExento>'+ALLTRIM(STR(fcec05c.exento,12,2))+'</VlrExento>')
*!*				ELSE
*!*					FPUTS(gnFileXml,'<VlrExento>0.00</VlrExento>')
*!*				ENDIF
		
		
*!*				FPUTS(gnFileXml,'<Ddoc>')	
*!*				FPUTS(gnFileXml,'<EmisorNodoc>'+ALLTRIM(fcec05c.sfra)+'</EmisorNodoc>')		
*!*				FPUTS(gnFileXml,'<FechaExpedido>'+(fcec05c.expedido)+'</FechaExpedido>')
*!*				FPUTS(gnFileXml,'<FechaVencido>'+(fcec05c.vencido)+'</FechaVencido>')
*!*		 		
*!*				FPUTS(gnFileXml,'</Ddoc>')

			*- Hace un ciclo para detarmiar todos los Items
					
*!*			SELECT * FROM tempxx1;
*!*			WHERE tempxx1.fact_num  = gVenta.fact_num;
*!*			ORDER BY 1,2;
*!*			INTO CURSOR gDetaFactura
	 		
*!*			SELECT gDetaFactura
*!*			FPUTS(gnFileXml,'	<DETALLE>')
*!*			SCAN ALL
*!*				FPUTS(gnFileXml,'		<LINEA>')
*!*				FPUTS(gnFileXml,'			<CANTIDAD>'+ALLTRIM(STR(gDetaFactura.Total_art1,12,5))+'</CANTIDAD>')
*!*				FPUTS(gnFileXml,'			<DESCRIPCION><![CDATA['+_Tildes(gDetaFactura.Art_des)+']]></DESCRIPCION>')
*!*				FPUTS(gnFileXml,'			<METRICA>'+ALLTRIM(gDetaFactura.Uni_venta)+'</METRICA>')
*!*				FPUTS(gnFileXml,'			<PRECIOUNITARIO>'+ALLTRIM(STR(gDetaFactura.Prec_Uni,12,5))+'</PRECIOUNITARIO>')
*!*				FPUTS(gnFileXml,'			<VALOR>'+ALLTRIM(STR(gDetaFactura.Renglon_neto,12,5))+'</VALOR>')
*!*				FPUTS(gnFileXml,'			<DETALLE1><![CDATA['+ALLTRIM(gDetaFactura.Co_art)+']]></DETALLE1>')
*!*				FPUTS(gnFileXml,'			<DETALLE2><![CDATA['+ALLTRIM(STR(gDetaFactura.Prec_vta,12,3))+']]></DETALLE2>')
*!*				FPUTS(gnFileXml,'			<DETALLE3><![CDATA['+ALLTRIM(STR(gDetaFactura.porc1,8,2))+']]></DETALLE3>')
*!*				FPUTS(gnFileXml,'			<DETALLE4><![CDATA['+ALLTRIM(STR(gDetaFactura.porc2,8,2))+']]></DETALLE4>')
*!*				FPUTS(gnFileXml,'			<DETALLE5><![CDATA['+ALLTRIM(STR(gDetaFactura.porc3,8,2))+']]></DETALLE5>')
*!*				FPUTS(gnFileXml,'		</LINEA>')
*!*			ENDSCAN
*!*			USE IN gDetaFactura
*!*			FPUTS(gnFileXml,'	</DETALLE>')
