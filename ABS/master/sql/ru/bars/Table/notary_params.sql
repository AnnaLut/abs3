

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NOTARY_PARAMS.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to NOTARY_PARAMS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NOTARY_PARAMS'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''NOTARY_PARAMS'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NOTARY_PARAMS ***
begin 
  execute immediate '
  CREATE TABLE BARS.NOTARY_PARAMS 
   (	TAG VARCHAR2(30 CHAR), 
	VALUE VARCHAR2(4000), 
	KF VARCHAR2(6 CHAR) DEFAULT sys_context(''bars_context'', ''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to NOTARY_PARAMS ***
 exec bpa.alter_policies('NOTARY_PARAMS');


COMMENT ON TABLE BARS.NOTARY_PARAMS IS 'Параметри та налаштування модуля ЦБД нотаріусів';
COMMENT ON COLUMN BARS.NOTARY_PARAMS.TAG IS 'Код параметру';
COMMENT ON COLUMN BARS.NOTARY_PARAMS.VALUE IS 'Значення параметру';
COMMENT ON COLUMN BARS.NOTARY_PARAMS.KF IS 'МФО регіонального управління';




PROMPT *** Create  constraint PK_NOTARY_PARAMS ***
begin   
 execute immediate '
  ALTER TABLE BARS.NOTARY_PARAMS ADD CONSTRAINT PK_NOTARY_PARAMS PRIMARY KEY (TAG)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002861281 ***
begin   
 execute immediate '
  ALTER TABLE BARS.NOTARY_PARAMS MODIFY (KF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002861280 ***
begin   
 execute immediate '
  ALTER TABLE BARS.NOTARY_PARAMS MODIFY (VALUE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002861279 ***
begin   
 execute immediate '
  ALTER TABLE BARS.NOTARY_PARAMS MODIFY (TAG NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_NOTARY_PARAMS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_NOTARY_PARAMS ON BARS.NOTARY_PARAMS (TAG) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  NOTARY_PARAMS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on NOTARY_PARAMS   to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NOTARY_PARAMS.sql =========*** End ***
PROMPT ===================================================================================== 
