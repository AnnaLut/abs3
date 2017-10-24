

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ZAY_DATA_TRANSFER_LOG.sql =========***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ZAY_DATA_TRANSFER_LOG ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ZAY_DATA_TRANSFER_LOG'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ZAY_DATA_TRANSFER_LOG'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ZAY_DATA_TRANSFER_LOG ***
begin 
  execute immediate '
  CREATE TABLE BARS.ZAY_DATA_TRANSFER_LOG 
   (	ID NUMBER(38,0), 
	REQ_ID NUMBER(38,0), 
	URL VARCHAR2(256), 
	MFO VARCHAR2(10), 
	TRANSFER_TYPE NUMBER(2,0), 
	TRANSFER_DATE DATE, 
	TRANSFER_RESULT NUMBER(1,0), 
	COMM VARCHAR2(1024)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ZAY_DATA_TRANSFER_LOG ***
 exec bpa.alter_policies('ZAY_DATA_TRANSFER_LOG');


COMMENT ON TABLE BARS.ZAY_DATA_TRANSFER_LOG IS '����� ������� �������� ����� �� �� �� ��';
COMMENT ON COLUMN BARS.ZAY_DATA_TRANSFER_LOG.ID IS '�������������';
COMMENT ON COLUMN BARS.ZAY_DATA_TRANSFER_LOG.REQ_ID IS '������������� ������';
COMMENT ON COLUMN BARS.ZAY_DATA_TRANSFER_LOG.URL IS 'url ������ �� ������ ��';
COMMENT ON COLUMN BARS.ZAY_DATA_TRANSFER_LOG.MFO IS '��� ��';
COMMENT ON COLUMN BARS.ZAY_DATA_TRANSFER_LOG.TRANSFER_TYPE IS '��� �����, �� �����������
                                                          1 - ���������� �����,
                                                          2 - ���������,
                                                          3 - ³������� ������,
                                                          4 - ������������ ��������� �����,
                                                          5 - ����������� ������,
                                                          6 - ���������� ���� �������� ����� �� ������,
                                                          7 - ����������� ������,
                                                          8 - �������� ��� �� ������,
                                                          9 - �������� ������';
COMMENT ON COLUMN BARS.ZAY_DATA_TRANSFER_LOG.TRANSFER_DATE IS '���� ��������� ��������';
COMMENT ON COLUMN BARS.ZAY_DATA_TRANSFER_LOG.TRANSFER_RESULT IS '��������� �������� 1-��������/0- �� ��������';
COMMENT ON COLUMN BARS.ZAY_DATA_TRANSFER_LOG.COMM IS '��������';




PROMPT *** Create  constraint PK_ZAYDATATRANSFERLG ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAY_DATA_TRANSFER_LOG ADD CONSTRAINT PK_ZAYDATATRANSFERLG PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ZAYDATTRANSRESULTLG_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAY_DATA_TRANSFER_LOG MODIFY (TRANSFER_RESULT CONSTRAINT CC_ZAYDATTRANSRESULTLG_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ZAYDATTRANSDATELG_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAY_DATA_TRANSFER_LOG MODIFY (TRANSFER_DATE CONSTRAINT CC_ZAYDATTRANSDATELG_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ZAYDATTRANSTYPELG_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAY_DATA_TRANSFER_LOG MODIFY (TRANSFER_TYPE CONSTRAINT CC_ZAYDATTRANSTYPELG_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ZAYDATTRANSMFOLG_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAY_DATA_TRANSFER_LOG MODIFY (MFO CONSTRAINT CC_ZAYDATTRANSMFOLG_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ZAYDATTRANSURLLG_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAY_DATA_TRANSFER_LOG MODIFY (URL CONSTRAINT CC_ZAYDATTRANSURLLG_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ZAYDATATRANSFERLG ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ZAYDATATRANSFERLG ON BARS.ZAY_DATA_TRANSFER_LOG (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ZAY_DATA_TRANSFER_LOG ***
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on ZAY_DATA_TRANSFER_LOG to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ZAY_DATA_TRANSFER_LOG.sql =========***
PROMPT ===================================================================================== 
