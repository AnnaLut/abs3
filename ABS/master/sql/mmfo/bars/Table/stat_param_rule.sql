

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/STAT_PARAM_RULE.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to STAT_PARAM_RULE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''STAT_PARAM_RULE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''STAT_PARAM_RULE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''STAT_PARAM_RULE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table STAT_PARAM_RULE ***
begin 
  execute immediate '
  CREATE TABLE BARS.STAT_PARAM_RULE 
   (	ID NUMBER(10,0), 
	TABLE_NAME VARCHAR2(50), 
	DK NUMBER(1,0), 
	PARAM_MAIN VARCHAR2(50), 
	VALUE_MAIN VARCHAR2(50), 
	PARAM_SUBJECT VARCHAR2(50), 
	VALUE_SUBJECT VARCHAR2(50), 
	TABID NUMBER(10,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYNI ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to STAT_PARAM_RULE ***
 exec bpa.alter_policies('STAT_PARAM_RULE');


COMMENT ON TABLE BARS.STAT_PARAM_RULE IS 'Соответствия одних стат. параметров другим';
COMMENT ON COLUMN BARS.STAT_PARAM_RULE.ID IS '';
COMMENT ON COLUMN BARS.STAT_PARAM_RULE.TABLE_NAME IS '';
COMMENT ON COLUMN BARS.STAT_PARAM_RULE.DK IS '0 - Продажа валюты, 1- Покупка валюты';
COMMENT ON COLUMN BARS.STAT_PARAM_RULE.PARAM_MAIN IS 'Название основного параметра';
COMMENT ON COLUMN BARS.STAT_PARAM_RULE.VALUE_MAIN IS 'Значение параметра';
COMMENT ON COLUMN BARS.STAT_PARAM_RULE.PARAM_SUBJECT IS 'Зависимый параметр';
COMMENT ON COLUMN BARS.STAT_PARAM_RULE.VALUE_SUBJECT IS 'Значение зависимого параметра';
COMMENT ON COLUMN BARS.STAT_PARAM_RULE.TABID IS '';




PROMPT *** Create  constraint PK_STAT_PARAM_RULE ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAT_PARAM_RULE ADD CONSTRAINT PK_STAT_PARAM_RULE PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010056 ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAT_PARAM_RULE MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_STAT_PARAM_RULE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_STAT_PARAM_RULE ON BARS.STAT_PARAM_RULE (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  STAT_PARAM_RULE ***
grant SELECT                                                                 on STAT_PARAM_RULE to BARSREADER_ROLE;
grant SELECT                                                                 on STAT_PARAM_RULE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/STAT_PARAM_RULE.sql =========*** End *
PROMPT ===================================================================================== 
