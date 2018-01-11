

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPT_EXTCONSENT.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPT_EXTCONSENT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPT_EXTCONSENT'', ''CENTER'' , ''E'', ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''DPT_EXTCONSENT'', ''FILIAL'' , null, ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''DPT_EXTCONSENT'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPT_EXTCONSENT ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPT_EXTCONSENT 
   (	DPT_ID NUMBER(38,0), 
	DAT_BEGIN DATE, 
	DAT_END DATE, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPT_EXTCONSENT ***
 exec bpa.alter_policies('DPT_EXTCONSENT');


COMMENT ON TABLE BARS.DPT_EXTCONSENT IS 'Вклади, власники яких підписали ДУ на пролонгацію';
COMMENT ON COLUMN BARS.DPT_EXTCONSENT.DPT_ID IS 'Іденитифікатор вкладу';
COMMENT ON COLUMN BARS.DPT_EXTCONSENT.DAT_BEGIN IS 'Дата автолонгації вкладу';
COMMENT ON COLUMN BARS.DPT_EXTCONSENT.DAT_END IS 'Дата завершення вкладу після автолонгації';
COMMENT ON COLUMN BARS.DPT_EXTCONSENT.KF IS '';




PROMPT *** Create  constraint PK_DPTEXTCONSENT ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_EXTCONSENT ADD CONSTRAINT PK_DPTEXTCONSENT PRIMARY KEY (DPT_ID, DAT_BEGIN)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTEXTCONSENT_DPTID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_EXTCONSENT MODIFY (DPT_ID CONSTRAINT CC_DPTEXTCONSENT_DPTID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTEXTCONSENT_DATBEGIN_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_EXTCONSENT MODIFY (DAT_BEGIN CONSTRAINT CC_DPTEXTCONSENT_DATBEGIN_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTEXTCONSENT_DATEND_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_EXTCONSENT MODIFY (DAT_END CONSTRAINT CC_DPTEXTCONSENT_DATEND_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTEXTCONSENT_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_EXTCONSENT MODIFY (KF CONSTRAINT CC_DPTEXTCONSENT_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DPTEXTCONSENT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DPTEXTCONSENT ON BARS.DPT_EXTCONSENT (DPT_ID, DAT_BEGIN) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DPT_EXTCONSENT ***
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_EXTCONSENT  to ABS_ADMIN;
grant SELECT                                                                 on DPT_EXTCONSENT  to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_EXTCONSENT  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPT_EXTCONSENT  to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_EXTCONSENT  to DPT_ADMIN;
grant SELECT                                                                 on DPT_EXTCONSENT  to START1;
grant SELECT                                                                 on DPT_EXTCONSENT  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPT_EXTCONSENT.sql =========*** End **
PROMPT ===================================================================================== 
