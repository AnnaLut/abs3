

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TAX_SETTINGS.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TAX_SETTINGS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TAX_SETTINGS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''TAX_SETTINGS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''TAX_SETTINGS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TAX_SETTINGS ***
begin 
  execute immediate '
  CREATE TABLE BARS.TAX_SETTINGS 
   (	ID NUMBER(*,0), 
	TAX_TYPE NUMBER(*,0), 
	TAX_NAME VARCHAR2(100), 
	DAT_BEGIN DATE, 
	DAT_END DATE, 
	TAX_INT NUMBER, 
	TAX_OB22_3622 VARCHAR2(2), 
	TAX_OB22_3522 VARCHAR2(2)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TAX_SETTINGS ***
 exec bpa.alter_policies('TAX_SETTINGS');


COMMENT ON TABLE BARS.TAX_SETTINGS IS 'Перелік податків з пасивних доходів ФО';
COMMENT ON COLUMN BARS.TAX_SETTINGS.ID IS 'Порядковий номер';
COMMENT ON COLUMN BARS.TAX_SETTINGS.TAX_TYPE IS 'Тип податку (код)';
COMMENT ON COLUMN BARS.TAX_SETTINGS.TAX_NAME IS 'Назва податку';
COMMENT ON COLUMN BARS.TAX_SETTINGS.DAT_BEGIN IS 'Дата початку періода оподаткування';
COMMENT ON COLUMN BARS.TAX_SETTINGS.DAT_END IS 'Дата закінчення періода оподаткування';
COMMENT ON COLUMN BARS.TAX_SETTINGS.TAX_INT IS 'Ставка оподаткування на вказаний період';
COMMENT ON COLUMN BARS.TAX_SETTINGS.TAX_OB22_3622 IS '';
COMMENT ON COLUMN BARS.TAX_SETTINGS.TAX_OB22_3522 IS '';




PROMPT *** Create  constraint CHK_TAX_SETTINGS ***
begin   
 execute immediate '
  ALTER TABLE BARS.TAX_SETTINGS ADD CONSTRAINT CHK_TAX_SETTINGS CHECK (DAT_BEGIN < DAT_END OR DAT_END IS NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_TAX_TYPE_TAX_SETTINGS ***
begin   
 execute immediate '
  ALTER TABLE BARS.TAX_SETTINGS ADD CONSTRAINT PK_TAX_TYPE_TAX_SETTINGS PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_1TAX_PERIODS ***
begin   
 execute immediate '
  ALTER TABLE BARS.TAX_SETTINGS ADD CONSTRAINT UK_1TAX_PERIODS UNIQUE (TAX_TYPE, DAT_BEGIN, DAT_END)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_TAX_TYPE_TAX_SETTINGS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_TAX_TYPE_TAX_SETTINGS ON BARS.TAX_SETTINGS (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_1TAX_SETTINGS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_1TAX_SETTINGS ON BARS.TAX_SETTINGS (TAX_TYPE, DAT_BEGIN, DAT_END) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TAX_SETTINGS ***
grant SELECT                                                                 on TAX_SETTINGS    to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TAX_SETTINGS    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TAX_SETTINGS    to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on TAX_SETTINGS    to START1;
grant SELECT                                                                 on TAX_SETTINGS    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TAX_SETTINGS.sql =========*** End *** 
PROMPT ===================================================================================== 
