

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/FINMON_QUE_MODIFICATION.sql =========*
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to FINMON_QUE_MODIFICATION ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''FINMON_QUE_MODIFICATION'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''FINMON_QUE_MODIFICATION'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''FINMON_QUE_MODIFICATION'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table FINMON_QUE_MODIFICATION ***
begin 
  execute immediate '
  CREATE TABLE BARS.FINMON_QUE_MODIFICATION 
   (	ID NUMBER, 
	MOD_DATE DATE DEFAULT SYSDATE, 
	MOD_TYPE VARCHAR2(1), 
	USER_ID NUMBER(38,0), 
	USER_NAME VARCHAR2(50), 
	MOD_VALUE VARCHAR2(1000), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to FINMON_QUE_MODIFICATION ***
 exec bpa.alter_policies('FINMON_QUE_MODIFICATION');


COMMENT ON TABLE BARS.FINMON_QUE_MODIFICATION IS 'Журнал модификаций очереди экспорта в фин.мон.';
COMMENT ON COLUMN BARS.FINMON_QUE_MODIFICATION.ID IS 'Рефернс документа';
COMMENT ON COLUMN BARS.FINMON_QUE_MODIFICATION.MOD_DATE IS 'Дата модификации';
COMMENT ON COLUMN BARS.FINMON_QUE_MODIFICATION.MOD_TYPE IS 'ИД типа модификации';
COMMENT ON COLUMN BARS.FINMON_QUE_MODIFICATION.USER_ID IS 'ИД пользователя';
COMMENT ON COLUMN BARS.FINMON_QUE_MODIFICATION.USER_NAME IS 'ФИО пользователя';
COMMENT ON COLUMN BARS.FINMON_QUE_MODIFICATION.MOD_VALUE IS 'Старое значение';
COMMENT ON COLUMN BARS.FINMON_QUE_MODIFICATION.KF IS '';




PROMPT *** Create  constraint XPK_FINMON_QUE_MODIFICATION ***
begin   
 execute immediate '
  ALTER TABLE BARS.FINMON_QUE_MODIFICATION ADD CONSTRAINT XPK_FINMON_QUE_MODIFICATION PRIMARY KEY (ID, MOD_DATE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_FINMONQUEMODIFICATION_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.FINMON_QUE_MODIFICATION ADD CONSTRAINT FK_FINMONQUEMODIFICATION_ID FOREIGN KEY (ID)
	  REFERENCES BARS.FINMON_QUE (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint R_FINMON_QMOD_MODTYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.FINMON_QUE_MODIFICATION ADD CONSTRAINT R_FINMON_QMOD_MODTYPE FOREIGN KEY (MOD_TYPE)
	  REFERENCES BARS.FINMON_QUE_MODTYPE (MOD_TYPE) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint R_FINMON_QMOD_STAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.FINMON_QUE_MODIFICATION ADD CONSTRAINT R_FINMON_QMOD_STAFF FOREIGN KEY (USER_ID)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_FINMONQUEMODIFICATION_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.FINMON_QUE_MODIFICATION ADD CONSTRAINT FK_FINMONQUEMODIFICATION_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_FINMONQUEMODIFICATION_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.FINMON_QUE_MODIFICATION MODIFY (ID CONSTRAINT NK_FINMONQUEMODIFICATION_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_FINMONQUEMODIFICATION_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.FINMON_QUE_MODIFICATION MODIFY (KF CONSTRAINT CC_FINMONQUEMODIFICATION_KF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_FINMON_QUE_MODIFICATION ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_FINMON_QUE_MODIFICATION ON BARS.FINMON_QUE_MODIFICATION (ID, MOD_DATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  FINMON_QUE_MODIFICATION ***
grant FLASHBACK,SELECT                                                       on FINMON_QUE_MODIFICATION to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on FINMON_QUE_MODIFICATION to BARS_DM;
grant SELECT                                                                 on FINMON_QUE_MODIFICATION to FINMON01;
grant FLASHBACK,SELECT                                                       on FINMON_QUE_MODIFICATION to WR_REFREAD;



PROMPT *** Create SYNONYM  to FINMON_QUE_MODIFICATION ***

  CREATE OR REPLACE PUBLIC SYNONYM FINMON_QUE_MODIFICATION FOR BARS.FINMON_QUE_MODIFICATION;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/FINMON_QUE_MODIFICATION.sql =========*
PROMPT ===================================================================================== 
