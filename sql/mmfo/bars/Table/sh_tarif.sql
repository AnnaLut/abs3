

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SH_TARIF.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SH_TARIF ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SH_TARIF'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SH_TARIF'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''SH_TARIF'', ''WHOLE'' , null, ''null'', ''null'', ''null'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SH_TARIF ***
begin 
  execute immediate '
  CREATE TABLE BARS.SH_TARIF 
   (	IDS NUMBER, 
	KOD NUMBER(22,0), 
	TAR NUMBER(22,0), 
	PR NUMBER(20,4), 
	SMIN NUMBER(22,0), 
	SMAX NUMBER(22,0), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	NBS_OB22 CHAR(6)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SH_TARIF ***
 exec bpa.alter_policies('SH_TARIF');


COMMENT ON TABLE BARS.SH_TARIF IS 'ПАКЕТЫ тарифов';
COMMENT ON COLUMN BARS.SH_TARIF.IDS IS 'Код ПАКЕТА тарифов';
COMMENT ON COLUMN BARS.SH_TARIF.KOD IS 'Код тарифа';
COMMENT ON COLUMN BARS.SH_TARIF.TAR IS 'Тариф';
COMMENT ON COLUMN BARS.SH_TARIF.PR IS '% от суммы документа';
COMMENT ON COLUMN BARS.SH_TARIF.SMIN IS 'Минимальная сумма тарифа';
COMMENT ON COLUMN BARS.SH_TARIF.SMAX IS 'Максимальная сумма тарифа';
COMMENT ON COLUMN BARS.SH_TARIF.KF IS '';
COMMENT ON COLUMN BARS.SH_TARIF.NBS_OB22 IS '';




PROMPT *** Create  constraint PK_SHTARIF ***
begin   
 execute immediate '
  ALTER TABLE BARS.SH_TARIF ADD CONSTRAINT PK_SHTARIF PRIMARY KEY (KF, IDS, KOD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SHTARIF_KOD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SH_TARIF MODIFY (KOD CONSTRAINT CC_SHTARIF_KOD_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SHTARIF_IDS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SH_TARIF MODIFY (IDS CONSTRAINT CC_SHTARIF_IDS_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SHTARIF_TAR_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SH_TARIF MODIFY (TAR CONSTRAINT CC_SHTARIF_TAR_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SHTARIF_PR_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SH_TARIF MODIFY (PR CONSTRAINT CC_SHTARIF_PR_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SHTARIF_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SH_TARIF MODIFY (KF CONSTRAINT CC_SHTARIF_KF_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SHTARIF ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SHTARIF ON BARS.SH_TARIF (KF, IDS, KOD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SH_TARIF ***
grant DELETE,INSERT,SELECT,UPDATE                                            on SH_TARIF        to ABS_ADMIN;
grant SELECT                                                                 on SH_TARIF        to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SH_TARIF        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SH_TARIF        to BARS_DM;
grant SELECT                                                                 on SH_TARIF        to START1;
grant SELECT                                                                 on SH_TARIF        to UPLD;
grant FLASHBACK,SELECT                                                       on SH_TARIF        to WR_REFREAD;



PROMPT *** Create SYNONYM  to SH_TARIF ***

  CREATE OR REPLACE PUBLIC SYNONYM SH_TARIF FOR BARS.SH_TARIF;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SH_TARIF.sql =========*** End *** ====
PROMPT ===================================================================================== 
