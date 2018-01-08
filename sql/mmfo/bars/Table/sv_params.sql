

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SV_PARAMS.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SV_PARAMS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SV_PARAMS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SV_PARAMS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SV_PARAMS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SV_PARAMS ***
begin 
  execute immediate '
  CREATE TABLE BARS.SV_PARAMS 
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




PROMPT *** ALTER_POLICIES to SV_PARAMS ***
 exec bpa.alter_policies('SV_PARAMS');


COMMENT ON TABLE BARS.SV_PARAMS IS 'Параметри модуля';
COMMENT ON COLUMN BARS.SV_PARAMS.PAR IS 'Код параметру';
COMMENT ON COLUMN BARS.SV_PARAMS.VAL IS 'Значення';
COMMENT ON COLUMN BARS.SV_PARAMS.COMM IS 'Назва параметру';




PROMPT *** Create  constraint PK_SVPARAMS ***
begin   
 execute immediate '
  ALTER TABLE BARS.SV_PARAMS ADD CONSTRAINT PK_SVPARAMS PRIMARY KEY (PAR)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SVPARAMS_PAR_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SV_PARAMS MODIFY (PAR CONSTRAINT CC_SVPARAMS_PAR_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SVPARAMS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SVPARAMS ON BARS.SV_PARAMS (PAR) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SV_PARAMS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on SV_PARAMS       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SV_PARAMS       to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on SV_PARAMS       to RPBN002;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SV_PARAMS.sql =========*** End *** ===
PROMPT ===================================================================================== 
