

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPT_LETTERS.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPT_LETTERS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPT_LETTERS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DPT_LETTERS'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''DPT_LETTERS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPT_LETTERS ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPT_LETTERS 
   (	DOC_SCHEME_ID VARCHAR2(35), 
	COMMENTS VARCHAR2(254), 
	STATUS NUMBER(1,0) DEFAULT 1
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPT_LETTERS ***
 exec bpa.alter_policies('DPT_LETTERS');


COMMENT ON TABLE BARS.DPT_LETTERS IS 'Таблица типов писем и уведомлений клиентам (ПРАВЭКС)';
COMMENT ON COLUMN BARS.DPT_LETTERS.DOC_SCHEME_ID IS 'Идентификатор шаблона договора (ПК, ФК)';
COMMENT ON COLUMN BARS.DPT_LETTERS.COMMENTS IS 'Коментарий';
COMMENT ON COLUMN BARS.DPT_LETTERS.STATUS IS 'Статус активности (0-не активно, 1-активно)';




PROMPT *** Create  constraint PK_DPTLETTERS ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_LETTERS ADD CONSTRAINT PK_DPTLETTERS PRIMARY KEY (DOC_SCHEME_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTLETTERS_STATUS ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_LETTERS ADD CONSTRAINT CC_DPTLETTERS_STATUS CHECK (STATUS IN (0, 1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTLETTERS_DOCSCHEMEID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_LETTERS MODIFY (DOC_SCHEME_ID CONSTRAINT CC_DPTLETTERS_DOCSCHEMEID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTLETTERS_STATUS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_LETTERS MODIFY (STATUS CONSTRAINT CC_DPTLETTERS_STATUS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DPTLETTERS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DPTLETTERS ON BARS.DPT_LETTERS (DOC_SCHEME_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DPT_LETTERS ***
grant SELECT                                                                 on DPT_LETTERS     to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_LETTERS     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPT_LETTERS     to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_LETTERS     to DPT_ADMIN;
grant SELECT                                                                 on DPT_LETTERS     to DPT_ROLE;
grant SELECT                                                                 on DPT_LETTERS     to START1;
grant SELECT                                                                 on DPT_LETTERS     to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPT_LETTERS     to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPT_LETTERS.sql =========*** End *** =
PROMPT ===================================================================================== 
