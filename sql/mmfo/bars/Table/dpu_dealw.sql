

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPU_DEALW.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPU_DEALW ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPU_DEALW'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''DPU_DEALW'', ''FILIAL'' , null, ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''DPU_DEALW'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPU_DEALW ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPU_DEALW 
   (	DPU_ID NUMBER(38,0), 
	TAG VARCHAR2(10), 
	VALUE VARCHAR2(250), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPU_DEALW ***
 exec bpa.alter_policies('DPU_DEALW');


COMMENT ON TABLE BARS.DPU_DEALW IS 'Додаткові параметри депозитних договорів ЮО';
COMMENT ON COLUMN BARS.DPU_DEALW.DPU_ID IS 'Ідентифікатор депозитного договору ЮО';
COMMENT ON COLUMN BARS.DPU_DEALW.TAG IS 'Код дод. параметру';
COMMENT ON COLUMN BARS.DPU_DEALW.VALUE IS 'Значення дод. параметру';
COMMENT ON COLUMN BARS.DPU_DEALW.KF IS '';




PROMPT *** Create  constraint PK_DPUDEALW ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_DEALW ADD CONSTRAINT PK_DPUDEALW PRIMARY KEY (DPU_ID, TAG)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUDEALW_DPUID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_DEALW MODIFY (DPU_ID CONSTRAINT CC_DPUDEALW_DPUID_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUDEALW_TAG_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_DEALW MODIFY (TAG CONSTRAINT CC_DPUDEALW_TAG_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUDEALW_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_DEALW MODIFY (KF CONSTRAINT CC_DPUDEALW_KF_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DPUDEALW ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DPUDEALW ON BARS.DPU_DEALW (DPU_ID, TAG) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I1_DPUDEALW ***
begin   
 execute immediate '
  CREATE INDEX BARS.I1_DPUDEALW ON BARS.DPU_DEALW (TAG, VALUE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DPU_DEALW ***
grant DELETE,INSERT,SELECT,UPDATE                                            on DPU_DEALW       to ABS_ADMIN;
grant SELECT                                                                 on DPU_DEALW       to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPU_DEALW       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPU_DEALW       to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPU_DEALW       to DPT_ADMIN;
grant SELECT                                                                 on DPU_DEALW       to START1;
grant SELECT                                                                 on DPU_DEALW       to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPU_DEALW.sql =========*** End *** ===
PROMPT ===================================================================================== 
