

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ANB1.sql =========*** Run *** ========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ANB1 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ANB1'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''ANB1'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ANB1'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ANB1 ***
begin 
  execute immediate '
  CREATE TABLE BARS.ANB1 
   (	ID CHAR(4), 
	NAME VARCHAR2(40), 
	V0 NUMBER, 
	G0 NUMBER, 
	V1 NUMBER, 
	G1 NUMBER, 
	V2 NUMBER, 
	G2 NUMBER, 
	V12 NUMBER, 
	G12 NUMBER, 
	NREP NUMBER(*,0), 
	D0 DATE, 
	D1 DATE, 
	D2 DATE, 
	D12 DATE, 
	D3 DATE, 
	D4 DATE, 
	D5 DATE, 
	D6 DATE, 
	D7 DATE, 
	D8 DATE, 
	D9 DATE, 
	D10 DATE, 
	D11 DATE, 
	V3 NUMBER, 
	V4 NUMBER, 
	V5 NUMBER, 
	V6 NUMBER, 
	V7 NUMBER, 
	V8 NUMBER, 
	V9 NUMBER, 
	V10 NUMBER, 
	V11 NUMBER, 
	G3 NUMBER, 
	G4 NUMBER, 
	G5 NUMBER, 
	G6 NUMBER, 
	G7 NUMBER, 
	G8 NUMBER, 
	G9 NUMBER, 
	G10 NUMBER, 
	G11 NUMBER, 
	N0 NUMBER, 
	SID VARCHAR2(8), 
	PR_99 NUMBER(*,0), 
	PR_SR NUMBER(*,0), 
	PR_AU NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ANB1 ***
 exec bpa.alter_policies('ANB1');


COMMENT ON TABLE BARS.ANB1 IS 'Структура управл_нського обл_ку';
COMMENT ON COLUMN BARS.ANB1.ID IS 'Код';
COMMENT ON COLUMN BARS.ANB1.NAME IS 'Наименование';
COMMENT ON COLUMN BARS.ANB1.V0 IS '';
COMMENT ON COLUMN BARS.ANB1.G0 IS '';
COMMENT ON COLUMN BARS.ANB1.V1 IS '';
COMMENT ON COLUMN BARS.ANB1.G1 IS '';
COMMENT ON COLUMN BARS.ANB1.V2 IS '';
COMMENT ON COLUMN BARS.ANB1.G2 IS '';
COMMENT ON COLUMN BARS.ANB1.V12 IS '';
COMMENT ON COLUMN BARS.ANB1.G12 IS '';
COMMENT ON COLUMN BARS.ANB1.NREP IS '';
COMMENT ON COLUMN BARS.ANB1.D0 IS '';
COMMENT ON COLUMN BARS.ANB1.D1 IS '';
COMMENT ON COLUMN BARS.ANB1.D2 IS '';
COMMENT ON COLUMN BARS.ANB1.D12 IS '';
COMMENT ON COLUMN BARS.ANB1.D3 IS '';
COMMENT ON COLUMN BARS.ANB1.D4 IS '';
COMMENT ON COLUMN BARS.ANB1.D5 IS '';
COMMENT ON COLUMN BARS.ANB1.D6 IS '';
COMMENT ON COLUMN BARS.ANB1.D7 IS '';
COMMENT ON COLUMN BARS.ANB1.D8 IS '';
COMMENT ON COLUMN BARS.ANB1.D9 IS '';
COMMENT ON COLUMN BARS.ANB1.D10 IS '';
COMMENT ON COLUMN BARS.ANB1.D11 IS '';
COMMENT ON COLUMN BARS.ANB1.V3 IS '';
COMMENT ON COLUMN BARS.ANB1.V4 IS '';
COMMENT ON COLUMN BARS.ANB1.V5 IS '';
COMMENT ON COLUMN BARS.ANB1.V6 IS '';
COMMENT ON COLUMN BARS.ANB1.V7 IS '';
COMMENT ON COLUMN BARS.ANB1.V8 IS '';
COMMENT ON COLUMN BARS.ANB1.V9 IS '';
COMMENT ON COLUMN BARS.ANB1.V10 IS '';
COMMENT ON COLUMN BARS.ANB1.V11 IS '';
COMMENT ON COLUMN BARS.ANB1.G3 IS '';
COMMENT ON COLUMN BARS.ANB1.G4 IS '';
COMMENT ON COLUMN BARS.ANB1.G5 IS '';
COMMENT ON COLUMN BARS.ANB1.G6 IS '';
COMMENT ON COLUMN BARS.ANB1.G7 IS '';
COMMENT ON COLUMN BARS.ANB1.G8 IS '';
COMMENT ON COLUMN BARS.ANB1.G9 IS '';
COMMENT ON COLUMN BARS.ANB1.G10 IS '';
COMMENT ON COLUMN BARS.ANB1.G11 IS '';
COMMENT ON COLUMN BARS.ANB1.N0 IS '';
COMMENT ON COLUMN BARS.ANB1.SID IS '';
COMMENT ON COLUMN BARS.ANB1.PR_99 IS '';
COMMENT ON COLUMN BARS.ANB1.PR_SR IS '';
COMMENT ON COLUMN BARS.ANB1.PR_AU IS '';




PROMPT *** Create  constraint XPK_ANB1 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ANB1 ADD CONSTRAINT XPK_ANB1 PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ANB1_NREP ***
begin   
 execute immediate '
  ALTER TABLE BARS.ANB1 ADD CONSTRAINT FK_ANB1_NREP FOREIGN KEY (NREP)
	  REFERENCES BARS.ANB0 (NREP) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006664 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ANB1 MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_ANB1 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_ANB1 ON BARS.ANB1 (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ANB1 ***
grant DELETE,INSERT,SELECT,UPDATE                                            on ANB1            to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ANB1            to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on ANB1            to RPBN001;
grant SELECT                                                                 on ANB1            to SALGL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on ANB1            to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ANB1.sql =========*** End *** ========
PROMPT ===================================================================================== 
