

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CIN_TAG_RNK.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CIN_TAG_RNK ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CIN_TAG_RNK'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CIN_TAG_RNK'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CIN_TAG_RNK'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CIN_TAG_RNK ***
begin 
  execute immediate '
  CREATE TABLE BARS.CIN_TAG_RNK 
   (	RNK NUMBER(*,0), 
	TAG CHAR(5), 
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




PROMPT *** ALTER_POLICIES to CIN_TAG_RNK ***
 exec bpa.alter_policies('CIN_TAG_RNK');


COMMENT ON TABLE BARS.CIN_TAG_RNK IS '';
COMMENT ON COLUMN BARS.CIN_TAG_RNK.RNK IS '';
COMMENT ON COLUMN BARS.CIN_TAG_RNK.TAG IS '';
COMMENT ON COLUMN BARS.CIN_TAG_RNK.PR_A1 IS '';
COMMENT ON COLUMN BARS.CIN_TAG_RNK.SK_A1 IS '';




PROMPT *** Create  constraint XPK_CINTAGRNK ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIN_TAG_RNK ADD CONSTRAINT XPK_CINTAGRNK PRIMARY KEY (RNK, TAG)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006682 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIN_TAG_RNK MODIFY (TAG NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006683 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIN_TAG_RNK MODIFY (PR_A1 NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_CINTAGRNK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_CINTAGRNK ON BARS.CIN_TAG_RNK (RNK, TAG) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CIN_TAG_RNK ***
grant SELECT                                                                 on CIN_TAG_RNK     to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CIN_TAG_RNK     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CIN_TAG_RNK     to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CIN_TAG_RNK     to PYOD001;
grant SELECT                                                                 on CIN_TAG_RNK     to UPLD;
grant FLASHBACK,SELECT                                                       on CIN_TAG_RNK     to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CIN_TAG_RNK.sql =========*** End *** =
PROMPT ===================================================================================== 
