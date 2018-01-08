

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/PEREKR_A.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to PEREKR_A ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''PEREKR_A'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''PEREKR_A'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''PEREKR_A'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table PEREKR_A ***
begin 
  execute immediate '
  CREATE TABLE BARS.PEREKR_A 
   (	IDG NUMBER(38,0), 
	IDS NUMBER(38,0), 
	ACC NUMBER(38,0), 
	SPS NUMBER(38,0), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to PEREKR_A ***
 exec bpa.alter_policies('PEREKR_A');


COMMENT ON TABLE BARS.PEREKR_A IS 'Перекрытия. Список источников.';
COMMENT ON COLUMN BARS.PEREKR_A.IDG IS 'Идентификатор группы';
COMMENT ON COLUMN BARS.PEREKR_A.IDS IS 'Идентификатор схемы';
COMMENT ON COLUMN BARS.PEREKR_A.ACC IS 'Идентификатор счета';
COMMENT ON COLUMN BARS.PEREKR_A.SPS IS 'Способ вычисления';
COMMENT ON COLUMN BARS.PEREKR_A.KF IS '';




PROMPT *** Create  constraint PK_PEREKRA ***
begin   
 execute immediate '
  ALTER TABLE BARS.PEREKR_A ADD CONSTRAINT PK_PEREKRA PRIMARY KEY (ACC)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005774 ***
begin   
 execute immediate '
  ALTER TABLE BARS.PEREKR_A MODIFY (IDG NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005775 ***
begin   
 execute immediate '
  ALTER TABLE BARS.PEREKR_A MODIFY (IDS NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005776 ***
begin   
 execute immediate '
  ALTER TABLE BARS.PEREKR_A MODIFY (ACC NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PEREKRA_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PEREKR_A MODIFY (KF CONSTRAINT CC_PEREKRA_KF_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_PEREKRA ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_PEREKRA ON BARS.PEREKR_A (ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  PEREKR_A ***
grant DELETE,INSERT,SELECT,UPDATE                                            on PEREKR_A        to ABS_ADMIN;
grant SELECT                                                                 on PEREKR_A        to BARS015;
grant SELECT                                                                 on PEREKR_A        to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on PEREKR_A        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on PEREKR_A        to BARS_DM;
grant SELECT                                                                 on PEREKR_A        to START1;
grant SELECT                                                                 on PEREKR_A        to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on PEREKR_A        to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/PEREKR_A.sql =========*** End *** ====
PROMPT ===================================================================================== 
