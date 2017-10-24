

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPT_INSIDERS.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPT_INSIDERS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPT_INSIDERS'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''DPT_INSIDERS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPT_INSIDERS ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPT_INSIDERS 
   (	OKPO VARCHAR2(10), 
	NAME VARCHAR2(70), 
	DOC_TYPE VARCHAR2(35), 
	DOC_NAME VARCHAR2(35), 
	DOC_ISSUE VARCHAR2(50), 
	DOC_DATE DATE, 
	DETAILS VARCHAR2(100)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPT_INSIDERS ***
 exec bpa.alter_policies('DPT_INSIDERS');


COMMENT ON TABLE BARS.DPT_INSIDERS IS '������� �볺��� - ��������� �����';
COMMENT ON COLUMN BARS.DPT_INSIDERS.OKPO IS '���������������� ��� �볺���';
COMMENT ON COLUMN BARS.DPT_INSIDERS.NAME IS 'ϲ�';
COMMENT ON COLUMN BARS.DPT_INSIDERS.DOC_TYPE IS '��� ���������';
COMMENT ON COLUMN BARS.DPT_INSIDERS.DOC_NAME IS '���� � ����� ���������';
COMMENT ON COLUMN BARS.DPT_INSIDERS.DOC_ISSUE IS '�����, �� ����� ��������';
COMMENT ON COLUMN BARS.DPT_INSIDERS.DOC_DATE IS '���� ������ ���������';
COMMENT ON COLUMN BARS.DPT_INSIDERS.DETAILS IS '�������';




PROMPT *** Create  constraint PK_DPTINSIDERS ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_INSIDERS ADD CONSTRAINT PK_DPTINSIDERS PRIMARY KEY (OKPO)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTINSIDERS_OKPO_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_INSIDERS MODIFY (OKPO CONSTRAINT CC_DPTINSIDERS_OKPO_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DPTINSIDERS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DPTINSIDERS ON BARS.DPT_INSIDERS (OKPO) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DPT_INSIDERS ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPT_INSIDERS    to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_INSIDERS    to DPT_ADMIN;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPT_INSIDERS    to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on DPT_INSIDERS    to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPT_INSIDERS.sql =========*** End *** 
PROMPT ===================================================================================== 
