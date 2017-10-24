

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/FINMON/Table/BANK.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** Create  table BANK ***
begin 
  execute immediate '
  CREATE TABLE FINMON.BANK 
   (	ID VARCHAR2(15), 
	UST_ID VARCHAR2(10), 
	UST_MFO VARCHAR2(6), 
	UST_TYP VARCHAR2(1), 
	UST_VID VARCHAR2(3), 
	UST_NAME VARCHAR2(254), 
	UST_OBL VARCHAR2(2), 
	UST_STR VARCHAR2(3), 
	UST_TLF VARCHAR2(10), 
	UST_EMAIL VARCHAR2(254), 
	UST_ADR VARCHAR2(254), 
	VDP_POS VARCHAR2(100), 
	VDP_NM1 VARCHAR2(50), 
	VDP_NM2 VARCHAR2(30), 
	VDP_NM3 VARCHAR2(30), 
	VDP_TLF VARCHAR2(10), 
	VDP_EMAIL VARCHAR2(254), 
	ID_KEY_DDFM VARCHAR2(6), 
	ID_KEY_BANK VARCHAR2(20), 
	COMMENT_UST_VID VARCHAR2(1000), 
	ADDR_POSTAL_CODE VARCHAR2(10), 
	ADDR_CITY VARCHAR2(254), 
	ADDR_STREAT VARCHAR2(254), 
	ADDR_BUD VARCHAR2(10), 
	ADDR_KOR VARCHAR2(10), 
	ADDR_OFIS VARCHAR2(10), 
	STATUS VARCHAR2(1)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE USERS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE FINMON.BANK IS '������ ������ � ��������';
COMMENT ON COLUMN FINMON.BANK.ID IS '������������� ������';
COMMENT ON COLUMN FINMON.BANK.UST_ID IS '��� ������';
COMMENT ON COLUMN FINMON.BANK.UST_MFO IS '���';
COMMENT ON COLUMN FINMON.BANK.UST_TYP IS '��� ���������� (1-����, ��.����, 4-������)';
COMMENT ON COLUMN FINMON.BANK.UST_VID IS '��� ���������� (100 - ��� ������)';
COMMENT ON COLUMN FINMON.BANK.UST_NAME IS '������������';
COMMENT ON COLUMN FINMON.BANK.UST_OBL IS '��� ������� �� ��������������� ���';
COMMENT ON COLUMN FINMON.BANK.UST_STR IS '��� ������ �� ��������������� ���';
COMMENT ON COLUMN FINMON.BANK.UST_TLF IS '������� ����������';
COMMENT ON COLUMN FINMON.BANK.UST_EMAIL IS '����������� ����� ����������';
COMMENT ON COLUMN FINMON.BANK.UST_ADR IS '�������� ����� ����������';
COMMENT ON COLUMN FINMON.BANK.VDP_POS IS '��������� �����. ����';
COMMENT ON COLUMN FINMON.BANK.VDP_NM1 IS '������� �������������';
COMMENT ON COLUMN FINMON.BANK.VDP_NM2 IS '��� �������������';
COMMENT ON COLUMN FINMON.BANK.VDP_NM3 IS '�������� �������������';
COMMENT ON COLUMN FINMON.BANK.VDP_TLF IS '������� �����. ����';
COMMENT ON COLUMN FINMON.BANK.VDP_EMAIL IS '����������� ����� �����. ����';
COMMENT ON COLUMN FINMON.BANK.ID_KEY_DDFM IS '';
COMMENT ON COLUMN FINMON.BANK.ID_KEY_BANK IS '';
COMMENT ON COLUMN FINMON.BANK.COMMENT_UST_VID IS '';
COMMENT ON COLUMN FINMON.BANK.ADDR_POSTAL_CODE IS '';
COMMENT ON COLUMN FINMON.BANK.ADDR_CITY IS '';
COMMENT ON COLUMN FINMON.BANK.ADDR_STREAT IS '';
COMMENT ON COLUMN FINMON.BANK.ADDR_BUD IS '';
COMMENT ON COLUMN FINMON.BANK.ADDR_KOR IS '';
COMMENT ON COLUMN FINMON.BANK.ADDR_OFIS IS '';
COMMENT ON COLUMN FINMON.BANK.STATUS IS '';




PROMPT *** Create  constraint FK_BANK_STATUS ***
begin   
 execute immediate '
  ALTER TABLE FINMON.BANK ADD CONSTRAINT FK_BANK_STATUS FOREIGN KEY (STATUS)
	  REFERENCES FINMON.K_DFM06 (CODE) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint R_BANK_K_DFM07 ***
begin   
 execute immediate '
  ALTER TABLE FINMON.BANK ADD CONSTRAINT R_BANK_K_DFM07 FOREIGN KEY (UST_TYP)
	  REFERENCES FINMON.K_DFM07 (CODE) DEFERRABLE ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint R_BANK_K_DFM05 ***
begin   
 execute immediate '
  ALTER TABLE FINMON.BANK ADD CONSTRAINT R_BANK_K_DFM05 FOREIGN KEY (UST_VID)
	  REFERENCES FINMON.K_DFM05 (CODE) DEFERRABLE ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XPK_BANK ***
begin   
 execute immediate '
  ALTER TABLE FINMON.BANK ADD CONSTRAINT XPK_BANK PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE USERS  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_BANK_VDP_TLF ***
begin   
 execute immediate '
  ALTER TABLE FINMON.BANK MODIFY (VDP_TLF CONSTRAINT NK_BANK_VDP_TLF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_BANK_VDP_NM1 ***
begin   
 execute immediate '
  ALTER TABLE FINMON.BANK MODIFY (VDP_NM1 CONSTRAINT NK_BANK_VDP_NM1 NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_BANK_VDP_POS ***
begin   
 execute immediate '
  ALTER TABLE FINMON.BANK MODIFY (VDP_POS CONSTRAINT NK_BANK_VDP_POS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_BANK_UST_ADR ***
begin   
 execute immediate '
  ALTER TABLE FINMON.BANK MODIFY (UST_ADR CONSTRAINT NK_BANK_UST_ADR NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_BANK_UST_TLF ***
begin   
 execute immediate '
  ALTER TABLE FINMON.BANK MODIFY (UST_TLF CONSTRAINT NK_BANK_UST_TLF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_BANK_UST_STR ***
begin   
 execute immediate '
  ALTER TABLE FINMON.BANK MODIFY (UST_STR CONSTRAINT NK_BANK_UST_STR NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_BANK_UST_OBL ***
begin   
 execute immediate '
  ALTER TABLE FINMON.BANK MODIFY (UST_OBL CONSTRAINT NK_BANK_UST_OBL NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_BANK_UST_NAME ***
begin   
 execute immediate '
  ALTER TABLE FINMON.BANK MODIFY (UST_NAME CONSTRAINT NK_BANK_UST_NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_BANK_UST_VID ***
begin   
 execute immediate '
  ALTER TABLE FINMON.BANK MODIFY (UST_VID CONSTRAINT NK_BANK_UST_VID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_BANK_UST_TYP ***
begin   
 execute immediate '
  ALTER TABLE FINMON.BANK MODIFY (UST_TYP CONSTRAINT NK_BANK_UST_TYP NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_BANK_UST_MFO ***
begin   
 execute immediate '
  ALTER TABLE FINMON.BANK MODIFY (UST_MFO CONSTRAINT NK_BANK_UST_MFO NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_BANK_UST_ID ***
begin   
 execute immediate '
  ALTER TABLE FINMON.BANK MODIFY (UST_ID CONSTRAINT NK_BANK_UST_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_BANK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX FINMON.XPK_BANK ON FINMON.BANK (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE USERS ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index XAK_BANK_OKPO ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX FINMON.XAK_BANK_OKPO ON FINMON.BANK (UST_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE USERS ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BANK ***
grant SELECT                                                                 on BANK            to BARS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/FINMON/Table/BANK.sql =========*** End *** ======
PROMPT ===================================================================================== 
