

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/META_NSIFUNCTION.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to META_NSIFUNCTION ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''META_NSIFUNCTION'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''META_NSIFUNCTION'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''META_NSIFUNCTION'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table META_NSIFUNCTION ***
begin 
  execute immediate '
  CREATE TABLE BARS.META_NSIFUNCTION 
   (	TABID NUMBER(38,0), 
	FUNCID NUMBER(10,0), 
	DESCR VARCHAR2(100), 
	PROC_NAME VARCHAR2(254), 
	PROC_PAR VARCHAR2(254), 
	PROC_EXEC VARCHAR2(30), 
	QST VARCHAR2(254), 
	MSG VARCHAR2(254), 
	FORM_NAME VARCHAR2(254), 
	CHECK_FUNC VARCHAR2(254), 
	WEB_FORM_NAME VARCHAR2(508), 
	ICON_ID NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to META_NSIFUNCTION ***
 exec bpa.alter_policies('META_NSIFUNCTION');


COMMENT ON TABLE BARS.META_NSIFUNCTION IS '�������� �������, ����������� �� ������������';
COMMENT ON COLUMN BARS.META_NSIFUNCTION.WEB_FORM_NAME IS '������� WEB';
COMMENT ON COLUMN BARS.META_NSIFUNCTION.ICON_ID IS '��� ������ ��� ������';
COMMENT ON COLUMN BARS.META_NSIFUNCTION.TABID IS '��� �������';
COMMENT ON COLUMN BARS.META_NSIFUNCTION.FUNCID IS '��. ������� ��� ����������';
COMMENT ON COLUMN BARS.META_NSIFUNCTION.DESCR IS '�������� �������';
COMMENT ON COLUMN BARS.META_NSIFUNCTION.PROC_NAME IS 'Sql-��������� � �����������';
COMMENT ON COLUMN BARS.META_NSIFUNCTION.PROC_PAR IS '�������� ���������� ��� Sql-���������';
COMMENT ON COLUMN BARS.META_NSIFUNCTION.PROC_EXEC IS '�������� ��������� ���������';
COMMENT ON COLUMN BARS.META_NSIFUNCTION.QST IS '������ ����� �����������';
COMMENT ON COLUMN BARS.META_NSIFUNCTION.MSG IS '��������� ����� �������� ���������� ���������';
COMMENT ON COLUMN BARS.META_NSIFUNCTION.FORM_NAME IS '������� �������';
COMMENT ON COLUMN BARS.META_NSIFUNCTION.CHECK_FUNC IS '������� ��������';




PROMPT *** Create  constraint CC_METANSIFUNCTION_DESCR_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_NSIFUNCTION ADD CONSTRAINT CC_METANSIFUNCTION_DESCR_NN CHECK (descr is not null) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_METANSIFUNCTION_ICONID ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_NSIFUNCTION ADD CONSTRAINT FK_METANSIFUNCTION_ICONID FOREIGN KEY (ICON_ID)
	  REFERENCES BARS.META_ICONS (ICON_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_METANSIFUNCTION_METATABLES ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_NSIFUNCTION ADD CONSTRAINT FK_METANSIFUNCTION_METATABLES FOREIGN KEY (TABID)
	  REFERENCES BARS.META_TABLES (TABID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_METANSIFUNCTION ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_NSIFUNCTION ADD CONSTRAINT PK_METANSIFUNCTION PRIMARY KEY (TABID, FUNCID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_METANSIFUNCTION ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_METANSIFUNCTION ON BARS.META_NSIFUNCTION (TABID, FUNCID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  META_NSIFUNCTION ***
grant DELETE,INSERT,SELECT,UPDATE                                            on META_NSIFUNCTION to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on META_NSIFUNCTION to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on META_NSIFUNCTION to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/META_NSIFUNCTION.sql =========*** End 
PROMPT ===================================================================================== 
