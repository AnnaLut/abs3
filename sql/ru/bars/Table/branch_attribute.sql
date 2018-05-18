

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BRANCH_ATTRIBUTE.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BRANCH_ATTRIBUTE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BRANCH_ATTRIBUTE'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''BRANCH_ATTRIBUTE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BRANCH_ATTRIBUTE ***
begin 
  execute immediate '
  CREATE TABLE BARS.BRANCH_ATTRIBUTE 
   (	ATTRIBUTE_CODE VARCHAR2(50), 
	ATTRIBUTE_DESC VARCHAR2(200), 
	ATTRIBUTE_DATATYPE VARCHAR2(1), 
	ATTRIBUTE_FORMAT VARCHAR2(50), 
	ATTRIBUTE_MODULE VARCHAR2(50)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BRANCH_ATTRIBUTE ***
 exec bpa.alter_policies('BRANCH_ATTRIBUTE');


COMMENT ON TABLE BARS.BRANCH_ATTRIBUTE IS 'Аттрибуты бранча (коды параметров)';
COMMENT ON COLUMN BARS.BRANCH_ATTRIBUTE.ATTRIBUTE_CODE IS 'Код';
COMMENT ON COLUMN BARS.BRANCH_ATTRIBUTE.ATTRIBUTE_DESC IS 'Описание';
COMMENT ON COLUMN BARS.BRANCH_ATTRIBUTE.ATTRIBUTE_DATATYPE IS 'Тип параметра (С-char, N-number, D-data)';
COMMENT ON COLUMN BARS.BRANCH_ATTRIBUTE.ATTRIBUTE_FORMAT IS 'Формат ввода';
COMMENT ON COLUMN BARS.BRANCH_ATTRIBUTE.ATTRIBUTE_MODULE IS '';




PROMPT *** Create  constraint CC_BRANCHATTR_TYPE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BRANCH_ATTRIBUTE MODIFY (ATTRIBUTE_DATATYPE CONSTRAINT CC_BRANCHATTR_TYPE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BRANCH_ATTRIBUTES_DTTYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.BRANCH_ATTRIBUTE ADD CONSTRAINT CC_BRANCH_ATTRIBUTES_DTTYPE CHECK (attribute_datatype in (''N'',''C'',''D'')) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_BRANCH_ATTRIBUTE ***
begin   
 execute immediate '
  ALTER TABLE BARS.BRANCH_ATTRIBUTE ADD CONSTRAINT PK_BRANCH_ATTRIBUTE PRIMARY KEY (ATTRIBUTE_CODE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_BRANCH_ATTRIBUTE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_BRANCH_ATTRIBUTE ON BARS.BRANCH_ATTRIBUTE (ATTRIBUTE_CODE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BRANCH_ATTRIBUTE ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on BRANCH_ATTRIBUTE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on BRANCH_ATTRIBUTE to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BRANCH_ATTRIBUTE.sql =========*** End 
PROMPT ===================================================================================== 
