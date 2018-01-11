

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CIN_TAG_TK.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CIN_TAG_TK ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CIN_TAG_TK'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CIN_TAG_TK'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CIN_TAG_TK'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CIN_TAG_TK ***
begin 
  execute immediate '
  CREATE TABLE BARS.CIN_TAG_TK 
   (	RNK NUMBER(*,0), 
	TK NUMBER(*,0), 
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




PROMPT *** ALTER_POLICIES to CIN_TAG_TK ***
 exec bpa.alter_policies('CIN_TAG_TK');


COMMENT ON TABLE BARS.CIN_TAG_TK IS '';
COMMENT ON COLUMN BARS.CIN_TAG_TK.RNK IS '';
COMMENT ON COLUMN BARS.CIN_TAG_TK.TK IS '';
COMMENT ON COLUMN BARS.CIN_TAG_TK.TAG IS '';
COMMENT ON COLUMN BARS.CIN_TAG_TK.PR_A1 IS '';
COMMENT ON COLUMN BARS.CIN_TAG_TK.SK_A1 IS '';




PROMPT *** Create  constraint SYS_C005960 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIN_TAG_TK MODIFY (TAG NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005961 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIN_TAG_TK MODIFY (PR_A1 NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XPK_CINTAGTK ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIN_TAG_TK ADD CONSTRAINT XPK_CINTAGTK PRIMARY KEY (TK, TAG)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_CINTAGTK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_CINTAGTK ON BARS.CIN_TAG_TK (TK, TAG) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CIN_TAG_TK ***
grant SELECT                                                                 on CIN_TAG_TK      to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CIN_TAG_TK      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CIN_TAG_TK      to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CIN_TAG_TK      to PYOD001;
grant DELETE,INSERT,SELECT,UPDATE                                            on CIN_TAG_TK      to START1;
grant SELECT                                                                 on CIN_TAG_TK      to UPLD;
grant FLASHBACK,SELECT                                                       on CIN_TAG_TK      to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CIN_TAG_TK.sql =========*** End *** ==
PROMPT ===================================================================================== 
