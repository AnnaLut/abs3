

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSUPL/Table/TMP_UPL_CUSTADRESS.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  table TMP_UPL_CUSTADRESS ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARSUPL.TMP_UPL_CUSTADRESS 
   (	RNK NUMBER(38,0), 
	AU_CONTRY NUMBER, 
	AU_ZIP VARCHAR2(20), 
	AU_DOMAIN VARCHAR2(30), 
	AU_REGION VARCHAR2(30), 
	AU_LOCALITY VARCHAR2(30), 
	AU_ADRESS VARCHAR2(100), 
	AU_TERID NUMBER, 
	AF_CONTRY NUMBER, 
	AF_ZIP VARCHAR2(20), 
	AF_DOMAIN VARCHAR2(30), 
	AF_REGION VARCHAR2(30), 
	AF_LOCALITY VARCHAR2(30), 
	AF_ADRESS VARCHAR2(100), 
	AF_TERID NUMBER, 
	AP_CONTRY NUMBER, 
	AP_ZIP VARCHAR2(20), 
	AP_DOMAIN VARCHAR2(30), 
	AP_REGION VARCHAR2(30), 
	AP_LOCALITY VARCHAR2(30), 
	AP_ADRESS VARCHAR2(100), 
	AP_TERID NUMBER
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSUPL.TMP_UPL_CUSTADRESS IS '';
COMMENT ON COLUMN BARSUPL.TMP_UPL_CUSTADRESS.AP_REGION IS '';
COMMENT ON COLUMN BARSUPL.TMP_UPL_CUSTADRESS.AP_LOCALITY IS '';
COMMENT ON COLUMN BARSUPL.TMP_UPL_CUSTADRESS.AP_ADRESS IS '';
COMMENT ON COLUMN BARSUPL.TMP_UPL_CUSTADRESS.AP_TERID IS '';
COMMENT ON COLUMN BARSUPL.TMP_UPL_CUSTADRESS.RNK IS '';
COMMENT ON COLUMN BARSUPL.TMP_UPL_CUSTADRESS.AU_CONTRY IS '';
COMMENT ON COLUMN BARSUPL.TMP_UPL_CUSTADRESS.AU_ZIP IS '';
COMMENT ON COLUMN BARSUPL.TMP_UPL_CUSTADRESS.AU_DOMAIN IS '';
COMMENT ON COLUMN BARSUPL.TMP_UPL_CUSTADRESS.AU_REGION IS '';
COMMENT ON COLUMN BARSUPL.TMP_UPL_CUSTADRESS.AU_LOCALITY IS '';
COMMENT ON COLUMN BARSUPL.TMP_UPL_CUSTADRESS.AU_ADRESS IS '';
COMMENT ON COLUMN BARSUPL.TMP_UPL_CUSTADRESS.AU_TERID IS '';
COMMENT ON COLUMN BARSUPL.TMP_UPL_CUSTADRESS.AF_CONTRY IS '';
COMMENT ON COLUMN BARSUPL.TMP_UPL_CUSTADRESS.AF_ZIP IS '';
COMMENT ON COLUMN BARSUPL.TMP_UPL_CUSTADRESS.AF_DOMAIN IS '';
COMMENT ON COLUMN BARSUPL.TMP_UPL_CUSTADRESS.AF_REGION IS '';
COMMENT ON COLUMN BARSUPL.TMP_UPL_CUSTADRESS.AF_LOCALITY IS '';
COMMENT ON COLUMN BARSUPL.TMP_UPL_CUSTADRESS.AF_ADRESS IS '';
COMMENT ON COLUMN BARSUPL.TMP_UPL_CUSTADRESS.AF_TERID IS '';
COMMENT ON COLUMN BARSUPL.TMP_UPL_CUSTADRESS.AP_CONTRY IS '';
COMMENT ON COLUMN BARSUPL.TMP_UPL_CUSTADRESS.AP_ZIP IS '';
COMMENT ON COLUMN BARSUPL.TMP_UPL_CUSTADRESS.AP_DOMAIN IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSUPL/Table/TMP_UPL_CUSTADRESS.sql =========***
PROMPT ===================================================================================== 
