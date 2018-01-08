

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/PFU/Table/PFU_NO_TURNOVER_LIST.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  table PFU_NO_TURNOVER_LIST ***
begin 
  execute immediate '
  CREATE TABLE PFU.PFU_NO_TURNOVER_LIST 
   (	ID NUMBER(38,0), 
	ID_REQUEST NUMBER(38,0), 
	DATE_CREATE DATE, 
	DATE_SENT DATE, 
	FULL_LINES NUMBER(38,0), 
	USER_ID NUMBER, 
	STATE VARCHAR2(20), 
	KF VARCHAR2(10)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE PFU.PFU_NO_TURNOVER_LIST IS '';
COMMENT ON COLUMN PFU.PFU_NO_TURNOVER_LIST.ID IS '';
COMMENT ON COLUMN PFU.PFU_NO_TURNOVER_LIST.ID_REQUEST IS '';
COMMENT ON COLUMN PFU.PFU_NO_TURNOVER_LIST.DATE_CREATE IS '';
COMMENT ON COLUMN PFU.PFU_NO_TURNOVER_LIST.DATE_SENT IS '';
COMMENT ON COLUMN PFU.PFU_NO_TURNOVER_LIST.FULL_LINES IS '';
COMMENT ON COLUMN PFU.PFU_NO_TURNOVER_LIST.USER_ID IS '';
COMMENT ON COLUMN PFU.PFU_NO_TURNOVER_LIST.STATE IS '';
COMMENT ON COLUMN PFU.PFU_NO_TURNOVER_LIST.KF IS '';



PROMPT *** Create  grants  PFU_NO_TURNOVER_LIST ***
grant SELECT                                                                 on PFU_NO_TURNOVER_LIST to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/PFU/Table/PFU_NO_TURNOVER_LIST.sql =========*** E
PROMPT ===================================================================================== 
