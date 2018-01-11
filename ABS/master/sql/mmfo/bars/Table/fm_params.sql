

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/FM_PARAMS.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to FM_PARAMS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''FM_PARAMS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''FM_PARAMS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''FM_PARAMS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table FM_PARAMS ***
begin 
  execute immediate '
  CREATE TABLE BARS.FM_PARAMS 
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




PROMPT *** ALTER_POLICIES to FM_PARAMS ***
 exec bpa.alter_policies('FM_PARAMS');


COMMENT ON TABLE BARS.FM_PARAMS IS 'FM. Параметри модуля';
COMMENT ON COLUMN BARS.FM_PARAMS.PAR IS 'Код параметру';
COMMENT ON COLUMN BARS.FM_PARAMS.VAL IS 'Значення';
COMMENT ON COLUMN BARS.FM_PARAMS.COMM IS 'Назва параметру';




PROMPT *** Create  constraint PK_FMPARAMS ***
begin   
 execute immediate '
  ALTER TABLE BARS.FM_PARAMS ADD CONSTRAINT PK_FMPARAMS PRIMARY KEY (PAR)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_FMPARAMS_PAR_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.FM_PARAMS MODIFY (PAR CONSTRAINT CC_FMPARAMS_PAR_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_FMPARAMS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_FMPARAMS ON BARS.FM_PARAMS (PAR) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  FM_PARAMS ***
grant SELECT                                                                 on FM_PARAMS       to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on FM_PARAMS       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on FM_PARAMS       to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on FM_PARAMS       to FINMON01;
grant SELECT                                                                 on FM_PARAMS       to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/FM_PARAMS.sql =========*** End *** ===
PROMPT ===================================================================================== 
