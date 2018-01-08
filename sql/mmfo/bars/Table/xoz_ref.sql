

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/XOZ_REF.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to XOZ_REF ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''XOZ_REF'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''XOZ_REF'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''XOZ_REF'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table XOZ_REF ***
begin 
  execute immediate '
  CREATE TABLE BARS.XOZ_REF 
   (	REF1 NUMBER, 
	STMT1 NUMBER, 
	REF2 NUMBER, 
	ACC NUMBER, 
	MDATE DATE, 
	S NUMBER, 
	FDAT DATE, 
	S0 NUMBER, 
	NOTP NUMBER(*,0), 
	PRG NUMBER(*,0), 
	BU VARCHAR2(30), 
	DATZ DATE, 
	REFD NUMBER, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	ID NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND  ENABLE ROW MOVEMENT ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to XOZ_REF ***
 exec bpa.alter_policies('XOZ_REF');


COMMENT ON TABLE BARS.XOZ_REF IS 'Картотека дебиторов (предназ по задумке для хоз.деб)';
COMMENT ON COLUMN BARS.XOZ_REF.REF1 IS 'Референс начального документа  ДЕБЕТ';
COMMENT ON COLUMN BARS.XOZ_REF.STMT1 IS 'stmt начального документа  ДЕБЕТ';
COMMENT ON COLUMN BARS.XOZ_REF.REF2 IS 'Референс передебетованного док КРЕДИТ';
COMMENT ON COLUMN BARS.XOZ_REF.ACC IS 'Идентификатор счета картотеки';
COMMENT ON COLUMN BARS.XOZ_REF.MDATE IS 'План-дата закриття';
COMMENT ON COLUMN BARS.XOZ_REF.S IS 'План-сума закриття';
COMMENT ON COLUMN BARS.XOZ_REF.FDAT IS 'Факт-дата откр.деб.';
COMMENT ON COLUMN BARS.XOZ_REF.S0 IS 'Сума проплати (ДЕБЕТ)';
COMMENT ON COLUMN BARS.XOZ_REF.NOTP IS 'Признак "Нет.дог". 1 = В рез-23 НЕ учитывать просрочку по дате, как просрочку';
COMMENT ON COLUMN BARS.XOZ_REF.PRG IS 'Код проекту';
COMMENT ON COLUMN BARS.XOZ_REF.BU IS 'Код бюджетної одиниці';
COMMENT ON COLUMN BARS.XOZ_REF.DATZ IS 'Звітна дата зактиття деб.заб.';
COMMENT ON COLUMN BARS.XOZ_REF.REFD IS 'Референс деб.запиту до ЦА на закриття дебітора';
COMMENT ON COLUMN BARS.XOZ_REF.KF IS '';
COMMENT ON COLUMN BARS.XOZ_REF.ID IS '';




PROMPT *** Create  constraint UK_XOZREF ***
begin   
 execute immediate '
  ALTER TABLE BARS.XOZ_REF ADD CONSTRAINT UK_XOZREF UNIQUE (REF1, STMT1)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_XOZRE_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.XOZ_REF MODIFY (KF CONSTRAINT CC_XOZRE_KF_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_XOZRE_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.XOZ_REF MODIFY (ID CONSTRAINT CC_XOZRE_ID_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_XOZREF ***
begin   
 execute immediate '
  ALTER TABLE BARS.XOZ_REF ADD CONSTRAINT PK_XOZREF PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_XOZREF_REF2DATZ ***
begin   
 execute immediate '
  ALTER TABLE BARS.XOZ_REF ADD CONSTRAINT CC_XOZREF_REF2DATZ CHECK (REF2 IS NULL AND DATZ IS NULL
                                                                     OR
                                                                      REF2 IS NOT NULL AND DATZ IS NOT NULL
                                                                     ) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006344 ***
begin   
 execute immediate '
  ALTER TABLE BARS.XOZ_REF MODIFY (REF1 NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006345 ***
begin   
 execute immediate '
  ALTER TABLE BARS.XOZ_REF MODIFY (STMT1 NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006346 ***
begin   
 execute immediate '
  ALTER TABLE BARS.XOZ_REF MODIFY (ACC NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006347 ***
begin   
 execute immediate '
  ALTER TABLE BARS.XOZ_REF MODIFY (FDAT NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_XOZREF ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_XOZREF ON BARS.XOZ_REF (REF1, STMT1) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_XOZREF ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_XOZREF ON BARS.XOZ_REF (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  XOZ_REF ***
grant SELECT                                                                 on XOZ_REF         to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on XOZ_REF         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on XOZ_REF         to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on XOZ_REF         to START1;
grant SELECT                                                                 on XOZ_REF         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/XOZ_REF.sql =========*** End *** =====
PROMPT ===================================================================================== 
