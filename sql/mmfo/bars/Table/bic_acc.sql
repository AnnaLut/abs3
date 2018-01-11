

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BIC_ACC.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BIC_ACC ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BIC_ACC'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''BIC_ACC'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''BIC_ACC'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BIC_ACC ***
begin 
  execute immediate '
  CREATE TABLE BARS.BIC_ACC 
   (	BIC CHAR(11), 
	ACC NUMBER, 
	TRANSIT NUMBER, 
	THEIR_ACC VARCHAR2(35), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BIC_ACC ***
 exec bpa.alter_policies('BIC_ACC');


COMMENT ON TABLE BARS.BIC_ACC IS '';
COMMENT ON COLUMN BARS.BIC_ACC.BIC IS '';
COMMENT ON COLUMN BARS.BIC_ACC.ACC IS 'Внутренний номер счета';
COMMENT ON COLUMN BARS.BIC_ACC.TRANSIT IS 'Внутренний номер счета';
COMMENT ON COLUMN BARS.BIC_ACC.THEIR_ACC IS '';
COMMENT ON COLUMN BARS.BIC_ACC.KF IS '';




PROMPT *** Create  constraint XPK_BIC_ACC ***
begin   
 execute immediate '
  ALTER TABLE BARS.BIC_ACC ADD CONSTRAINT XPK_BIC_ACC PRIMARY KEY (BIC, ACC)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BICACC_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BIC_ACC MODIFY (KF CONSTRAINT CC_BICACC_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XFK_BIC_BIC_ACC ***
begin   
 execute immediate '
  CREATE INDEX BARS.XFK_BIC_BIC_ACC ON BARS.BIC_ACC (BIC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index XFK_ACC_BIC_ACC ***
begin   
 execute immediate '
  CREATE INDEX BARS.XFK_ACC_BIC_ACC ON BARS.BIC_ACC (ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index XFK_TRANSIT_BIC_ACC ***
begin   
 execute immediate '
  CREATE INDEX BARS.XFK_TRANSIT_BIC_ACC ON BARS.BIC_ACC (TRANSIT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_BIC_ACC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_BIC_ACC ON BARS.BIC_ACC (BIC, ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BIC_ACC ***
grant SELECT                                                                 on BIC_ACC         to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on BIC_ACC         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on BIC_ACC         to BARS_DM;
grant SELECT                                                                 on BIC_ACC         to SWTOSS;
grant SELECT                                                                 on BIC_ACC         to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on BIC_ACC         to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on BIC_ACC         to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BIC_ACC.sql =========*** End *** =====
PROMPT ===================================================================================== 
