

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CIN_TK.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CIN_TK ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CIN_TK'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CIN_TK'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CIN_TK'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CIN_TK ***
begin 
  execute immediate '
  CREATE TABLE BARS.CIN_TK 
   (	ID NUMBER(*,0), 
	RNK NUMBER(*,0), 
	MFO VARCHAR2(12), 
	NLS VARCHAR2(14), 
	S_A2 NUMBER, 
	NLSR VARCHAR2(14), 
	S_B2 NUMBER, 
	NAME VARCHAR2(38), 
	PR_B1 NUMBER DEFAULT 0, 
	S_C0 NUMBER, 
	BRANCH VARCHAR2(22), 
	SB1_MIN NUMBER, 
	KORR NUMBER(*,0), 
	S_B3 NUMBER DEFAULT 0
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CIN_TK ***
 exec bpa.alter_policies('CIN_TK');


COMMENT ON TABLE BARS.CIN_TK IS '';
COMMENT ON COLUMN BARS.CIN_TK.ID IS '';
COMMENT ON COLUMN BARS.CIN_TK.RNK IS '';
COMMENT ON COLUMN BARS.CIN_TK.MFO IS '';
COMMENT ON COLUMN BARS.CIN_TK.NLS IS '';
COMMENT ON COLUMN BARS.CIN_TK.S_A2 IS '';
COMMENT ON COLUMN BARS.CIN_TK.NLSR IS '';
COMMENT ON COLUMN BARS.CIN_TK.S_B2 IS '';
COMMENT ON COLUMN BARS.CIN_TK.NAME IS '';
COMMENT ON COLUMN BARS.CIN_TK.PR_B1 IS '';
COMMENT ON COLUMN BARS.CIN_TK.S_C0 IS '';
COMMENT ON COLUMN BARS.CIN_TK.BRANCH IS '';
COMMENT ON COLUMN BARS.CIN_TK.SB1_MIN IS 'Б1~Min.сума~за мiсяць';
COMMENT ON COLUMN BARS.CIN_TK.KORR IS '';
COMMENT ON COLUMN BARS.CIN_TK.S_B3 IS 'Б3~Штраф за холостий виїзд(по TК)';




PROMPT *** Create  constraint SYS_C006106 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIN_TK MODIFY (RNK NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XPK_CINTK ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIN_TK ADD CONSTRAINT XPK_CINTK PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006107 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIN_TK MODIFY (MFO NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006108 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIN_TK MODIFY (NLS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006109 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIN_TK MODIFY (NLSR NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006110 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIN_TK MODIFY (PR_B1 NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006111 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIN_TK MODIFY (S_B3 NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_CINTK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_CINTK ON BARS.CIN_TK (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CIN_TK ***
grant SELECT                                                                 on CIN_TK          to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CIN_TK          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CIN_TK          to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CIN_TK          to PYOD001;
grant DELETE,INSERT,SELECT,UPDATE                                            on CIN_TK          to START1;
grant SELECT                                                                 on CIN_TK          to UPLD;
grant FLASHBACK,SELECT                                                       on CIN_TK          to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CIN_TK.sql =========*** End *** ======
PROMPT ===================================================================================== 
