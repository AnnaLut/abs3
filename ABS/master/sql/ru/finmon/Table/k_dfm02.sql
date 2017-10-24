

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/FINMON/Table/K_DFM02.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  table K_DFM02 ***
begin 
  execute immediate '
  CREATE TABLE FINMON.K_DFM02 
   (	CODE VARCHAR2(4), 
	NAME VARCHAR2(512), 
	D_CLOSE DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE USERS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE FINMON.K_DFM02 IS '';
COMMENT ON COLUMN FINMON.K_DFM02.CODE IS '';
COMMENT ON COLUMN FINMON.K_DFM02.NAME IS '';
COMMENT ON COLUMN FINMON.K_DFM02.D_CLOSE IS '';




PROMPT *** Create  constraint XPK_K_DFM02 ***
begin   
 execute immediate '
  ALTER TABLE FINMON.K_DFM02 ADD CONSTRAINT XPK_K_DFM02 PRIMARY KEY (CODE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE USERS  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_K_DFM02 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX FINMON.XPK_K_DFM02 ON FINMON.K_DFM02 (CODE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE USERS ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  K_DFM02 ***
grant SELECT                                                                 on K_DFM02         to BARS;
grant SELECT                                                                 on K_DFM02         to FINMON01;



PROMPT *** Create SYNONYM  to K_DFM02 ***

  CREATE OR REPLACE PUBLIC SYNONYM K_DFM02 FOR FINMON.K_DFM02;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/FINMON/Table/K_DFM02.sql =========*** End *** ===
PROMPT ===================================================================================== 
