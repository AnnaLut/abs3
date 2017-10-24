

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPT_VIDD_SCHEME_ARC.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPT_VIDD_SCHEME_ARC ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPT_VIDD_SCHEME_ARC'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''DPT_VIDD_SCHEME_ARC'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPT_VIDD_SCHEME_ARC ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPT_VIDD_SCHEME_ARC 
   (	TYPE_ID NUMBER, 
	VIDD NUMBER, 
	FLAGS NUMBER DEFAULT 1, 
	ID VARCHAR2(100), 
	ID_FR VARCHAR2(100)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPT_VIDD_SCHEME_ARC ***
 exec bpa.alter_policies('DPT_VIDD_SCHEME_ARC');


COMMENT ON TABLE BARS.DPT_VIDD_SCHEME_ARC IS 'Код вида дополнительного соглашения';
COMMENT ON COLUMN BARS.DPT_VIDD_SCHEME_ARC.TYPE_ID IS 'Код продукту';
COMMENT ON COLUMN BARS.DPT_VIDD_SCHEME_ARC.VIDD IS 'Код виду вкладу (субпордукту)';
COMMENT ON COLUMN BARS.DPT_VIDD_SCHEME_ARC.FLAGS IS 'Код додаткової угоди';
COMMENT ON COLUMN BARS.DPT_VIDD_SCHEME_ARC.ID IS 'Ідентифікатор шаблону';
COMMENT ON COLUMN BARS.DPT_VIDD_SCHEME_ARC.ID_FR IS 'Ідентифікатор шаблону (FastReports)';




PROMPT *** Create  constraint CC_DPTVIDDSCHEME_ARC_FLAGS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD_SCHEME_ARC MODIFY (FLAGS CONSTRAINT CC_DPTVIDDSCHEME_ARC_FLAGS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTVIDDSCHEME_ARC_TID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD_SCHEME_ARC MODIFY (TYPE_ID CONSTRAINT CC_DPTVIDDSCHEME_ARC_TID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DPT_VIDD_SCHEME_ARC ***
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on DPT_VIDD_SCHEME_ARC to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPT_VIDD_SCHEME_ARC to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPT_VIDD_SCHEME_ARC.sql =========*** E
PROMPT ===================================================================================== 
