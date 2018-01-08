

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/FINMON/Table/FM_PARAMS.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  table FM_PARAMS ***
begin 
  execute immediate '
  CREATE TABLE FINMON.FM_PARAMS 
   (	PAR VARCHAR2(10), 
	VAL VARCHAR2(100), 
	COMM VARCHAR2(100)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE FINMON.FM_PARAMS IS '';
COMMENT ON COLUMN FINMON.FM_PARAMS.PAR IS '';
COMMENT ON COLUMN FINMON.FM_PARAMS.VAL IS '';
COMMENT ON COLUMN FINMON.FM_PARAMS.COMM IS '';




PROMPT *** Create  constraint CC_FMPARAMS_PAR_NN ***
begin   
 execute immediate '
  ALTER TABLE FINMON.FM_PARAMS MODIFY (PAR CONSTRAINT CC_FMPARAMS_PAR_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_FMPARAMS ***
begin   
 execute immediate '
  ALTER TABLE FINMON.FM_PARAMS ADD CONSTRAINT PK_FMPARAMS PRIMARY KEY (PAR)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_FMPARAMS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX FINMON.PK_FMPARAMS ON FINMON.FM_PARAMS (PAR) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  FM_PARAMS ***
grant SELECT                                                                 on FM_PARAMS       to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on FM_PARAMS       to FINMON01;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/FINMON/Table/FM_PARAMS.sql =========*** End *** =
PROMPT ===================================================================================== 
