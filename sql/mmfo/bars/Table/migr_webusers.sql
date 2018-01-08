

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/MIGR_WEBUSERS.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to MIGR_WEBUSERS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''MIGR_WEBUSERS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''MIGR_WEBUSERS'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''MIGR_WEBUSERS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table MIGR_WEBUSERS ***
begin 
  execute immediate '
  CREATE TABLE BARS.MIGR_WEBUSERS 
   (	TABN VARCHAR2(10), 
	FIO VARCHAR2(60), 
	USER_TYPE NUMBER(2,0), 
	BRANCH VARCHAR2(30), 
	BRANCH_NAME VARCHAR2(100), 
	IMPORTED NUMBER(*,0) DEFAULT 0, 
	ID NUMBER(38,0), 
	LOGNAME VARCHAR2(30), 
	WEBLOGIN VARCHAR2(30)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to MIGR_WEBUSERS ***
 exec bpa.alter_policies('MIGR_WEBUSERS');


COMMENT ON TABLE BARS.MIGR_WEBUSERS IS 'Довідник користувачів для імпорту у веб';
COMMENT ON COLUMN BARS.MIGR_WEBUSERS.TABN IS 'Табельний номер ';
COMMENT ON COLUMN BARS.MIGR_WEBUSERS.FIO IS 'ПІБ користувача';
COMMENT ON COLUMN BARS.MIGR_WEBUSERS.USER_TYPE IS 'Тип користувача';
COMMENT ON COLUMN BARS.MIGR_WEBUSERS.BRANCH IS 'Відділення';
COMMENT ON COLUMN BARS.MIGR_WEBUSERS.BRANCH_NAME IS 'Найменування відділення';
COMMENT ON COLUMN BARS.MIGR_WEBUSERS.IMPORTED IS 'Признак імпорту';
COMMENT ON COLUMN BARS.MIGR_WEBUSERS.ID IS 'Номер користувача в АБС';
COMMENT ON COLUMN BARS.MIGR_WEBUSERS.LOGNAME IS 'Ім`я користувача в АБС';
COMMENT ON COLUMN BARS.MIGR_WEBUSERS.WEBLOGIN IS 'Логін користувача';




PROMPT *** Create  constraint CC_MIGR_WEBUSERS_FIO_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.MIGR_WEBUSERS MODIFY (FIO CONSTRAINT CC_MIGR_WEBUSERS_FIO_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_MIGR_WEBUSERS_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.MIGR_WEBUSERS MODIFY (BRANCH CONSTRAINT CC_MIGR_WEBUSERS_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_MIGR_WEBUSERS_IMPORTED_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.MIGR_WEBUSERS MODIFY (IMPORTED CONSTRAINT CC_MIGR_WEBUSERS_IMPORTED_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  MIGR_WEBUSERS ***
grant SELECT                                                                 on MIGR_WEBUSERS   to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on MIGR_WEBUSERS   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on MIGR_WEBUSERS   to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on MIGR_WEBUSERS   to START1;
grant SELECT                                                                 on MIGR_WEBUSERS   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/MIGR_WEBUSERS.sql =========*** End ***
PROMPT ===================================================================================== 
