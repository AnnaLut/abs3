

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CM_SALARY.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CM_SALARY ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CM_SALARY'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CM_SALARY'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CM_SALARY ***
begin 
  execute immediate '
  CREATE TABLE BARS.CM_SALARY 
   (	ID NUMBER(22,0), 
	OKPO VARCHAR2(14), 
	OKPO_N NUMBER(22,0), 
	ORG_NAME VARCHAR2(100), 
	PRODUCT_CODE VARCHAR2(32), 
	CHG_DATE DATE DEFAULT sysdate, 
	CHG_USER VARCHAR2(64) DEFAULT user, 
	ORG_MFO VARCHAR2(6), 
	ORG_NLS VARCHAR2(14)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CM_SALARY ***
 exec bpa.alter_policies('CM_SALARY');


COMMENT ON TABLE BARS.CM_SALARY IS 'CardMake. ��������� ���������� ��������';
COMMENT ON COLUMN BARS.CM_SALARY.ORG_MFO IS '���, � ���. ������ ���� �����������';
COMMENT ON COLUMN BARS.CM_SALARY.ORG_NLS IS '���� �����������';
COMMENT ON COLUMN BARS.CM_SALARY.ID IS '���������� �������������';
COMMENT ON COLUMN BARS.CM_SALARY.OKPO IS '��� ������';
COMMENT ON COLUMN BARS.CM_SALARY.OKPO_N IS '��� ����������� ������ ������';
COMMENT ON COLUMN BARS.CM_SALARY.ORG_NAME IS '�������� �����������';
COMMENT ON COLUMN BARS.CM_SALARY.PRODUCT_CODE IS '��� �������� (�������� ��. ���������� � ��� ��)';
COMMENT ON COLUMN BARS.CM_SALARY.CHG_DATE IS '';
COMMENT ON COLUMN BARS.CM_SALARY.CHG_USER IS '';




PROMPT *** Create  constraint PK_CMSALARY ***
begin   
 execute immediate '
  ALTER TABLE BARS.CM_SALARY ADD CONSTRAINT PK_CMSALARY PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CMSALARY ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CMSALARY ON BARS.CM_SALARY (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CM_SALARY ***
grant SELECT                                                                 on CM_SALARY       to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CM_SALARY       to CM_ACCESS_ROLE;
grant SELECT                                                                 on CM_SALARY       to OW;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CM_SALARY.sql =========*** End *** ===
PROMPT ===================================================================================== 
