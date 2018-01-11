

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/Table/OPLDOK.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  table OPLDOK ***
begin 
  execute immediate '
  CREATE TABLE BARSAQ.OPLDOK 
   (	REF NUMBER(38,0), 
	TT CHAR(3), 
	DK NUMBER(1,0), 
	ACC NUMBER(38,0), 
	FDAT DATE, 
	S NUMBER(24,0), 
	SQ NUMBER(24,0), 
	TXT VARCHAR2(70), 
	STMT NUMBER(38,0), 
	SOS NUMBER(1,0), 
	KF VARCHAR2(6), 
	OTM NUMBER(*,0), 
	ID NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE AQTS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSAQ.OPLDOK IS '';
COMMENT ON COLUMN BARSAQ.OPLDOK.REF IS '';
COMMENT ON COLUMN BARSAQ.OPLDOK.TT IS '';
COMMENT ON COLUMN BARSAQ.OPLDOK.DK IS '';
COMMENT ON COLUMN BARSAQ.OPLDOK.ACC IS '';
COMMENT ON COLUMN BARSAQ.OPLDOK.FDAT IS '';
COMMENT ON COLUMN BARSAQ.OPLDOK.S IS '';
COMMENT ON COLUMN BARSAQ.OPLDOK.SQ IS '';
COMMENT ON COLUMN BARSAQ.OPLDOK.TXT IS '';
COMMENT ON COLUMN BARSAQ.OPLDOK.STMT IS '';
COMMENT ON COLUMN BARSAQ.OPLDOK.SOS IS '';
COMMENT ON COLUMN BARSAQ.OPLDOK.KF IS '';
COMMENT ON COLUMN BARSAQ.OPLDOK.OTM IS '';
COMMENT ON COLUMN BARSAQ.OPLDOK.ID IS '';




PROMPT *** Create  constraint PK_BARSAQ_OPLDOK ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.OPLDOK ADD CONSTRAINT PK_BARSAQ_OPLDOK PRIMARY KEY (REF, STMT, DK)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE AQTS  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_BARSAQ_OPLDOK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSAQ.PK_BARSAQ_OPLDOK ON BARSAQ.OPLDOK (REF, STMT, DK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE AQTS ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/Table/OPLDOK.sql =========*** End *** ====
PROMPT ===================================================================================== 
