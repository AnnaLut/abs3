

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ZAY_DATA_TRANSFER.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ZAY_DATA_TRANSFER ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ZAY_DATA_TRANSFER'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''ZAY_DATA_TRANSFER'', ''FILIAL'' , ''M'', null, null, null);
               bpa.alter_policy_info(''ZAY_DATA_TRANSFER'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ZAY_DATA_TRANSFER ***
begin 
  execute immediate '
  CREATE TABLE BARS.ZAY_DATA_TRANSFER 
   (	ID NUMBER(38,0), 
	REQ_ID NUMBER(38,0), 
	URL VARCHAR2(256), 
	MFO VARCHAR2(10), 
	TRANSFER_TYPE NUMBER(2,0), 
	TRANSFER_DATE DATE, 
	TRANSFER_RESULT NUMBER(1,0), 
	COMM VARCHAR2(1024), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ZAY_DATA_TRANSFER ***
 exec bpa.alter_policies('ZAY_DATA_TRANSFER');


COMMENT ON TABLE BARS.ZAY_DATA_TRANSFER IS '������ �������� ����� ������ ZAY � �� �� �� ';
COMMENT ON COLUMN BARS.ZAY_DATA_TRANSFER.ID IS '�������������';
COMMENT ON COLUMN BARS.ZAY_DATA_TRANSFER.REQ_ID IS '������������� ������';
COMMENT ON COLUMN BARS.ZAY_DATA_TRANSFER.URL IS 'url ������ �� ������ ��';
COMMENT ON COLUMN BARS.ZAY_DATA_TRANSFER.MFO IS '��� ��';
COMMENT ON COLUMN BARS.ZAY_DATA_TRANSFER.TRANSFER_TYPE IS '��� �����, �� �����������
                                                      1 - ���������� �����,
                                                      2 - ���������,
                                                      3 - ³������� ������,
                                                      4 - ������������ ��������� �����,
                                                      5 - ����������� ������,
                                                      6 - ���������� ���� �������� ����� �� ������,
                                                      7 - ,
                                                      8 - �������� ��� �� ������,
                                                      9 - �������� ������';
COMMENT ON COLUMN BARS.ZAY_DATA_TRANSFER.TRANSFER_DATE IS '���� ��������� ��������';
COMMENT ON COLUMN BARS.ZAY_DATA_TRANSFER.TRANSFER_RESULT IS '��������� �������� 1-��������/0- �� ��������';
COMMENT ON COLUMN BARS.ZAY_DATA_TRANSFER.COMM IS '��������';
COMMENT ON COLUMN BARS.ZAY_DATA_TRANSFER.KF IS '';




PROMPT *** Create  constraint PK_ZAYDATATRANSFER ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAY_DATA_TRANSFER ADD CONSTRAINT PK_ZAYDATATRANSFER PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGD  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ZAYDATATRANSFER_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAY_DATA_TRANSFER ADD CONSTRAINT FK_ZAYDATATRANSFER_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ZAYDATTRANSURL_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAY_DATA_TRANSFER MODIFY (URL CONSTRAINT CC_ZAYDATTRANSURL_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ZAYDATTRANSMFO_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAY_DATA_TRANSFER MODIFY (MFO CONSTRAINT CC_ZAYDATTRANSMFO_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ZAYDATTRANSTYPE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAY_DATA_TRANSFER MODIFY (TRANSFER_TYPE CONSTRAINT CC_ZAYDATTRANSTYPE_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ZAYDATTRANSDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAY_DATA_TRANSFER MODIFY (TRANSFER_DATE CONSTRAINT CC_ZAYDATTRANSDATE_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ZAYDATTRANSRESULT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAY_DATA_TRANSFER MODIFY (TRANSFER_RESULT CONSTRAINT CC_ZAYDATTRANSRESULT_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ZAYDATATRANSFER_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAY_DATA_TRANSFER MODIFY (KF CONSTRAINT CC_ZAYDATATRANSFER_KF_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ZAYDATATRANSFER ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ZAYDATATRANSFER ON BARS.ZAY_DATA_TRANSFER (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ZAY_DATA_TRANSFER ***
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on ZAY_DATA_TRANSFER to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ZAY_DATA_TRANSFER to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ZAY_DATA_TRANSFER.sql =========*** End
PROMPT ===================================================================================== 
