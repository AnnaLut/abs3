

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/RNK2DEAL_ACC.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to RNK2DEAL_ACC ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''RNK2DEAL_ACC'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''RNK2DEAL_ACC'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table RNK2DEAL_ACC ***
begin 
  execute immediate '
  CREATE TABLE BARS.RNK2DEAL_ACC 
   (	RNKFROM NUMBER, 
	RNKTO NUMBER, 
	SDATE DATE, 
	DEAL_FROM NUMBER(10,0), 
	DEAL_TO NUMBER(10,0), 
	ACC NUMBER(38,0), 
	ID NUMBER(*,0), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to RNK2DEAL_ACC ***
 exec bpa.alter_policies('RNK2DEAL_ACC');


COMMENT ON TABLE BARS.RNK2DEAL_ACC IS '';
COMMENT ON COLUMN BARS.RNK2DEAL_ACC.RNKFROM IS '';
COMMENT ON COLUMN BARS.RNK2DEAL_ACC.RNKTO IS '';
COMMENT ON COLUMN BARS.RNK2DEAL_ACC.SDATE IS '';
COMMENT ON COLUMN BARS.RNK2DEAL_ACC.DEAL_FROM IS '';
COMMENT ON COLUMN BARS.RNK2DEAL_ACC.DEAL_TO IS '';
COMMENT ON COLUMN BARS.RNK2DEAL_ACC.ACC IS '';
COMMENT ON COLUMN BARS.RNK2DEAL_ACC.ID IS '';
COMMENT ON COLUMN BARS.RNK2DEAL_ACC.KF IS '';




PROMPT *** Create  constraint SYS_C00133863 ***
begin   
 execute immediate '
  ALTER TABLE BARS.RNK2DEAL_ACC MODIFY (DEAL_FROM NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00133864 ***
begin   
 execute immediate '
  ALTER TABLE BARS.RNK2DEAL_ACC MODIFY (DEAL_TO NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00133865 ***
begin   
 execute immediate '
  ALTER TABLE BARS.RNK2DEAL_ACC MODIFY (ACC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  RNK2DEAL_ACC ***
grant SELECT                                                                 on RNK2DEAL_ACC    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/RNK2DEAL_ACC.sql =========*** End *** 
PROMPT ===================================================================================== 
