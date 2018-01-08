

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/REP_ACCG_OTCHG.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to REP_ACCG_OTCHG ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''REP_ACCG_OTCHG'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''REP_ACCG_OTCHG'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''REP_ACCG_OTCHG'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table REP_ACCG_OTCHG ***
begin 
  execute immediate '
  CREATE TABLE BARS.REP_ACCG_OTCHG 
   (	ACCGRP NUMBER, 
	OTCHGRP NUMBER, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to REP_ACCG_OTCHG ***
 exec bpa.alter_policies('REP_ACCG_OTCHG');


COMMENT ON TABLE BARS.REP_ACCG_OTCHG IS 'Описание связки групп счетов и отчетных групп';
COMMENT ON COLUMN BARS.REP_ACCG_OTCHG.ACCGRP IS '';
COMMENT ON COLUMN BARS.REP_ACCG_OTCHG.OTCHGRP IS '';
COMMENT ON COLUMN BARS.REP_ACCG_OTCHG.KF IS '';




PROMPT *** Create  constraint CC_REPACCGOTCHG_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.REP_ACCG_OTCHG MODIFY (KF CONSTRAINT CC_REPACCGOTCHG_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XPK_REP_ACCG_OTCHG ***
begin   
 execute immediate '
  ALTER TABLE BARS.REP_ACCG_OTCHG ADD CONSTRAINT XPK_REP_ACCG_OTCHG PRIMARY KEY (ACCGRP, OTCHGRP)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_REP_ACCG_OTCHG ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_REP_ACCG_OTCHG ON BARS.REP_ACCG_OTCHG (ACCGRP, OTCHGRP) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  REP_ACCG_OTCHG ***
grant SELECT                                                                 on REP_ACCG_OTCHG  to ABS_ADMIN;
grant DELETE,INSERT,SELECT,UPDATE                                            on REP_ACCG_OTCHG  to BARS014;
grant SELECT                                                                 on REP_ACCG_OTCHG  to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on REP_ACCG_OTCHG  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on REP_ACCG_OTCHG  to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on REP_ACCG_OTCHG  to RPBN001;
grant SELECT                                                                 on REP_ACCG_OTCHG  to TASK_LIST;
grant SELECT                                                                 on REP_ACCG_OTCHG  to UPLD;
grant FLASHBACK,SELECT                                                       on REP_ACCG_OTCHG  to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/REP_ACCG_OTCHG.sql =========*** End **
PROMPT ===================================================================================== 
