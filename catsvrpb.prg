******************************************************************************************************************
*  D&D.M.S - DISENO & DESARROLLO MANTENIMIENTO DE SOFTWARE                
*  C.A.T.S - Control Administrativo Total Sistematizado.                  
*            Sistema Contable                                             
*  HECTOR FABIO CARDONA OTALVORA                                          
******************************************************************************************************************
*  DEFINICION DE VARIABLES PUBLICAS                                       
*  Revision                                                                                       2009.06.02
*  Revision                                                                                       2012.06.19
*  ACTIVO WW catsmen                                                                              2012.12.04
*  x00,y00                                                                                        2013.05.21
*  mcodctan,mcrn,mdbn/desc4,otdes                                                                 2014.03.09/14/09.25
*  desotr/mcrneto                                                                                 11.06/11.13
*  act. fijos, flujo                                                                              2016.09,27  14:50
*  var manop,mmesp,mdiap -en inicio                                                               2018.04.24  05:18
*  var mdv,memail                                                                                     .10.27  13:19
*  xml                                                                                                .11.13  18:29
*  xml - comentarios los ma..mz y los msg000 ..99                                                     .12.14  16:16
*  no USE-color                                                                                   2020.11.28  09:55
*  publicas globales                                                                              2021.02.24  08:09
*******************************************************************************************************************
PROCEDURE catsvrpb

*!*	USE catscia ALIAS catscia IN 1
*!*	USE catsusu ALIAS catsusu IN 2
*!*	SELECT catscia
*!*	SET ORDER TO TAG catscia

PUBLIC Mgaaaamm,Mgaammddd,Mgaammddh,Mgidperi,mcrdocfe

PUBLIC maccion,mautorf,mautorv,mautorc,mactica,mactdian
PUBLIC maaaa,macteco,mactindc,maacorn,mapl1,mapl2
PUBLIC maaaamm,maammddd,maammddh,maacorn,mabonoc
PUBLIC mafectai,mafectac

PUBLIC mbodega,mbase,mbcoch,mbench,manop,mmesp,mdiap

PUBLIC mcicemp,mciuemp,mcpvlriv,mclavem,mconcept,mcodigo,mcrtipo,mclave
PUBLIC mcrdocum,mcrconce,mcrvenci,mcodart,mcodtipo,mcodartm,mcrneto
PUBLIC mcorlin1,mcorlin2,mcanexan,mcanexac,mconcp,mciudad,mcr,mcrn,mchrpant
PUBLIC mcredito,mcupocr,mcupocr1,mcupocre,mciudad,mcon,mcr,mcargoc
PUBLIC mcocctaa,mcodctam,mcrtipod,mcrnrod,mcodcta,mcodctan,mcrtipoc,mcrnroc,mccos
PUBLIC mcod_neg,mcod_ase,mcod_cob,mcnalext,mcodesc1,mcodesc2,mccut,mcune
PUBLIC mclv1,mclv2,mclase,mctinf_a,mctinf_b,mctinf_c,mctinf_d,mctinf_e,mctafl,mcxp
PUBLIC mcginf_a,mcginf_b,mcginf_c,mcginf_d,mcginf_e,mcginf_f,mcginf_g,mcginf_m,mccosto

PUBLIC mdiremp,mdocumen,mdocumea,mdiascr,mdescue1,mdescue2,mdescue3,mdescue4,mdesotr
PUBLIC mdesc1,mdesc2,mdesc3,mdescc,mdescc1,mdescc2
PUBLIC mdetalla,mdiasmas,mdirdes,mdb,mdvemp,mdia,mdir,mdv
PUBLIC mdetcli,mdb,mdbn,mddcorn,mdebito,mdiaant,mdiap
PUBLIC mdesc_pp,mdesc_vc,mdesc_uc,mde_piec,mde_piep,mde_piee,mdbach

PUBLIC mempresa,mexpedid,mexpven,memaemp,meanemp,memaiemp,mexpedi,memail

PUBLIC mfeccor,mfecha,mfechat,mfranro,mfaxemp,mfecdes,mfechas,mfecalf
PUBLIC mfechain,mfechare,mfechana,mfechauc,mfechaup,mfecfin,mfrequis
PUBLIC mfec_min,mfec_max,mformch,mfechati

PUBLIC mgrupo,mgrupocp,mgranco

PUBLIC midperi,midperid,midperih,mimpdir,mimpres,mica,midcia,mid
PUBLIC mivainc,midreg,miva20,miva16,miva5,miva1,mivapor,mivabase

PUBLIC mk1,mk2,mk3,mKcomp

PUBLIC mlinart,mlista,mlabor,mletras,mlini,mlnln

PUBLIC mmoneda,mmmcorn,mmsecc,mmoneda,mmesalf,mmesalfh,mmes,mmesant

PUBLIC mnitm,mnitddms,mnitempr,mnumera,mnit,mnombod,mnroch
PUBLIC mnitini,mnrod,mnrod1,mnrocp,mnroo,mnitcg,mnitcc,mnitcp,mnitem,mctenit
PUBLIC mnetivan,mnetican,mnetrftn,mnetofra
PUBLIC mnetricn,mnetrivn,mnetivaf,mneticaf,mnroc,mnotac,mnotad
PUBLIC mnetrftf,mnetricf,mnetrivf,mnetorft
PUBLIC mnetoriv,mnetoric,mnetorv,mnetodes,mnetootr,mnetorec
PUBLIC mnomcli,mnombre,mnombrec,mnom1,mnom2,mnivfrmt,mnomven
PUBLIC mnota1,mnota2,mnota3,mnota4,mnota5,mnota6,mnota7,mnota8,mnota9
PUBLIC mnivel,mnroc,mnitini,mnomusu
PUBLIC mnvad,mnviv,mnvoc,mnvpd,mnvcc,mnvcp,mnvcg,mnvaf,nvpo, ;
		mnvivmov,mnvocmov,mnvpdmov,mnvccmov,mnvcpmov, ;
		mnvafmov,mnvpomov,mnvcgmov, ;
		mnvivver,mnvocver,mnvpdver,mnvccver,mnvcpver,;
		mnvafver,mnvpover,mnvcgver, ;
		mnvivlis,mnvoclis,mnvpdlis,mnvcclis,mnvcplis, ;
		mnvaflis,mnvpolis,mnvcglisca,mnvcglisco, ;
		mnvcglisad,mnvcglistr, ;
		mnvivdoc,mnvocdoc,mnvpddoc,mnvccdoc,mnvcpdoc, ;
		mnvafdoc,mnvpodoc,mnvcgdoc, ;
		mnvivtra,mnvoctra,mnvpdtra,mnvcctra,mnvcptra, ;
		mnvaftra,mnvpotra,mnvcgtra,mnvcgcxc,mnvcgcxp

PUBLIC mordenc,mok,mopok,mopsino,mopsinoel,mop_tipo

PUBLIC mparamet,mpedido,mporiva,mpag,mporica,mporcer,mporret,mprefijo,mporcre
PUBLIC mprpart,mpro_nr

PUBLIC mrango,mraya,mretfted,mretivad,mreticad,mruta
PUBLIC mregiemp,mraz,mrod,mrete,mrazon,mrayas,mrequis
PUBLIC mrivcemp,mrivsemp,mricemp,mriremp,mregcli,mnroreb,mretave,mretcre

PUBLIC msfra,msecc,mseccm,msbvalor,mswl2,msistema,msector,mstatus
PUBLIC msaldof,msena,msg,msg1,mslogemp,msigno,msignodc,msigdc1,msalco
PUBLIC msiter,msicc,msicer,msicxc,msicxp,msecdoc,msalfin,msalini
PUBLIC mvaldcto,msubtot,msubiva

PUBLIC mtelemp,mtels,mtipo,mtipo1,mtipoo,mtotzona,mtipod,mtotalne
PUBLIC mtitcua,mtexto,mtextosn,mtipoc,mtitra,mtitrb
PUBLIC mtotcl,mtot00,mtot30,mtot60,mtot90,mtot91,mtot121
PUBLIC mtotcar,mtotabo,mtotdbi,mtotdbf,mtotcri,mtotcrf,mtipobod,mtipob
PUBLIC mticanal,mtpcune,mtpccos,mtiposc

PUBLIC munegr,munineg

PUBLIC mvaltota,mvaliva,mvendedo,mvencimi,mvalor,mvencido,mvalbasg,mvalbasx
PUBLIC mvenfj,mvalomas,mvalexan,mvalexac,mvalch

PUBLIC mzona,mzonam,mzonaini,mzonafin

PUBLIC mmiv,mmoc,mmpd,mmcc,mmcp,mmpo,mmvt,mmig,mmpr,mmcg,mmgr,mmidf,mmmm,mprgh,mmaf,mmfl

PUBLIC mivarch,mivmovi,mivver,mivlist,mivdocu,mivtras, ;
		mivsw01,mivsw02,mivsw03,mivsw04,mivsw05,mivsw06
	
PUBLIC mocarch,mocmovi,mocver,mocsw01,mocsw02,mocsw03,mocsw04,mocsw05,mocsw06, ;
		mobs1,mobs2,mobs3
PUBLIC mpdarch,mpdmovi,mpdver,mpdsw01,mpdsw02,mpdsw03,mpdsw04,mpdsw05,mpdsw06
	
PUBLIC mccarch,mccmovi,mccver,mcclist,mcctras, ;
		mccsw01,mccsw02,mccsw03,mccsw04,mccsw05,mccsw06
	
PUBLIC mcparch,mcpmovi,mcpver,mcplist,mcptras, ;
		mcpsw01,mcpsw02,mcpsw03,mcpsw04,mcpsw05,mcpsw06
	
PUBLIC mpoarch,mpomovi,mpover,mpolist,mpodocu,mpotras, ;
		mposw01,mposw02,mposw03,mposw04,mposw05,mposw06
	
PUBLIC mcgarch,mcgmovi,mcgver,mcglica,mcglico,mcgliad,mcglitr,mcgdocu, ;
		mcgcxc,mcgcxp,mcgtras
PUBLIC cgsw01,mcgsw01,mcgsw02,mcgsw03,mcgsw04,mcgsw05,mcgsw06

PUBLIC mwct1,mwct2,mwct3,mwct4,mwct5,mwcta,mwctb,mwctc,mwctd
PUBLIC mx00,my00,mx01,my01

mtitcua = "C.A.T.S_USL"
mnitddms = " "

mtextosn = "	MSG: ERROR_NO_VALIDO SOLO: S o N "
mopok = 0 + 48 + 0
mopsino = 4 + 32 + 0
mopsinoel = 3 + 32 + 0

*0	 Sólo botón Aceptar.
*1	 Botones Aceptar y Cancelar.
*2	 Botones Anular, Reintentar e Ignorar.
*3	 Botones Sí, No y Cancelar.
*4	 Botones Sí y No.
*5	 Botones Reintentar y Cancelar.

*Valor	Icono
*16	 Punto.
*32	 Signo de interrogación.
*48	 Signo de exclamación.
*64	 Icono de información (i).

*Valor	Botón predeterminado
*0   Primer botón.
*256 Segundo botón.
*512 Tercer botón.

DEFINE WINDOW wwcats    FROM 3,1   TO 10,99 NONE NOSHADOW
DEFINE WINDOW wcats     FROM 5,1   TO 35,99 NONE NOSHADOW
DEFINE WINDOW wcatsid   FROM 20,40 TO 28,77 DOUBLE NOSHADOW
DEFINE WINDOW wcatsmd   FROM 20,1  TO 32,99 DOUBLE NOSHADOW
DEFINE WINDOW catsmen   FROM 27,5  TO 35,95 DOUBLE NOSHADOW
DEFINE WINDOW wcatsmen  FROM 27,5  TO 35,95 DOUBLE NOSHADOW
x0 = 10
y0 = 20
x1 = x0+8
y1 = 90
DEFINE WINDOW catsww  FROM  x0,y0 TO x1,y1 DOUBLE NOSHADOW
DEFINE WINDOW wcatsww FROM  0,1 TO 40,99 DOUBLE NOSHADOW

DEFINE WINDOW wcatssat  FROM  15,1 TO 29,95 DOUBLE NOSHADOW
DEFINE WINDOW wcatsva1  FROM 27,1   TO 35,95 DOUBLE NOSHADOW

RETURN
