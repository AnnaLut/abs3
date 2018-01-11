

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/WCS_SUBPRODUCT_GARANTEES.sql =========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to WCS_SUBPRODUCT_GARANTEES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''WCS_SUBPRODUCT_GARANTEES'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_SUBPRODUCT_GARANTEES'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_SUBPRODUCT_GARANTEES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table WCS_SUBPRODUCT_GARANTEES ***
begin 
  execute immediate '
  CREATE TABLE BARS.WCS_SUBPRODUCT_GARANTEES 
   (	SUBPRODUCT_ID VARCHAR2(100), 
	GARANTEE_ID VARCHAR2(100), 
	IS_REQUIRED NUMBER DEFAULT 1, 
	ORD NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to WCS_SUBPRODUCT_GARANTEES ***
 exec bpa.alter_policies('WCS_SUBPRODUCT_GARANTEES');


COMMENT ON TABLE BARS.WCS_SUBPRODUCT_GARANTEES IS 'Привязка залогов к продукту';
COMMENT ON COLUMN BARS.WCS_SUBPRODUCT_GARANTEES.SUBPRODUCT_ID IS 'Идентификатор субпродукта';
COMMENT ON COLUMN BARS.WCS_SUBPRODUCT_GARANTEES.GARANTEE_ID IS 'Идентификатор типа залога';
COMMENT ON COLUMN BARS.WCS_SUBPRODUCT_GARANTEES.IS_REQUIRED IS 'Обязательна ли для заполнения';
COMMENT ON COLUMN BARS.WCS_SUBPRODUCT_GARANTEES.ORD IS 'Порядок';




PROMPT *** Create  constraint CC_SBPGARS_REQUIRED ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SUBPRODUCT_GARANTEES ADD CONSTRAINT CC_SBPGARS_REQUIRED CHECK (is_required in (0, 1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_SBPGARS ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SUBPRODUCT_GARANTEES ADD CONSTRAINT PK_SBPGARS PRIMARY KEY (SUBPRODUCT_ID, GARANTEE_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SBPGARS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SBPGARS ON BARS.WCS_SUBPRODUCT_GARANTEES (SUBPRODUCT_ID, GARANTEE_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  WCS_SUBPRODUCT_GARANTEES ***
grant SELECT                                                                 on WCS_SUBPRODUCT_GARANTEES to BARSREADER_ROLE;
grant SELECT                                                                 on WCS_SUBPRODUCT_GARANTEES to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on WCS_SUBPRODUCT_GARANTEES to BARS_DM;
grant SELECT                                                                 on WCS_SUBPRODUCT_GARANTEES to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/WCS_SUBPRODUCT_GARANTEES.sql =========
PROMPT ===================================================================================== 
