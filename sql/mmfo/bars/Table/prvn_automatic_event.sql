

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/PRVN_AUTOMATIC_EVENT.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to PRVN_AUTOMATIC_EVENT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''PRVN_AUTOMATIC_EVENT'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''PRVN_AUTOMATIC_EVENT'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''PRVN_AUTOMATIC_EVENT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table PRVN_AUTOMATIC_EVENT ***
begin 
  execute immediate '
  CREATE TABLE BARS.PRVN_AUTOMATIC_EVENT 
   (	ID NUMBER(38,0), 
	REPORTING_DATE DATE, 
	REF_AGR NUMBER(38,0), 
	RNK NUMBER(38,0), 
	EVENT_TYPE NUMBER(1,0), 
	EVENT_DATE DATE, 
	OBJECT_TYPE VARCHAR2(5), 
	RESTR_END_DAT DATE, 
	CREATE_DATE DATE, 
	ZO NUMBER(*,0), 
	VIDD NUMBER, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to PRVN_AUTOMATIC_EVENT ***
 exec bpa.alter_policies('PRVN_AUTOMATIC_EVENT');


COMMENT ON TABLE BARS.PRVN_AUTOMATIC_EVENT IS '';
COMMENT ON COLUMN BARS.PRVN_AUTOMATIC_EVENT.KF IS 'Код фiлiалу (МФО)';
COMMENT ON COLUMN BARS.PRVN_AUTOMATIC_EVENT.ID IS 'Ід. номер';
COMMENT ON COLUMN BARS.PRVN_AUTOMATIC_EVENT.REPORTING_DATE IS 'Звітна дат';
COMMENT ON COLUMN BARS.PRVN_AUTOMATIC_EVENT.REF_AGR IS 'Референс угоди';
COMMENT ON COLUMN BARS.PRVN_AUTOMATIC_EVENT.RNK IS 'РНК клієнта';
COMMENT ON COLUMN BARS.PRVN_AUTOMATIC_EVENT.EVENT_TYPE IS 'Тип події дефолту';
COMMENT ON COLUMN BARS.PRVN_AUTOMATIC_EVENT.EVENT_DATE IS 'Дата винекнення події дефолту';
COMMENT ON COLUMN BARS.PRVN_AUTOMATIC_EVENT.OBJECT_TYPE IS 'Тип системи';
COMMENT ON COLUMN BARS.PRVN_AUTOMATIC_EVENT.RESTR_END_DAT IS 'Дата закінчення реструктуризації';
COMMENT ON COLUMN BARS.PRVN_AUTOMATIC_EVENT.CREATE_DATE IS '';
COMMENT ON COLUMN BARS.PRVN_AUTOMATIC_EVENT.ZO IS '=0 без корр, =1-з корр';
COMMENT ON COLUMN BARS.PRVN_AUTOMATIC_EVENT.VIDD IS 'Вид~Активу';




PROMPT *** Create  constraint CC_PRVNAUTOEVENT_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PRVN_AUTOMATIC_EVENT MODIFY (KF CONSTRAINT CC_PRVNAUTOEVENT_KF_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008352 ***
begin   
 execute immediate '
  ALTER TABLE BARS.PRVN_AUTOMATIC_EVENT MODIFY (ID NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008353 ***
begin   
 execute immediate '
  ALTER TABLE BARS.PRVN_AUTOMATIC_EVENT MODIFY (EVENT_TYPE NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_PRVNAUTOEVENT ***
begin   
 execute immediate '
  ALTER TABLE BARS.PRVN_AUTOMATIC_EVENT ADD CONSTRAINT PK_PRVNAUTOEVENT PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_PRVNAUTOEVENT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_PRVNAUTOEVENT ON BARS.PRVN_AUTOMATIC_EVENT (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index IDX_PRVNAUTOEVENT_REPDATE ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_PRVNAUTOEVENT_REPDATE ON BARS.PRVN_AUTOMATIC_EVENT (REPORTING_DATE, KF, ZO, EVENT_TYPE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS COMPRESS 4 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  PRVN_AUTOMATIC_EVENT ***
grant SELECT                                                                 on PRVN_AUTOMATIC_EVENT to BARSREADER_ROLE;
grant SELECT                                                                 on PRVN_AUTOMATIC_EVENT to BARSUPL;
grant SELECT                                                                 on PRVN_AUTOMATIC_EVENT to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on PRVN_AUTOMATIC_EVENT to BARS_DM;
grant SELECT                                                                 on PRVN_AUTOMATIC_EVENT to START1;
grant SELECT                                                                 on PRVN_AUTOMATIC_EVENT to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/PRVN_AUTOMATIC_EVENT.sql =========*** 
PROMPT ===================================================================================== 
