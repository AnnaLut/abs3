

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NBS_DVAL.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to NBS_DVAL ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NBS_DVAL'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''NBS_DVAL'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''NBS_DVAL'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NBS_DVAL ***
begin 
  execute immediate '
  CREATE TABLE BARS.NBS_DVAL 
   (	NBS VARCHAR2(4), 
	MASK VARCHAR2(14), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to NBS_DVAL ***
 exec bpa.alter_policies('NBS_DVAL');


COMMENT ON TABLE BARS.NBS_DVAL IS '';
COMMENT ON COLUMN BARS.NBS_DVAL.NBS IS '';
COMMENT ON COLUMN BARS.NBS_DVAL.MASK IS '';
COMMENT ON COLUMN BARS.NBS_DVAL.KF IS '';




PROMPT *** Create  constraint PK_NBSDVAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBS_DVAL ADD CONSTRAINT PK_NBSDVAL PRIMARY KEY (KF, NBS)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C007853 ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBS_DVAL MODIFY (NBS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C007854 ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBS_DVAL MODIFY (MASK NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_NBSDVAL_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBS_DVAL MODIFY (KF CONSTRAINT CC_NBSDVAL_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_NBSDVAL ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_NBSDVAL ON BARS.NBS_DVAL (KF, NBS) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  NBS_DVAL ***
grant SELECT                                                                 on NBS_DVAL        to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on NBS_DVAL        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on NBS_DVAL        to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on NBS_DVAL        to NBS_DVAL;
grant DELETE,INSERT,SELECT,UPDATE                                            on NBS_DVAL        to SEP_ROLE;
grant SELECT                                                                 on NBS_DVAL        to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on NBS_DVAL        to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on NBS_DVAL        to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NBS_DVAL.sql =========*** End *** ====
PROMPT ===================================================================================== 
