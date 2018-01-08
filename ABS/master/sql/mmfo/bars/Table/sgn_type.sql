

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SGN_TYPE.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SGN_TYPE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SGN_TYPE'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''SGN_TYPE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SGN_TYPE ***
begin 
  execute immediate '
  CREATE TABLE BARS.SGN_TYPE 
   (	ID VARCHAR2(3), 
	NAME VARCHAR2(60), 
	IS_ACTIVE VARCHAR2(1)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SGN_TYPE ***
 exec bpa.alter_policies('SGN_TYPE');


COMMENT ON TABLE BARS.SGN_TYPE IS 'Типи ЕЦП';
COMMENT ON COLUMN BARS.SGN_TYPE.ID IS 'Тип підпису';
COMMENT ON COLUMN BARS.SGN_TYPE.NAME IS 'Назва';
COMMENT ON COLUMN BARS.SGN_TYPE.IS_ACTIVE IS 'Ознака. Y - діючий, N - не діючий';




PROMPT *** Create  constraint CC_SNGTYPE_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SGN_TYPE MODIFY (ID CONSTRAINT CC_SNGTYPE_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SNGTYPE_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SGN_TYPE MODIFY (NAME CONSTRAINT CC_SNGTYPE_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SGNTYPE_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.SGN_TYPE ADD CONSTRAINT CC_SGNTYPE_ID CHECK (id=upper(id)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SGNTYPE_ISACTIVE ***
begin   
 execute immediate '
  ALTER TABLE BARS.SGN_TYPE ADD CONSTRAINT CC_SGNTYPE_ISACTIVE CHECK (is_active in (''Y'', ''N'')) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_SGNTYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.SGN_TYPE ADD CONSTRAINT PK_SGNTYPE PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SGNTYPE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SGNTYPE ON BARS.SGN_TYPE (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SGN_TYPE ***
grant SELECT                                                                 on SGN_TYPE        to BARSREADER_ROLE;
grant SELECT                                                                 on SGN_TYPE        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SGN_TYPE.sql =========*** End *** ====
PROMPT ===================================================================================== 
