

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPT_REQ_TYPES.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPT_REQ_TYPES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPT_REQ_TYPES'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DPT_REQ_TYPES'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''DPT_REQ_TYPES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPT_REQ_TYPES ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPT_REQ_TYPES 
   (	REQTYPE_ID NUMBER(38,0), 
	REQTYPE_CODE VARCHAR2(30), 
	REQTYPE_NAME VARCHAR2(100), 
	REQTYPE_FUNC VARCHAR2(100), 
	DELETED DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPT_REQ_TYPES ***
 exec bpa.alter_policies('DPT_REQ_TYPES');


COMMENT ON TABLE BARS.DPT_REQ_TYPES IS 'Депозитные договора. Типы запросов';
COMMENT ON COLUMN BARS.DPT_REQ_TYPES.REQTYPE_ID IS 'Идентификатор типа запроса';
COMMENT ON COLUMN BARS.DPT_REQ_TYPES.REQTYPE_CODE IS 'Мнемонический код типа запроса';
COMMENT ON COLUMN BARS.DPT_REQ_TYPES.REQTYPE_NAME IS 'Наименование типа запроса';
COMMENT ON COLUMN BARS.DPT_REQ_TYPES.REQTYPE_FUNC IS 'Функция обработки запроса';
COMMENT ON COLUMN BARS.DPT_REQ_TYPES.DELETED IS '';




PROMPT *** Create  constraint PK_DPTREQTYPES ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_REQ_TYPES ADD CONSTRAINT PK_DPTREQTYPES PRIMARY KEY (REQTYPE_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_DPTREQTYPES ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_REQ_TYPES ADD CONSTRAINT UK_DPTREQTYPES UNIQUE (REQTYPE_CODE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTREQTYPES_REQTYPEID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_REQ_TYPES MODIFY (REQTYPE_ID CONSTRAINT CC_DPTREQTYPES_REQTYPEID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTREQTYPES_REQTYPECODE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_REQ_TYPES MODIFY (REQTYPE_CODE CONSTRAINT CC_DPTREQTYPES_REQTYPECODE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTREQTYPES_REQTYPENAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_REQ_TYPES MODIFY (REQTYPE_NAME CONSTRAINT CC_DPTREQTYPES_REQTYPENAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTREQTYPES_REQTYPEFUNC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_REQ_TYPES MODIFY (REQTYPE_FUNC CONSTRAINT CC_DPTREQTYPES_REQTYPEFUNC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DPTREQTYPES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DPTREQTYPES ON BARS.DPT_REQ_TYPES (REQTYPE_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_DPTREQTYPES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_DPTREQTYPES ON BARS.DPT_REQ_TYPES (REQTYPE_CODE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DPT_REQ_TYPES ***
grant SELECT                                                                 on DPT_REQ_TYPES   to BARS_DM;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPT_REQ_TYPES   to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPT_REQ_TYPES.sql =========*** End ***
PROMPT ===================================================================================== 
