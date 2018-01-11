

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NOSEP.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to NOSEP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NOSEP'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''NOSEP'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''NOSEP'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NOSEP ***
begin 
  execute immediate '
  CREATE TABLE BARS.NOSEP 
   (	NBS VARCHAR2(4), 
	KOD NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to NOSEP ***
 exec bpa.alter_policies('NOSEP');


COMMENT ON TABLE BARS.NOSEP IS '';
COMMENT ON COLUMN BARS.NOSEP.NBS IS '';
COMMENT ON COLUMN BARS.NOSEP.KOD IS '';




PROMPT *** Create  constraint XPK_NOSEP ***
begin   
 execute immediate '
  ALTER TABLE BARS.NOSEP ADD CONSTRAINT XPK_NOSEP PRIMARY KEY (NBS, KOD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_NOSEP_NBS ***
begin   
 execute immediate '
  ALTER TABLE BARS.NOSEP MODIFY (NBS CONSTRAINT NK_NOSEP_NBS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_NOSEP_KOD ***
begin   
 execute immediate '
  ALTER TABLE BARS.NOSEP MODIFY (KOD CONSTRAINT NK_NOSEP_KOD NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_NOSEP ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_NOSEP ON BARS.NOSEP (NBS, KOD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  NOSEP ***
grant SELECT                                                                 on NOSEP           to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on NOSEP           to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on NOSEP           to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on NOSEP           to NOSEP;
grant SELECT                                                                 on NOSEP           to OPER000;
grant DELETE,INSERT,SELECT,UPDATE                                            on NOSEP           to SEP_ROLE;
grant SELECT                                                                 on NOSEP           to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on NOSEP           to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on NOSEP           to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NOSEP.sql =========*** End *** =======
PROMPT ===================================================================================== 
