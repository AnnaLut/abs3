

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ASYNC_RUN_OBJ_TYPE.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ASYNC_RUN_OBJ_TYPE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ASYNC_RUN_OBJ_TYPE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''ASYNC_RUN_OBJ_TYPE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ASYNC_RUN_OBJ_TYPE ***
begin 
  execute immediate '
  CREATE TABLE BARS.ASYNC_RUN_OBJ_TYPE 
   (	OBJ_TYPE_ID NUMBER, 
	OBJ_TYPE_CODE VARCHAR2(40), 
	OBJ_TYPE_DESC VARCHAR2(2000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ASYNC_RUN_OBJ_TYPE ***
 exec bpa.alter_policies('ASYNC_RUN_OBJ_TYPE');


COMMENT ON TABLE BARS.ASYNC_RUN_OBJ_TYPE IS 'Довідник типів запусканих об'єктів';
COMMENT ON COLUMN BARS.ASYNC_RUN_OBJ_TYPE.OBJ_TYPE_ID IS 'Ідентифікатор типу';
COMMENT ON COLUMN BARS.ASYNC_RUN_OBJ_TYPE.OBJ_TYPE_CODE IS 'Код типу';
COMMENT ON COLUMN BARS.ASYNC_RUN_OBJ_TYPE.OBJ_TYPE_DESC IS 'Опис типу';




PROMPT *** Create  constraint PK_ASNROBJT ***
begin   
 execute immediate '
  ALTER TABLE BARS.ASYNC_RUN_OBJ_TYPE ADD CONSTRAINT PK_ASNROBJT PRIMARY KEY (OBJ_TYPE_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ASNROBJT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ASNROBJT ON BARS.ASYNC_RUN_OBJ_TYPE (OBJ_TYPE_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ASYNC_RUN_OBJ_TYPE ***
grant SELECT                                                                 on ASYNC_RUN_OBJ_TYPE to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ASYNC_RUN_OBJ_TYPE.sql =========*** En
PROMPT ===================================================================================== 
