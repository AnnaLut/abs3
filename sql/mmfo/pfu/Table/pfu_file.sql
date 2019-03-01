

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/PFU/Table/PFU_FILE.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  table PFU_FILE ***
begin 
  execute immediate '
  CREATE TABLE PFU.PFU_FILE 
   (	ID NUMBER(10,0), 
	ENVELOPE_REQUEST_ID NUMBER(10,0), 
	CHECK_SUM NUMBER(38,2), 
	CHECK_LINES_COUNT NUMBER(38,0), 
	PAYMENT_DATE DATE, 
	FILE_NUMBER NUMBER(5,0), 
	FILE_NAME VARCHAR2(256 CHAR), 
	FILE_DATA BLOB, 
	STATE VARCHAR2(20), 
	CRT_DATE DATE, 
	DATA_SIGN CLOB, 
	USERID NUMBER(38,0), 
	PAY_DATE DATE, 
	MATCH_DATE DATE,
        FILE_TYPE VARCHAR2(2 CHAR) default ''01'' not null
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD 
 LOB (FILE_DATA) STORE AS BASICFILE (
  TABLESPACE BRSBIGD ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) 
 LOB (DATA_SIGN) STORE AS BASICFILE (
  TABLESPACE BRSBIGD ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


comment on column pfu.pfu_file.ID is 'ID �����';
comment on column pfu.pfu_file.ENVELOPE_REQUEST_ID is '����� ��������';
comment on column pfu.pfu_file.CHECK_SUM is '����';
comment on column pfu.pfu_file.CHECK_LINES_COUNT is 'ʳ������ ����� �����';
comment on column pfu.pfu_file.PAYMENT_DATE is '������� ���� ������ ������';
comment on column pfu.pfu_file.FILE_NUMBER is '���������� ����� ����� � �������';
comment on column pfu.pfu_file.FILE_NAME is '����� �����';
comment on column pfu.pfu_file.FILE_DATA is '���� �����';
comment on column pfu.pfu_file.STATE is '���� �����';
comment on column pfu.pfu_file.CRT_DATE is '���� �������� ������';
comment on column pfu.pfu_file.DATA_SIGN is 'ϳ����';
comment on column pfu.pfu_file.USERID is 'ID �����������';
comment on column pfu.pfu_file.PAY_DATE is '���� ������ ������';
comment on column pfu.pfu_file.MATCH_DATE is '���� �������� 2-� ���������';




PROMPT *** Create  constraint PK_PFU_FILE ***
begin   
 execute immediate '
  ALTER TABLE PFU.PFU_FILE ADD CONSTRAINT PK_PFU_FILE PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00111539 ***
begin   
 execute immediate '
  ALTER TABLE PFU.PFU_FILE MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_PFU_FILE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX PFU.PK_PFU_FILE ON PFU.PFU_FILE (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

-- Add/modify columns 
begin
    execute immediate 'alter table PFU_FILE add file_type VARCHAR2(2 CHAR) default ''01'' not null';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 

-- Add comments to the columns 
comment on column PFU_FILE.file_type
  is '��� ������(1-�����, 2-�����������)';



PROMPT *** Create  grants  PFU_FILE ***
grant SELECT                                                                 on PFU_FILE        to BARS;
grant SELECT                                                                 on PFU_FILE        to BARSREADER_ROLE;
grant SELECT                                                                 on PFU_FILE        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on PFU_FILE        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/PFU/Table/PFU_FILE.sql =========*** End *** =====
PROMPT ===================================================================================== 
