

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPT_DEPOSITW.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPT_DEPOSITW ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPT_DEPOSITW'', ''CENTER'' , ''E'', ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''DPT_DEPOSITW'', ''FILIAL'' , null, ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''DPT_DEPOSITW'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPT_DEPOSITW ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPT_DEPOSITW 
   (	DPT_ID NUMBER(38,0), 
	TAG CHAR(5), 
	VALUE VARCHAR2(500), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	BRANCH VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPT_DEPOSITW ***
 exec bpa.alter_policies('DPT_DEPOSITW');


COMMENT ON TABLE BARS.DPT_DEPOSITW IS 'Хранилище доп.реквизитов вкладов';
COMMENT ON COLUMN BARS.DPT_DEPOSITW.DPT_ID IS '№ вклада';
COMMENT ON COLUMN BARS.DPT_DEPOSITW.TAG IS 'Код реквизита';
COMMENT ON COLUMN BARS.DPT_DEPOSITW.VALUE IS 'Значение реквизита';
COMMENT ON COLUMN BARS.DPT_DEPOSITW.KF IS '';
COMMENT ON COLUMN BARS.DPT_DEPOSITW.BRANCH IS '';




PROMPT *** Create  constraint PK_DPTDEPOSITW ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DEPOSITW ADD CONSTRAINT PK_DPTDEPOSITW PRIMARY KEY (DPT_ID, TAG)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTDEPOSITW_DPTID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DEPOSITW MODIFY (DPT_ID CONSTRAINT CC_DPTDEPOSITW_DPTID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTDEPOSITW_TAG_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DEPOSITW MODIFY (TAG CONSTRAINT CC_DPTDEPOSITW_TAG_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTDEPOSITW_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DEPOSITW MODIFY (KF CONSTRAINT CC_DPTDEPOSITW_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTDEPOSITW_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DEPOSITW MODIFY (BRANCH CONSTRAINT CC_DPTDEPOSITW_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DPTDEPOSITW ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DPTDEPOSITW ON BARS.DPT_DEPOSITW (DPT_ID, TAG) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DPT_DEPOSITW ***
grant SELECT                                                                 on DPT_DEPOSITW    to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_DEPOSITW    to BARS_ACCESS_DEFROLE;
grant ALTER,DEBUG,DELETE,FLASHBACK,INDEX,INSERT,ON COMMIT REFRESH,QUERY REWRITE,REFERENCES,SELECT,UPDATE on DPT_DEPOSITW    to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_DEPOSITW    to DPT_ROLE;
grant SELECT                                                                 on DPT_DEPOSITW    to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPT_DEPOSITW    to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPT_DEPOSITW.sql =========*** End *** 
PROMPT ===================================================================================== 
