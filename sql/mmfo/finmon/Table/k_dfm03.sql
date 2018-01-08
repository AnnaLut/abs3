

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/FINMON/Table/K_DFM03.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  table K_DFM03 ***
begin 
  execute immediate '
  CREATE TABLE FINMON.K_DFM03 
   (	CODE VARCHAR2(3), 
	NAME VARCHAR2(1000), 
	D_CLOSE DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE USERS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE FINMON.K_DFM03 IS '';
COMMENT ON COLUMN FINMON.K_DFM03.CODE IS '';
COMMENT ON COLUMN FINMON.K_DFM03.NAME IS '';
COMMENT ON COLUMN FINMON.K_DFM03.D_CLOSE IS '';




PROMPT *** Create  constraint XPK_K_DFM03 ***
begin   
 execute immediate '
  ALTER TABLE FINMON.K_DFM03 ADD CONSTRAINT XPK_K_DFM03 PRIMARY KEY (CODE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE USERS  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_K_DFM03 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX FINMON.XPK_K_DFM03 ON FINMON.K_DFM03 (CODE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE USERS ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  K_DFM03 ***
grant SELECT                                                                 on K_DFM03         to BARS;
grant SELECT                                                                 on K_DFM03         to BARSREADER_ROLE;
grant SELECT                                                                 on K_DFM03         to FINMON01;



PROMPT *** Create SYNONYM  to K_DFM03 ***

  CREATE OR REPLACE PUBLIC SYNONYM K_DFM03 FOR FINMON.K_DFM03;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/FINMON/Table/K_DFM03.sql =========*** End *** ===
PROMPT ===================================================================================== 
