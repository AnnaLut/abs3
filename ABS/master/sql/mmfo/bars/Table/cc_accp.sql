

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CC_ACCP.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CC_ACCP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CC_ACCP'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CC_ACCP'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''CC_ACCP'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CC_ACCP ***
begin 
  execute immediate '
  CREATE TABLE BARS.CC_ACCP 
   (	ACC NUMBER(38,0), 
	ACCS NUMBER(38,0), 
	ND NUMBER(38,0), 
	PR_12 NUMBER(*,0), 
	IDZ NUMBER(*,0), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	MPAWN NUMBER, 
	PAWN NUMBER, 
	RNK NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CC_ACCP ***
 exec bpa.alter_policies('CC_ACCP');


COMMENT ON TABLE BARS.CC_ACCP IS 'Связь сч.обеспечения и сч.актива(кредита)';
COMMENT ON COLUMN BARS.CC_ACCP.ACC IS 'ACC сч.обеспечения';
COMMENT ON COLUMN BARS.CC_ACCP.ACCS IS 'ACC сч.актива(кредита)';
COMMENT ON COLUMN BARS.CC_ACCP.ND IS 'Реф.КД';
COMMENT ON COLUMN BARS.CC_ACCP.PR_12 IS 'Признак "перв/втор" застави по вiдношенню до КД';
COMMENT ON COLUMN BARS.CC_ACCP.IDZ IS '';
COMMENT ON COLUMN BARS.CC_ACCP.KF IS '';
COMMENT ON COLUMN BARS.CC_ACCP.MPAWN IS '';
COMMENT ON COLUMN BARS.CC_ACCP.PAWN IS '';
COMMENT ON COLUMN BARS.CC_ACCP.RNK IS '';




PROMPT *** Create  constraint XPK_CC_ACCP ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_ACCP ADD CONSTRAINT XPK_CC_ACCP PRIMARY KEY (ACC, ACCS)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CCACCP_ACCOUNTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_ACCP ADD CONSTRAINT FK_CCACCP_ACCOUNTS FOREIGN KEY (KF, ACCS)
	  REFERENCES BARS.ACCOUNTS (KF, ACC) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CCACCP_ACCOUNTS2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_ACCP ADD CONSTRAINT FK_CCACCP_ACCOUNTS2 FOREIGN KEY (KF, ACC)
	  REFERENCES BARS.ACCOUNTS (KF, ACC) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CCACCP_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_ACCP ADD CONSTRAINT FK_CCACCP_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_CC_ACCP_ACC ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_ACCP MODIFY (ACC CONSTRAINT NK_CC_ACCP_ACC NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_CC_ACCP_ACCS ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_ACCP MODIFY (ACCS CONSTRAINT NK_CC_ACCP_ACCS NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CCACCP_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_ACCP MODIFY (KF CONSTRAINT CC_CCACCP_KF_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_CC_ACCP ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_CC_ACCP ON BARS.CC_ACCP (ACC, ACCS) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I1_CC_ACCP ***
begin   
 execute immediate '
  CREATE INDEX BARS.I1_CC_ACCP ON BARS.CC_ACCP (ND, ACC, ACCS) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I2_CC_ACCP ***
begin   
 execute immediate '
  CREATE INDEX BARS.I2_CC_ACCP ON BARS.CC_ACCP (KF, ACCS, ACC, ND) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CC_ACCP ***
grant SELECT                                                                 on CC_ACCP         to BARSUPL;
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on CC_ACCP         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CC_ACCP         to BARS_DM;
grant ALTER,DEBUG,DELETE,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on CC_ACCP         to FOREX;
grant DELETE,INSERT,SELECT,UPDATE                                            on CC_ACCP         to RCC_DEAL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CC_ACCP         to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on CC_ACCP         to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CC_ACCP.sql =========*** End *** =====
PROMPT ===================================================================================== 
