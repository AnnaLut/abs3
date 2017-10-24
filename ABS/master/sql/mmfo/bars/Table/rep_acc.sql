

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/REP_ACC.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to REP_ACC ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''REP_ACC'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''REP_ACC'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''REP_ACC'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table REP_ACC ***
begin 
  execute immediate '
  CREATE TABLE BARS.REP_ACC 
   (	ACCGRP NUMBER, 
	NLSMASK VARCHAR2(14), 
	KV NUMBER, 
	BRANCH VARCHAR2(30)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to REP_ACC ***
 exec bpa.alter_policies('REP_ACC');


COMMENT ON TABLE BARS.REP_ACC IS 'Список типов отчетов, которые можно формировать на основании каталогизированных отчетов.';
COMMENT ON COLUMN BARS.REP_ACC.ACCGRP IS '';
COMMENT ON COLUMN BARS.REP_ACC.NLSMASK IS '';
COMMENT ON COLUMN BARS.REP_ACC.KV IS '';
COMMENT ON COLUMN BARS.REP_ACC.BRANCH IS 'Маска бранча (% - для всех)';




PROMPT *** Create  constraint XPK_REPACC ***
begin   
 execute immediate '
  ALTER TABLE BARS.REP_ACC ADD CONSTRAINT XPK_REPACC PRIMARY KEY (ACCGRP, NLSMASK, KV, BRANCH)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_REP_ACC_ACC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_REP_ACC_ACC ON BARS.REP_ACC (ACCGRP, NLSMASK, KV) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_REPACC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_REPACC ON BARS.REP_ACC (ACCGRP, NLSMASK, KV, BRANCH) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  REP_ACC ***
grant SELECT                                                                 on REP_ACC         to ABS_ADMIN;
grant DELETE,INSERT,SELECT,UPDATE                                            on REP_ACC         to BARS014;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on REP_ACC         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on REP_ACC         to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on REP_ACC         to RPBN001;
grant SELECT                                                                 on REP_ACC         to TASK_LIST;
grant FLASHBACK,SELECT                                                       on REP_ACC         to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/REP_ACC.sql =========*** End *** =====
PROMPT ===================================================================================== 
