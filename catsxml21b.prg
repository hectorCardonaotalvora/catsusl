**********************************************************************************************************************
*  D&D.M.S - DISENO & DESARROLLO MANTENIMIENTO DE SOFWARE                 
*  C.A.T.S - Control Administrativo Total Sistematizado.                  
*            Sistema Contable                                             
*  HECTOR FABIO CARDONA OTALVORA                                          
**********************************************************************************************************************
* nota debito                                                                                        2021.10.19  10:19
* catsusl                                                                                                 11.12  14:30
**********************************************************************************************************************
PROCEDURE catsxml21b

LOCAL filenamexml

IF mmidf <> "P"
	filenamexml = ('D:' + sys(2003) + '\fcecats\' + ALLTRIM(fcec05b.predres) +ALLTRIM(fcec05b.sfra)+'.xml')
ELSE
	filenamexml = ('C:' + sys(2003) + '\fcecats\' + ALLTRIM(fcec05b.predres) +ALLTRIM(fcec05b.sfra)+'.xml')
ENDIF

*Borra Archivo para crearlo de nuevo
DELETE FILE &filenamexml

IF FILE(filenamexml)  && Existe el archivo?
	gnFileXml = FOPEN(filenamexml,12)  && Si, abrirlo lectura-escritura
ELSE
	gnFileXml  = FCREATE(filenamexml)  && No, crearlo
ENDIF

SELECT cufedd
*DELETE ALL

Mcufe = " "

Mcufe = ALLTRIM(SUBSTR(cufe,4,100))

MESSAGEBOX("MSG: CUFE: "+Mcufe, mopok, mtitcua)

IF SUBSTR(Mcufe,1,1) <> " "

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
		
	SELECT fcec05b
	GOTO TOP
	
*!*	DO WHILE !EOF()
	**.- Inicio Encabezado 
		FPUTS(gnFileXml,'<NOTA xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">')
		
			FPUTS(gnFileXml,'<ENC>')
				FPUTS(gnFileXml,'<ENC_1>'+"ND"+'</ENC_1>')
				FPUTS(gnFileXml,'<ENC_2>'+ALLTRIM(fcec05b.nitemp)+'</ENC_2>')
				FPUTS(gnFileXml,'<ENC_3>'+ALLTRIM(fcec05b.nit)+'</ENC_3>')
				FPUTS(gnFileXml,'<ENC_4>'+ALLTRIM(fcec05b.veresq)+'</ENC_4>')
				FPUTS(gnFileXml,'<ENC_5>'+ALLTRIM(fcec05b.esqdian)+'</ENC_5>')
				FPUTS(gnFileXml,'<ENC_6>'+ALLTRIM(fcec05b.predres)+ALLTRIM(fcec05b.sfra)+'</ENC_6>')
				FPUTS(gnFileXml,'<ENC_7>'+SUBSTR(fcec05b.expedido,1,4)+"-"+SUBSTR(fcec05b.expedido,5,2)+"-"+SUBSTR(fcec05b.expedido,7,2)+'</ENC_7>')
				FPUTS(gnFileXml,'<ENC_8>'+TIME()+"-05:00"+'</ENC_8>')
				FPUTS(gnFileXml,'<ENC_9>'+ALLTRIM(fcec05b.tipdoc)+'</ENC_9>')
				FPUTS(gnFileXml,'<ENC_10>'+ALLTRIM(fcec05b.divisa)+'</ENC_10>')
				FPUTS(gnFileXml,'<ENC_15>'+ALLTRIM(STR(fcec05b.nitem))+'</ENC_15>')
				FPUTS(gnFileXml,'<ENC_16>'+SUBSTR(fcec05b.vencido,1,4)+"-"+SUBSTR(fcec05b.vencido,5,2)+"-"+SUBSTR(fcec05b.vencido,7,2)+'</ENC_16>')
				FPUTS(gnFileXml,'<ENC_20>'+ALLTRIM(fcec05b.dambient)+'</ENC_20>')
				FPUTS(gnFileXml,'<ENC_21>'+ALLTRIM(fcec05b.optipo)+'</ENC_21>')
			FPUTS(gnFileXml,'</ENC>')
			
	 *enc_9 1 = Factura
	**.- Finaliza Encabezado 
	
		**.- Inicia Emisor
			
			FPUTS(gnFileXml,'<EMI>')
				FPUTS(gnFileXml,'<EMI_1>'+ALLTRIM(fcec05b.idtpeemp)+'</EMI_1>')
				FPUTS(gnFileXml,'<EMI_2>'+ALLTRIM(fcec05b.nitemp)+'</EMI_2>')
				FPUTS(gnFileXml,'<EMI_3>'+ALLTRIM(fcec05b.idtpiemp)+'</EMI_3>')
				FPUTS(gnFileXml,'<EMI_4>'+ALLTRIM(fcec05b.grupoemp)+'</EMI_4>')
				
*!*				IF SUBSTR(fcec05b.idtpeemp,1,1) = "1"
*!*				IF SUBSTR(fcec05b.razonemp,1,1) <> " "
					FPUTS(gnFileXml,'<EMI_6>'+ALLTRIM(fcec05b.razonemp)+'</EMI_6>')
*!*				ELSE
*!*					FPUTS(gnFileXml,'<EMI_6>'+ALLTRIM(fcec05b.nomemp)+" "+ALLTRIM(fcec05b.apl1emp)+" "+ALLTRIM(fcec05b.apl2emp)+'</EMI_6>')
*!*				ENDIF
				IF SUBSTR(fcec05b.nomcoemp,1,1) <> " "
					FPUTS(gnFileXml,'<EMI_7>'+ALLTRIM(fcec05b.nomcoemp)+'</EMI_7>')
				ENDIF
				
*!*					IF SUBSTR(fcec05b.idtpeemp,1,1) = "2"
*!*						FPUTS(gnFileXml,'<EMI_8>'+ALLTRIM(fcec05b.nomemp)+'</EMI_8>')
*!*						FPUTS(gnFileXml,'<EMI_9>'+ALLTRIM(fcec05b.apl1emp)+" "+ALLTRIM(fcec05b.apl2emp)+'</EMI_9>')
*!*					ENDIF
				
				FPUTS(gnFileXml,'<EMI_10>'+ALLTRIM(fcec05b.diremp)+'</EMI_10>')
				FPUTS(gnFileXml,'<EMI_11>'+ALLTRIM(fcec05b.cdptoemp)+'</EMI_11>')
*!*					FPUTS(gnFileXml,'<EMI_12>'+ALLTRIM(fcec05b.mpioemp)+'</EMI_12>')
				FPUTS(gnFileXml,'<EMI_13>'+ALLTRIM(fcec05b.mpioemp)+'</EMI_13>')
				FPUTS(gnFileXml,'<EMI_14>'+ALLTRIM(fcec05b.cpostemp)+'</EMI_14>')
				FPUTS(gnFileXml,'<EMI_15>'+ALLTRIM(fcec05b.cpaisemp)+'</EMI_15>')
*!*					FPUTS(gnFileXml,'<EMI_17>'+ALLTRIM(fcec05b.matccemp)+'</EMI_17>')
*!*					FPUTS(gnFileXml,'<EMI_18>'+ALLTRIM(fcec05b.diremp)+'</EMI_18>')
				FPUTS(gnFileXml,'<EMI_19>'+ALLTRIM(fcec05b.dptoemp)+'</EMI_19>')
*!*					FPUTS(gnFileXml,'<EMI_20>'+ALLTRIM(fcec05b.ciuemp)+'</EMI_20>')
				FPUTS(gnFileXml,'<EMI_21>'+ALLTRIM(fcec05b.npaisemp)+'</EMI_21>')
				FPUTS(gnFileXml,'<EMI_22>'+ALLTRIM(fcec05b.dvemp)+'</EMI_22>')
				FPUTS(gnFileXml,'<EMI_23>'+ALLTRIM(fcec05b.cmpioemp)+'</EMI_23>')

*!*					IF SUBSTR(fcec05b.razonemp,1,1) <> " "
				FPUTS(gnFileXml,'<EMI_24>'+ALLTRIM(fcec05b.razonemp)+'</EMI_24>')
*!*					ELSE
*!*						FPUTS(gnFileXml,'<EMI_24>'+ALLTRIM(fcec05b.nomemp)+" "+ALLTRIM(fcec05b.apl1emp)+" "+ALLTRIM(fcec05b.apl2emp)+'</EMI_24>')
*!*					ENDIF
				FPUTS(gnFileXml,'<EMI_25>'+ALLTRIM(fcec05b.ciiuemp)+'</EMI_25>')
				
				FPUTS(gnFileXml,'<TAC>')
					FPUTS(gnFileXml,'<TAC_1>'+ALLTRIM(fcec05b.ruto1emp)+'</TAC_1>')
				FPUTS(gnFileXml,'</TAC>')
												
				***DATOS CLIENTE ***
				FPUTS(gnFileXml,'<DFE>')
					FPUTS(gnFileXml,'<DFE_1>'+ALLTRIM(fcec05b.cmpioemp)+'</DFE_1>')
					FPUTS(gnFileXml,'<DFE_2>'+ALLTRIM(fcec05b.cdptoemp)+'</DFE_2>')
					FPUTS(gnFileXml,'<DFE_3>'+ALLTRIM(fcec05b.cpaisemp)+'</DFE_3>')
					FPUTS(gnFileXml,'<DFE_4>'+ALLTRIM(fcec05b.cpostemp)+'</DFE_4>')
					FPUTS(gnFileXml,'<DFE_5>'+ALLTRIM(fcec05b.npaisemp)+'</DFE_5>')
					FPUTS(gnFileXml,'<DFE_6>'+ALLTRIM(fcec05b.dptoemp)+'</DFE_6>')
					FPUTS(gnFileXml,'<DFE_7>'+ALLTRIM(fcec05b.ciuemp)+'</DFE_7>')
					FPUTS(gnFileXml,'<DFE_8>'+ALLTRIM(fcec05b.diremp)+'</DFE_8>')
				FPUTS(gnFileXml,'</DFE>')
						
				***MAT CCIO ***
*!*					IF SUBSTR(fcec05b.idtpeemp,1,1) = "1"
				FPUTS(gnFileXml,'<ICC>')
					FPUTS(gnFileXml,'<ICC_1>'+ALLTRIM(fcec05b.matccemp)+'</ICC_1>')
*!*						FPUTS(gnFileXml,'<ICC_2>'+ALLTRIM(fcec05b.mpioemp)+'</ICC_2>')
*!*						FPUTS(gnFileXml,'<ICC_3>'+ALLTRIM(fcec05b.ciuccemp)+'</ICC_3>')
*!*						FPUTS(gnFileXml,'<ICC_5>'+ALLTRIM(fcec05b.dptccemp)+'</ICC_5>')
*!*						FPUTS(gnFileXml,'<ICC_6>'+ALLTRIM(fcec05b.dirccemp)+'</ICC_6>')
*!*						FPUTS(gnFileXml,'<ICC_7>'+ALLTRIM(fcec05b.paiccemp)+'</ICC_7>')
*!*						FPUTS(gnFileXml,'<ICC_8>'+ALLTRIM(fcec05b.npaccemp)+'</ICC_8>')
					FPUTS(gnFileXml,'<ICC_9>'+ALLTRIM(SUBSTR(fcec05b.predres,1,4))+'</ICC_9>')
				FPUTS(gnFileXml,'</ICC>')
*!*					ENDIF
*!*						
				***CONTACTO EMISOR ***
				FPUTS(gnFileXml,'<CDE>')
					FPUTS(gnFileXml,'<CDE_1>'+ALLTRIM(fcec05b.tpconemp)+'</CDE_1>')
					FPUTS(gnFileXml,'<CDE_2>'+ALLTRIM(fcec05b.nmconemp)+'</CDE_2>')
					FPUTS(gnFileXml,'<CDE_3>'+ALLTRIM(fcec05b.tlconemp)+'</CDE_3>')
					FPUTS(gnFileXml,'<CDE_4>'+ALLTRIM(fcec05b.emconemp)+'</CDE_4>')
				FPUTS(gnFileXml,'</CDE>')
				
				FPUTS(gnFileXml,'<GTE>')
					FPUTS(gnFileXml,'<GTE_1>'+ALLTRIM(fcec05b.ctri01emp)+'</GTE_1>')
					FPUTS(gnFileXml,'<GTE_2>'+ALLTRIM(fcec05b.dtri01emp)+'</GTE_2>')
				FPUTS(gnFileXml,'</GTE>')
			
			FPUTS(gnFileXml,'</EMI>')
		**.- Fin Emisor
 		
 		**.- Inicia ADQuiriente	
			FPUTS(gnFileXml,'<ADQ>')
				FPUTS(gnFileXml,'<ADQ_1>'+ALLTRIM(fcec05b.idtpeadq)+'</ADQ_1>')
				FPUTS(gnFileXml,'<ADQ_2>'+ALLTRIM(fcec05b.nit)+'</ADQ_2>')
				FPUTS(gnFileXml,'<ADQ_3>'+ALLTRIM(fcec05b.idtpiadq)+'</ADQ_3>')
				FPUTS(gnFileXml,'<ADQ_4>'+ALLTRIM(fcec05b.idregadq)+'</ADQ_4>')
			*verificar si es juridico natural
				IF SUBSTR(fcec05b.idtpeadq,1,1) = "1"
					FPUTS(gnFileXml,'<ADQ_6>'+ALLTRIM(fcec05b.razon)+'</ADQ_6>')
				ELSE
					FPUTS(gnFileXml,'<ADQ_6>'+ALLTRIM(fcec05b.nom1)+" "+ALLTRIM(fcec05b.apl1)+" "+ALLTRIM(fcec05b.apl2)+'</ADQ_6>')
				ENDIF
*!*				FPUTS(gnFileXml,'<ADQ_7>'+ALLTRIM(fcec05b.nomcom)+'</ADQ_7>')
				IF SUBSTR(fcec05b.idtpeadq,1,1) = "2"
					FPUTS(gnFileXml,'<ADQ_8>'+ALLTRIM(fcec05b.nom1)+'</ADQ_8>')
					FPUTS(gnFileXml,'<ADQ_9>'+ALLTRIM(fcec05b.apl1)+" "+ALLTRIM(fcec05b.apl2)+'</ADQ_9>')
				ENDIF
				FPUTS(gnFileXml,'<ADQ_10>'+ALLTRIM(fcec05b.direcc)+'</ADQ_10>')
				FPUTS(gnFileXml,'<ADQ_11>'+ALLTRIM(fcec05b.coddpto)+'</ADQ_11>')
*				FPUTS(gnFileXml,'<ADQ_12>'+ALLTRIM(fcec05b.mpio)+'</ADQ_12>')
				FPUTS(gnFileXml,'<ADQ_13>'+ALLTRIM(fcec05b.mpio)+'</ADQ_13>')
				FPUTS(gnFileXml,'<ADQ_14>'+ALLTRIM(fcec05b.cpostal)+'</ADQ_14>')
				FPUTS(gnFileXml,'<ADQ_15>'+ALLTRIM(fcec05b.cpaisadq)+'</ADQ_15>')
				
*!*					IF SUBSTR(fcec05b.matccadq,1,1) <> " "
*!*						FPUTS(gnFileXml,'<ADQ_17>'+ALLTRIM(fcec05b.matccadq)+'</ADQ_17>')
*!*					ENDIF
*!*					FPUTS(gnFileXml,'<ADQ_18>'+ALLTRIM(fcec05b.direcc)+'</ADQ_18>')
				FPUTS(gnFileXml,'<ADQ_19>'+ALLTRIM(fcec05b.dpto)+'</ADQ_19>')
*!*					FPUTS(gnFileXml,'<ADQ_20>'+ALLTRIM(fcec05b.ciud)+'</ADQ_20>')
				FPUTS(gnFileXml,'<ADQ_21>'+ALLTRIM(fcec05b.npaisadq)+'</ADQ_21>')
				FPUTS(gnFileXml,'<ADQ_22>'+ALLTRIM(fcec05b.dv)+'</ADQ_22>')
				FPUTS(gnFileXml,'<ADQ_23>'+ALLTRIM(fcec05b.coddpto)+ALLTRIM(fcec05b.codmpio)+'</ADQ_23>')
				FPUTS(gnFileXml,'<ADQ_24>'+ALLTRIM(fcec05b.nit)+'</ADQ_24>')
 		 		
				FPUTS(gnFileXml,'<TCR>')
				FPUTS(gnFileXml,'<TCR_1>'+ALLTRIM(fcec05b.ruto1adq)+'</TCR_1>')
				FPUTS(gnFileXml,'</TCR>')
				
				FPUTS(gnFileXml,'<ILA>')
				IF SUBSTR(fcec05b.idtpeadq,1,1) = "1"
					FPUTS(gnFileXml,'<ILA_1>'+ALLTRIM(fcec05b.razon)+'</ILA_1>')
				ENDIF
				IF SUBSTR(fcec05b.idtpeadq,1,1) = "2"
					FPUTS(gnFileXml,'<ILA_1>'+ALLTRIM(fcec05b.nom1)+" "+ALLTRIM(fcec05b.apl1)+'</ILA_1>')
				ENDIF
				FPUTS(gnFileXml,'<ILA_2>'+ALLTRIM(fcec05b.nit)+'</ILA_2>')
				FPUTS(gnFileXml,'<ILA_3>'+ALLTRIM(fcec05b.idtpiadq)+'</ILA_3>')
				FPUTS(gnFileXml,'<ILA_4>'+ALLTRIM(fcec05b.idtpeadq)+'</ILA_4>')
				FPUTS(gnFileXml,'</ILA>')
				
				FPUTS(gnFileXml,'<DFA>')
				FPUTS(gnFileXml,'<DFA_1>'+ALLTRIM(fcec05b.cpaisadq)+'</DFA_1>')
				FPUTS(gnFileXml,'<DFA_2>'+ALLTRIM(fcec05b.coddpto)+'</DFA_2>')
				FPUTS(gnFileXml,'<DFA_3>'+ALLTRIM(fcec05b.cpostal)+'</DFA_3>')
				FPUTS(gnFileXml,'<DFA_4>'+ALLTRIM(fcec05b.coddpto)+ALLTRIM(fcec05b.codmpio)+'</DFA_4>')
				FPUTS(gnFileXml,'<DFA_5>'+ALLTRIM(fcec05b.npaisadq)+'</DFA_5>')
				FPUTS(gnFileXml,'<DFA_6>'+ALLTRIM(fcec05b.dpto)+'</DFA_6>')
				FPUTS(gnFileXml,'<DFA_7>'+ALLTRIM(fcec05b.mpio)+'</DFA_7>')
				FPUTS(gnFileXml,'<DFA_8>'+ALLTRIM(fcec05b.direcc)+'</DFA_8>')
				FPUTS(gnFileXml,'</DFA>')
								
				***camara de ccio adquiriente
*!*					IF SUBSTR(fcec05b.idtpeadq,1,1) = "1"
*!*						IF SUBSTR(fcec05b.matccadq,1,1) <> " "
*!*							FPUTS(gnFileXml,'<ICR>')
*!*							FPUTS(gnFileXml,'<ICR_1>'+ALLTRIM(fcec05b.matccadq)+'</ICR_1>')
*!*							FPUTS(gnFileXml,'</ICR>')
*!*						ENDIF
*!*					ENDIF
								
*!*				CONTACTO ADQUIRIENTE
				FPUTS(gnFileXml,'<CDA>')
					FPUTS(gnFileXml,'<CDA_1>'+ALLTRIM(fcec05b.tpconta)+'</CDA_1>')
					FPUTS(gnFileXml,'<CDA_2>'+ALLTRIM(fcec05b.nomconta)+'</CDA_2>')
					FPUTS(gnFileXml,'<CDA_3>'+ALLTRIM(fcec05b.telconta)+'</CDA_3>')
					FPUTS(gnFileXml,'<CDA_4>'+ALLTRIM(fcec05b.emaconta)+'</CDA_4>')
				FPUTS(gnFileXml,'</CDA>')
*!*				* fin contacto
				
				FPUTS(gnFileXml,'<GTA>')
					FPUTS(gnFileXml,'<GTA_1>'+ALLTRIM(fcec05b.ctri01adq)+'</GTA_1>')
					FPUTS(gnFileXml,'<GTA_2>'+ALLTRIM(fcec05b.dtri01adq)+'</GTA_2>')
				FPUTS(gnFileXml,'</GTA>')
			
			FPUTS(gnFileXml,'</ADQ>')
		**.- Fin Adquiriente
			
 		**.- Inicio Datos Documento -totales
			FPUTS(gnFileXml,'<TOT>')
				FPUTS(gnFileXml,'<TOT_1>'+ALLTRIM(STR((fcec05b.subtotal),11,2))+'</TOT_1>')
				FPUTS(gnFileXml,'<TOT_2>'+ALLTRIM(fcec05b.divisa)+'</TOT_2>')
				FPUTS(gnFileXml,'<TOT_3>'+ALLTRIM(STR((fcec05b.subneto),11,2))+'</TOT_3>')
				FPUTS(gnFileXml,'<TOT_4>'+ALLTRIM(fcec05b.divisa)+'</TOT_4>')
				FPUTS(gnFileXml,'<TOT_5>'+ALLTRIM(STR(fcec05b.total,11,2))+'</TOT_5>')
				FPUTS(gnFileXml,'<TOT_6>'+ALLTRIM(fcec05b.divisa)+'</TOT_6>')
				FPUTS(gnFileXml,'<TOT_7>'+ALLTRIM(STR(fcec05b.total,11,2))+'</TOT_7>')
				FPUTS(gnFileXml,'<TOT_8>'+ALLTRIM(fcec05b.divisa)+'</TOT_8>')
*!*				FPUTS(gnFileXml,'<Tot_9>'+ALLTRIM(STR(fcec05b.desc1,9,4))+'</Tot_9>')
*!*				FPUTS(gnFileXml,'<Tot_10>'+ALLTRIM(fcec05b.divisa)+'</Tot_10>')
*!*				FPUTS(gnFileXml,'<Tot_11>'+ALLTRIM(STR(fcec05b.cargos,9,4))+'</Tot_11>')
*!*				FPUTS(gnFileXml,'<Tot_12>'+ALLTRIM(fcec05b.divisa)+'</Tot_12>')
*!*				FPUTS(gnFileXml,'<Tot_13>'+ALLTRIM(STR(fcec05b.anticipo,9,4))+'</Tot_13>')
*!*				FPUTS(gnFileXml,'<Tot_14>'+ALLTRIM(fcec05b.divisa)+'</Tot_14>')
*!*				FPUTS(gnFileXml,'<Tot_15>'+ALLTRIM(STR(fcec05b.redondeo,9,4))+'</Tot_15>')
*!*				FPUTS(gnFileXml,'<Tot_16>'+ALLTRIM(fcec05b.divisa)+'</Tot_16>')
			FPUTS(gnFileXml,'</TOT>')
			
			Mvlraciv = 0.00
			Mvlracbv = 0.00
			Mporiva  = 0.00
			Mvlraciv0 = 0.00
			Mvlracbv0 = 0.00
			Mporiva0  = 0.00
			
			SELECT fced05b
			SCAN ALL
				
	 			IF fced05b.vlriva > 0
					
					Mvlraciv = Mvlraciv + fced05b.vlriva
					
					Mvlracbv = Mvlracbv + fced05b.vlcanuni
					
					Mporiva = fced05b.poriva
					
				ELSE
					
					Mvlracbv0 = Mvlracbv0 + fced05b.vlcanuni
					
					Mvlraciv0 = 0.00
					
					Mporiva0 = 0.00
				
				ENDIF
			ENDSCAN
			
*.*	 		IF Mvlraciv > 0
				FPUTS(gnFileXml,'<TIM>')
					FPUTS(gnFileXml,'<TIM_1>'+"false"+'</TIM_1>')
					FPUTS(gnFileXml,'<TIM_2>'+ALLTRIM(STR(Mvlraciv,11,2))+'</TIM_2>')
					FPUTS(gnFileXml,'<TIM_3>'+ALLTRIM(fcec05b.divisa)+'</TIM_3>')
			
	 		*** EL 01 TRAER DESDE EL PROG  ver como POR SI
					IF Mvlracbv > 0
						FPUTS(gnFileXml,'<IMP>')
						FPUTS(gnFileXml,'<IMP_1>'+"01"+'</IMP_1>')
						FPUTS(gnFileXml,'<IMP_2>'+ALLTRIM(STR(Mvlracbv,11,2))+'</IMP_2>')
						FPUTS(gnFileXml,'<IMP_3>'+ALLTRIM(fcec05b.divisa)+'</IMP_3>')
						FPUTS(gnFileXml,'<IMP_4>'+ALLTRIM(STR(Mvlraciv,11,2))+'</IMP_4>')
						FPUTS(gnFileXml,'<IMP_5>'+ALLTRIM(fcec05b.divisa)+'</IMP_5>')
						FPUTS(gnFileXml,'<IMP_6>'+ALLTRIM(STR(Mporiva,11,3))+'</IMP_6>')
						FPUTS(gnFileXml,'</IMP>')
					ENDIF
					IF Mvlracbv0 > 0
						FPUTS(gnFileXml,'<IMP>')
						FPUTS(gnFileXml,'<IMP_1>'+"01"+'</IMP_1>')
						FPUTS(gnFileXml,'<IMP_2>'+ALLTRIM(STR(Mvlracbv0,11,2))+'</IMP_2>')
						FPUTS(gnFileXml,'<IMP_3>'+ALLTRIM(fcec05b.divisa)+'</IMP_3>')
						FPUTS(gnFileXml,'<IMP_4>'+ALLTRIM(STR(Mvlraciv0,11,2))+'</IMP_4>')
						FPUTS(gnFileXml,'<IMP_5>'+ALLTRIM(fcec05b.divisa)+'</IMP_5>')
						FPUTS(gnFileXml,'<IMP_6>'+ALLTRIM(STR(Mporiva0,11,3))+'</IMP_6>')
						FPUTS(gnFileXml,'</IMP>')
					ENDIF
				FPUTS(gnFileXml,'</TIM>')
*.*			ENDIF

*!*		 			*** EL false es pr impto -iva si fuera true es x retenciones
*!*		 			
*!*		 			IF fced05c.vlriva > 0
*!*						Mvlraciv = Mvlraciv + fced05c.vlriva
*!*						
*!*						Mvlracbv = Mvlracbv + fced05c.vlcanuni
*!*						
*!*						Mporiva = fced05c.poriva
*!*					ENDIF
*!*				ENDSCAN
*!*				
*!*		 		IF Mvlraciv > 0
*!*					FPUTS(gnFileXml,'<TIM>')
*!*						FPUTS(gnFileXml,'<TIM_1>'+"false"+'</TIM_1>')
*!*						FPUTS(gnFileXml,'<TIM_2>'+ALLTRIM(STR(Mvlraciv,11,2))+'</TIM_2>')
*!*						FPUTS(gnFileXml,'<TIM_3>'+ALLTRIM(fcec05b.divisa)+'</TIM_3>')
*!*				
*!*		 		*** EL 01 TRAER DESDE EL PROG  ver como POR SI
*!*				
*!*						FPUTS(gnFileXml,'<IMP>')
*!*						FPUTS(gnFileXml,'<IMP_1>'+"01"+'</IMP_1>')
*!*						FPUTS(gnFileXml,'<IMP_2>'+ALLTRIM(STR(Mvlracbv,11,2))+'</IMP_2>')
*!*						FPUTS(gnFileXml,'<IMP_3>'+ALLTRIM(fcec05b.divisa)+'</IMP_3>')
*!*						FPUTS(gnFileXml,'<IMP_4>'+ALLTRIM(STR(Mvlraciv,11,2))+'</IMP_4>')
*!*						FPUTS(gnFileXml,'<IMP_5>'+ALLTRIM(fcec05b.divisa)+'</IMP_5>')
*!*						FPUTS(gnFileXml,'<IMP_6>'+ALLTRIM(STR(Mporiva,11,3))+'</IMP_6>')
*!*						FPUTS(gnFileXml,'</IMP>')
*!*					FPUTS(gnFileXml,'</TIM>')
*!*				ENDIF
			
*.* descuentos
*!*			FPUTS(gnFileXml,'<Dsc>')
*!*			FPUTS(gnFileXml,'	<Dsc_1>'+"false"+'</Dsc_1>')
*!*			FPUTS(gnFileXml,'	<Dsc_2>'+ALLTRIM(STR(pordesc1))+'</Dsc_2>')
*!*			FPUTS(gnFileXml,'	<Dsc_3>'+ALLTRIM(STR(fcec05b.desc1))+'</Dsc_3>')
*!*			FPUTS(gnFileXml,'	<Dsc_4>'+ALLTRIM(fcec05b.divisa)+'</Dsc_4>')
*!*			FPUTS(gnFileXml,'	<Dsc_5>'+"19"+'</Dsc_5>')
*!*			FPUTS(gnFileXml,'	<Dsc_8>'+ALLTRIM(fcec05b.divisa)+'</Dsc_8>')
*!*			FPUTS(gnFileXml,'	<Dsc_9>'+"1"+'</Dsc_9>')
*!*			FPUTS(gnFileXml,'</Dsc>')
			
			*.* resolucion 
			FPUTS(gnFileXml,'<DRF>')
				FPUTS(gnFileXml,'<DRF_1>'+ALLTRIM(fcec05b.numres)+'</DRF_1>')
				FPUTS(gnFileXml,'<DRF_2>'+ALLTRIM(fcec05b.finidres)+'</DRF_2>')
				FPUTS(gnFileXml,'<DRF_3>'+ALLTRIM(fcec05b.ffindres)+'</DRF_3>')
				FPUTS(gnFileXml,'<DRF_4>'+ALLTRIM(SUBSTR(fcec05b.predres,1,4))+'</DRF_4>')
				FPUTS(gnFileXml,'<DRF_5>'+ALLTRIM(fcec05b.docidres)+'</DRF_5>')
				FPUTS(gnFileXml,'<DRF_6>'+ALLTRIM(fcec05b.docfdres)+'</DRF_6>')
			FPUTS(gnFileXml,'</DRF>')
			
			*** VERIFICAR SI VA IVA
*!*				FPUTS(gnFileXml,'<ITD>')
*!*					FPUTS(gnFileXml,'<ITD_1>'+ALLTRIM(STR(fcec05b.iva,9,4))+'</ITD_1>')
*!*					FPUTS(gnFileXml,'<ITD_2>'+ALLTRIM(fcec05b.divisa)+'</ITD_2>')
*!*					FPUTS(gnFileXml,'<ITD_3>'+ALLTRIM(STR(fcec05b.totrets,9,4))+'</ITD_3>')
*!*					FPUTS(gnFileXml,'<ITD_4>'+ALLTRIM(fcec05b.divisa)+'</ITD_4>')
*!*					FPUTS(gnFileXml,'<ITD_5>'+ALLTRIM(STR(fcec05b.total,9,4))+'</ITD_5>')
*!*					FPUTS(gnFileXml,'<ITD_6>'+ALLTRIM(fcec05b.divisa)+'</ITD_6>')
*!*				FPUTS(gnFileXml,'</ITD>')
			*** VERIFICAR SI VA IVA
			
			*** VERIFICAR SI VA receptor de pago
*!*				FPUTS(gnFileXml,'<RCP>')
*!*					FPUTS(gnFileXml,'<RCP_1>'+ALLTRIM(fcec05b.nitemp)+'</RCP_1>')
*!*					FPUTS(gnFileXml,'<RCP_2>'+ALLTRIM(fcec05b.idtpiemp)+'</RCP_2>')
*!*					FPUTS(gnFileXml,'<RCP_3>'+ALLTRIM((fcec05b.idregemp))+'</RCP_3>')
*!*					
*!*					IF SUBSTR(fcec05b.idtpeemp,1,1) = "1"
*!*						FPUTS(gnFileXml,'<RCP_4>'+ALLTRIM(fcec05b.razonemp)+'</RCP_4>')
*!*					ENDIF
*!*					FPUTS(gnFileXml,'<RCP_5>'+ALLTRIM(fcec05b.nomcoemp)+'</RCP_5>')
*!*					IF SUBSTR(fcec05b.idtpeemp,1,1) = "2"
*!*						FPUTS(gnFileXml,'<RCP_6>'+ALLTRIM(fcec05b.nomemp)+'</RCP_6>')
*!*						FPUTS(gnFileXml,'<RCP_7>'+ALLTRIM(fcec05b.apl1emp)+" "+ALLTRIM(fcec05b.apl2emp)+'</RCP_7>')
*!*					ENDIF

*!*					FPUTS(gnFileXml,'<RCP_8>'+ALLTRIM(fcec05b.diremp)+'</RCP_8>')
*!*					FPUTS(gnFileXml,'<RCP_9>'+ALLTRIM(fcec05b.dptoemp)+'</RCP_9>')
*!*					FPUTS(gnFileXml,'<RCP_10>'+ALLTRIM(fcec05b.mpioemp)+'</RCP_10>')
*!*					FPUTS(gnFileXml,'<RCP_11>'+ALLTRIM(fcec05b.ciuemp)+'</RCP_11>')
*!*	*				FPUTS(gnFileXml,'<RCP_12>'+ALLTRIM(fcec05b.)+'</RCP_12>')
*!*					FPUTS(gnFileXml,'<RCP_13>'+ALLTRIM(fcec05b.cpaisemp)+'</RCP_13>')
*!*					
*!*					FPUTS(gnFileXml,'<PCR>')
*!*						FPUTS(gnFileXml,'<PCR_1>'+ALLTRIM(fcec05b.ruto1adq)+'</PCR_1>')
*!*					FPUTS(gnFileXml,'</PCR>')
*!*				FPUTS(gnFileXml,'</RCP>')
			*** VERIFICAR SI VA
			
*!*					FPUTS(gnFileXml,'<PCR>')
*!*					FPUTS(gnFileXml,'<PCR_1>'+ALLTRIM(fcec05b.ruto1emp)+'</PCR_1>')
*!*					FPUTS(gnFileXml,'</PCR>')
*!*					FPUTS(gnFileXml,'<QTA>')
*!*					FPUTS(gnFileXml,'<QTA_1>'+ALLTRIM(fcec05b.ruto1emp)+'</QTA_1>')
*!*					FPUTS(gnFileXml,'</QTA>')
*!*					FPUTS(gnFileXml,'<ATA>')
*!*					FPUTS(gnFileXml,'<ATA_1>'+ALLTRIM(fcec05b.ruto1emp)+'</ATA_1>')
*!*					FPUTS(gnFileXml,'</ATA>')
				
*!*				FPUTS(gnFileXml,'<Ref>')
*!*					FPUTS(gnFileXml,'<Ref_1>'+""+'</Ref_1>')
*!*					FPUTS(gnFileXml,'<Ref_2>'+ +'</Ref_2>')
*!*					FPUTS(gnFileXml,'<Ref_3>'+ +'</Ref_3>')
*!*					FPUTS(gnFileXml,'<Ref_4>'+ +'</Ref_4>')
*!*				FPUTS(gnFileXml,'</Ref>')

				IF SUBSTR(fcec05b.nota1emp,1,1) <> " "
					FPUTS(gnFileXml,'<NOT>')
					FPUTS(gnFileXml,'<NOT_1>'+ALLTRIM(fcec05b.nota1emp)+'</NOT_1>')
					FPUTS(gnFileXml,'</NOT>')
				ENDIF
				
*!*					IF SUBSTR(fcec05b.nota2emp,1,1) <> " "
*!*						FPUTS(gnFileXml,'<NOT>')
*!*						FPUTS(gnFileXml,'<NOT_1>'+ALLTRIM(fcec05b.nota2emp)+'</NOT_1>')
*!*						FPUTS(gnFileXml,'</NOT>')
*!*					ENDIF
*!*					IF SUBSTR(fcec05b.nota3emp,1,1) <> " "
*!*						FPUTS(gnFileXml,'<NOT>')
*!*						FPUTS(gnFileXml,'<NOT_1>'+ALLTRIM(fcec05b.nota3emp)+'</NOT_1>')
*!*						FPUTS(gnFileXml,'</NOT>')
*!*					ENDIF
*!*					IF SUBSTR(fcec05b.nota4emp,1,1) <> " "
*!*						FPUTS(gnFileXml,'<NOT>')
*!*						FPUTS(gnFileXml,'<NOT_1>'+ALLTRIM(fcec05b.nota4emp)+'</NOT_1>')
*!*						FPUTS(gnFileXml,'</NOT>')
*!*					ENDIF
				
				IF SUBSTR(fcec05b.ordenc,1,1) <> " "
					FPUTS(gnFileXml,'<ORC>')
					FPUTS(gnFileXml,'<ORC_1>'+ALLTRIM(fcec05b.ordenc)+'</ORC_1>')
					FPUTS(gnFileXml,'</ORC>')
				ENDIF

					*** EL REF PARA CUFE

					FPUTS(gnFileXml,'<REF>')
					FPUTS(gnFileXml,'<REF_1>'+"IV"+'</REF_1>')
					FPUTS(gnFileXml,'<REF_2>'+ALLTRIM(fcec05b.prefres) +ALLTRIM(mcrdocfe)+'</REF_2>')
					FPUTS(gnFileXml,'<REF_4>'+ALLTRIM(Mcufe)+'</REF_4>')
					FPUTS(gnFileXml,'<REF_5>'+"CUFE-SHA384"+'</REF_5>')
					FPUTS(gnFileXml,'</REF>')
				
					*** EL MEP 1 "METODO DE PAGO 1 NO DEFINIDO" TRAER DESDE EL PROG ver como POR SI		
				
				FPUTS(gnFileXml,'<MEP>')
					FPUTS(gnFileXml,'<MEP_1>'+"1"+'</MEP_1>')
					IF fcec05b.diascr > 0
						FPUTS(gnFileXml,'<MEP_2>'+"2"+'</MEP_2>')
					ELSE
						FPUTS(gnFileXml,'<MEP_2>'+"1"+'</MEP_2>')
					ENDIF
					FPUTS(gnFileXml,'<MEP_3>'+SUBSTR(fcec05b.vencido,1,4)+"-"+SUBSTR(fcec05b.vencido,5,2)+"-"+SUBSTR(fcec05b.vencido,7,2)+'</MEP_3>')
				FPUTS(gnFileXml,'</MEP>')
			
 			**.- Fin Datos Documento
 	 		
			SELECT fced05b
*!*			FPUTS(gnFileXml,'<Ddetalle>')
			SCAN ALL
			FPUTS(gnFileXml,'<ITE>')
				FPUTS(gnFileXml,'<ITE_1>'+ALLTRIM(STR(fced05b.secc))+'</ITE_1>')
				FPUTS(gnFileXml,'<ITE_3>'+ALLTRIM(STR(fced05b.cantidad,11,2))+'</ITE_3>')
				FPUTS(gnFileXml,'<ITE_4>'+ALLTRIM(fced05b.medida)+'</ITE_4>')
				FPUTS(gnFileXml,'<ITE_5>'+ALLTRIM(STR(fced05b.vlcanuni,11,2))+'</ITE_5>')
				FPUTS(gnFileXml,'<ITE_6>'+ALLTRIM(fced05b.divisa)+'</ITE_6>')
				FPUTS(gnFileXml,'<ITE_7>'+ALLTRIM(STR(fced05b.vlunit,11,2))+'</ITE_7>')
				FPUTS(gnFileXml,'<ITE_8>'+ALLTRIM(fced05b.divisa)+'</ITE_8>')
*!*				FPUTS(gnFileXml,'<ITE_10>'+ALLTRIM(fced05b.descrip)+'</ITE_10>')
				FPUTS(gnFileXml,'<ITE_11>'+ALLTRIM(fced05b.descrip)+'</ITE_11>')
*!*				FPUTS(gnFileXml,'<ITE_19>'+ALLTRIM(STR(fced05b.vlcanuni,9,4))+'</ITE_19>')
*!*				FPUTS(gnFileXml,'<ITE_20>'+ALLTRIM(fced05b.divisa)+'</ITE_20>')
*!*				FPUTS(gnFileXml,'<ITE_21>'+ALLTRIM(STR(fced05b.vlcanuni+fced05b.vlriva,9,4))+'</ITE_21>')
*!*				FPUTS(gnFileXml,'<ITE_22>'+ALLTRIM(fced05b.divisa)+'</ITE_22>')
				FPUTS(gnFileXml,'<ITE_27>'+ALLTRIM(STR(fced05b.cantidad,9,0))+'</ITE_27>')
				FPUTS(gnFileXml,'<ITE_28>'+ALLTRIM(fced05b.medida)+'</ITE_28>')
				
				IF SUBSTR(fced05b.lote,1,1) <> " "
					FPUTS(gnFileXml,'<LOT>')
						FPUTS(gnFileXml,'<LOT_1>'+iae11+" Reg. Invima "+ALLTRIM(fced05b.reginvim)+'</LOT_1>')
						FPUTS(gnFileXml,'<LOT_2>'+SUBSTR(fced05b.fvlote,1,4)+"-"+SUBSTR(fced05b.fvlote,5,2)+"-"+SUBSTR(fced05b.fvlote,7,2)+'</LOT_2>')
					FPUTS(gnFileXml,'</LOT>')
				ENDIF
				
				*** TAER DESDE PRG ver como PORSI ok
				
				FPUTS(gnFileXml,'<IAE>')
					FPUTS(gnFileXml,'<IAE_1>'+ALLTRIM(fced05b.iae1)+'</IAE_1>')
					FPUTS(gnFileXml,'<IAE_2>'+ALLTRIM(fced05b.iae2)+'</IAE_2>')
					FPUTS(gnFileXml,'<IAE_3>'+ALLTRIM(fced05b.iae3)+'</IAE_3>')
					FPUTS(gnFileXml,'<IAE_4>'+ALLTRIM(fced05b.iae4)+'</IAE_4>')
				FPUTS(gnFileXml,'</IAE>')
				
				FPUTS(gnFileXml,'<TII>')
					FPUTS(gnFileXml,'<TII_1>'+ALLTRIM(STR(fced05b.vlriva,11,2))+'</TII_1>')
					FPUTS(gnFileXml,'<TII_2>'+ALLTRIM(fcec05b.divisa)+'</TII_2>')
					FPUTS(gnFileXml,'<TII_3>'+"false"+'</TII_3>')
						FPUTS(gnFileXml,'<IIM>')
							FPUTS(gnFileXml,'<IIM_1>'+"01"+'</IIM_1>')
							FPUTS(gnFileXml,'<IIM_2>'+ALLTRIM(STR(fced05b.vlriva,11,2))+'</IIM_2>')
							FPUTS(gnFileXml,'<IIM_3>'+ALLTRIM(fced05b.divisa)+'</IIM_3>')
							FPUTS(gnFileXml,'<IIM_4>'+ALLTRIM(STR(fced05b.vlcanuni,11,2))+'</IIM_4>')
							FPUTS(gnFileXml,'<IIM_5>'+ALLTRIM(fced05b.divisa)+'</IIM_5>')
							FPUTS(gnFileXml,'<IIM_6>'+ALLTRIM(STR(fced05b.poriva,6,3))+'</IIM_6>')
						FPUTS(gnFileXml,'</IIM>')
				FPUTS(gnFileXml,'</TII>')
			FPUTS(gnFileXml,'</ITE>')
			
			ENDSCAN
				 	
		FPUTS(gnFileXml,'</NOTA>')
ENDIF

ENDIF

=FCLOSE(gnFileXml )  && Cerrar archivo

