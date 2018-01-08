

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ATTRIBUTE_KIND_BAK.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ATTRIBUTE_KIND_BAK ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ATTRIBUTE_KIND_BAK ***
begin 
  execute immediate '
  CREATE TABLE BARS.ATTRIBUTE_KIND_BAK 
   (	ID NUMBER(5,0), 
	ATTRIBUTE_CODE VARCHAR2(30 CHAR), 
	ATTRIBUTE_NAME VARCHAR2(300 CHAR), 
	ATTRIBUTE_TYPE_ID NUMBER(5,0), 
	OBJECT_TYPE_ID NUMBER(5,0), 
	VALUE_TYPE_ID NUMBER(5,0), 
	VALUE_TABLE_OWNER VARCHAR2(30 CHAR), 
	VALUE_TABLE_NAME VARCHAR2(30 CHAR), 
	KEY_COLUMN_NAME VARCHAR2(30 CHAR), 
	VALUE_COLUMN_NAME VARCHAR2(30 CHAR), 
	REGULAR_EXPRESSION VARCHAR2(200 CHAR), 
	LIST_TYPE_ID NUMBER(5,0), 
	MULTY_VALUE_FLAG CHAR(1), 
	HISTORY_SAVING_MODE_ID NUMBER(5,0), 
	GET_VALUE_FUNCTION VARCHAR2(100 CHAR), 
	GET_VALUES_FUNCTION VARCHAR2(100 CHAR), 
	SET_VALUE_PROCEDURE VARCHAR2(100 CHAR), 
	DEL_VALUE_PROCEDURE VARCHAR2(100 CHAR), 
	STATE_ID NUMBER(5,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ATTRIBUTE_KIND_BAK ***
 exec bpa.alter_policies('ATTRIBUTE_KIND_BAK');


COMMENT ON TABLE BARS.ATTRIBUTE_KIND_BAK IS '������� �������� ��'����. ������ ������� �������� ��������';
COMMENT ON COLUMN BARS.ATTRIBUTE_KIND_BAK.GET_VALUE_FUNCTION IS '�������, �� ����������� ��� ��������� �������� �������������� ��������';
COMMENT ON COLUMN BARS.ATTRIBUTE_KIND_BAK.GET_VALUES_FUNCTION IS '�������, �� ����������� ��� ��������� ������ ������� �������������� ��������, ���� ��� ������ �������� ������������ ������� ��������';
COMMENT ON COLUMN BARS.ATTRIBUTE_KIND_BAK.SET_VALUE_PROCEDURE IS '���������, �� ����������� ����� ������������� �������� ��������, ��� ������ ������� �������� ������������ ��������';
COMMENT ON COLUMN BARS.ATTRIBUTE_KIND_BAK.DEL_VALUE_PROCEDURE IS '���������, �� ����������� ����� ���������� �������� ��������, ��� ������ ��������� �������� ������������ ��������';
COMMENT ON COLUMN BARS.ATTRIBUTE_KIND_BAK.STATE_ID IS '������, � ����� �������� ������� (����� �������������, ��������, ��������)';
COMMENT ON COLUMN BARS.ATTRIBUTE_KIND_BAK.ID IS '������������� ��������';
COMMENT ON COLUMN BARS.ATTRIBUTE_KIND_BAK.ATTRIBUTE_CODE IS '��� ��������';
COMMENT ON COLUMN BARS.ATTRIBUTE_KIND_BAK.ATTRIBUTE_NAME IS '����� ��������';
COMMENT ON COLUMN BARS.ATTRIBUTE_KIND_BAK.ATTRIBUTE_TYPE_ID IS '��� �������� - ���������� �������� ��������� ��� �������� � �������� ����, ������� �������� ��������� �������� �� ���� � ������������ ��������, ������������ �������� �� ��������� ��������, � ������ ���� ����������� ��� �����';
COMMENT ON COLUMN BARS.ATTRIBUTE_KIND_BAK.OBJECT_TYPE_ID IS '��� ��'����, ���� ��������� ����� �������';
COMMENT ON COLUMN BARS.ATTRIBUTE_KIND_BAK.VALUE_TYPE_ID IS '��� �������� ��������';
COMMENT ON COLUMN BARS.ATTRIBUTE_KIND_BAK.VALUE_TABLE_OWNER IS '';
COMMENT ON COLUMN BARS.ATTRIBUTE_KIND_BAK.VALUE_TABLE_NAME IS '';
COMMENT ON COLUMN BARS.ATTRIBUTE_KIND_BAK.KEY_COLUMN_NAME IS '';
COMMENT ON COLUMN BARS.ATTRIBUTE_KIND_BAK.VALUE_COLUMN_NAME IS '����� ����, �� ������ �������� ��������, � ������� ������������ ��������';
COMMENT ON COLUMN BARS.ATTRIBUTE_KIND_BAK.REGULAR_EXPRESSION IS '���������� ����� ��� �������� ������� ��� ����������� �������� �������� (����� ��� ��������� ��������)';
COMMENT ON COLUMN BARS.ATTRIBUTE_KIND_BAK.LIST_TYPE_ID IS '������������� ������, � ������� ������� ����� ���� ���������� �������� ������ ��������';
COMMENT ON COLUMN BARS.ATTRIBUTE_KIND_BAK.MULTY_VALUE_FLAG IS '������ ����, �� �� ������ ���� �������� ���� ���� ��������� ������� ������� ��� ���� �����';
COMMENT ON COLUMN BARS.ATTRIBUTE_KIND_BAK.HISTORY_SAVING_MODE_ID IS '����� ���������� ����� ������� �������� (�� �������� ������, �������� ������ �������, �������� ������ ������� �� ����)';



PROMPT *** Create  grants  ATTRIBUTE_KIND_BAK ***
grant SELECT                                                                 on ATTRIBUTE_KIND_BAK to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ATTRIBUTE_KIND_BAK.sql =========*** En
PROMPT ===================================================================================== 
