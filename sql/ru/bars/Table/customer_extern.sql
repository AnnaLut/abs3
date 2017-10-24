

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CUSTOMER_EXTERN.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CUSTOMER_EXTERN ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CUSTOMER_EXTERN'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CUSTOMER_EXTERN'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CUSTOMER_EXTERN ***
begin 
  execute immediate '
  CREATE TABLE BARS.CUSTOMER_EXTERN 
   (	ID NUMBER(22,0), 
	NAME VARCHAR2(70), 
	DOC_TYPE NUMBER(22,0), 
	DOC_SERIAL VARCHAR2(30), 
	DOC_NUMBER VARCHAR2(22), 
	DOC_DATE DATE, 
	DOC_ISSUER VARCHAR2(70), 
	BIRTHDAY DATE, 
	BIRTHPLACE VARCHAR2(70), 
	SEX CHAR(1) DEFAULT ''0'', 
	ADR VARCHAR2(100), 
	TEL VARCHAR2(100), 
	EMAIL VARCHAR2(100), 
	CUSTTYPE NUMBER(1,0), 
	OKPO VARCHAR2(14), 
	COUNTRY NUMBER(3,0), 
	REGION VARCHAR2(2), 
	FS CHAR(2), 
	VED CHAR(5), 
	SED CHAR(4), 
	ISE CHAR(5), 
	NOTES VARCHAR2(80)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CUSTOMER_EXTERN ***
 exec bpa.alter_policies('CUSTOMER_EXTERN');


COMMENT ON TABLE BARS.CUSTOMER_EXTERN IS '�� ������� �����';
COMMENT ON COLUMN BARS.CUSTOMER_EXTERN.ID IS 'Id';
COMMENT ON COLUMN BARS.CUSTOMER_EXTERN.NAME IS '������������/���';
COMMENT ON COLUMN BARS.CUSTOMER_EXTERN.DOC_TYPE IS '��� ���������';
COMMENT ON COLUMN BARS.CUSTOMER_EXTERN.DOC_SERIAL IS '����� ���������';
COMMENT ON COLUMN BARS.CUSTOMER_EXTERN.DOC_NUMBER IS '����� ���������';
COMMENT ON COLUMN BARS.CUSTOMER_EXTERN.DOC_DATE IS '���� ������ ���������';
COMMENT ON COLUMN BARS.CUSTOMER_EXTERN.DOC_ISSUER IS '����� ������ ���������';
COMMENT ON COLUMN BARS.CUSTOMER_EXTERN.BIRTHDAY IS '���� ��������';
COMMENT ON COLUMN BARS.CUSTOMER_EXTERN.BIRTHPLACE IS '����� ��������';
COMMENT ON COLUMN BARS.CUSTOMER_EXTERN.SEX IS '';
COMMENT ON COLUMN BARS.CUSTOMER_EXTERN.ADR IS '�����';
COMMENT ON COLUMN BARS.CUSTOMER_EXTERN.TEL IS '�������';
COMMENT ON COLUMN BARS.CUSTOMER_EXTERN.EMAIL IS 'E_mail';
COMMENT ON COLUMN BARS.CUSTOMER_EXTERN.CUSTTYPE IS '������� (1-��, 2-��)';
COMMENT ON COLUMN BARS.CUSTOMER_EXTERN.OKPO IS '����';
COMMENT ON COLUMN BARS.CUSTOMER_EXTERN.COUNTRY IS '��� ������';
COMMENT ON COLUMN BARS.CUSTOMER_EXTERN.REGION IS '��� �������';
COMMENT ON COLUMN BARS.CUSTOMER_EXTERN.FS IS '����� ������������� (K081)';
COMMENT ON COLUMN BARS.CUSTOMER_EXTERN.VED IS '��� ��. ����-�� (K110)';
COMMENT ON COLUMN BARS.CUSTOMER_EXTERN.SED IS '���.-�������� ����� (K051)';
COMMENT ON COLUMN BARS.CUSTOMER_EXTERN.ISE IS '����. ������ ��������� (K070)';
COMMENT ON COLUMN BARS.CUSTOMER_EXTERN.NOTES IS '�����������';




PROMPT *** Create  constraint FK_CUSTOMEREXTERN_ISE ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_EXTERN ADD CONSTRAINT FK_CUSTOMEREXTERN_ISE FOREIGN KEY (ISE)
	  REFERENCES BARS.ISE (ISE) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CUSTOMEREXTERN_SED ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_EXTERN ADD CONSTRAINT FK_CUSTOMEREXTERN_SED FOREIGN KEY (SED)
	  REFERENCES BARS.SED (SED) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CUSTOMEREXTERN_VED ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_EXTERN ADD CONSTRAINT FK_CUSTOMEREXTERN_VED FOREIGN KEY (VED)
	  REFERENCES BARS.VED (VED) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CUSTOMEREXTERN_FS ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_EXTERN ADD CONSTRAINT FK_CUSTOMEREXTERN_FS FOREIGN KEY (FS)
	  REFERENCES BARS.FS (FS) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CUSTOMEREXTERN_COUNTRY ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_EXTERN ADD CONSTRAINT FK_CUSTOMEREXTERN_COUNTRY FOREIGN KEY (COUNTRY)
	  REFERENCES BARS.COUNTRY (COUNTRY) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CUSTOMEREXTERN_SEX ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_EXTERN ADD CONSTRAINT FK_CUSTOMEREXTERN_SEX FOREIGN KEY (SEX)
	  REFERENCES BARS.SEX (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CUSTOMEREXTERN_PASSP ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_EXTERN ADD CONSTRAINT FK_CUSTOMEREXTERN_PASSP FOREIGN KEY (DOC_TYPE)
	  REFERENCES BARS.PASSP (PASSP) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_CUSTOMEREXTERN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_EXTERN ADD CONSTRAINT PK_CUSTOMEREXTERN PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTOMEREXTERN_SEX_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_EXTERN MODIFY (SEX CONSTRAINT CC_CUSTOMEREXTERN_SEX_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTOMEREXTERN_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_EXTERN MODIFY (ID CONSTRAINT CC_CUSTOMEREXTERN_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CUSTOMEREXTERN ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CUSTOMEREXTERN ON BARS.CUSTOMER_EXTERN (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CUSTOMER_EXTERN ***
grant SELECT                                                                 on CUSTOMER_EXTERN to BARSUPL;
grant DELETE,INSERT,SELECT,UPDATE                                            on CUSTOMER_EXTERN to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CUSTOMER_EXTERN to BARS_SUP;
grant DELETE,INSERT,SELECT,UPDATE                                            on CUSTOMER_EXTERN to CUST001;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CUSTOMER_EXTERN to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to CUSTOMER_EXTERN ***

  CREATE OR REPLACE PUBLIC SYNONYM CUSTOMER_EXTERN FOR BARS.CUSTOMER_EXTERN;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CUSTOMER_EXTERN.sql =========*** End *
PROMPT ===================================================================================== 
