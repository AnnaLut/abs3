

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPT_BONUS_SETTINGS.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPT_BONUS_SETTINGS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPT_BONUS_SETTINGS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''DPT_BONUS_SETTINGS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPT_BONUS_SETTINGS ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPT_BONUS_SETTINGS 
   (	DPT_TYPE NUMBER, 
	DPT_VIDD NUMBER, 
	KV NUMBER(3,0), 
	VAL NUMBER, 
	S NUMBER, 
	BONUS_ID NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPT_BONUS_SETTINGS ***
 exec bpa.alter_policies('DPT_BONUS_SETTINGS');


COMMENT ON TABLE BARS.DPT_BONUS_SETTINGS IS 'Довідник значень бонусів до депозитних договорів ФО';
COMMENT ON COLUMN BARS.DPT_BONUS_SETTINGS.DPT_TYPE IS 'Тип депозитного договору';
COMMENT ON COLUMN BARS.DPT_BONUS_SETTINGS.DPT_VIDD IS 'Вид депозитного договору';
COMMENT ON COLUMN BARS.DPT_BONUS_SETTINGS.KV IS 'Валюта';
COMMENT ON COLUMN BARS.DPT_BONUS_SETTINGS.VAL IS 'Значення бонуса';
COMMENT ON COLUMN BARS.DPT_BONUS_SETTINGS.S IS 'Гранична сума';
COMMENT ON COLUMN BARS.DPT_BONUS_SETTINGS.BONUS_ID IS 'Код бонусу';




PROMPT *** Create  constraint UK_DPT_BONUS_SETTINGS ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_BONUS_SETTINGS ADD CONSTRAINT UK_DPT_BONUS_SETTINGS UNIQUE (BONUS_ID, DPT_TYPE, DPT_VIDD, KV, S)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_DPT_BONUS_SETTINGS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_DPT_BONUS_SETTINGS ON BARS.DPT_BONUS_SETTINGS (BONUS_ID, DPT_TYPE, DPT_VIDD, KV, S) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DPT_BONUS_SETTINGS ***
grant SELECT                                                                 on DPT_BONUS_SETTINGS to BARSREADER_ROLE;
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on DPT_BONUS_SETTINGS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPT_BONUS_SETTINGS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPT_BONUS_SETTINGS.sql =========*** En
PROMPT ===================================================================================== 
