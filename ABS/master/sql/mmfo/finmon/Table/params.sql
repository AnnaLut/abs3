

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/FINMON/Table/PARAMS.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  table PARAMS ***
begin 
  execute immediate '
  CREATE TABLE FINMON.PARAMS 
   (	PAR VARCHAR2(8), 
	VAL VARCHAR2(200), 
	COMM VARCHAR2(70), 
	KF VARCHAR2(6)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE USERS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE FINMON.PARAMS IS '';
COMMENT ON COLUMN FINMON.PARAMS.PAR IS '';
COMMENT ON COLUMN FINMON.PARAMS.VAL IS '';
COMMENT ON COLUMN FINMON.PARAMS.COMM IS '';
COMMENT ON COLUMN FINMON.PARAMS.KF IS '';




PROMPT *** Create  constraint XPK_PARAMS ***
begin   
 execute immediate '
  ALTER TABLE FINMON.PARAMS ADD CONSTRAINT XPK_PARAMS PRIMARY KEY (PAR, KF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE USERS  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0032053 ***
begin   
 execute immediate '
  ALTER TABLE FINMON.PARAMS MODIFY (PAR NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_PARAMS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX FINMON.XPK_PARAMS ON FINMON.PARAMS (PAR, KF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE USERS ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/FINMON/Table/PARAMS.sql =========*** End *** ====
PROMPT ===================================================================================== 
