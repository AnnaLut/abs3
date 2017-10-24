

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/E_TAR_ND.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to E_TAR_ND ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''E_TAR_ND'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''E_TAR_ND'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''E_TAR_ND'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table E_TAR_ND ***
begin 
  execute immediate '
  CREATE TABLE BARS.E_TAR_ND 
   (	ND NUMBER(*,0), 
	ID NUMBER(*,0), 
	OTM NUMBER(*,0) DEFAULT 0, 
	DAT_BEG DATE, 
	DAT_END DATE, 
	DAT_OPL DATE, 
	SUMT NUMBER, 
	SUMT1 NUMBER, 
	DAT_LB DATE, 
	DAT_LE DATE, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	S_PROGN NUMBER, 
	DAT_PROGN DATE, 
	S_POROG NUMBER, 
	S_TAR_POR1 NUMBER, 
	S_TAR_POR2 NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to E_TAR_ND ***
 exec bpa.alter_policies('E_TAR_ND');


COMMENT ON TABLE BARS.E_TAR_ND IS 'Договора и эл.услуги';
COMMENT ON COLUMN BARS.E_TAR_ND.ND IS 'Реф дог';
COMMENT ON COLUMN BARS.E_TAR_ND.ID IS 'Идент услуги';
COMMENT ON COLUMN BARS.E_TAR_ND.OTM IS 'Отметка о вкл 1-вкл, иначе0 выкл';
COMMENT ON COLUMN BARS.E_TAR_ND.DAT_BEG IS 'Дата подключения услуги';
COMMENT ON COLUMN BARS.E_TAR_ND.DAT_END IS 'Дата отключения услуги';
COMMENT ON COLUMN BARS.E_TAR_ND.DAT_OPL IS 'Пред. дата расчета ';
COMMENT ON COLUMN BARS.E_TAR_ND.SUMT IS 'Инд.тариф (общ)в коп';
COMMENT ON COLUMN BARS.E_TAR_ND.SUMT1 IS 'Инд.тариф (1 док)в коп';
COMMENT ON COLUMN BARS.E_TAR_ND.DAT_LB IS 'Початок д_ї п_льг.тарифу';
COMMENT ON COLUMN BARS.E_TAR_ND.DAT_LE IS 'Зак_нчення д_ї п_льг.тарифу';
COMMENT ON COLUMN BARS.E_TAR_ND.KF IS '';
COMMENT ON COLUMN BARS.E_TAR_ND.S_PROGN IS '';
COMMENT ON COLUMN BARS.E_TAR_ND.DAT_PROGN IS '';
COMMENT ON COLUMN BARS.E_TAR_ND.S_POROG IS '';
COMMENT ON COLUMN BARS.E_TAR_ND.S_TAR_POR1 IS '';
COMMENT ON COLUMN BARS.E_TAR_ND.S_TAR_POR2 IS '';




PROMPT *** Create  constraint PK_ETARND ***
begin   
 execute immediate '
  ALTER TABLE BARS.E_TAR_ND ADD CONSTRAINT PK_ETARND PRIMARY KEY (ND, ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_E_TAR_ND_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.E_TAR_ND ADD CONSTRAINT FK_E_TAR_ND_ID FOREIGN KEY (KF, ID)
	  REFERENCES BARS.E_TARIF (KF, ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ETARND_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.E_TAR_ND ADD CONSTRAINT FK_ETARND_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if sqlcode=-54 or  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ETARND_EDEAL$BASE ***
begin   
 execute immediate '
  ALTER TABLE BARS.E_TAR_ND ADD CONSTRAINT FK_ETARND_EDEAL$BASE FOREIGN KEY (KF, ND)
	  REFERENCES BARS.E_DEAL$BASE (KF, ND) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_E_TAR_ND_ND ***
begin   
 execute immediate '
  ALTER TABLE BARS.E_TAR_ND MODIFY (ND CONSTRAINT NK_E_TAR_ND_ND NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_E_TAR_ND_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.E_TAR_ND MODIFY (ID CONSTRAINT NK_E_TAR_ND_ID NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ETARND_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.E_TAR_ND MODIFY (KF CONSTRAINT CC_ETARND_KF_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ETARND ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ETARND ON BARS.E_TAR_ND (ND, ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  E_TAR_ND ***
grant DELETE,INSERT,SELECT,UPDATE                                            on E_TAR_ND        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on E_TAR_ND        to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on E_TAR_ND        to ELT;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on E_TAR_ND        to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to E_TAR_ND ***

  CREATE OR REPLACE PUBLIC SYNONYM E_TAR_ND FOR BARS.E_TAR_ND;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/E_TAR_ND.sql =========*** End *** ====
PROMPT ===================================================================================== 
