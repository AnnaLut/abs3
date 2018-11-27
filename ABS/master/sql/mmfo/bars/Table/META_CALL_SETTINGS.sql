

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/META_CALL_SETTINGS.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to META_CALL_SETTINGS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''META_CALL_SETTINGS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''META_CALL_SETTINGS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table META_CALL_SETTINGS ***
begin 
  execute immediate '
  CREATE TABLE BARS.META_CALL_SETTINGS 
   (	ID NUMBER(38,0), 
	CODE VARCHAR2(30), 
	CALL_FROM VARCHAR2(30), 
	WEB_FORM_NAME VARCHAR2(400), 
	TABID NUMBER(38,0), 
	FUNCID NUMBER(38,0), 
	ACCESSCODE NUMBER(2,0), 
	SHOW_DIALOG VARCHAR2(30), 
	LINK_TYPE VARCHAR2(30), 
	INSERT_AFTER NUMBER(1,0) DEFAULT 0, 
	EDIT_MODE VARCHAR2(30) DEFAULT ''ROW_EDIT'', 
	SUMM_VISIBLE NUMBER(1,0) DEFAULT 0, 
	CONDITIONS CLOB, 
	EXCEL_OPT VARCHAR2(30), 
	ADD_WITH_WINDOW NUMBER(1,0) DEFAULT 0, 
	SWITCH_OF_DEPS NUMBER(1,0) DEFAULT 0, 
	SHOW_COUNT NUMBER(1,0) DEFAULT 0, 
	SAVE_COLUMN VARCHAR2(30), 
	CODEAPP VARCHAR2(30 CHAR), 
	BASE_OPTIONS VARCHAR2(1000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND 
 LOB (CONDITIONS) STORE AS BASICFILE (
  TABLESPACE BRSDYND ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


begin 
   execute immediate('alter table BARS.META_CALL_SETTINGS add "custom_options" clob ');
exception when others then 
   null; 
end;
/



PROMPT *** ALTER_POLICIES to META_CALL_SETTINGS ***
 exec bpa.alter_policies('META_CALL_SETTINGS');


COMMENT ON TABLE BARS.META_CALL_SETTINGS IS '�������� ������ ����������';
COMMENT ON COLUMN BARS.META_CALL_SETTINGS.ID IS '�������������';
COMMENT ON COLUMN BARS.META_CALL_SETTINGS.CODE IS '��������� ���������� ������������� ��� ������ �� ���� ������ ����������.';
COMMENT ON COLUMN BARS.META_CALL_SETTINGS.CALL_FROM IS '��������� ����, ���������� ��� ����������� �������������. �.�. ������ ��������� ��� ���������� ����.';
COMMENT ON COLUMN BARS.META_CALL_SETTINGS.WEB_FORM_NAME IS '��� url, ���� ��� ������������ ������ ������, ���� �� ����� ���� �������� �� ��������� ������� ��������� � �������.';
COMMENT ON COLUMN BARS.META_CALL_SETTINGS.TABID IS '���� ���� ��������� before - ��������� � � meta_nsifunction ����� �����,';
COMMENT ON COLUMN BARS.META_CALL_SETTINGS.FUNCID IS '���� ���� ��������� before - ��������� � � meta_nsifunction ����� �����';
COMMENT ON COLUMN BARS.META_CALL_SETTINGS.ACCESSCODE IS '������������ ������� ACCESSCODE.';
COMMENT ON COLUMN BARS.META_CALL_SETTINGS.SHOW_DIALOG IS '���������� �� ���� � ��������� � ����� ������.';
COMMENT ON COLUMN BARS.META_CALL_SETTINGS.LINK_TYPE IS '��������� � �������� � ����� ����������. OPEN_IN_WINDOW - ����� ������ � ��������� ����(�� ��������� � ����� �������). OPEN_IN_TUBE - � ����� �������. ';
COMMENT ON COLUMN BARS.META_CALL_SETTINGS.INSERT_AFTER IS '���������� ����� ������ �� � ������, � ����� �����';
COMMENT ON COLUMN BARS.META_CALL_SETTINGS.EDIT_MODE IS '��� �������������� MULTI_EDIT - ������������� �������������� ROW_EDIT - ����������(�� ���������)';
COMMENT ON COLUMN BARS.META_CALL_SETTINGS.SUMM_VISIBLE IS '������� �������� ������ �� ������� ������� 0 - �� ���� �������(�� ���������).';
COMMENT ON COLUMN BARS.META_CALL_SETTINGS.CONDITIONS IS '������� ������';
COMMENT ON COLUMN BARS.META_CALL_SETTINGS.EXCEL_OPT IS '������������ ��� ��������� �������� � EXCEL WITHOUT_EXCEL , XLSX, XLSX_XLS, XLS';
COMMENT ON COLUMN BARS.META_CALL_SETTINGS.ADD_WITH_WINDOW IS '���������� ����� ������ ����� � ������� ����, 0 - ������� ������ � ����.';
COMMENT ON COLUMN BARS.META_CALL_SETTINGS.SWITCH_OF_DEPS IS '��������� ��� ONLINE �����������.';
COMMENT ON COLUMN BARS.META_CALL_SETTINGS.SHOW_COUNT IS '���������� ���-�� ������� � ������� 0 - �� ����������';
COMMENT ON COLUMN BARS.META_CALL_SETTINGS.SAVE_COLUMN IS '���������, ��������� �������, ����������� ';
COMMENT ON COLUMN BARS.META_CALL_SETTINGS.CODEAPP IS '��� ������ �����������, ��������� ����. ������ � TABID.';
COMMENT ON COLUMN BARS.META_CALL_SETTINGS.BASE_OPTIONS IS '���������, ������� ����� ����������� ��������� �������� ��������� ����';




PROMPT *** Create  constraint SYS_C00138709 ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_CALL_SETTINGS MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_METACALLSETTINGS ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_CALL_SETTINGS ADD CONSTRAINT PK_METACALLSETTINGS PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_METACALLSETTINGS_CODE ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_CALL_SETTINGS ADD CONSTRAINT UK_METACALLSETTINGS_CODE UNIQUE (CODE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_METACALLSETTINGS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_METACALLSETTINGS ON BARS.META_CALL_SETTINGS (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_METACALLSETTINGS_CODE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_METACALLSETTINGS_CODE ON BARS.META_CALL_SETTINGS (CODE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  META_CALL_SETTINGS ***
grant SELECT                                                                 on META_CALL_SETTINGS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/META_CALL_SETTINGS.sql =========*** En
PROMPT ===================================================================================== 
