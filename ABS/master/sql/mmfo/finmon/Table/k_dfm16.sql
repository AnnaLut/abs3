

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/FINMON/Table/K_DFM16.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  table K_DFM16 ***
begin 
  execute immediate '
  CREATE TABLE FINMON.K_DFM16 
   (	CODE VARCHAR2(2), 
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


COMMENT ON TABLE FINMON.K_DFM16 IS '';
COMMENT ON COLUMN FINMON.K_DFM16.CODE IS '';
COMMENT ON COLUMN FINMON.K_DFM16.NAME IS '';
COMMENT ON COLUMN FINMON.K_DFM16.D_CLOSE IS '';




PROMPT *** Create  constraint K_DFM16_PK ***
begin   
 execute immediate '
  ALTER TABLE FINMON.K_DFM16 ADD CONSTRAINT K_DFM16_PK PRIMARY KEY (CODE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE USERS  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0032128 ***
begin   
 execute immediate '
  ALTER TABLE FINMON.K_DFM16 MODIFY (CODE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index K_DFM16_PK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX FINMON.K_DFM16_PK ON FINMON.K_DFM16 (CODE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE USERS ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  K_DFM16 ***
grant SELECT                                                                 on K_DFM16         to BARSREADER_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/FINMON/Table/K_DFM16.sql =========*** End *** ===
PROMPT ===================================================================================== 
