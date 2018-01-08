

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/FINMON/Table/K_DFM01E.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  table K_DFM01E ***
begin 
  execute immediate '
  CREATE TABLE FINMON.K_DFM01E 
   (	CODE VARCHAR2(1), 
	NAME VARCHAR2(120), 
	D_CLOSE DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE USERS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE FINMON.K_DFM01E IS '';
COMMENT ON COLUMN FINMON.K_DFM01E.CODE IS '';
COMMENT ON COLUMN FINMON.K_DFM01E.NAME IS '';
COMMENT ON COLUMN FINMON.K_DFM01E.D_CLOSE IS '';




PROMPT *** Create  constraint XPK_K_DFM01E ***
begin   
 execute immediate '
  ALTER TABLE FINMON.K_DFM01E ADD CONSTRAINT XPK_K_DFM01E PRIMARY KEY (CODE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE USERS  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_K_DFM01E ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX FINMON.XPK_K_DFM01E ON FINMON.K_DFM01E (CODE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE USERS ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  K_DFM01E ***
grant SELECT                                                                 on K_DFM01E        to BARS;
grant SELECT                                                                 on K_DFM01E        to FINMON01;



PROMPT *** Create SYNONYM  to K_DFM01E ***

  CREATE OR REPLACE PUBLIC SYNONYM K_DFM01E FOR FINMON.K_DFM01E;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/FINMON/Table/K_DFM01E.sql =========*** End *** ==
PROMPT ===================================================================================== 
