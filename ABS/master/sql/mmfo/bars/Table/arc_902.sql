

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ARC_902.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ARC_902 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ARC_902'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''ARC_902'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ARC_902'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ARC_902 ***
begin 
  execute immediate '
  CREATE TABLE BARS.ARC_902 
   (	REF NUMBER, 
	REF_OUT NUMBER
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ARC_902 ***
 exec bpa.alter_policies('ARC_902');


COMMENT ON TABLE BARS.ARC_902 IS '';
COMMENT ON COLUMN BARS.ARC_902.REF IS '';
COMMENT ON COLUMN BARS.ARC_902.REF_OUT IS '';




PROMPT *** Create  constraint XPK_ARC_902 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ARC_902 ADD CONSTRAINT XPK_ARC_902 PRIMARY KEY (REF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_ARC_902 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_ARC_902 ON BARS.ARC_902 (REF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ARC_902 ***
grant SELECT                                                                 on ARC_902         to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on ARC_902         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ARC_902         to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on ARC_902         to START1;
grant SELECT                                                                 on ARC_902         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ARC_902.sql =========*** End *** =====
PROMPT ===================================================================================== 
