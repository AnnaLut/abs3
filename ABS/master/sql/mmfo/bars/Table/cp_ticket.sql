

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CP_TICKET.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CP_TICKET ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CP_TICKET'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CP_TICKET'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CP_TICKET'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CP_TICKET ***
begin 
  execute immediate '
  CREATE TABLE BARS.CP_TICKET 
   (	REF NUMBER, 
	KOL NUMBER, 
	VIDDN VARCHAR2(4), 
	NTIK VARCHAR2(10), 
	DAT_UG DATE, 
	DAT_OPL DATE, 
	DAT_ROZ DATE, 
	DAT_KOM DATE, 
	MFOB VARCHAR2(6), 
	OKPOB VARCHAR2(10), 
	NLSB VARCHAR2(15), 
	NBB VARCHAR2(250), 
	BICB VARCHAR2(11), 
	MFOB_ VARCHAR2(6), 
	OKPOB_ VARCHAR2(10), 
	NLSB_ VARCHAR2(15), 
	NBB_ VARCHAR2(250)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CP_TICKET ***
 exec bpa.alter_policies('CP_TICKET');


COMMENT ON TABLE BARS.CP_TICKET IS '������� ������������ ������ ��';
COMMENT ON COLUMN BARS.CP_TICKET.REF IS 'REF ������� ������';
COMMENT ON COLUMN BARS.CP_TICKET.KOL IS '���������� �� � ������';
COMMENT ON COLUMN BARS.CP_TICKET.VIDDN IS '��������� ���� ������';
COMMENT ON COLUMN BARS.CP_TICKET.NTIK IS '����� ������';
COMMENT ON COLUMN BARS.CP_TICKET.DAT_UG IS '���� ���������� ������';
COMMENT ON COLUMN BARS.CP_TICKET.DAT_OPL IS '���� ������';
COMMENT ON COLUMN BARS.CP_TICKET.DAT_ROZ IS '���� ����������(�����������)';
COMMENT ON COLUMN BARS.CP_TICKET.DAT_KOM IS '���� ������ ������';
COMMENT ON COLUMN BARS.CP_TICKET.MFOB IS '��� ��������';
COMMENT ON COLUMN BARS.CP_TICKET.OKPOB IS '���� ��������';
COMMENT ON COLUMN BARS.CP_TICKET.NLSB IS '���. � ��������';
COMMENT ON COLUMN BARS.CP_TICKET.NBB IS '����� ��������';
COMMENT ON COLUMN BARS.CP_TICKET.BICB IS 'BIC �����-��������� ��������';
COMMENT ON COLUMN BARS.CP_TICKET.MFOB_ IS '��� �����������';
COMMENT ON COLUMN BARS.CP_TICKET.OKPOB_ IS '���� �����������';
COMMENT ON COLUMN BARS.CP_TICKET.NLSB_ IS '���. � �����������';
COMMENT ON COLUMN BARS.CP_TICKET.NBB_ IS '����� �����������';




PROMPT *** Create  constraint PK_CP_TICKET ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_TICKET ADD CONSTRAINT PK_CP_TICKET PRIMARY KEY (REF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CP_TICKET ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CP_TICKET ON BARS.CP_TICKET (REF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CP_TICKET ***
grant SELECT                                                                 on CP_TICKET       to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CP_TICKET       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CP_TICKET       to BARS_DM;
grant SELECT                                                                 on CP_TICKET       to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CP_TICKET.sql =========*** End *** ===
PROMPT ===================================================================================== 
