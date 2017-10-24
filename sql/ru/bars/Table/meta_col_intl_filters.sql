

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/META_COL_INTL_FILTERS.sql =========***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to META_COL_INTL_FILTERS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''META_COL_INTL_FILTERS'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''META_COL_INTL_FILTERS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table META_COL_INTL_FILTERS ***
begin 
  execute immediate '
  CREATE TABLE BARS.META_COL_INTL_FILTERS 
   (	FILTER_ID NUMBER(38,0), 
	TABID NUMBER(38,0), 
	COLID NUMBER(38,0), 
	MANDATORY_FLAG_ID NUMBER(1,0) DEFAULT 0
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to META_COL_INTL_FILTERS ***
 exec bpa.alter_policies('META_COL_INTL_FILTERS');


COMMENT ON TABLE BARS.META_COL_INTL_FILTERS IS '“аблиц€ ф≥льтр≥в в≥дображуваних при вход≥ в дов≥дник описаний в баз≥ метаданих';
COMMENT ON COLUMN BARS.META_COL_INTL_FILTERS.FILTER_ID IS '≤дентиф≥катор ф≥льтра';
COMMENT ON COLUMN BARS.META_COL_INTL_FILTERS.TABID IS '≤дентиф≥катор таблиц≥ в баз≥ метаданих';
COMMENT ON COLUMN BARS.META_COL_INTL_FILTERS.COLID IS '≤дентиф≥катор колонки таблиц≥ в баз≥ метаданих';
COMMENT ON COLUMN BARS.META_COL_INTL_FILTERS.MANDATORY_FLAG_ID IS 'ќзнака обов€зковост≥ заповненн€ даного ф≥льтру';




PROMPT *** Create  constraint FK_METACOLINTLF_METAMNDF ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_COL_INTL_FILTERS ADD CONSTRAINT FK_METACOLINTLF_METAMNDF FOREIGN KEY (MANDATORY_FLAG_ID)
	  REFERENCES BARS.META_MANDATORY_FLAGS (MANDATORY_FLAG_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_METACOLINTLF_METACOLS ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_COL_INTL_FILTERS ADD CONSTRAINT FK_METACOLINTLF_METACOLS FOREIGN KEY (TABID, COLID)
	  REFERENCES BARS.META_COLUMNS (TABID, COLID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_META_COL_INTL_FILTERS ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_COL_INTL_FILTERS ADD CONSTRAINT PK_META_COL_INTL_FILTERS PRIMARY KEY (FILTER_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_METACOLINTLF_MFLAG_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_COL_INTL_FILTERS MODIFY (MANDATORY_FLAG_ID CONSTRAINT CC_METACOLINTLF_MFLAG_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_METACOLINTLF_COLID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_COL_INTL_FILTERS MODIFY (COLID CONSTRAINT CC_METACOLINTLF_COLID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_METACOLINTLF_TABID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_COL_INTL_FILTERS MODIFY (TABID CONSTRAINT CC_METACOLINTLF_TABID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_METACOLINTLF_FID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_COL_INTL_FILTERS MODIFY (FILTER_ID CONSTRAINT CC_METACOLINTLF_FID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_META_COL_INTL_FILTERS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_META_COL_INTL_FILTERS ON BARS.META_COL_INTL_FILTERS (FILTER_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_META_COL_INTL_FILTERS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_META_COL_INTL_FILTERS ON BARS.META_COL_INTL_FILTERS (TABID, COLID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  META_COL_INTL_FILTERS ***
grant SELECT                                                                 on META_COL_INTL_FILTERS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on META_COL_INTL_FILTERS to START1;
grant DELETE,INSERT,SELECT,UPDATE                                            on META_COL_INTL_FILTERS to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/META_COL_INTL_FILTERS.sql =========***
PROMPT ===================================================================================== 
