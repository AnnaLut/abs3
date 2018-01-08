

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/PKK_HISTORY.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to PKK_HISTORY ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''PKK_HISTORY'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''PKK_HISTORY'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''PKK_HISTORY'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table PKK_HISTORY ***
begin 
  execute immediate '
  CREATE TABLE BARS.PKK_HISTORY 
   (	REF NUMBER(38,0), 
	F_N VARCHAR2(12), 
	F_D DATE, 
	ACC NUMBER(38,0), 
	DK NUMBER(1,0), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to PKK_HISTORY ***
 exec bpa.alter_policies('PKK_HISTORY');


COMMENT ON TABLE BARS.PKK_HISTORY IS '';
COMMENT ON COLUMN BARS.PKK_HISTORY.REF IS '';
COMMENT ON COLUMN BARS.PKK_HISTORY.F_N IS '';
COMMENT ON COLUMN BARS.PKK_HISTORY.F_D IS '';
COMMENT ON COLUMN BARS.PKK_HISTORY.ACC IS '';
COMMENT ON COLUMN BARS.PKK_HISTORY.DK IS '';
COMMENT ON COLUMN BARS.PKK_HISTORY.KF IS '';




PROMPT *** Create  constraint FK_PKKHISTORY_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.PKK_HISTORY ADD CONSTRAINT FK_PKKHISTORY_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_PKKHISTORY_DK ***
begin   
 execute immediate '
  ALTER TABLE BARS.PKK_HISTORY ADD CONSTRAINT FK_PKKHISTORY_DK FOREIGN KEY (DK)
	  REFERENCES BARS.DK (DK) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PKKHISTORY_REF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PKK_HISTORY MODIFY (REF CONSTRAINT CC_PKKHISTORY_REF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PKKHISTORY_ACC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PKK_HISTORY MODIFY (ACC CONSTRAINT CC_PKKHISTORY_ACC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PKKHISTORY_DK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PKK_HISTORY MODIFY (DK CONSTRAINT CC_PKKHISTORY_DK_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PKKHISTORY_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PKK_HISTORY MODIFY (KF CONSTRAINT CC_PKKHISTORY_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_PKKHISTORY_ACC ***
begin   
 execute immediate '
  CREATE INDEX BARS.I_PKKHISTORY_ACC ON BARS.PKK_HISTORY (ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  PKK_HISTORY ***
grant SELECT                                                                 on PKK_HISTORY     to BARS_DM;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on PKK_HISTORY     to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/PKK_HISTORY.sql =========*** End *** =
PROMPT ===================================================================================== 
