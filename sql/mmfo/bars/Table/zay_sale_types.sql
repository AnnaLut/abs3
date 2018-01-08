

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ZAY_SALE_TYPES.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ZAY_SALE_TYPES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ZAY_SALE_TYPES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ZAY_SALE_TYPES ***
begin 
  execute immediate '
  CREATE TABLE BARS.ZAY_SALE_TYPES 
   (	TP_ID NUMBER(1,0), 
	TP_NM VARCHAR2(100)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ZAY_SALE_TYPES ***
 exec bpa.alter_policies('ZAY_SALE_TYPES');


COMMENT ON TABLE BARS.ZAY_SALE_TYPES IS 'Види надходжень для продажу валюти';
COMMENT ON COLUMN BARS.ZAY_SALE_TYPES.TP_ID IS 'Код виду надходження';
COMMENT ON COLUMN BARS.ZAY_SALE_TYPES.TP_NM IS 'Опис виду надходження';




PROMPT *** Create  constraint PK_ZAYSALETYPES ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAY_SALE_TYPES ADD CONSTRAINT PK_ZAYSALETYPES PRIMARY KEY (TP_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ZAYSALETYPES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ZAYSALETYPES ON BARS.ZAY_SALE_TYPES (TP_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ZAY_SALE_TYPES ***
grant SELECT                                                                 on ZAY_SALE_TYPES  to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on ZAY_SALE_TYPES  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ZAY_SALE_TYPES  to UPLD;
grant DELETE,INSERT,SELECT,UPDATE                                            on ZAY_SALE_TYPES  to ZAY;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ZAY_SALE_TYPES.sql =========*** End **
PROMPT ===================================================================================== 
