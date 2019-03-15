

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/FINMON_REFT.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to FINMON_REFT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''FINMON_REFT'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''FINMON_REFT'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''FINMON_REFT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table FINMON_REFT ***
begin 
  execute immediate '
  CREATE TABLE BARS.FINMON_REFT 
   (	C1 NUMBER, 
	C2 DATE, 
	C3 NUMBER, 
	C4 VARCHAR2(1), 
	C5 VARCHAR2(150), 
	C6 VARCHAR2(350), 
	C7 VARCHAR2(350), 
	C8 VARCHAR2(350), 
	C9 VARCHAR2(350), 
	C10 VARCHAR2(2), 
	C11 VARCHAR2(6), 
	C12 VARCHAR2(1), 
	C13 VARCHAR2(500), 
	C14 VARCHAR2(750), 
	C15 VARCHAR2(500), 
	C16 VARCHAR2(500), 
	C17 VARCHAR2(500), 
	C18 VARCHAR2(500), 
	C19 VARCHAR2(500), 
	C20 VARCHAR2(1000), 
	C21 VARCHAR2(500), 
	C22 VARCHAR2(1000), 
	C23 VARCHAR2(3), 
	C24 VARCHAR2(1000), 
	C25 VARCHAR2(1000), 
	C26 VARCHAR2(250), 
	C27 VARCHAR2(3), 
	C28 VARCHAR2(50), 
	C29 VARCHAR2(300), 
	C30 VARCHAR2(300), 
	C31 VARCHAR2(350), 
	C32 VARCHAR2(350), 
	C33 VARCHAR2(50), 
	C34 VARCHAR2(1000), 
	C35 VARCHAR2(1000), 
	C36 VARCHAR2(700), 
	C37 VARCHAR2(4000), 
	C38 VARCHAR2(1000), 
	C39 DATE, 
	C40 VARCHAR2(1000), 
	C41 VARCHAR2(1000), 
	NAME_HASH VARCHAR2(32)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to FINMON_REFT ***
 exec bpa.alter_policies('FINMON_REFT');


COMMENT ON TABLE BARS.FINMON_REFT IS '������ ��������� �� �������� ���, ���`������ � ���������� ������������ ��������';
COMMENT ON COLUMN BARS.FINMON_REFT.C1 IS '����� ����� � ������� ���';
COMMENT ON COLUMN BARS.FINMON_REFT.C2 IS '���� �������� ����� �� ������� ���';
COMMENT ON COLUMN BARS.FINMON_REFT.C3 IS '��� ������';
COMMENT ON COLUMN BARS.FINMON_REFT.C4 IS '��� �����';
COMMENT ON COLUMN BARS.FINMON_REFT.C5 IS '�������, �������� �� ����� ����� ������� �� ������� ���';
COMMENT ON COLUMN BARS.FINMON_REFT.C6 IS '������� ��������� / ��`� 1 ����������� / ������������ �������� �����';
COMMENT ON COLUMN BARS.FINMON_REFT.C7 IS '��`� ��������� / ��`� 2 �����������';
COMMENT ON COLUMN BARS.FINMON_REFT.C8 IS '�� ������� ��������� / ��`� 3 �����������';
COMMENT ON COLUMN BARS.FINMON_REFT.C9 IS '��`� 4 ����������� ';
COMMENT ON COLUMN BARS.FINMON_REFT.C10 IS '³����� ��� �������� ������ ��������� ����, ���������, �� ��.';
COMMENT ON COLUMN BARS.FINMON_REFT.C11 IS '�������� ���������';
COMMENT ON COLUMN BARS.FINMON_REFT.C12 IS '����� ���������';
COMMENT ON COLUMN BARS.FINMON_REFT.C13 IS '���� ���������� / ���� ��������� �������� �����';
COMMENT ON COLUMN BARS.FINMON_REFT.C14 IS '̳��� ���������� / ̳�������������� �������� �����  ';
COMMENT ON COLUMN BARS.FINMON_REFT.C15 IS '������������';
COMMENT ON COLUMN BARS.FINMON_REFT.C16 IS '�������������';
COMMENT ON COLUMN BARS.FINMON_REFT.C17 IS '������';
COMMENT ON COLUMN BARS.FINMON_REFT.C18 IS 'г� ��������';
COMMENT ON COLUMN BARS.FINMON_REFT.C19 IS '������, ��������, ������ �� ���� ������';
COMMENT ON COLUMN BARS.FINMON_REFT.C20 IS '���� �� �����';
COMMENT ON COLUMN BARS.FINMON_REFT.C21 IS '���� ������';
COMMENT ON COLUMN BARS.FINMON_REFT.C22 IS '������ ������ ';
COMMENT ON COLUMN BARS.FINMON_REFT.C23 IS '����� ������ (���) ';
COMMENT ON COLUMN BARS.FINMON_REFT.C24 IS '������������ ������, �� ����� ��������';
COMMENT ON COLUMN BARS.FINMON_REFT.C25 IS '���������������� �����/���';
COMMENT ON COLUMN BARS.FINMON_REFT.C26 IS '�����';
COMMENT ON COLUMN BARS.FINMON_REFT.C27 IS '����� (���)';
COMMENT ON COLUMN BARS.FINMON_REFT.C28 IS '�������� ��� ';
COMMENT ON COLUMN BARS.FINMON_REFT.C29 IS '������� (����, ��������)';
COMMENT ON COLUMN BARS.FINMON_REFT.C30 IS '̳���';
COMMENT ON COLUMN BARS.FINMON_REFT.C31 IS '������';
COMMENT ON COLUMN BARS.FINMON_REFT.C32 IS '�������';
COMMENT ON COLUMN BARS.FINMON_REFT.C33 IS '����';
COMMENT ON COLUMN BARS.FINMON_REFT.C34 IS '������ (�� �������������)';
COMMENT ON COLUMN BARS.FINMON_REFT.C35 IS '³����� ��� ��������� ����� ������ (������)';
COMMENT ON COLUMN BARS.FINMON_REFT.C36 IS '³����� ��� ����������� � �������� �� ����������� �������';
COMMENT ON COLUMN BARS.FINMON_REFT.C37 IS '��������� ����������';
COMMENT ON COLUMN BARS.FINMON_REFT.C38 IS '����������� ������';
COMMENT ON COLUMN BARS.FINMON_REFT.C39 IS '³����� ��� ���������� � ������� ���';
COMMENT ON COLUMN BARS.FINMON_REFT.C40 IS '���������� ��� ����, � ����� ������� �������';
COMMENT ON COLUMN BARS.FINMON_REFT.C41 IS '����� ����������� �������';
COMMENT ON COLUMN BARS.FINMON_REFT.NAME_HASH IS '';




PROMPT *** Create  constraint CC_FINMONREFT_C1_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.FINMON_REFT MODIFY (C1 CONSTRAINT CC_FINMONREFT_C1_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XPK_FINMON_REFT ***
begin   
 execute immediate '
  ALTER TABLE BARS.FINMON_REFT ADD CONSTRAINT XPK_FINMON_REFT PRIMARY KEY (C1)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_FINMON_REFT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_FINMON_REFT ON BARS.FINMON_REFT (C1) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_FINMON_REFT_NAME_HASH ***
begin   
 execute immediate '
  CREATE INDEX BARS.I_FINMON_REFT_NAME_HASH ON BARS.FINMON_REFT (NAME_HASH) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/


PROMPT *** Create  index I_FINMON_REFT_NAME_�25 ***
begin   
 execute immediate '
  CREATE INDEX BARS.I_FINMON_REFT_NAME_�25 ON BARS.FINMON_REFT REGEXP_LIKE( c25, ''^([[:digit:]]{8}|[[:digit:]]{10})$'')
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/


PROMPT *** Create  grants  FINMON_REFT ***
grant SELECT                                                                 on FINMON_REFT     to BARSREADER_ROLE;
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on FINMON_REFT     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on FINMON_REFT     to BARS_DM;
grant ALTER,DEBUG,DELETE,FLASHBACK,INDEX,INSERT,ON COMMIT REFRESH,QUERY REWRITE,REFERENCES,SELECT,UPDATE on FINMON_REFT     to FINMON;
grant SELECT                                                                 on FINMON_REFT     to UPLD;



PROMPT *** Create SYNONYM  to FINMON_REFT ***

  CREATE OR REPLACE PUBLIC SYNONYM FINMON_REFT FOR BARS.FINMON_REFT;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/FINMON_REFT.sql =========*** End *** =
PROMPT ===================================================================================== 
