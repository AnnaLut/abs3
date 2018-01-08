

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/PFU/Table/PFU_NO_TURNOVER.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  table PFU_NO_TURNOVER ***
begin 
  execute immediate '
  CREATE TABLE PFU.PFU_NO_TURNOVER 
   (	ID NUMBER(38,0), 
	ID_FILE NUMBER(38,0), 
	LAST_NAME VARCHAR2(70), 
	NAME VARCHAR2(70), 
	FATHER_NAME VARCHAR2(70), 
	OKPO VARCHAR2(20), 
	SER_NUM VARCHAR2(20), 
	NUM_ACC VARCHAR2(20), 
	KF VARCHAR2(6), 
	DATE_LAST DATE
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE PFU.PFU_NO_TURNOVER IS 'Список пенсионеров, по которым не было дебетового движения';
COMMENT ON COLUMN PFU.PFU_NO_TURNOVER.ID IS '';
COMMENT ON COLUMN PFU.PFU_NO_TURNOVER.ID_FILE IS '';
COMMENT ON COLUMN PFU.PFU_NO_TURNOVER.LAST_NAME IS '';
COMMENT ON COLUMN PFU.PFU_NO_TURNOVER.NAME IS '';
COMMENT ON COLUMN PFU.PFU_NO_TURNOVER.FATHER_NAME IS '';
COMMENT ON COLUMN PFU.PFU_NO_TURNOVER.OKPO IS '';
COMMENT ON COLUMN PFU.PFU_NO_TURNOVER.SER_NUM IS '';
COMMENT ON COLUMN PFU.PFU_NO_TURNOVER.NUM_ACC IS '';
COMMENT ON COLUMN PFU.PFU_NO_TURNOVER.KF IS '';
COMMENT ON COLUMN PFU.PFU_NO_TURNOVER.DATE_LAST IS '';



PROMPT *** Create  grants  PFU_NO_TURNOVER ***
grant SELECT                                                                 on PFU_NO_TURNOVER to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/PFU/Table/PFU_NO_TURNOVER.sql =========*** End **
PROMPT ===================================================================================== 
