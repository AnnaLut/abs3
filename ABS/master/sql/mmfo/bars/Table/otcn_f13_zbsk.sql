

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OTCN_F13_ZBSK.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OTCN_F13_ZBSK ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OTCN_F13_ZBSK'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''OTCN_F13_ZBSK'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''OTCN_F13_ZBSK'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OTCN_F13_ZBSK ***
begin 
  execute immediate '
  CREATE TABLE BARS.OTCN_F13_ZBSK 
   (	REF NUMBER, 
	TT CHAR(3), 
	FDAT DATE, 
	ACCD NUMBER, 
	NLSD VARCHAR2(15), 
	KV NUMBER(*,0), 
	ACCK NUMBER, 
	NLSK VARCHAR2(15), 
	S NUMBER, 
	SQ NUMBER, 
	NAZN VARCHAR2(160), 
	ISP NUMBER, 
	SK_ZB NUMBER, 
	RECID NUMBER, 
	KO NUMBER(*,0), 
	TOBO VARCHAR2(30), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	STMT NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OTCN_F13_ZBSK ***
 exec bpa.alter_policies('OTCN_F13_ZBSK');


COMMENT ON TABLE BARS.OTCN_F13_ZBSK IS 'Архив проводок по внебалансовых символам касспланае для файла #13';
COMMENT ON COLUMN BARS.OTCN_F13_ZBSK.STMT IS '';
COMMENT ON COLUMN BARS.OTCN_F13_ZBSK.RECID IS 'ID ';
COMMENT ON COLUMN BARS.OTCN_F13_ZBSK.KO IS 'Код областi';
COMMENT ON COLUMN BARS.OTCN_F13_ZBSK.TOBO IS 'Код ТОБО';
COMMENT ON COLUMN BARS.OTCN_F13_ZBSK.KF IS '';
COMMENT ON COLUMN BARS.OTCN_F13_ZBSK.REF IS 'Референс док-та';
COMMENT ON COLUMN BARS.OTCN_F13_ZBSK.TT IS 'Код операцiї';
COMMENT ON COLUMN BARS.OTCN_F13_ZBSK.FDAT IS 'Дата операцiї';
COMMENT ON COLUMN BARS.OTCN_F13_ZBSK.ACCD IS 'Код рах. Дт';
COMMENT ON COLUMN BARS.OTCN_F13_ZBSK.NLSD IS 'Рах. Дт';
COMMENT ON COLUMN BARS.OTCN_F13_ZBSK.KV IS 'Код валюти';
COMMENT ON COLUMN BARS.OTCN_F13_ZBSK.ACCK IS 'Код рах. Кт';
COMMENT ON COLUMN BARS.OTCN_F13_ZBSK.NLSK IS 'Рах. Кт';
COMMENT ON COLUMN BARS.OTCN_F13_ZBSK.S IS 'Сума док-та номiнал';
COMMENT ON COLUMN BARS.OTCN_F13_ZBSK.SQ IS 'Сума док-та еквiвалент';
COMMENT ON COLUMN BARS.OTCN_F13_ZBSK.NAZN IS 'Призначення платежу';
COMMENT ON COLUMN BARS.OTCN_F13_ZBSK.ISP IS 'Код виконавця';
COMMENT ON COLUMN BARS.OTCN_F13_ZBSK.SK_ZB IS 'Позабал. символ';




PROMPT *** Create  constraint PK_F13_ZBSK ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTCN_F13_ZBSK ADD CONSTRAINT PK_F13_ZBSK PRIMARY KEY (RECID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_OTCNF13ZBSK_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTCN_F13_ZBSK ADD CONSTRAINT FK_OTCNF13ZBSK_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006487 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTCN_F13_ZBSK MODIFY (REF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006488 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTCN_F13_ZBSK MODIFY (RECID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OTCNF13ZBSK_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTCN_F13_ZBSK MODIFY (KF CONSTRAINT CC_OTCNF13ZBSK_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index I1_OTCN_F13_ZBSK ***
begin   
 execute immediate '
  CREATE INDEX BARS.I1_OTCN_F13_ZBSK ON BARS.OTCN_F13_ZBSK (REF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I2_OTCN_F13_ZBSK ***
begin   
 execute immediate '
  CREATE INDEX BARS.I2_OTCN_F13_ZBSK ON BARS.OTCN_F13_ZBSK (FDAT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_OTCN_F13_ZBSK ***
begin   
 execute immediate '
  CREATE INDEX BARS.PK_OTCN_F13_ZBSK ON BARS.OTCN_F13_ZBSK (RECID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OTCN_F13_ZBSK ***
grant DELETE,INSERT,SELECT,UPDATE                                            on OTCN_F13_ZBSK   to ABS_ADMIN;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on OTCN_F13_ZBSK   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on OTCN_F13_ZBSK   to BARS_DM;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on OTCN_F13_ZBSK   to RPBN002;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on OTCN_F13_ZBSK   to SALGL;
grant SELECT                                                                 on OTCN_F13_ZBSK   to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on OTCN_F13_ZBSK   to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OTCN_F13_ZBSK.sql =========*** End ***
PROMPT ===================================================================================== 
