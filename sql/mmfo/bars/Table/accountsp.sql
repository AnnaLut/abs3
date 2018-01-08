

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ACCOUNTSP.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ACCOUNTSP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ACCOUNTSP'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''ACCOUNTSP'', ''FILIAL'' , null, ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''ACCOUNTSP'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ACCOUNTSP ***
begin 
  execute immediate '
  CREATE TABLE BARS.ACCOUNTSP 
   (	ACC NUMBER, 
	DAT1 DATE, 
	DAT2 DATE, 
	PARID NUMBER, 
	VAL VARCHAR2(254), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ACCOUNTSP ***
 exec bpa.alter_policies('ACCOUNTSP');


COMMENT ON TABLE BARS.ACCOUNTSP IS '';
COMMENT ON COLUMN BARS.ACCOUNTSP.ACC IS '';
COMMENT ON COLUMN BARS.ACCOUNTSP.DAT1 IS '';
COMMENT ON COLUMN BARS.ACCOUNTSP.DAT2 IS '';
COMMENT ON COLUMN BARS.ACCOUNTSP.PARID IS '';
COMMENT ON COLUMN BARS.ACCOUNTSP.VAL IS '';
COMMENT ON COLUMN BARS.ACCOUNTSP.KF IS '';




PROMPT *** Create  constraint XPK_ACCOUNTSP ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTSP ADD CONSTRAINT XPK_ACCOUNTSP PRIMARY KEY (ACC, DAT1, PARID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ACCOUNTSP_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTSP ADD CONSTRAINT FK_ACCOUNTSP_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ACCOUNTSP_ACCOUNTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTSP ADD CONSTRAINT FK_ACCOUNTSP_ACCOUNTS FOREIGN KEY (KF, ACC)
	  REFERENCES BARS.ACCOUNTS (KF, ACC) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ACCOUNTSP_SPARAM_LIST ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTSP ADD CONSTRAINT FK_ACCOUNTSP_SPARAM_LIST FOREIGN KEY (PARID)
	  REFERENCES BARS.SPARAM_LIST (SPID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCOUNTSP_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTSP MODIFY (KF CONSTRAINT CC_ACCOUNTSP_KF_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_ACCOUNTSP ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_ACCOUNTSP ON BARS.ACCOUNTSP (ACC, DAT1, PARID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ACCOUNTSP ***
grant DELETE,INSERT,SELECT,UPDATE                                            on ACCOUNTSP       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ACCOUNTSP       to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on ACCOUNTSP       to START1;



PROMPT *** Create SYNONYM  to ACCOUNTSP ***

  CREATE OR REPLACE PUBLIC SYNONYM ACCOUNTSP FOR BARS.ACCOUNTSP;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ACCOUNTSP.sql =========*** End *** ===
PROMPT ===================================================================================== 
