

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPT_BRATES.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPT_BRATES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPT_BRATES'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DPT_BRATES'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''DPT_BRATES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPT_BRATES ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPT_BRATES 
   (	MOD_CODE VARCHAR2(3), 
	VIDD NUMBER(38,0), 
	DATE_ENTRY DATE, 
	BR_ID NUMBER(38,0), 
	BASEY NUMBER(38,0) DEFAULT 0
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPT_BRATES ***
 exec bpa.alter_policies('DPT_BRATES');


COMMENT ON TABLE BARS.DPT_BRATES IS 'Історія змін базових ставок для видів банківських продуктів (по датам вступу в дію)';
COMMENT ON COLUMN BARS.DPT_BRATES.MOD_CODE IS 'Код~модуля';
COMMENT ON COLUMN BARS.DPT_BRATES.VIDD IS 'Код~виду';
COMMENT ON COLUMN BARS.DPT_BRATES.DATE_ENTRY IS 'Дата~вступу в дію';
COMMENT ON COLUMN BARS.DPT_BRATES.BR_ID IS 'Код~базовой~ставки';
COMMENT ON COLUMN BARS.DPT_BRATES.BASEY IS 'Базовий~рік';




PROMPT *** Create  constraint PK_DPTBRATES ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_BRATES ADD CONSTRAINT PK_DPTBRATES PRIMARY KEY (MOD_CODE, VIDD, DATE_ENTRY)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTBRATES_MODCODE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_BRATES MODIFY (MOD_CODE CONSTRAINT CC_DPTBRATES_MODCODE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTBRATES_VIDD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_BRATES MODIFY (VIDD CONSTRAINT CC_DPTBRATES_VIDD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTBRATES_DATEENTRY_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_BRATES MODIFY (DATE_ENTRY CONSTRAINT CC_DPTBRATES_DATEENTRY_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTBRATES_BRID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_BRATES MODIFY (BR_ID CONSTRAINT CC_DPTBRATES_BRID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTBRATES_BASE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_BRATES MODIFY (BASEY CONSTRAINT CC_DPTBRATES_BASE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DPTBRATES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DPTBRATES ON BARS.DPT_BRATES (MOD_CODE, VIDD, DATE_ENTRY) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I1_DPT_BRATES ***
begin   
 execute immediate '
  CREATE INDEX BARS.I1_DPT_BRATES ON BARS.DPT_BRATES (BR_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I2_DPT_BRATES ***
begin   
 execute immediate '
  CREATE INDEX BARS.I2_DPT_BRATES ON BARS.DPT_BRATES (DATE_ENTRY) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DPT_BRATES ***
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_BRATES      to ABS_ADMIN;
grant SELECT                                                                 on DPT_BRATES      to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_BRATES      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPT_BRATES      to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_BRATES      to DPT_ADMIN;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_BRATES      to DPT_ROLE;
grant SELECT                                                                 on DPT_BRATES      to REFSYNC_USR;
grant SELECT                                                                 on DPT_BRATES      to TECH001;
grant SELECT                                                                 on DPT_BRATES      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPT_BRATES.sql =========*** End *** ==
PROMPT ===================================================================================== 
