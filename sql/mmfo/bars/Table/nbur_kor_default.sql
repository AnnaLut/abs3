

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NBUR_KOR_DEFAULT.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to NBUR_KOR_DEFAULT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NBUR_KOR_DEFAULT'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''NBUR_KOR_DEFAULT'', ''FILIAL'' , null, ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''NBUR_KOR_DEFAULT'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NBUR_KOR_DEFAULT ***
begin 
  execute immediate '
  CREATE TABLE BARS.NBUR_KOR_DEFAULT 
   (	KF NUMBER DEFAULT sys_context(''bars_context'',''user_mfo''), 
	REPORT_CODE VARCHAR2(3), 
	CODE_VAR VARCHAR2(10), 
	VALUE VARCHAR2(200)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to NBUR_KOR_DEFAULT ***
 exec bpa.alter_policies('NBUR_KOR_DEFAULT');


COMMENT ON TABLE BARS.NBUR_KOR_DEFAULT IS '"Казначейство, значення по-замовчанню для показників файлів #70 та #D3"';
COMMENT ON COLUMN BARS.NBUR_KOR_DEFAULT.KF IS 'Код філії';
COMMENT ON COLUMN BARS.NBUR_KOR_DEFAULT.REPORT_CODE IS 'Код файлу';
COMMENT ON COLUMN BARS.NBUR_KOR_DEFAULT.CODE_VAR IS 'Код показника';
COMMENT ON COLUMN BARS.NBUR_KOR_DEFAULT.VALUE IS 'Значення по-замовчанню';




PROMPT *** Create  constraint CC_KORDEFAULT_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_KOR_DEFAULT MODIFY (KF CONSTRAINT CC_KORDEFAULT_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_KORDEFAULT_KODF ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_KOR_DEFAULT MODIFY (REPORT_CODE CONSTRAINT CC_KORDEFAULT_KODF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_KORDEFAULT ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_KOR_DEFAULT ADD CONSTRAINT PK_KORDEFAULT PRIMARY KEY (KF, REPORT_CODE, CODE_VAR)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_KORDEFAULT_VALUE ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_KOR_DEFAULT MODIFY (VALUE CONSTRAINT CC_KORDEFAULT_VALUE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_KORDEFAULT_CODEVAR ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_KOR_DEFAULT MODIFY (CODE_VAR CONSTRAINT CC_KORDEFAULT_CODEVAR NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_KORDEFAULT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_KORDEFAULT ON BARS.NBUR_KOR_DEFAULT (KF, REPORT_CODE, CODE_VAR) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  NBUR_KOR_DEFAULT ***
grant SELECT                                                                 on NBUR_KOR_DEFAULT to BARSUPL;
grant DELETE,INSERT,SELECT,UPDATE                                            on NBUR_KOR_DEFAULT to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on NBUR_KOR_DEFAULT to RPBN002;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NBUR_KOR_DEFAULT.sql =========*** End 
PROMPT ===================================================================================== 
