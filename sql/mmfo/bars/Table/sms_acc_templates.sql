

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SMS_ACC_TEMPLATES.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SMS_ACC_TEMPLATES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SMS_ACC_TEMPLATES'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SMS_ACC_TEMPLATES'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''SMS_ACC_TEMPLATES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SMS_ACC_TEMPLATES ***
begin 
  execute immediate '
  CREATE TABLE BARS.SMS_ACC_TEMPLATES 
   (	ID NUMBER, 
	ACC_TIP CHAR(3), 
	ACC_NBS CHAR(4), 
	OPER_TT CHAR(3), 
	TEXT_CYR VARCHAR2(160), 
	TEXT_LAT VARCHAR2(160), 
	DK NUMBER(1,0), 
	TT VARCHAR2(3), 
	REF NUMBER, 
	NLSB VARCHAR2(15), 
	NOT_SEND NUMBER(1,0), 
	NBSA CHAR(4), 
	NBSB CHAR(4)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SMS_ACC_TEMPLATES ***
 exec bpa.alter_policies('SMS_ACC_TEMPLATES');


COMMENT ON TABLE BARS.SMS_ACC_TEMPLATES IS 'Шаблоны SMS сообщений для движений по счету';
COMMENT ON COLUMN BARS.SMS_ACC_TEMPLATES.ID IS 'ID';
COMMENT ON COLUMN BARS.SMS_ACC_TEMPLATES.ACC_TIP IS 'Тип счета';
COMMENT ON COLUMN BARS.SMS_ACC_TEMPLATES.ACC_NBS IS 'Балансовый номер счета';
COMMENT ON COLUMN BARS.SMS_ACC_TEMPLATES.OPER_TT IS 'Тип операции по счету';
COMMENT ON COLUMN BARS.SMS_ACC_TEMPLATES.TEXT_CYR IS 'Текст шаблона кирилицей';
COMMENT ON COLUMN BARS.SMS_ACC_TEMPLATES.TEXT_LAT IS 'Текст шаблона латиницей';
COMMENT ON COLUMN BARS.SMS_ACC_TEMPLATES.DK IS '';
COMMENT ON COLUMN BARS.SMS_ACC_TEMPLATES.TT IS '';
COMMENT ON COLUMN BARS.SMS_ACC_TEMPLATES.REF IS '';
COMMENT ON COLUMN BARS.SMS_ACC_TEMPLATES.NLSB IS '';
COMMENT ON COLUMN BARS.SMS_ACC_TEMPLATES.NOT_SEND IS 'Null - відправляти СМС, NotNull - не відправляти';
COMMENT ON COLUMN BARS.SMS_ACC_TEMPLATES.NBSA IS '';
COMMENT ON COLUMN BARS.SMS_ACC_TEMPLATES.NBSB IS '';




PROMPT *** Create  constraint SYS_C005500 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SMS_ACC_TEMPLATES MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_SMS_ACC_TEMPLATES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_SMS_ACC_TEMPLATES ON BARS.SMS_ACC_TEMPLATES (ACC_TIP, ACC_NBS, OPER_TT, DK, NBSA, NBSB) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SMS_ACC_TEMPLATES ***
grant SELECT                                                                 on SMS_ACC_TEMPLATES to BARSREADER_ROLE;
grant SELECT                                                                 on SMS_ACC_TEMPLATES to BARS_DM;
grant SELECT                                                                 on SMS_ACC_TEMPLATES to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SMS_ACC_TEMPLATES.sql =========*** End
PROMPT ===================================================================================== 
