

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CIN_CUST.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CIN_CUST ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CIN_CUST'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CIN_CUST'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CIN_CUST'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CIN_CUST ***
begin 
  execute immediate '
  CREATE TABLE BARS.CIN_CUST 
   (	RNK NUMBER(*,0), 
	MFO_2600 VARCHAR2(12), 
	NLS_2600 VARCHAR2(14), 
	NLS_2909 VARCHAR2(14), 
	S_A2 NUMBER DEFAULT 0, 
	S_B2 NUMBER DEFAULT 0, 
	PR_B1 NUMBER DEFAULT 0, 
	S_C0 NUMBER, 
	NLS_3739 VARCHAR2(14), 
	DAPP DATE, 
	PA1 NUMBER, 
	PA2 NUMBER, 
	PB1 NUMBER, 
	PB2 NUMBER, 
	PC0 NUMBER, 
	TXT1 VARCHAR2(100), 
	TXT2 VARCHAR2(100), 
	TXT3 VARCHAR2(100), 
	TXT4 VARCHAR2(100), 
	TXT5 VARCHAR2(100), 
	TXT6 VARCHAR2(100), 
	SB1_MIN NUMBER, 
	NLS_3578 VARCHAR2(15), 
	S_B3 NUMBER DEFAULT 0
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CIN_CUST ***
 exec bpa.alter_policies('CIN_CUST');


COMMENT ON TABLE BARS.CIN_CUST IS '';
COMMENT ON COLUMN BARS.CIN_CUST.RNK IS '';
COMMENT ON COLUMN BARS.CIN_CUST.MFO_2600 IS '';
COMMENT ON COLUMN BARS.CIN_CUST.NLS_2600 IS '';
COMMENT ON COLUMN BARS.CIN_CUST.NLS_2909 IS '';
COMMENT ON COLUMN BARS.CIN_CUST.S_A2 IS '';
COMMENT ON COLUMN BARS.CIN_CUST.S_B2 IS '';
COMMENT ON COLUMN BARS.CIN_CUST.PR_B1 IS '';
COMMENT ON COLUMN BARS.CIN_CUST.S_C0 IS '';
COMMENT ON COLUMN BARS.CIN_CUST.NLS_3739 IS '';
COMMENT ON COLUMN BARS.CIN_CUST.DAPP IS '';
COMMENT ON COLUMN BARS.CIN_CUST.PA1 IS '';
COMMENT ON COLUMN BARS.CIN_CUST.PA2 IS '';
COMMENT ON COLUMN BARS.CIN_CUST.PB1 IS '';
COMMENT ON COLUMN BARS.CIN_CUST.PB2 IS '';
COMMENT ON COLUMN BARS.CIN_CUST.PC0 IS '';
COMMENT ON COLUMN BARS.CIN_CUST.TXT1 IS '';
COMMENT ON COLUMN BARS.CIN_CUST.TXT2 IS '';
COMMENT ON COLUMN BARS.CIN_CUST.TXT3 IS '';
COMMENT ON COLUMN BARS.CIN_CUST.TXT4 IS '';
COMMENT ON COLUMN BARS.CIN_CUST.TXT5 IS '';
COMMENT ON COLUMN BARS.CIN_CUST.TXT6 IS '';
COMMENT ON COLUMN BARS.CIN_CUST.SB1_MIN IS 'Б1~Min.сума~за мiсяць';
COMMENT ON COLUMN BARS.CIN_CUST.NLS_3578 IS '';
COMMENT ON COLUMN BARS.CIN_CUST.S_B3 IS 'Б3~Штраф за холостий виїзд(по Кл)';




PROMPT *** Create  constraint XPK_CINCUST ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIN_CUST ADD CONSTRAINT XPK_CINCUST PRIMARY KEY (RNK)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005255 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIN_CUST MODIFY (RNK NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005256 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIN_CUST MODIFY (MFO_2600 NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005257 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIN_CUST MODIFY (NLS_2600 NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005258 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIN_CUST MODIFY (NLS_2909 NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005259 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIN_CUST MODIFY (S_A2 NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005260 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIN_CUST MODIFY (S_B2 NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005261 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIN_CUST MODIFY (PR_B1 NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005262 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIN_CUST MODIFY (S_B3 NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_CINCUST ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_CINCUST ON BARS.CIN_CUST (RNK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CIN_CUST ***
grant SELECT                                                                 on CIN_CUST        to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CIN_CUST        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CIN_CUST        to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CIN_CUST        to PYOD001;
grant DELETE,INSERT,SELECT,UPDATE                                            on CIN_CUST        to START1;
grant SELECT                                                                 on CIN_CUST        to UPLD;
grant FLASHBACK,SELECT                                                       on CIN_CUST        to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CIN_CUST.sql =========*** End *** ====
PROMPT ===================================================================================== 
