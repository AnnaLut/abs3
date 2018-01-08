

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/PKK_HISTORY_ARC.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to PKK_HISTORY_ARC ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''PKK_HISTORY_ARC'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''PKK_HISTORY_ARC'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''PKK_HISTORY_ARC'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table PKK_HISTORY_ARC ***
begin 
  execute immediate '
  CREATE TABLE BARS.PKK_HISTORY_ARC 
   (	REF NUMBER(38,0), 
	F_N VARCHAR2(12), 
	F_D DATE, 
	ACC NUMBER(38,0), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to PKK_HISTORY_ARC ***
 exec bpa.alter_policies('PKK_HISTORY_ARC');


COMMENT ON TABLE BARS.PKK_HISTORY_ARC IS '';
COMMENT ON COLUMN BARS.PKK_HISTORY_ARC.REF IS '';
COMMENT ON COLUMN BARS.PKK_HISTORY_ARC.F_N IS '';
COMMENT ON COLUMN BARS.PKK_HISTORY_ARC.F_D IS '';
COMMENT ON COLUMN BARS.PKK_HISTORY_ARC.ACC IS '';
COMMENT ON COLUMN BARS.PKK_HISTORY_ARC.KF IS '';




PROMPT *** Create  constraint PK_PKKHISTORYARC ***
begin   
 execute immediate '
  ALTER TABLE BARS.PKK_HISTORY_ARC ADD CONSTRAINT PK_PKKHISTORYARC PRIMARY KEY (REF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PKKHISTORYARC_REF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PKK_HISTORY_ARC MODIFY (REF CONSTRAINT CC_PKKHISTORYARC_REF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PKKHISTORYARC_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PKK_HISTORY_ARC MODIFY (KF CONSTRAINT CC_PKKHISTORYARC_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_PKKHISTORYARC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_PKKHISTORYARC ON BARS.PKK_HISTORY_ARC (REF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_PKKHISTORYARC_ACC ***
begin   
 execute immediate '
  CREATE INDEX BARS.I_PKKHISTORYARC_ACC ON BARS.PKK_HISTORY_ARC (ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  PKK_HISTORY_ARC ***
grant SELECT                                                                 on PKK_HISTORY_ARC to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on PKK_HISTORY_ARC to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on PKK_HISTORY_ARC to OBPC;
grant DELETE                                                                 on PKK_HISTORY_ARC to PYOD001;
grant SELECT                                                                 on PKK_HISTORY_ARC to TECH004;
grant SELECT                                                                 on PKK_HISTORY_ARC to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/PKK_HISTORY_ARC.sql =========*** End *
PROMPT ===================================================================================== 
