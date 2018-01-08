

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/MWAY_MATCH.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to MWAY_MATCH ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''MWAY_MATCH'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''MWAY_MATCH'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''MWAY_MATCH'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table MWAY_MATCH ***
begin 
  execute immediate '
  CREATE TABLE BARS.MWAY_MATCH 
   (	ID NUMBER, 
	DATE_TR DATE, 
	SUM_TR NUMBER(*,0), 
	LCV_TR VARCHAR2(3), 
	NLS_TR VARCHAR2(15), 
	RRN_TR VARCHAR2(100), 
	DRN_TR VARCHAR2(100), 
	STATE NUMBER, 
	REF_TR NUMBER(38,0), 
	REF_FEE_TR NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYNI ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to MWAY_MATCH ***
 exec bpa.alter_policies('MWAY_MATCH');


COMMENT ON TABLE BARS.MWAY_MATCH IS '������� �������� � �����-����� WAY4';
COMMENT ON COLUMN BARS.MWAY_MATCH.SUM_TR IS '���� ����������';
COMMENT ON COLUMN BARS.MWAY_MATCH.LCV_TR IS '������ ����������';
COMMENT ON COLUMN BARS.MWAY_MATCH.NLS_TR IS '����� ������� �볺���';
COMMENT ON COLUMN BARS.MWAY_MATCH.RRN_TR IS '��� ���';
COMMENT ON COLUMN BARS.MWAY_MATCH.DRN_TR IS '��� ���';
COMMENT ON COLUMN BARS.MWAY_MATCH.STATE IS '������';
COMMENT ON COLUMN BARS.MWAY_MATCH.REF_TR IS '';
COMMENT ON COLUMN BARS.MWAY_MATCH.REF_FEE_TR IS '';
COMMENT ON COLUMN BARS.MWAY_MATCH.ID IS '��. �����';
COMMENT ON COLUMN BARS.MWAY_MATCH.DATE_TR IS '���� ����������';




PROMPT *** Create  constraint SYS_C0035373 ***
begin   
 execute immediate '
  ALTER TABLE BARS.MWAY_MATCH ADD PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_MWAYMATCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.MWAY_MATCH ADD CONSTRAINT UK_MWAYMATCH UNIQUE (REF_TR)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_MWAYMATCH ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_MWAYMATCH ON BARS.MWAY_MATCH (REF_TR) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index SYS_C0035373 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.SYS_C0035373 ON BARS.MWAY_MATCH (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  MWAY_MATCH ***
grant SELECT                                                                 on MWAY_MATCH      to BARSREADER_ROLE;
grant SELECT                                                                 on MWAY_MATCH      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on MWAY_MATCH      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/MWAY_MATCH.sql =========*** End *** ==
PROMPT ===================================================================================== 
