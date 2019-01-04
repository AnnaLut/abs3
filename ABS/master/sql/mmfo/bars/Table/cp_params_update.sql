

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CP_PARAMS_UPDATE.sql =========***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CP_PARAMS_UPDATE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CP_PARAMS_UPDATE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CP_PARAMS_UPDATE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CP_PARAMS_UPDATE ***
begin 
  execute immediate '
  CREATE TABLE BARS.CP_PARAMS_UPDATE 
   (	IDUPD NUMBER(38,0), 
	CHGACTION CHAR(1), 
	CHGDATE DATE, 
	EFFECTDATE DATE, 
	DONEBY NUMBER(38,0), 
	PAR_NAME VARCHAR2(128), 
	PAR_VALUE VARCHAR2(255), 
	PAR_COMMENT VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CP_PARAMS_UPDATE ***
 exec bpa.alter_policies('CP_PARAMS_UPDATE');


COMMENT ON TABLE BARS.CP_PARAMS_UPDATE IS 'Історія змін параметрів';
COMMENT ON COLUMN BARS.CP_PARAMS_UPDATE.IDUPD IS 'Ідентифікатор зміни';
COMMENT ON COLUMN BARS.CP_PARAMS_UPDATE.CHGACTION IS 'Код типу зміни';
COMMENT ON COLUMN BARS.CP_PARAMS_UPDATE.CHGDATE IS 'Календарна дата зміни';
COMMENT ON COLUMN BARS.CP_PARAMS_UPDATE.EFFECTDATE IS 'Банківська дата зміни';
COMMENT ON COLUMN BARS.CP_PARAMS_UPDATE.DONEBY IS 'Ідентифікатор користувача, що виконав зміни';


PROMPT *** Create  constraint CC_CPPARAMSUPD_IDUPD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_PARAMS_UPDATE MODIFY (IDUPD CONSTRAINT CC_CPPARAMSUPD_IDUPD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CPPARAMSUPD_CHGACTION_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_PARAMS_UPDATE MODIFY (CHGACTION CONSTRAINT CC_CPPARAMSUPD_CHGACTION_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/


PROMPT *** Create  constraint CC_CPPARAMSUPD_DONEBY_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_PARAMS_UPDATE MODIFY (DONEBY CONSTRAINT CC_CPPARAMSUPD_DONEBY_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  index IDX_U_CPPARAMSUPD_IDUPD ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.IDX_U_CPPARAMSUPD_IDUPD ON BARS.CP_PARAMS_UPDATE (IDUPD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index IDX_CPPARAMSUPD_PAR_NAME ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_CPPARAMSUPD_PAR_NAME ON BARS.CP_PARAMS_UPDATE (PAR_NAME) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CP_PARAMS_UPDATE ***
grant SELECT                                                                 on CP_PARAMS_UPDATE to BARSREADER_ROLE;
grant SELECT                                                                 on CP_PARAMS_UPDATE to BARSUPL;
grant SELECT                                                                 on CP_PARAMS_UPDATE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CP_PARAMS_UPDATE to BARS_DM;
grant SELECT                                                                 on CP_PARAMS_UPDATE to START1;
grant SELECT                                                                 on CP_PARAMS_UPDATE to UPLD;
grant SELECT                                                                 on CP_PARAMS_UPDATE to CP_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CP_PARAMS_UPDATE.sql =========***
PROMPT ===================================================================================== 
