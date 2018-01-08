

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NBS_KNYGA.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to NBS_KNYGA ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NBS_KNYGA'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''NBS_KNYGA'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''NBS_KNYGA'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NBS_KNYGA ***
begin 
  execute immediate '
  CREATE TABLE BARS.NBS_KNYGA 
   (	NBS VARCHAR2(4), 
	VKL VARCHAR2(1)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to NBS_KNYGA ***
 exec bpa.alter_policies('NBS_KNYGA');


COMMENT ON TABLE BARS.NBS_KNYGA IS '';
COMMENT ON COLUMN BARS.NBS_KNYGA.NBS IS '';
COMMENT ON COLUMN BARS.NBS_KNYGA.VKL IS '';




PROMPT *** Create  constraint PK_NBSKNYGA_NBS ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBS_KNYGA ADD CONSTRAINT PK_NBSKNYGA_NBS PRIMARY KEY (NBS)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_NBSKNYGA_NBS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_NBSKNYGA_NBS ON BARS.NBS_KNYGA (NBS) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  NBS_KNYGA ***
grant DELETE,INSERT,SELECT,UPDATE                                            on NBS_KNYGA       to ABS_ADMIN;
grant SELECT                                                                 on NBS_KNYGA       to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on NBS_KNYGA       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on NBS_KNYGA       to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on NBS_KNYGA       to START1;
grant SELECT                                                                 on NBS_KNYGA       to UPLD;
grant FLASHBACK,SELECT                                                       on NBS_KNYGA       to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NBS_KNYGA.sql =========*** End *** ===
PROMPT ===================================================================================== 
