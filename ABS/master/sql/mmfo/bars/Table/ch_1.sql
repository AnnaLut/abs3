

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CH_1.sql =========*** Run *** ========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CH_1 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CH_1'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CH_1'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CH_1'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CH_1 ***
begin 
  execute immediate '
  CREATE TABLE BARS.CH_1 
   (	ID NUMBER(*,0), 
	FDAT DATE, 
	ND VARCHAR2(40), 
	S NUMBER, 
	KV NUMBER(*,0), 
	MFO VARCHAR2(12), 
	NLS VARCHAR2(15), 
	IDS NUMBER(*,0), 
	OKPO VARCHAR2(10), 
	BIC_E VARCHAR2(11), 
	FIO VARCHAR2(70), 
	KOL NUMBER(*,0), 
	NOM NUMBER, 
	SOS NUMBER(*,0), 
	TOBO VARCHAR2(30), 
	REF1 NUMBER(*,0), 
	REF2 NUMBER(*,0), 
	REF3 NUMBER(*,0), 
	REF4 NUMBER(*,0), 
	REF5 NUMBER(*,0), 
	REF6 NUMBER(*,0), 
	MFOA VARCHAR2(12)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CH_1 ***
 exec bpa.alter_policies('CH_1');


COMMENT ON TABLE BARS.CH_1 IS '';
COMMENT ON COLUMN BARS.CH_1.ID IS '';
COMMENT ON COLUMN BARS.CH_1.FDAT IS '';
COMMENT ON COLUMN BARS.CH_1.ND IS '';
COMMENT ON COLUMN BARS.CH_1.S IS '';
COMMENT ON COLUMN BARS.CH_1.KV IS '';
COMMENT ON COLUMN BARS.CH_1.MFO IS '';
COMMENT ON COLUMN BARS.CH_1.NLS IS '';
COMMENT ON COLUMN BARS.CH_1.IDS IS '';
COMMENT ON COLUMN BARS.CH_1.OKPO IS '';
COMMENT ON COLUMN BARS.CH_1.BIC_E IS '';
COMMENT ON COLUMN BARS.CH_1.FIO IS '';
COMMENT ON COLUMN BARS.CH_1.KOL IS '';
COMMENT ON COLUMN BARS.CH_1.NOM IS '';
COMMENT ON COLUMN BARS.CH_1.SOS IS '';
COMMENT ON COLUMN BARS.CH_1.TOBO IS '';
COMMENT ON COLUMN BARS.CH_1.REF1 IS '';
COMMENT ON COLUMN BARS.CH_1.REF2 IS '';
COMMENT ON COLUMN BARS.CH_1.REF3 IS '';
COMMENT ON COLUMN BARS.CH_1.REF4 IS '';
COMMENT ON COLUMN BARS.CH_1.REF5 IS '';
COMMENT ON COLUMN BARS.CH_1.REF6 IS '';
COMMENT ON COLUMN BARS.CH_1.MFOA IS '';




PROMPT *** Create  constraint PK_CH_1 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CH_1 ADD CONSTRAINT PK_CH_1 PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CH_1_MFOA ***
begin   
 execute immediate '
  ALTER TABLE BARS.CH_1 ADD CONSTRAINT FK_CH_1_MFOA FOREIGN KEY (MFOA)
	  REFERENCES BARS.CH_1A (MFOA) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CH_1 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CH_1 ADD CONSTRAINT FK_CH_1 FOREIGN KEY (IDS)
	  REFERENCES BARS.CH_1S (IDS) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CH_1 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CH_1 ON BARS.CH_1 (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CH_1 ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CH_1            to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CH_1            to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CH_1            to RCH_1;
grant DELETE,INSERT,SELECT,UPDATE                                            on CH_1            to START1;
grant FLASHBACK,SELECT                                                       on CH_1            to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CH_1.sql =========*** End *** ========
PROMPT ===================================================================================== 
