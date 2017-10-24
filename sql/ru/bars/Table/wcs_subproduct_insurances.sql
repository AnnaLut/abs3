

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/WCS_SUBPRODUCT_INSURANCES.sql ========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to WCS_SUBPRODUCT_INSURANCES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''WCS_SUBPRODUCT_INSURANCES'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_SUBPRODUCT_INSURANCES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table WCS_SUBPRODUCT_INSURANCES ***
begin 
  execute immediate '
  CREATE TABLE BARS.WCS_SUBPRODUCT_INSURANCES 
   (	SUBPRODUCT_ID VARCHAR2(100), 
	INSURANCE_ID VARCHAR2(100), 
	IS_REQUIRED NUMBER DEFAULT 1, 
	ORD NUMBER, 
	WS_ID VARCHAR2(100) DEFAULT ''MAIN''
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to WCS_SUBPRODUCT_INSURANCES ***
 exec bpa.alter_policies('WCS_SUBPRODUCT_INSURANCES');


COMMENT ON TABLE BARS.WCS_SUBPRODUCT_INSURANCES IS '�������� ��������� � �������� (��������� ��������)';
COMMENT ON COLUMN BARS.WCS_SUBPRODUCT_INSURANCES.SUBPRODUCT_ID IS '������������� �����������';
COMMENT ON COLUMN BARS.WCS_SUBPRODUCT_INSURANCES.INSURANCE_ID IS '������������� ���� ���������';
COMMENT ON COLUMN BARS.WCS_SUBPRODUCT_INSURANCES.IS_REQUIRED IS '����������� �� ��� ����������';
COMMENT ON COLUMN BARS.WCS_SUBPRODUCT_INSURANCES.ORD IS '�������';
COMMENT ON COLUMN BARS.WCS_SUBPRODUCT_INSURANCES.WS_ID IS '������������� �������� ������������';




PROMPT *** Create  constraint FK_SBPINS_WSID_WS_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SUBPRODUCT_INSURANCES ADD CONSTRAINT FK_SBPINS_WSID_WS_ID FOREIGN KEY (WS_ID)
	  REFERENCES BARS.WCS_WORKSPACES (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SBPINS_SBPID_SBPS_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SUBPRODUCT_INSURANCES ADD CONSTRAINT FK_SBPINS_SBPID_SBPS_ID FOREIGN KEY (SUBPRODUCT_ID)
	  REFERENCES BARS.WCS_SUBPRODUCTS (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SBPINS_INSID_WCSINS_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SUBPRODUCT_INSURANCES ADD CONSTRAINT FK_SBPINS_INSID_WCSINS_ID FOREIGN KEY (INSURANCE_ID)
	  REFERENCES BARS.WCS_INSURANCES (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SBPINS_WSID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SUBPRODUCT_INSURANCES ADD CONSTRAINT CC_SBPINS_WSID_NN CHECK (WS_ID IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SBPINS_REQUIRED ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SUBPRODUCT_INSURANCES ADD CONSTRAINT CC_SBPINS_REQUIRED CHECK (is_required in (0, 1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_SBPINS ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SUBPRODUCT_INSURANCES ADD CONSTRAINT PK_SBPINS PRIMARY KEY (SUBPRODUCT_ID, INSURANCE_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003177324 ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SUBPRODUCT_INSURANCES MODIFY (INSURANCE_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003177323 ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SUBPRODUCT_INSURANCES MODIFY (SUBPRODUCT_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SBPINS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SBPINS ON BARS.WCS_SUBPRODUCT_INSURANCES (SUBPRODUCT_ID, INSURANCE_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  WCS_SUBPRODUCT_INSURANCES ***
grant SELECT                                                                 on WCS_SUBPRODUCT_INSURANCES to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/WCS_SUBPRODUCT_INSURANCES.sql ========
PROMPT ===================================================================================== 
