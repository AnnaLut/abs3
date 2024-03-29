

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CONTRACTS_JOURNAL.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CONTRACTS_JOURNAL ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CONTRACTS_JOURNAL'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CONTRACTS_JOURNAL'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CONTRACTS_JOURNAL'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CONTRACTS_JOURNAL ***
begin 
  execute immediate '
  CREATE TABLE BARS.CONTRACTS_JOURNAL 
   (	DAT DATE, 
	USERID NUMBER, 
	ACTION_ID NUMBER, 
	IMPEXP NUMBER, 
	PID NUMBER, 
	ID NUMBER, 
	RNK NUMBER, 
	NAME VARCHAR2(50), 
	DATEOPEN DATE, 
	DATECLOSE DATE, 
	S NUMBER, 
	KV NUMBER, 
	BENEFCOUNTRY NUMBER, 
	BENEFNAME VARCHAR2(50), 
	CONTINUED VARCHAR2(80), 
	IDT NUMBER, 
	NAME_TD VARCHAR2(35), 
	DAT_TD DATE, 
	SUM_TD NUMBER, 
	KURS_TD NUMBER(30,8), 
	IDR NUMBER, 
	NAME_RSTR VARCHAR2(50), 
	DAT_RSTR DATE, 
	IDP NUMBER, 
	DAT_PL DATE, 
	SUM_PL NUMBER, 
	KURS_PL NUMBER(30,8), 
	KV_PL NUMBER, 
	CONTROL_DAYS NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CONTRACTS_JOURNAL ***
 exec bpa.alter_policies('CONTRACTS_JOURNAL');


COMMENT ON TABLE BARS.CONTRACTS_JOURNAL IS '������ ��������� �� ���-���� ����������';
COMMENT ON COLUMN BARS.CONTRACTS_JOURNAL.DAT IS '';
COMMENT ON COLUMN BARS.CONTRACTS_JOURNAL.USERID IS '';
COMMENT ON COLUMN BARS.CONTRACTS_JOURNAL.ACTION_ID IS '';
COMMENT ON COLUMN BARS.CONTRACTS_JOURNAL.IMPEXP IS '';
COMMENT ON COLUMN BARS.CONTRACTS_JOURNAL.PID IS '';
COMMENT ON COLUMN BARS.CONTRACTS_JOURNAL.ID IS '';
COMMENT ON COLUMN BARS.CONTRACTS_JOURNAL.RNK IS '';
COMMENT ON COLUMN BARS.CONTRACTS_JOURNAL.NAME IS '';
COMMENT ON COLUMN BARS.CONTRACTS_JOURNAL.DATEOPEN IS '';
COMMENT ON COLUMN BARS.CONTRACTS_JOURNAL.DATECLOSE IS '';
COMMENT ON COLUMN BARS.CONTRACTS_JOURNAL.S IS '';
COMMENT ON COLUMN BARS.CONTRACTS_JOURNAL.KV IS '';
COMMENT ON COLUMN BARS.CONTRACTS_JOURNAL.BENEFCOUNTRY IS '';
COMMENT ON COLUMN BARS.CONTRACTS_JOURNAL.BENEFNAME IS '';
COMMENT ON COLUMN BARS.CONTRACTS_JOURNAL.CONTINUED IS '';
COMMENT ON COLUMN BARS.CONTRACTS_JOURNAL.IDT IS '';
COMMENT ON COLUMN BARS.CONTRACTS_JOURNAL.NAME_TD IS '';
COMMENT ON COLUMN BARS.CONTRACTS_JOURNAL.DAT_TD IS '';
COMMENT ON COLUMN BARS.CONTRACTS_JOURNAL.SUM_TD IS '';
COMMENT ON COLUMN BARS.CONTRACTS_JOURNAL.KURS_TD IS '';
COMMENT ON COLUMN BARS.CONTRACTS_JOURNAL.IDR IS '';
COMMENT ON COLUMN BARS.CONTRACTS_JOURNAL.NAME_RSTR IS '';
COMMENT ON COLUMN BARS.CONTRACTS_JOURNAL.DAT_RSTR IS '';
COMMENT ON COLUMN BARS.CONTRACTS_JOURNAL.IDP IS '';
COMMENT ON COLUMN BARS.CONTRACTS_JOURNAL.DAT_PL IS '';
COMMENT ON COLUMN BARS.CONTRACTS_JOURNAL.SUM_PL IS '';
COMMENT ON COLUMN BARS.CONTRACTS_JOURNAL.KURS_PL IS '';
COMMENT ON COLUMN BARS.CONTRACTS_JOURNAL.KV_PL IS '';
COMMENT ON COLUMN BARS.CONTRACTS_JOURNAL.CONTROL_DAYS IS '';



PROMPT *** Create  grants  CONTRACTS_JOURNAL ***
grant SELECT                                                                 on CONTRACTS_JOURNAL to BARSREADER_ROLE;
grant SELECT                                                                 on CONTRACTS_JOURNAL to BARS_DM;
grant SELECT                                                                 on CONTRACTS_JOURNAL to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CONTRACTS_JOURNAL to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CONTRACTS_JOURNAL.sql =========*** End
PROMPT ===================================================================================== 
