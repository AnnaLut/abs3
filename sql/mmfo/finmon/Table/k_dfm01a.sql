

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/FINMON/Table/K_DFM01A.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  table K_DFM01A ***
begin 
  execute immediate '
  CREATE TABLE FINMON.K_DFM01A 
   (	CODE VARCHAR2(1), 
	NAME VARCHAR2(60), 
	D_CLOSE DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE USERS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE FINMON.K_DFM01A IS '';
COMMENT ON COLUMN FINMON.K_DFM01A.CODE IS '';
COMMENT ON COLUMN FINMON.K_DFM01A.NAME IS '';
COMMENT ON COLUMN FINMON.K_DFM01A.D_CLOSE IS '';




PROMPT *** Create  constraint XPK_K_DFM01A ***
begin   
 execute immediate '
  ALTER TABLE FINMON.K_DFM01A ADD CONSTRAINT XPK_K_DFM01A PRIMARY KEY (CODE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE USERS  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_K_DFM01A ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX FINMON.XPK_K_DFM01A ON FINMON.K_DFM01A (CODE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE USERS ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  K_DFM01A ***
grant SELECT                                                                 on K_DFM01A        to BARS;
grant SELECT                                                                 on K_DFM01A        to BARSREADER_ROLE;
grant SELECT                                                                 on K_DFM01A        to FINMON01;



PROMPT *** Create SYNONYM  to K_DFM01A ***

  CREATE OR REPLACE PUBLIC SYNONYM K_DFM01A FOR FINMON.K_DFM01A;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/FINMON/Table/K_DFM01A.sql =========*** End *** ==
PROMPT ===================================================================================== 
