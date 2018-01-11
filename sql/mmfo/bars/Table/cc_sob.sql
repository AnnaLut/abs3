

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CC_SOB.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CC_SOB ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CC_SOB'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CC_SOB'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''CC_SOB'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CC_SOB ***
begin 
  execute immediate '
  CREATE TABLE BARS.CC_SOB 
   (	ND NUMBER(*,0), 
	FDAT DATE, 
	ID NUMBER(*,0), 
	ISP NUMBER(*,0), 
	TXT VARCHAR2(4000), 
	OTM NUMBER(*,0), 
	FREQ NUMBER(*,0), 
	PSYS NUMBER(*,0), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	FACT_DATE DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CC_SOB ***
 exec bpa.alter_policies('CC_SOB');


COMMENT ON TABLE BARS.CC_SOB IS '';
COMMENT ON COLUMN BARS.CC_SOB.ND IS 'Ном.КД';
COMMENT ON COLUMN BARS.CC_SOB.FDAT IS 'Дата события';
COMMENT ON COLUMN BARS.CC_SOB.ID IS 'Ном пп';
COMMENT ON COLUMN BARS.CC_SOB.ISP IS 'Пользователь';
COMMENT ON COLUMN BARS.CC_SOB.TXT IS 'Текст       ';
COMMENT ON COLUMN BARS.CC_SOB.OTM IS '';
COMMENT ON COLUMN BARS.CC_SOB.FREQ IS '';
COMMENT ON COLUMN BARS.CC_SOB.PSYS IS '';
COMMENT ON COLUMN BARS.CC_SOB.KF IS '';
COMMENT ON COLUMN BARS.CC_SOB.FACT_DATE IS 'Дата фактического исполнения события';




PROMPT *** Create  constraint NK_CC_SOB_ND ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_SOB MODIFY (ND CONSTRAINT NK_CC_SOB_ND NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_CC_SOB_FDAT ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_SOB MODIFY (FDAT CONSTRAINT NK_CC_SOB_FDAT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_CC_SOB_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_SOB MODIFY (ID CONSTRAINT NK_CC_SOB_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_CC_SOB_ISP ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_SOB MODIFY (ISP CONSTRAINT NK_CC_SOB_ISP NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CCSOB_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_SOB MODIFY (KF CONSTRAINT CC_CCSOB_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XPK_CC_SOB ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_SOB ADD CONSTRAINT XPK_CC_SOB PRIMARY KEY (ND, ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_CC_SOB ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_CC_SOB ON BARS.CC_SOB (ND, ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CC_SOB ***
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on CC_SOB          to BARS009;
grant SELECT                                                                 on CC_SOB          to BARSREADER_ROLE;
grant SELECT                                                                 on CC_SOB          to BARSUPL;
grant DELETE,INSERT,SELECT,UPDATE                                            on CC_SOB          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CC_SOB          to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CC_SOB          to RCC_DEAL;
grant SELECT                                                                 on CC_SOB          to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CC_SOB          to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CC_SOB.sql =========*** End *** ======
PROMPT ===================================================================================== 
