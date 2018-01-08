

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/REP_ACCGRP.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to REP_ACCGRP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''REP_ACCGRP'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''REP_ACCGRP'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''REP_ACCGRP'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table REP_ACCGRP ***
begin 
  execute immediate '
  CREATE TABLE BARS.REP_ACCGRP 
   (	ACCGRP NUMBER, 
	NAME VARCHAR2(100), 
	FILEMASK VARCHAR2(50), 
	GRPDIR VARCHAR2(500), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to REP_ACCGRP ***
 exec bpa.alter_policies('REP_ACCGRP');


COMMENT ON TABLE BARS.REP_ACCGRP IS 'Описание групп счетов для отчетности';
COMMENT ON COLUMN BARS.REP_ACCGRP.ACCGRP IS 'Номер группы счетов';
COMMENT ON COLUMN BARS.REP_ACCGRP.NAME IS 'Наименование группы счетов';
COMMENT ON COLUMN BARS.REP_ACCGRP.FILEMASK IS 'Приставка выходного файла ';
COMMENT ON COLUMN BARS.REP_ACCGRP.GRPDIR IS '';
COMMENT ON COLUMN BARS.REP_ACCGRP.KF IS '';




PROMPT *** Create  constraint XPK_REP_ACCGRP_ACCGRP ***
begin   
 execute immediate '
  ALTER TABLE BARS.REP_ACCGRP ADD CONSTRAINT XPK_REP_ACCGRP_ACCGRP PRIMARY KEY (ACCGRP)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_REPACCGRP_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.REP_ACCGRP ADD CONSTRAINT FK_REPACCGRP_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_REPACCGRP_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.REP_ACCGRP MODIFY (KF CONSTRAINT CC_REPACCGRP_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_REP_ACCGRP_ACCGRP ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_REP_ACCGRP_ACCGRP ON BARS.REP_ACCGRP (ACCGRP) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  REP_ACCGRP ***
grant SELECT                                                                 on REP_ACCGRP      to ABS_ADMIN;
grant DELETE,INSERT,SELECT,UPDATE                                            on REP_ACCGRP      to BARS014;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on REP_ACCGRP      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on REP_ACCGRP      to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on REP_ACCGRP      to RPBN001;
grant SELECT                                                                 on REP_ACCGRP      to TASK_LIST;
grant FLASHBACK,SELECT                                                       on REP_ACCGRP      to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/REP_ACCGRP.sql =========*** End *** ==
PROMPT ===================================================================================== 
