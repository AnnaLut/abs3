

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ALT_BPK.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ALT_BPK ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ALT_BPK'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''ALT_BPK'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''ALT_BPK'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ALT_BPK ***
begin 
  execute immediate '
  CREATE TABLE BARS.ALT_BPK 
   (	ID NUMBER(38,0), 
	NLSA VARCHAR2(15), 
	S NUMBER(24,2), 
	FIO VARCHAR2(70), 
	NAZN VARCHAR2(160), 
	NLSB VARCHAR2(15), 
	SK_ZB NUMBER(*,0), 
	BRANCH VARCHAR2(30), 
	USERID NUMBER(38,0), 
	REF NUMBER(38,0), 
	ERROR VARCHAR2(250), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ALT_BPK ***
 exec bpa.alter_policies('ALT_BPK');


COMMENT ON TABLE BARS.ALT_BPK IS 'Таблиця для зарахування на БПК';
COMMENT ON COLUMN BARS.ALT_BPK.KF IS '';
COMMENT ON COLUMN BARS.ALT_BPK.ID IS '№ П/П';
COMMENT ON COLUMN BARS.ALT_BPK.NLSA IS 'Рахунок А';
COMMENT ON COLUMN BARS.ALT_BPK.S IS 'Сума';
COMMENT ON COLUMN BARS.ALT_BPK.FIO IS 'Прізвище отримувача';
COMMENT ON COLUMN BARS.ALT_BPK.NAZN IS 'Призначення';
COMMENT ON COLUMN BARS.ALT_BPK.NLSB IS 'Рахунок Б';
COMMENT ON COLUMN BARS.ALT_BPK.SK_ZB IS 'Позабалансовий символ';
COMMENT ON COLUMN BARS.ALT_BPK.BRANCH IS 'Відділення';
COMMENT ON COLUMN BARS.ALT_BPK.USERID IS 'Код користувача';
COMMENT ON COLUMN BARS.ALT_BPK.REF IS 'Референс оплоченого документа';
COMMENT ON COLUMN BARS.ALT_BPK.ERROR IS '';




PROMPT *** Create  constraint PK_ALTBPK ***
begin   
 execute immediate '
  ALTER TABLE BARS.ALT_BPK ADD CONSTRAINT PK_ALTBPK PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ALTBPK_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ALT_BPK MODIFY (KF CONSTRAINT CC_ALTBPK_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ALTBPK_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ALT_BPK MODIFY (ID CONSTRAINT CC_ALTBPK_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ALTBPK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ALTBPK ON BARS.ALT_BPK (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I2_ALTBPK ***
begin   
 execute immediate '
  CREATE INDEX BARS.I2_ALTBPK ON BARS.ALT_BPK (REF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ALT_BPK ***
grant SELECT                                                                 on ALT_BPK         to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on ALT_BPK         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ALT_BPK         to BARS_DM;
grant SELECT                                                                 on ALT_BPK         to START1;
grant SELECT                                                                 on ALT_BPK         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ALT_BPK.sql =========*** End *** =====
PROMPT ===================================================================================== 
