PROCEDURE ZAPTBL

SET EXCLUSIVE ON
SET DELETED ON
SET CONFIRM OFF

USE catstbl ALIAS catstbl IN 0
SELECT catstbl 
GO top
DO WHILE .NOT. EOF()
	Mtabla = tabla	
	Mempak = empak
	
	USE &Mtabla ALIAS &Mtabla IN 0
	IF Mempak ="S"
		SELECT &Mtabla
		ZAP
	ENDIF
	
	SELECT catstbl 
	SKIP
ENDDO
CLOSE DATABASES
