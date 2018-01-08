

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ZAY_TYPE.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ZAY_TYPE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ZAY_TYPE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''ZAY_TYPE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ZAY_TYPE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ZAY_TYPE ***
begin 
  execute immediate '
  CREATE TABLE BARS.ZAY_TYPE 
   (	ID NUMBER(10,0), 
	NAME VARCHAR2(100)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ZAY_TYPE ***
 exec bpa.alter_policies('ZAY_TYPE');


COMMENT ON TABLE BARS.ZAY_TYPE IS 'Типы заявок';
COMMENT ON COLUMN BARS.ZAY_TYPE.ID IS 'Ид. типа';
COMMENT ON COLUMN BARS.ZAY_TYPE.NAME IS 'Наименование';




PROMPT *** Create  constraint PK_ZAYTYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAY_TYPE ADD CONSTRAINT PK_ZAYTYPE PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ZAYTYPE_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAY_TYPE MODIFY (ID CONSTRAINT CC_ZAYTYPE_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ZAYTYPE_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAY_TYPE MODIFY (NAME CONSTRAINT CC_ZAYTYPE_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ZAYTYPE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ZAYTYPE ON BARS.ZAY_TYPE (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ZAY_TYPE ***
grant DELETE,INSERT,SELECT,UPDATE                                            on ZAY_TYPE        to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on ZAY_TYPE        to ZAY;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ZAY_TYPE.sql =========*** End *** ====
PROMPT ===================================================================================== 
