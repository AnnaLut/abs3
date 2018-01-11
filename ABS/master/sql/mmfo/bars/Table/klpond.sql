

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KLPOND.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KLPOND ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KLPOND'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''KLPOND'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''KLPOND'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KLPOND ***
begin 
  execute immediate '
  CREATE TABLE BARS.KLPOND 
   (	REF NUMBER(*,0), 
	POND VARCHAR2(9), 
	FILENAME VARCHAR2(12), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KLPOND ***
 exec bpa.alter_policies('KLPOND');


COMMENT ON TABLE BARS.KLPOND IS '';
COMMENT ON COLUMN BARS.KLPOND.REF IS '¬нутренний номер документа (от "сотворени€ мира")';
COMMENT ON COLUMN BARS.KLPOND.POND IS '';
COMMENT ON COLUMN BARS.KLPOND.FILENAME IS '';
COMMENT ON COLUMN BARS.KLPOND.KF IS '';




PROMPT *** Create  constraint CC_KLPOND_POND_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLPOND MODIFY (POND CONSTRAINT CC_KLPOND_POND_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_KLPOND_FILENAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLPOND MODIFY (FILENAME CONSTRAINT CC_KLPOND_FILENAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_KLPOND_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLPOND MODIFY (KF CONSTRAINT CC_KLPOND_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XPK_KLPOND ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLPOND ADD CONSTRAINT XPK_KLPOND PRIMARY KEY (REF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_KLPOND ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_KLPOND ON BARS.KLPOND (REF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index XAK_KLPOND_POND_FN ***
begin   
 execute immediate '
  CREATE INDEX BARS.XAK_KLPOND_POND_FN ON BARS.KLPOND (POND, FILENAME) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index IDX_KLPOND_KFREF ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_KLPOND_KFREF ON BARS.KLPOND (KF, REF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  KLPOND ***
grant SELECT                                                                 on KLPOND          to BARSREADER_ROLE;
grant INSERT,SELECT,UPDATE                                                   on KLPOND          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KLPOND          to BARS_DM;
grant INSERT,UPDATE                                                          on KLPOND          to OPERKKK;
grant SELECT,UPDATE                                                          on KLPOND          to START1;
grant INSERT,SELECT,UPDATE                                                   on KLPOND          to TECH_MOM1;
grant SELECT                                                                 on KLPOND          to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on KLPOND          to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to KLPOND ***

  CREATE OR REPLACE PUBLIC SYNONYM KLPOND FOR BARS.KLPOND;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KLPOND.sql =========*** End *** ======
PROMPT ===================================================================================== 
