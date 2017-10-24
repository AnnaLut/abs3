

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/PRVN_AUTOMATIC_EVENT.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to PRVN_AUTOMATIC_EVENT ***


BEGIN 
        execute immediate  
          'begin  
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
COMMENT ON COLUMN BARS.PRVN_AUTOMATIC_EVENT.VIDD IS '���~������';
COMMENT ON COLUMN BARS.PRVN_AUTOMATIC_EVENT.KF IS '��� �i�i��� (���)';
COMMENT ON COLUMN BARS.PRVN_AUTOMATIC_EVENT.ZO IS '=0 ��� ����, =1-� ����';
COMMENT ON COLUMN BARS.PRVN_AUTOMATIC_EVENT.CREATE_DATE IS '';
COMMENT ON COLUMN BARS.PRVN_AUTOMATIC_EVENT.ID IS '��. �����';
COMMENT ON COLUMN BARS.PRVN_AUTOMATIC_EVENT.REPORTING_DATE IS '����� ���';
COMMENT ON COLUMN BARS.PRVN_AUTOMATIC_EVENT.REF_AGR IS '�������� �����';
COMMENT ON COLUMN BARS.PRVN_AUTOMATIC_EVENT.RNK IS '��� �볺���';
COMMENT ON COLUMN BARS.PRVN_AUTOMATIC_EVENT.EVENT_TYPE IS '��� ��䳿 �������';
COMMENT ON COLUMN BARS.PRVN_AUTOMATIC_EVENT.EVENT_DATE IS '���� ���������� ��䳿 �������';
COMMENT ON COLUMN BARS.PRVN_AUTOMATIC_EVENT.OBJECT_TYPE IS '��� �������';
COMMENT ON COLUMN BARS.PRVN_AUTOMATIC_EVENT.RESTR_END_DAT IS '���� ��������� ����������������';




PROMPT *** Create  constraint FK_PRVNAUTEVENT_PRVNOBJTYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.PRVN_AUTOMATIC_EVENT ADD CONSTRAINT FK_PRVNAUTEVENT_PRVNOBJTYPE FOREIGN KEY (OBJECT_TYPE)
	  REFERENCES BARS.PRVN_OBJECT_TYPE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_PRVNAUTO_PRVNTYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.PRVN_AUTOMATIC_EVENT ADD CONSTRAINT FK_PRVNAUTO_PRVNTYPE FOREIGN KEY (EVENT_TYPE)
	  REFERENCES BARS.PRVN_EVENT_TYPE (ID) ENABLE';
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




PROMPT *** Create  constraint SYS_C002727943 ***
begin   
 execute immediate '
  ALTER TABLE BARS.PRVN_AUTOMATIC_EVENT MODIFY (EVENT_TYPE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002727942 ***
begin   
 execute immediate '
  ALTER TABLE BARS.PRVN_AUTOMATIC_EVENT MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PRVNAUTOEVENT_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PRVN_AUTOMATIC_EVENT MODIFY (KF CONSTRAINT CC_PRVNAUTOEVENT_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
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



PROMPT *** Create  grants  PRVN_AUTOMATIC_EVENT ***
grant SELECT                                                                 on PRVN_AUTOMATIC_EVENT to BARSUPL;
grant SELECT                                                                 on PRVN_AUTOMATIC_EVENT to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on PRVN_AUTOMATIC_EVENT to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/PRVN_AUTOMATIC_EVENT.sql =========*** 
PROMPT ===================================================================================== 
