

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPT_VIDD_SCHEME.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPT_VIDD_SCHEME ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPT_VIDD_SCHEME'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DPT_VIDD_SCHEME'', ''FILIAL'' , null, null, null, ''E'');
               bpa.alter_policy_info(''DPT_VIDD_SCHEME'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPT_VIDD_SCHEME ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPT_VIDD_SCHEME 
   (	TYPE_ID NUMBER, 
	VIDD NUMBER, 
	FLAGS NUMBER DEFAULT 1, 
	ID VARCHAR2(100), 
	ID_FR VARCHAR2(100)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPT_VIDD_SCHEME ***
 exec bpa.alter_policies('DPT_VIDD_SCHEME');


COMMENT ON TABLE BARS.DPT_VIDD_SCHEME IS 'Код вида дополнительного соглашения';
COMMENT ON COLUMN BARS.DPT_VIDD_SCHEME.TYPE_ID IS 'Код продукту';
COMMENT ON COLUMN BARS.DPT_VIDD_SCHEME.VIDD IS 'Код виду вкладу (субпордукту)';
COMMENT ON COLUMN BARS.DPT_VIDD_SCHEME.FLAGS IS 'Код додаткової угоди';
COMMENT ON COLUMN BARS.DPT_VIDD_SCHEME.ID IS 'Ідентифікатор шаблону';
COMMENT ON COLUMN BARS.DPT_VIDD_SCHEME.ID_FR IS 'Ідентифікатор шаблону (FastReports)';




PROMPT *** Create  constraint CC_DPTVIDDSCHEME_ID_ID_FR ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD_SCHEME ADD CONSTRAINT CC_DPTVIDDSCHEME_ID_ID_FR CHECK (id is not null or id_fr is not null) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_DPTVIDDSCHEME ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD_SCHEME ADD CONSTRAINT UK_DPTVIDDSCHEME UNIQUE (TYPE_ID, VIDD, FLAGS)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTVIDDSCHEME_TID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD_SCHEME MODIFY (TYPE_ID CONSTRAINT CC_DPTVIDDSCHEME_TID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTVIDDSCHEME_FLAGS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD_SCHEME MODIFY (FLAGS CONSTRAINT CC_DPTVIDDSCHEME_FLAGS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_DPTVIDDSCHEME ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_DPTVIDDSCHEME ON BARS.DPT_VIDD_SCHEME (TYPE_ID, VIDD, FLAGS) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DPT_VIDD_SCHEME ***
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_VIDD_SCHEME to ABS_ADMIN;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_VIDD_SCHEME to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPT_VIDD_SCHEME to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_VIDD_SCHEME to DPT;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_VIDD_SCHEME to DPT_ADMIN;
grant SELECT                                                                 on DPT_VIDD_SCHEME to DPT_ROLE;
grant SELECT                                                                 on DPT_VIDD_SCHEME to START1;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_VIDD_SCHEME to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPT_VIDD_SCHEME.sql =========*** End *
PROMPT ===================================================================================== 
