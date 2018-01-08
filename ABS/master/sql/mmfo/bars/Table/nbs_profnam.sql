

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NBS_PROFNAM.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to NBS_PROFNAM ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NBS_PROFNAM'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''NBS_PROFNAM'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''NBS_PROFNAM'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NBS_PROFNAM ***
begin 
  execute immediate '
  CREATE TABLE BARS.NBS_PROFNAM 
   (	NBS VARCHAR2(4), 
	NP NUMBER, 
	NAME VARCHAR2(70), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to NBS_PROFNAM ***
 exec bpa.alter_policies('NBS_PROFNAM');


COMMENT ON TABLE BARS.NBS_PROFNAM IS 'Профили счетов';
COMMENT ON COLUMN BARS.NBS_PROFNAM.NBS IS 'Балансовый счет';
COMMENT ON COLUMN BARS.NBS_PROFNAM.NP IS '№ профиля БС';
COMMENT ON COLUMN BARS.NBS_PROFNAM.NAME IS 'Наименование профиля';
COMMENT ON COLUMN BARS.NBS_PROFNAM.KF IS '';




PROMPT *** Create  constraint PK_NBSPROFNAM ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBS_PROFNAM ADD CONSTRAINT PK_NBSPROFNAM PRIMARY KEY (KF, NBS, NP)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_NBSPROFNAM_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBS_PROFNAM MODIFY (KF CONSTRAINT CC_NBSPROFNAM_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_NBSPROFNAM_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBS_PROFNAM ADD CONSTRAINT FK_NBSPROFNAM_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_NBSPROFNAM ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_NBSPROFNAM ON BARS.NBS_PROFNAM (KF, NBS, NP) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  NBS_PROFNAM ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on NBS_PROFNAM     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on NBS_PROFNAM     to BARS_DM;
grant SELECT                                                                 on NBS_PROFNAM     to CUST001;
grant DELETE,INSERT,SELECT,UPDATE                                            on NBS_PROFNAM     to NBS_PROF;
grant DELETE,INSERT,SELECT,UPDATE                                            on NBS_PROFNAM     to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on NBS_PROFNAM     to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on NBS_PROFNAM     to WR_REFREAD;



PROMPT *** Create SYNONYM  to NBS_PROFNAM ***

  CREATE OR REPLACE PUBLIC SYNONYM NBS_PROFNAM FOR BARS.NBS_PROFNAM;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NBS_PROFNAM.sql =========*** End *** =
PROMPT ===================================================================================== 
