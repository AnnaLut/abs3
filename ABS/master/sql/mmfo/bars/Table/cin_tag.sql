

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CIN_TAG.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CIN_TAG ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CIN_TAG'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CIN_TAG'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CIN_TAG'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CIN_TAG ***
begin 
  execute immediate '
  CREATE TABLE BARS.CIN_TAG 
   (	TAG CHAR(5), 
	NAME VARCHAR2(35), 
	NOM NUMBER, 
	KOL NUMBER(*,0), 
	PR_A1 NUMBER DEFAULT 0, 
	SK_A1 NUMBER(19,2)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CIN_TAG ***
 exec bpa.alter_policies('CIN_TAG');


COMMENT ON TABLE BARS.CIN_TAG IS '';
COMMENT ON COLUMN BARS.CIN_TAG.TAG IS '';
COMMENT ON COLUMN BARS.CIN_TAG.NAME IS '';
COMMENT ON COLUMN BARS.CIN_TAG.NOM IS '';
COMMENT ON COLUMN BARS.CIN_TAG.KOL IS '';
COMMENT ON COLUMN BARS.CIN_TAG.PR_A1 IS '';
COMMENT ON COLUMN BARS.CIN_TAG.SK_A1 IS '';




PROMPT *** Create  constraint XPK_CINTAG ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIN_TAG ADD CONSTRAINT XPK_CINTAG PRIMARY KEY (TAG)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009776 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIN_TAG MODIFY (TAG NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009777 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIN_TAG MODIFY (NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009778 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIN_TAG MODIFY (NOM NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009779 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIN_TAG MODIFY (KOL NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009780 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIN_TAG MODIFY (PR_A1 NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_CINTAG ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_CINTAG ON BARS.CIN_TAG (TAG) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CIN_TAG ***
grant SELECT                                                                 on CIN_TAG         to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CIN_TAG         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CIN_TAG         to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CIN_TAG         to PYOD001;
grant SELECT                                                                 on CIN_TAG         to UPLD;
grant FLASHBACK,SELECT                                                       on CIN_TAG         to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CIN_TAG.sql =========*** End *** =====
PROMPT ===================================================================================== 
