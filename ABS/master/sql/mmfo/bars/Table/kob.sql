

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KOB.sql =========*** Run *** =========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KOB ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KOB'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KOB'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KOB'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KOB ***
begin 
  execute immediate '
  CREATE TABLE BARS.KOB 
   (	ACC NUMBER(*,0), 
	REF1 NUMBER(*,0), 
	OTM NUMBER(*,0), 
	REF2 NUMBER(*,0), 
	REF4 NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KOB ***
 exec bpa.alter_policies('KOB');


COMMENT ON TABLE BARS.KOB IS '';
COMMENT ON COLUMN BARS.KOB.ACC IS '';
COMMENT ON COLUMN BARS.KOB.REF1 IS '';
COMMENT ON COLUMN BARS.KOB.OTM IS '';
COMMENT ON COLUMN BARS.KOB.REF2 IS '';
COMMENT ON COLUMN BARS.KOB.REF4 IS '';




PROMPT *** Create  constraint XPK_KOB ***
begin   
 execute immediate '
  ALTER TABLE BARS.KOB ADD CONSTRAINT XPK_KOB PRIMARY KEY (REF1)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_KOB ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_KOB ON BARS.KOB (REF1) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  KOB ***
grant SELECT                                                                 on KOB             to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on KOB             to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KOB             to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on KOB             to START1;
grant SELECT                                                                 on KOB             to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KOB.sql =========*** End *** =========
PROMPT ===================================================================================== 
