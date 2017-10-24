

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/WCS_PARTNERS_ALL.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to WCS_PARTNERS_ALL ***
BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''WCS_PARTNERS_ALL'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_PARTNERS_ALL'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''WCS_PARTNERS_ALL'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table WCS_PARTNERS_ALL ***
begin 
  execute immediate '
  CREATE TABLE BARS.WCS_PARTNERS_ALL 
   (	ID NUMBER, 
	NAME VARCHAR2(255), 
	TYPE_ID VARCHAR2(100), 
	BRANCH VARCHAR2(30), 
	PTN_MFO VARCHAR2(12), 
	PTN_NLS VARCHAR2(15), 
	PTN_OKPO VARCHAR2(14), 
	PTN_NAME VARCHAR2(38), 
	ID_MATHER NUMBER, 
	FLAG_A NUMBER(1,0),
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

begin 
  execute immediate  'alter table WCS_PARTNERS_ALL add KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'') ';
  exception when others then       
  if sqlcode=-955 or sqlcode=-1430 then null; else raise; end if; 
end; 
/

PROMPT *** ALTER_POLICIES to WCS_PARTNERS_ALL ***
 exec bpa.alter_policies('WCS_PARTNERS_ALL');


COMMENT ON TABLE BARS.WCS_PARTNERS_ALL IS '�������� ��������';
COMMENT ON COLUMN BARS.WCS_PARTNERS_ALL.ID IS '�������������';
COMMENT ON COLUMN BARS.WCS_PARTNERS_ALL.NAME IS '������������';
COMMENT ON COLUMN BARS.WCS_PARTNERS_ALL.TYPE_ID IS '��� ��������';
COMMENT ON COLUMN BARS.WCS_PARTNERS_ALL.BRANCH IS '���������';
COMMENT ON COLUMN BARS.WCS_PARTNERS_ALL.PTN_MFO IS '��� ����� ��������';
COMMENT ON COLUMN BARS.WCS_PARTNERS_ALL.PTN_NLS IS '���� ��������';
COMMENT ON COLUMN BARS.WCS_PARTNERS_ALL.PTN_OKPO IS '�����. ��� ��������';
COMMENT ON COLUMN BARS.WCS_PARTNERS_ALL.PTN_NAME IS '������������ ��������';
COMMENT ON COLUMN BARS.WCS_PARTNERS_ALL.ID_MATHER IS '';
COMMENT ON COLUMN BARS.WCS_PARTNERS_ALL.FLAG_A IS '';




PROMPT *** Create  constraint UK_WCS_PARTNERS_ALL ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_PARTNERS_ALL ADD CONSTRAINT UK_WCS_PARTNERS_ALL UNIQUE (PTN_OKPO, PTN_NLS, PTN_MFO)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_WCSPARTNERS ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_PARTNERS_ALL ADD CONSTRAINT PK_WCSPARTNERS PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_PARTNERS_TID_PARTTS_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_PARTNERS_ALL ADD CONSTRAINT FK_PARTNERS_TID_PARTTS_ID FOREIGN KEY (TYPE_ID)
	  REFERENCES BARS.WCS_PARTNER_TYPES (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_PARTNERS_B_BRANCH_BRH ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_PARTNERS_ALL ADD CONSTRAINT FK_PARTNERS_B_BRANCH_BRH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_IDMATHER ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_PARTNERS_ALL ADD CONSTRAINT FK_IDMATHER FOREIGN KEY (ID_MATHER)
	  REFERENCES BARS.WCS_PARTNERS_ALL (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_WCSPARTNERS_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_PARTNERS_ALL MODIFY (NAME CONSTRAINT CC_WCSPARTNERS_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C007643 ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_PARTNERS_ALL MODIFY (FLAG_A NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_WCSPARTNERS_TYPEID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_PARTNERS_ALL MODIFY (TYPE_ID CONSTRAINT CC_WCSPARTNERS_TYPEID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_WCSPARTNERS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_WCSPARTNERS ON BARS.WCS_PARTNERS_ALL (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_WCS_PARTNERS_ALL ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_WCS_PARTNERS_ALL ON BARS.WCS_PARTNERS_ALL (PTN_OKPO, PTN_NLS, PTN_MFO) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  WCS_PARTNERS_ALL ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on WCS_PARTNERS_ALL to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on WCS_PARTNERS_ALL to BARS_DM;
grant SELECT                                                                 on WCS_PARTNERS_ALL to WCS_SYNC_USER;
grant FLASHBACK,SELECT                                                       on WCS_PARTNERS_ALL to WR_REFREAD;



PROMPT *** Create SYNONYM  to WCS_PARTNERS_ALL ***

  CREATE OR REPLACE PUBLIC SYNONYM WCS_PARTNERS_ALL FOR BARS.WCS_PARTNERS_ALL;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/WCS_PARTNERS_ALL.sql =========*** End 
PROMPT ===================================================================================== 

