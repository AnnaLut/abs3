

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CRKR_CA_TRANSFER.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CRKR_CA_TRANSFER ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CRKR_CA_TRANSFER'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CRKR_CA_TRANSFER'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CRKR_CA_TRANSFER ***
begin 
  execute immediate '
  CREATE TABLE BARS.CRKR_CA_TRANSFER 
   (	REG_ID NUMBER, 
	REF_ID NUMBER, 
	REG_DATE DATE DEFAULT sysdate, 
	AMOUNT NUMBER, 
	KV NUMBER(6,0), 
	MFO_CLIENT VARCHAR2(6), 
	NLS VARCHAR2(15), 
	TYPE_ID NUMBER, 
	OKPO VARCHAR2(10), 
	SER VARCHAR2(32), 
	DOCNUM VARCHAR2(20), 
	FIO VARCHAR2(100), 
	SECONDARY NUMBER(1,0), 
	SIGN RAW(2000), 
	DATE_KEY DATE, 
	STATE_ID NUMBER, 
	LAST_CHANGE DATE, 
	INFO VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CRKR_CA_TRANSFER ***
 exec bpa.alter_policies('CRKR_CA_TRANSFER');


COMMENT ON TABLE BARS.CRKR_CA_TRANSFER IS 'Переданий реєстр з ЦРКР для виплат';
COMMENT ON COLUMN BARS.CRKR_CA_TRANSFER.AMOUNT IS '';
COMMENT ON COLUMN BARS.CRKR_CA_TRANSFER.KV IS '';
COMMENT ON COLUMN BARS.CRKR_CA_TRANSFER.MFO_CLIENT IS '';
COMMENT ON COLUMN BARS.CRKR_CA_TRANSFER.NLS IS '';
COMMENT ON COLUMN BARS.CRKR_CA_TRANSFER.TYPE_ID IS '';
COMMENT ON COLUMN BARS.CRKR_CA_TRANSFER.OKPO IS '';
COMMENT ON COLUMN BARS.CRKR_CA_TRANSFER.SER IS '';
COMMENT ON COLUMN BARS.CRKR_CA_TRANSFER.DOCNUM IS '';
COMMENT ON COLUMN BARS.CRKR_CA_TRANSFER.FIO IS '';
COMMENT ON COLUMN BARS.CRKR_CA_TRANSFER.SECONDARY IS '';
COMMENT ON COLUMN BARS.CRKR_CA_TRANSFER.SIGN IS '';
COMMENT ON COLUMN BARS.CRKR_CA_TRANSFER.DATE_KEY IS '';
COMMENT ON COLUMN BARS.CRKR_CA_TRANSFER.STATE_ID IS '';
COMMENT ON COLUMN BARS.CRKR_CA_TRANSFER.LAST_CHANGE IS '';
COMMENT ON COLUMN BARS.CRKR_CA_TRANSFER.INFO IS '';
COMMENT ON COLUMN BARS.CRKR_CA_TRANSFER.REG_ID IS 'ІД реєстру в ЦРКР';
COMMENT ON COLUMN BARS.CRKR_CA_TRANSFER.REF_ID IS 'ІД документу';
COMMENT ON COLUMN BARS.CRKR_CA_TRANSFER.REG_DATE IS 'Дата створення запису';




PROMPT *** Create  constraint PK_CRKR_CA_TRANSFER ***
begin   
 execute immediate '
  ALTER TABLE BARS.CRKR_CA_TRANSFER ADD CONSTRAINT PK_CRKR_CA_TRANSFER PRIMARY KEY (REG_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CRKR_CA_TRANSFER ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CRKR_CA_TRANSFER ON BARS.CRKR_CA_TRANSFER (REG_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CRKR_CA_TRANSFER ***
grant SELECT                                                                 on CRKR_CA_TRANSFER to BARSREADER_ROLE;
grant INSERT,SELECT                                                          on CRKR_CA_TRANSFER to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CRKR_CA_TRANSFER to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CRKR_CA_TRANSFER.sql =========*** End 
PROMPT ===================================================================================== 
