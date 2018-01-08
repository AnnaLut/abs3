

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/WCS_SUBPRODUCT_CREDITDATA.sql ========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to WCS_SUBPRODUCT_CREDITDATA ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''WCS_SUBPRODUCT_CREDITDATA'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_SUBPRODUCT_CREDITDATA'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_SUBPRODUCT_CREDITDATA'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table WCS_SUBPRODUCT_CREDITDATA ***
begin 
  execute immediate '
  CREATE TABLE BARS.WCS_SUBPRODUCT_CREDITDATA 
   (	SUBPRODUCT_ID VARCHAR2(100), 
	CRDDATA_ID VARCHAR2(100), 
	QUESTION_ID VARCHAR2(100), 
	IS_VISIBLE NUMBER DEFAULT 1, 
	IS_CHECKABLE NUMBER DEFAULT 0, 
	CHECK_PROC VARCHAR2(4000), 
	IS_READONLY VARCHAR2(4000) DEFAULT ''0'', 
	DNSHOW_IF VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to WCS_SUBPRODUCT_CREDITDATA ***
 exec bpa.alter_policies('WCS_SUBPRODUCT_CREDITDATA');


COMMENT ON TABLE BARS.WCS_SUBPRODUCT_CREDITDATA IS 'Параметры кредита для субпродукта';
COMMENT ON COLUMN BARS.WCS_SUBPRODUCT_CREDITDATA.SUBPRODUCT_ID IS 'Идентификатор субпродукта';
COMMENT ON COLUMN BARS.WCS_SUBPRODUCT_CREDITDATA.CRDDATA_ID IS 'Идентификатор параметра';
COMMENT ON COLUMN BARS.WCS_SUBPRODUCT_CREDITDATA.QUESTION_ID IS 'Идентификатор вопроса';
COMMENT ON COLUMN BARS.WCS_SUBPRODUCT_CREDITDATA.IS_VISIBLE IS 'Отображать или нет';
COMMENT ON COLUMN BARS.WCS_SUBPRODUCT_CREDITDATA.IS_CHECKABLE IS 'Проверять или нет';
COMMENT ON COLUMN BARS.WCS_SUBPRODUCT_CREDITDATA.CHECK_PROC IS 'Идентификатор вопроса';
COMMENT ON COLUMN BARS.WCS_SUBPRODUCT_CREDITDATA.IS_READONLY IS 'Только чтение (null/1/true - OK, 0/false - NOT OK)';
COMMENT ON COLUMN BARS.WCS_SUBPRODUCT_CREDITDATA.DNSHOW_IF IS 'Условие по которому не показывать вопрос';




PROMPT *** Create  constraint PK_SBPCRDDATA ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SUBPRODUCT_CREDITDATA ADD CONSTRAINT PK_SBPCRDDATA PRIMARY KEY (SUBPRODUCT_ID, CRDDATA_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SBPCRDDATA_ISVISIBLE ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SUBPRODUCT_CREDITDATA ADD CONSTRAINT CC_SBPCRDDATA_ISVISIBLE CHECK (is_visible in (0, 1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SBPCRDDATA_ISCHECKABLE ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SUBPRODUCT_CREDITDATA ADD CONSTRAINT CC_SBPCRDDATA_ISCHECKABLE CHECK (is_checkable in (0, 1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SBPCRDDATA ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SBPCRDDATA ON BARS.WCS_SUBPRODUCT_CREDITDATA (SUBPRODUCT_ID, CRDDATA_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  WCS_SUBPRODUCT_CREDITDATA ***
grant SELECT                                                                 on WCS_SUBPRODUCT_CREDITDATA to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on WCS_SUBPRODUCT_CREDITDATA to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on WCS_SUBPRODUCT_CREDITDATA to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on WCS_SUBPRODUCT_CREDITDATA to START1;
grant SELECT                                                                 on WCS_SUBPRODUCT_CREDITDATA to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/WCS_SUBPRODUCT_CREDITDATA.sql ========
PROMPT ===================================================================================== 
