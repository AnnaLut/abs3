

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/FINMON/Table/K_DFM15.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  table K_DFM15 ***
begin 
  execute immediate '
  CREATE TABLE FINMON.K_DFM15 
   (	CODE VARCHAR2(4), 
	NAME VARCHAR2(1000), 
	D_CLOSE DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE USERS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE FINMON.K_DFM15 IS '';
COMMENT ON COLUMN FINMON.K_DFM15.CODE IS '';
COMMENT ON COLUMN FINMON.K_DFM15.NAME IS '';
COMMENT ON COLUMN FINMON.K_DFM15.D_CLOSE IS '';




PROMPT *** Create  constraint K_DFM15_PK ***
begin   
 execute immediate '
  ALTER TABLE FINMON.K_DFM15 ADD CONSTRAINT K_DFM15_PK PRIMARY KEY (CODE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE USERS  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0032127 ***
begin   
 execute immediate '
  ALTER TABLE FINMON.K_DFM15 MODIFY (CODE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index K_DFM15_PK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX FINMON.K_DFM15_PK ON FINMON.K_DFM15 (CODE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE USERS ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/FINMON/Table/K_DFM15.sql =========*** End *** ===
PROMPT ===================================================================================== 
