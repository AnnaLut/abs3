

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/FINMON/Table/K_DFM01C.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  table K_DFM01C ***
begin 
  execute immediate '
  CREATE TABLE FINMON.K_DFM01C 
   (	CODE VARCHAR2(1), 
	NAME VARCHAR2(40), 
	D_CLOSE DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE USERS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE FINMON.K_DFM01C IS '';
COMMENT ON COLUMN FINMON.K_DFM01C.CODE IS '';
COMMENT ON COLUMN FINMON.K_DFM01C.NAME IS '';
COMMENT ON COLUMN FINMON.K_DFM01C.D_CLOSE IS '';




PROMPT *** Create  constraint XPK_K_DFM01C ***
begin   
 execute immediate '
  ALTER TABLE FINMON.K_DFM01C ADD CONSTRAINT XPK_K_DFM01C PRIMARY KEY (CODE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE USERS  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_K_DFM01C ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX FINMON.XPK_K_DFM01C ON FINMON.K_DFM01C (CODE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE USERS ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  K_DFM01C ***
grant SELECT                                                                 on K_DFM01C        to BARS;
grant SELECT                                                                 on K_DFM01C        to BARSREADER_ROLE;
grant SELECT                                                                 on K_DFM01C        to FINMON01;



PROMPT *** Create SYNONYM  to K_DFM01C ***

  CREATE OR REPLACE PUBLIC SYNONYM K_DFM01C FOR FINMON.K_DFM01C;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/FINMON/Table/K_DFM01C.sql =========*** End *** ==
PROMPT ===================================================================================== 
