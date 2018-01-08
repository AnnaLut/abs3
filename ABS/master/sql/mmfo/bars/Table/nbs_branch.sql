

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NBS_BRANCH.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to NBS_BRANCH ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NBS_BRANCH'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''NBS_BRANCH'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''NBS_BRANCH'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NBS_BRANCH ***
begin 
  execute immediate '
  CREATE TABLE BARS.NBS_BRANCH 
   (	NBS CHAR(4), 
	UR NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to NBS_BRANCH ***
 exec bpa.alter_policies('NBS_BRANCH');


COMMENT ON TABLE BARS.NBS_BRANCH IS 'БР та їх розмiщення по рiвням бранчiв';
COMMENT ON COLUMN BARS.NBS_BRANCH.NBS IS 'БР';
COMMENT ON COLUMN BARS.NBS_BRANCH.UR IS '№ рiвня';




PROMPT *** Create  constraint XPK_NBSBRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBS_BRANCH ADD CONSTRAINT XPK_NBSBRANCH PRIMARY KEY (NBS)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_NBSBRANCH ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_NBSBRANCH ON BARS.NBS_BRANCH (NBS) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  NBS_BRANCH ***
grant DELETE,INSERT,SELECT,UPDATE                                            on NBS_BRANCH      to ABS_ADMIN;
grant SELECT                                                                 on NBS_BRANCH      to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on NBS_BRANCH      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on NBS_BRANCH      to BARS_DM;
grant SELECT                                                                 on NBS_BRANCH      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NBS_BRANCH.sql =========*** End *** ==
PROMPT ===================================================================================== 
