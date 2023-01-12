***************************************************************************************************************
*  D&D.M.S - DISENO & DESARROLLO MANTENIMIENTO DE SOFWARE                 *
*  C.A.T.S - Control Administrativo Total Sistematizado.                  *
*            Sistema Contable                                             *
*  HECTOR FABIO CARDONA OTALVORA                                          *
***************************************************************************************************************
*  version USL                                                                                2021.04.30  15:00
***************************************************************************************************************
CLEAR

CLOSE ALL FILES

SET CENTURY ON
SET DATE ANSI
SET STATUS BAR OFF
SET CONFIRM OFF
SET DELETE ON
SET BELL OFF
SET TALK OFF
SET PRINT OFF
SET DEVICE TO SCREEN
SET EXCLUSIVE OFF

SET SYSMENU OFF

CLOSE DATABASE
CLOSE PROCEDURE

SET PROCEDURE TO cats

DO catsvrpb

mid = "XXXXX"
mnviv = "0"
mnvoc = "0"
mnvpd = "0"
mnvcc = "0"
mnvcp = "0"
mnvcg = "0"
mnvaf = "0"
mnvpo = "0"

DO FORM catsclvc

READ EVENTS

DEACTIVATE WINDOW ALL
CLOSE DATABASES
CLOSE PROCEDURE
SET ECHO OFF
SET STEP OFF
SET DELETE OFF
SET SYSMENU TO DEFAULT

CLEAR EVENTS
RETURN
