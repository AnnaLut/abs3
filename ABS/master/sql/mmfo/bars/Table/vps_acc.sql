

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/VPS_ACC.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to VPS_ACC ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''VPS_ACC'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''VPS_ACC'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''VPS_ACC'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table VPS_ACC ***
begin 
  execute immediate '
  CREATE TABLE BARS.VPS_ACC 
   (	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	MFO VARCHAR2(12), 
	NLS VARCHAR2(15), 
	NLSA VARCHAR2(15), 
	 CONSTRAINT PK_VPSACC PRIMARY KEY (KF, MFO, NLS, NLSA) ENABLE
   ) ORGANIZATION INDEX NOCOMPRESS PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING
  TABLESPACE BRSSMLI 
 PCTTHRESHOLD 50';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to VPS_ACC ***
 exec bpa.alter_policies('VPS_ACC');


COMMENT ON TABLE BARS.VPS_ACC IS '';
COMMENT ON COLUMN BARS.VPS_ACC.KF IS '';
COMMENT ON COLUMN BARS.VPS_ACC.MFO IS '';
COMMENT ON COLUMN BARS.VPS_ACC.NLS IS '';
COMMENT ON COLUMN BARS.VPS_ACC.NLSA IS '';




PROMPT *** Create  constraint CC_VPSACC_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.VPS_ACC MODIFY (KF CONSTRAINT CC_VPSACC_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_VPSACC_MFO_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.VPS_ACC MODIFY (MFO CONSTRAINT CC_VPSACC_MFO_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_VPSACC_NLS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.VPS_ACC MODIFY (NLS CONSTRAINT CC_VPSACC_NLS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_VPSACC_NLSA_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.VPS_ACC MODIFY (NLSA CONSTRAINT CC_VPSACC_NLSA_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_VPSACC ***
begin   
 execute immediate '
  ALTER TABLE BARS.VPS_ACC ADD CONSTRAINT PK_VPSACC PRIMARY KEY (KF, MFO, NLS, NLSA)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_VPSACC_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.VPS_ACC ADD CONSTRAINT FK_VPSACC_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_VPSACC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_VPSACC ON BARS.VPS_ACC (KF, MFO, NLS, NLSA) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  VPS_ACC ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on VPS_ACC         to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on VPS_ACC         to SEP_ROLE;
grant SELECT                                                                 on VPS_ACC         to START1;
grant DELETE,INSERT,SELECT,UPDATE                                            on VPS_ACC         to VPS_ACC;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on VPS_ACC         to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on VPS_ACC         to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/VPS_ACC.sql =========*** End *** =====
PROMPT ===================================================================================== 
