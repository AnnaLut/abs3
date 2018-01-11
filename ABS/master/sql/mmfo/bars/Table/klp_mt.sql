

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KLP_MT.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KLP_MT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KLP_MT'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KLP_MT'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KLP_MT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KLP_MT ***
begin 
  execute immediate '
  CREATE TABLE BARS.KLP_MT 
   (	DOP NUMBER(*,0), 
	VALUE LONG RAW
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KLP_MT ***
 exec bpa.alter_policies('KLP_MT');


COMMENT ON TABLE BARS.KLP_MT IS '';
COMMENT ON COLUMN BARS.KLP_MT.DOP IS '';
COMMENT ON COLUMN BARS.KLP_MT.VALUE IS '';




PROMPT *** Create  constraint XPK_KLP_MT ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLP_MT ADD CONSTRAINT XPK_KLP_MT PRIMARY KEY (DOP)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008651 ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLP_MT MODIFY (DOP NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_KLP_MT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_KLP_MT ON BARS.KLP_MT (DOP) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  KLP_MT ***
grant SELECT                                                                 on KLP_MT          to BARSREADER_ROLE;
grant INSERT,SELECT                                                          on KLP_MT          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KLP_MT          to BARS_DM;
grant INSERT,SELECT                                                          on KLP_MT          to TECH_MOM1;
grant SELECT                                                                 on KLP_MT          to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on KLP_MT          to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to KLP_MT ***

  CREATE OR REPLACE PUBLIC SYNONYM KLP_MT FOR BARS.KLP_MT;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KLP_MT.sql =========*** End *** ======
PROMPT ===================================================================================== 
