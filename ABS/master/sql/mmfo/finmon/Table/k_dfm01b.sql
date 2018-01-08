

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/FINMON/Table/K_DFM01B.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  table K_DFM01B ***
begin 
  execute immediate '
  CREATE TABLE FINMON.K_DFM01B 
   (	CODE VARCHAR2(1), 
	NAME VARCHAR2(150), 
	D_CLOSE DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE USERS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE FINMON.K_DFM01B IS '';
COMMENT ON COLUMN FINMON.K_DFM01B.CODE IS '';
COMMENT ON COLUMN FINMON.K_DFM01B.NAME IS '';
COMMENT ON COLUMN FINMON.K_DFM01B.D_CLOSE IS '';




PROMPT *** Create  constraint XPK_K_DFM01B ***
begin   
 execute immediate '
  ALTER TABLE FINMON.K_DFM01B ADD CONSTRAINT XPK_K_DFM01B PRIMARY KEY (CODE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE USERS  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_K_DFM01B ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX FINMON.XPK_K_DFM01B ON FINMON.K_DFM01B (CODE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE USERS ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  K_DFM01B ***
grant SELECT                                                                 on K_DFM01B        to BARS;
grant SELECT                                                                 on K_DFM01B        to BARSREADER_ROLE;
grant SELECT                                                                 on K_DFM01B        to FINMON01;



PROMPT *** Create SYNONYM  to K_DFM01B ***

  CREATE OR REPLACE PUBLIC SYNONYM K_DFM01B FOR FINMON.K_DFM01B;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/FINMON/Table/K_DFM01B.sql =========*** End *** ==
PROMPT ===================================================================================== 
