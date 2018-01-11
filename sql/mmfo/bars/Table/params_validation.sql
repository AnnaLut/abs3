

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/PARAMS_VALIDATION.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to PARAMS_VALIDATION ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''PARAMS_VALIDATION'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''PARAMS_VALIDATION'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table PARAMS_VALIDATION ***
begin 
  execute immediate '
  CREATE TABLE BARS.PARAMS_VALIDATION 
   (	TT CHAR(3), 
	TAG CHAR(5), 
	CASE VARCHAR2(500), 
	DESCRIPTION VARCHAR2(500), 
	IS_CA NUMBER(1,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to PARAMS_VALIDATION ***
 exec bpa.alter_policies('PARAMS_VALIDATION');


COMMENT ON TABLE BARS.PARAMS_VALIDATION IS 'Валидация параметров';
COMMENT ON COLUMN BARS.PARAMS_VALIDATION.TT IS 'Код операции';
COMMENT ON COLUMN BARS.PARAMS_VALIDATION.TAG IS 'Код параметра';
COMMENT ON COLUMN BARS.PARAMS_VALIDATION.CASE IS 'Дополнительные динамические условия';
COMMENT ON COLUMN BARS.PARAMS_VALIDATION.DESCRIPTION IS 'Описание';
COMMENT ON COLUMN BARS.PARAMS_VALIDATION.IS_CA IS 'ЦА - 1/ РУ - 0';




PROMPT *** Create  constraint SYS_C00118464 ***
begin   
 execute immediate '
  ALTER TABLE BARS.PARAMS_VALIDATION MODIFY (TT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00118465 ***
begin   
 execute immediate '
  ALTER TABLE BARS.PARAMS_VALIDATION MODIFY (TAG NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00118466 ***
begin   
 execute immediate '
  ALTER TABLE BARS.PARAMS_VALIDATION MODIFY (IS_CA NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_PARAMSVALIDATION ***
begin   
 execute immediate '
  ALTER TABLE BARS.PARAMS_VALIDATION ADD CONSTRAINT UK_PARAMSVALIDATION UNIQUE (TT, TAG, IS_CA)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_PARAMSVALIDATION ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_PARAMSVALIDATION ON BARS.PARAMS_VALIDATION (TT, TAG, IS_CA) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  PARAMS_VALIDATION ***
grant SELECT                                                                 on PARAMS_VALIDATION to BARSREADER_ROLE;
grant SELECT                                                                 on PARAMS_VALIDATION to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/PARAMS_VALIDATION.sql =========*** End
PROMPT ===================================================================================== 
