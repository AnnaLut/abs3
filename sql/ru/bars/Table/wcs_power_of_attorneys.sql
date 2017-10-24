

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/WCS_POWER_OF_ATTORNEYS.sql =========**
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to WCS_POWER_OF_ATTORNEYS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''WCS_POWER_OF_ATTORNEYS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_POWER_OF_ATTORNEYS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table WCS_POWER_OF_ATTORNEYS ***
begin 
  execute immediate '
  CREATE TABLE BARS.WCS_POWER_OF_ATTORNEYS 
   (	BRANCH VARCHAR2(30), 
	ORD NUMBER, 
	ACTIVE NUMBER, 
	FIO VARCHAR2(255), 
	FIO_R VARCHAR2(255), 
	POST VARCHAR2(255), 
	POST_R VARCHAR2(255), 
	POA_DOC VARCHAR2(255), 
	POA_DATE DATE, 
	POA_NOTARY VARCHAR2(255), 
	POA_NOTARY_NUM VARCHAR2(255), 
	BRANCH_ADR VARCHAR2(255), 
	BRANCH_LOC VARCHAR2(255), 
	BRANCH_NAME VARCHAR2(255), 
	POA_CERT DATE, 
	DISTRICT_NAME VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to WCS_POWER_OF_ATTORNEYS ***
 exec bpa.alter_policies('WCS_POWER_OF_ATTORNEYS');


COMMENT ON TABLE BARS.WCS_POWER_OF_ATTORNEYS IS '����� ����������� �� ��������� ��������� ��������';
COMMENT ON COLUMN BARS.WCS_POWER_OF_ATTORNEYS.DISTRICT_NAME IS '';
COMMENT ON COLUMN BARS.WCS_POWER_OF_ATTORNEYS.POA_CERT IS '';
COMMENT ON COLUMN BARS.WCS_POWER_OF_ATTORNEYS.BRANCH IS '��� ��������';
COMMENT ON COLUMN BARS.WCS_POWER_OF_ATTORNEYS.ORD IS '�������';
COMMENT ON COLUMN BARS.WCS_POWER_OF_ATTORNEYS.ACTIVE IS '���� ���������';
COMMENT ON COLUMN BARS.WCS_POWER_OF_ATTORNEYS.FIO IS '��� ���������';
COMMENT ON COLUMN BARS.WCS_POWER_OF_ATTORNEYS.FIO_R IS '��� ��������� (���������) � ���. ���.';
COMMENT ON COLUMN BARS.WCS_POWER_OF_ATTORNEYS.POST IS '������ ���������';
COMMENT ON COLUMN BARS.WCS_POWER_OF_ATTORNEYS.POST_R IS '������ ��������� � ���. ���.';
COMMENT ON COLUMN BARS.WCS_POWER_OF_ATTORNEYS.POA_DOC IS '�������� �� ��������� ������������ � �������� ������ � �������� �����';
COMMENT ON COLUMN BARS.WCS_POWER_OF_ATTORNEYS.POA_DATE IS '���� ����������';
COMMENT ON COLUMN BARS.WCS_POWER_OF_ATTORNEYS.POA_NOTARY IS '������ �� Բ� �������� ���� �������� ��������� � �������� ������ � �������� �����';
COMMENT ON COLUMN BARS.WCS_POWER_OF_ATTORNEYS.POA_NOTARY_NUM IS '����� � ����� �������� ���� �������� ���������';
COMMENT ON COLUMN BARS.WCS_POWER_OF_ATTORNEYS.BRANCH_ADR IS '������ ��������';
COMMENT ON COLUMN BARS.WCS_POWER_OF_ATTORNEYS.BRANCH_LOC IS '��������� ����� ��������';
COMMENT ON COLUMN BARS.WCS_POWER_OF_ATTORNEYS.BRANCH_NAME IS '����� ��������, ��� ����� ��������';




PROMPT *** Create  constraint FK_WCSPWROFATTRNS_B_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_POWER_OF_ATTORNEYS ADD CONSTRAINT FK_WCSPWROFATTRNS_B_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_WCSPWROFATTRNS_ACTIVE ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_POWER_OF_ATTORNEYS ADD CONSTRAINT CC_WCSPWROFATTRNS_ACTIVE CHECK (active in (0, 1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_WCSPWROFATTRNS ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_POWER_OF_ATTORNEYS ADD CONSTRAINT PK_WCSPWROFATTRNS PRIMARY KEY (BRANCH, ORD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_WCSPWROFATTRNS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_WCSPWROFATTRNS ON BARS.WCS_POWER_OF_ATTORNEYS (BRANCH, ORD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  WCS_POWER_OF_ATTORNEYS ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on WCS_POWER_OF_ATTORNEYS to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on WCS_POWER_OF_ATTORNEYS to START1;
grant FLASHBACK,SELECT                                                       on WCS_POWER_OF_ATTORNEYS to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/WCS_POWER_OF_ATTORNEYS.sql =========**
PROMPT ===================================================================================== 
