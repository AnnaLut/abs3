

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/Table/SALDOA.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  table SALDOA ***
begin 
  execute immediate '
  CREATE TABLE BARSAQ.SALDOA 
   (	ACC NUMBER(*,0), 
	FDAT DATE, 
	PDAT DATE, 
	OSTF NUMBER(24,0), 
	DOS NUMBER(24,0), 
	KOS NUMBER(24,0), 
	TRCN NUMBER(10,0), 
	OSTQ NUMBER(24,0), 
	DOSQ NUMBER(24,0), 
	KOSQ NUMBER(24,0), 
	KF VARCHAR2(6)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE AQTS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSAQ.SALDOA IS '';
COMMENT ON COLUMN BARSAQ.SALDOA.ACC IS '';
COMMENT ON COLUMN BARSAQ.SALDOA.FDAT IS '';
COMMENT ON COLUMN BARSAQ.SALDOA.PDAT IS '';
COMMENT ON COLUMN BARSAQ.SALDOA.OSTF IS '';
COMMENT ON COLUMN BARSAQ.SALDOA.DOS IS '';
COMMENT ON COLUMN BARSAQ.SALDOA.KOS IS '';
COMMENT ON COLUMN BARSAQ.SALDOA.TRCN IS '';
COMMENT ON COLUMN BARSAQ.SALDOA.OSTQ IS '';
COMMENT ON COLUMN BARSAQ.SALDOA.DOSQ IS '';
COMMENT ON COLUMN BARSAQ.SALDOA.KOSQ IS '';
COMMENT ON COLUMN BARSAQ.SALDOA.KF IS '';




PROMPT *** Create  constraint PK_BARSAQ_SALDOA ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.SALDOA ADD CONSTRAINT PK_BARSAQ_SALDOA PRIMARY KEY (ACC, FDAT)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE AQTS  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_BARSAQ_SALDOA ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSAQ.PK_BARSAQ_SALDOA ON BARSAQ.SALDOA (ACC, FDAT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE AQTS ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/Table/SALDOA.sql =========*** End *** ====
PROMPT ===================================================================================== 
