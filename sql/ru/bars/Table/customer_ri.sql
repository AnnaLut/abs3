

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CUSTOMER_RI.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CUSTOMER_RI ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CUSTOMER_RI'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''CUSTOMER_RI'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CUSTOMER_RI ***
begin 
  execute immediate '
  CREATE TABLE BARS.CUSTOMER_RI 
   (	ID NUMBER, 
	IDCODE VARCHAR2(10), 
	DOCT NUMBER(2,0), 
	DOCS VARCHAR2(10), 
	DOCN VARCHAR2(10), 
	INSFORM NUMBER(1,0), 
	K060 NUMBER(2,0), 
	FILERI VARCHAR2(12), 
	DATERI DATE, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CUSTOMER_RI ***
 exec bpa.alter_policies('CUSTOMER_RI');


COMMENT ON TABLE BARS.CUSTOMER_RI IS '����� ��������� (� DBF)';
COMMENT ON COLUMN BARS.CUSTOMER_RI.ID IS '';
COMMENT ON COLUMN BARS.CUSTOMER_RI.IDCODE IS '��� �� ������/����';
COMMENT ON COLUMN BARS.CUSTOMER_RI.DOCT IS '��� ���������';
COMMENT ON COLUMN BARS.CUSTOMER_RI.DOCS IS '���� ���������';
COMMENT ON COLUMN BARS.CUSTOMER_RI.DOCN IS '����� ���������';
COMMENT ON COLUMN BARS.CUSTOMER_RI.INSFORM IS '������ �������� ������ ��������� (0-�,1-���)';
COMMENT ON COLUMN BARS.CUSTOMER_RI.K060 IS '��� ������ ���������';
COMMENT ON COLUMN BARS.CUSTOMER_RI.FILERI IS '����';
COMMENT ON COLUMN BARS.CUSTOMER_RI.DATERI IS '���� �����';
COMMENT ON COLUMN BARS.CUSTOMER_RI.KF IS '';




PROMPT *** Create  constraint PK_CUSTOMER_RI ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_RI ADD CONSTRAINT PK_CUSTOMER_RI PRIMARY KEY (KF, ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTOMERRI_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_RI MODIFY (KF CONSTRAINT CC_CUSTOMERRI_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index IX1_CUSTOMER_RI ***
begin   
 execute immediate '
  CREATE INDEX BARS.IX1_CUSTOMER_RI ON BARS.CUSTOMER_RI (IDCODE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CUSTOMER_RI ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CUSTOMER_RI ON BARS.CUSTOMER_RI (KF, ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index IX2_CUSTOMER_RI ***
begin   
 execute immediate '
  CREATE INDEX BARS.IX2_CUSTOMER_RI ON BARS.CUSTOMER_RI (DOCT, DOCS, DOCN) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CUSTOMER_RI ***
grant DELETE,INSERT,SELECT,UPDATE                                            on CUSTOMER_RI     to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CUSTOMER_RI     to TECH005;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CUSTOMER_RI.sql =========*** End *** =
PROMPT ===================================================================================== 
