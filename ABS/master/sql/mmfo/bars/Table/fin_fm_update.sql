

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/FIN_FM_UPDATE.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to FIN_FM_UPDATE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''FIN_FM_UPDATE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''FIN_FM_UPDATE'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''FIN_FM_UPDATE'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table FIN_FM_UPDATE ***
begin 
  execute immediate '
  CREATE TABLE BARS.FIN_FM_UPDATE 
   (	OKPO NUMBER, 
	FDAT DATE, 
	FM CHAR(1), 
	DATE_F1 DATE, 
	DATE_F2 DATE, 
	CHGDATE DATE, 
	CHGACTION NUMBER, 
	DONEBY VARCHAR2(64), 
	IDUPD NUMBER, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to FIN_FM_UPDATE ***
 exec bpa.alter_policies('FIN_FM_UPDATE');


COMMENT ON TABLE BARS.FIN_FM_UPDATE IS 'История збереження форми 1 та 2 ';
COMMENT ON COLUMN BARS.FIN_FM_UPDATE.OKPO IS 'Код ОКПО клиента';
COMMENT ON COLUMN BARS.FIN_FM_UPDATE.FDAT IS 'Дата изменения';
COMMENT ON COLUMN BARS.FIN_FM_UPDATE.FM IS 'Форма "М" или " "';
COMMENT ON COLUMN BARS.FIN_FM_UPDATE.DATE_F1 IS 'Дата збереження Форми 1';
COMMENT ON COLUMN BARS.FIN_FM_UPDATE.DATE_F2 IS 'Дата збереження Форми 2';
COMMENT ON COLUMN BARS.FIN_FM_UPDATE.CHGDATE IS 'Дата изменения';
COMMENT ON COLUMN BARS.FIN_FM_UPDATE.CHGACTION IS 'Тип изменения';
COMMENT ON COLUMN BARS.FIN_FM_UPDATE.DONEBY IS 'Кто изменил';
COMMENT ON COLUMN BARS.FIN_FM_UPDATE.IDUPD IS 'Id';
COMMENT ON COLUMN BARS.FIN_FM_UPDATE.KF IS '';




PROMPT *** Create  constraint XPK_FINFM_UPDATE ***
begin   
 execute immediate '
  ALTER TABLE BARS.FIN_FM_UPDATE ADD CONSTRAINT XPK_FINFM_UPDATE PRIMARY KEY (IDUPD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_FINFMUPDATE_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.FIN_FM_UPDATE MODIFY (KF CONSTRAINT CC_FINFMUPDATE_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_FINFM_UPDATE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_FINFM_UPDATE ON BARS.FIN_FM_UPDATE (IDUPD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  FIN_FM_UPDATE ***
grant SELECT                                                                 on FIN_FM_UPDATE   to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on FIN_FM_UPDATE   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on FIN_FM_UPDATE   to BARS_DM;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on FIN_FM_UPDATE   to START1;
grant SELECT                                                                 on FIN_FM_UPDATE   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/FIN_FM_UPDATE.sql =========*** End ***
PROMPT ===================================================================================== 
