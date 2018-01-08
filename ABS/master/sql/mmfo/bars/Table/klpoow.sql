

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KLPOOW.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KLPOOW ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KLPOOW'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''KLPOOW'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''KLPOOW'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KLPOOW ***
begin 
  execute immediate '
  CREATE TABLE BARS.KLPOOW 
   (	SAB VARCHAR2(6), 
	OPER CHAR(4), 
	MFOA VARCHAR2(12), 
	NLSA VARCHAR2(15), 
	MFOB VARCHAR2(12), 
	NLSB VARCHAR2(15), 
	NAMB VARCHAR2(38), 
	S NUMBER(24,0), 
	ND VARCHAR2(10), 
	NAZN VARCHAR2(160), 
	POND VARCHAR2(9), 
	PRWO VARCHAR2(60), 
	NFIA VARCHAR2(12), 
	TIP CHAR(1), 
	OTM CHAR(1), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KLPOOW ***
 exec bpa.alter_policies('KLPOOW');


COMMENT ON TABLE BARS.KLPOOW IS '';
COMMENT ON COLUMN BARS.KLPOOW.SAB IS '';
COMMENT ON COLUMN BARS.KLPOOW.OPER IS '';
COMMENT ON COLUMN BARS.KLPOOW.MFOA IS '';
COMMENT ON COLUMN BARS.KLPOOW.NLSA IS '';
COMMENT ON COLUMN BARS.KLPOOW.MFOB IS '';
COMMENT ON COLUMN BARS.KLPOOW.NLSB IS '';
COMMENT ON COLUMN BARS.KLPOOW.NAMB IS '';
COMMENT ON COLUMN BARS.KLPOOW.S IS '';
COMMENT ON COLUMN BARS.KLPOOW.ND IS '';
COMMENT ON COLUMN BARS.KLPOOW.NAZN IS '';
COMMENT ON COLUMN BARS.KLPOOW.POND IS '';
COMMENT ON COLUMN BARS.KLPOOW.PRWO IS '';
COMMENT ON COLUMN BARS.KLPOOW.NFIA IS '';
COMMENT ON COLUMN BARS.KLPOOW.TIP IS '';
COMMENT ON COLUMN BARS.KLPOOW.OTM IS '';
COMMENT ON COLUMN BARS.KLPOOW.KF IS '';




PROMPT *** Create  constraint FK_KLPOOW_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLPOOW ADD CONSTRAINT FK_KLPOOW_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_KLPOOW_MFOA_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLPOOW MODIFY (MFOA CONSTRAINT CC_KLPOOW_MFOA_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_KLPOOW_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLPOOW MODIFY (KF CONSTRAINT CC_KLPOOW_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_KLPOOW_NAZN_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLPOOW MODIFY (NAZN CONSTRAINT CC_KLPOOW_NAZN_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_KLPOOW_ND_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLPOOW MODIFY (ND CONSTRAINT CC_KLPOOW_ND_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_KLPOOW_S_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLPOOW MODIFY (S CONSTRAINT CC_KLPOOW_S_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_KLPOOW_NAMB_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLPOOW MODIFY (NAMB CONSTRAINT CC_KLPOOW_NAMB_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_KLPOOW_NLSB_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLPOOW MODIFY (NLSB CONSTRAINT CC_KLPOOW_NLSB_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_KLPOOW_MFOB_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLPOOW MODIFY (MFOB CONSTRAINT CC_KLPOOW_MFOB_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_KLPOOW_NLSA_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLPOOW MODIFY (NLSA CONSTRAINT CC_KLPOOW_NLSA_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index IDX_KLPOOW_SAB ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_KLPOOW_SAB ON BARS.KLPOOW (SAB) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  KLPOOW ***
grant INSERT                                                                 on KLPOOW          to BARS014;
grant DELETE,INSERT,SELECT,UPDATE                                            on KLPOOW          to BARS_ACCESS_DEFROLE;
grant INSERT                                                                 on KLPOOW          to OPERKKK;
grant INSERT                                                                 on KLPOOW          to START1;
grant DELETE,INSERT,SELECT,UPDATE                                            on KLPOOW          to TECH_MOM1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on KLPOOW          to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to KLPOOW ***

  CREATE OR REPLACE PUBLIC SYNONYM KLPOOW FOR BARS.KLPOOW;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KLPOOW.sql =========*** End *** ======
PROMPT ===================================================================================== 
