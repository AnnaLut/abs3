

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NLK_REF_UPDATE.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to NLK_REF_UPDATE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NLK_REF_UPDATE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''NLK_REF_UPDATE'', ''FILIAL'', ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''NLK_REF_UPDATE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NLK_REF_UPDATE ***
begin 
  execute immediate '
  CREATE TABLE BARS.NLK_REF_UPDATE 
   (	REF1 NUMBER(38,0), 
	REF2 NUMBER(38,0), 
	ACC NUMBER(38,0), 
	KF VARCHAR2(6), 
	REF2_STATE VARCHAR2(1), 
	CHGDATE DATE, 
	CHGACTION NUMBER, 
	DONEBY VARCHAR2(64), 
	IDUPD NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to NLK_REF_UPDATE ***
 exec bpa.alter_policies('NLK_REF_UPDATE');


COMMENT ON TABLE BARS.NLK_REF_UPDATE IS 'Картотека кредитовых поступлений';
COMMENT ON COLUMN BARS.NLK_REF_UPDATE.REF1 IS 'Референс начального документа';
COMMENT ON COLUMN BARS.NLK_REF_UPDATE.REF2 IS 'Референс перекредитованного документа';
COMMENT ON COLUMN BARS.NLK_REF_UPDATE.ACC IS 'Идентификатор счета картотеки';
COMMENT ON COLUMN BARS.NLK_REF_UPDATE.KF IS '';
COMMENT ON COLUMN BARS.NLK_REF_UPDATE.REF2_STATE IS 'Состояние документа ref2: P - плановый, NULL - фактический.Для ref2 is null всегда ref2_state is null';
COMMENT ON COLUMN BARS.NLK_REF_UPDATE.CHGDATE IS 'Дата изменения';
COMMENT ON COLUMN BARS.NLK_REF_UPDATE.CHGACTION IS 'Тип изменения';
COMMENT ON COLUMN BARS.NLK_REF_UPDATE.DONEBY IS 'Кто изменил';
COMMENT ON COLUMN BARS.NLK_REF_UPDATE.IDUPD IS 'Id';




PROMPT *** Create  constraint XPK_SKRYNKANDUPDATE ***
begin   
 execute immediate '
  ALTER TABLE BARS.NLK_REF_UPDATE ADD CONSTRAINT XPK_SKRYNKANDUPDATE PRIMARY KEY (IDUPD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_SKRYNKANDUPDATE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_SKRYNKANDUPDATE ON BARS.NLK_REF_UPDATE (IDUPD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/


PROMPT *** Create  index IDX_SKRYNKANDUPDATE ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_SKRYNKANDUPDATE ON BARS.NLK_REF_UPDATE (ACC, KF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/


PROMPT *** Create  grants  NLK_REF_UPDATE ***
grant SELECT                                                                 on NLK_REF_UPDATE  to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on NLK_REF_UPDATE  to BARS_ACCESS_DEFROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on NLK_REF_UPDATE  to START1;
grant SELECT                                                                 on NLK_REF_UPDATE  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NLK_REF_UPDATE.sql =========*** End **
PROMPT ===================================================================================== 
