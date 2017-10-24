

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPT_TYPES.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPT_TYPES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPT_TYPES'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DPT_TYPES'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''DPT_TYPES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPT_TYPES ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPT_TYPES 
   (	TYPE_ID NUMBER(38,0), 
	TYPE_NAME VARCHAR2(100), 
	TYPE_CODE VARCHAR2(4), 
	SORT_ORD NUMBER(38,0), 
	FL_ACTIVE NUMBER(1,0), 
	FL_DEMAND NUMBER(1,0) DEFAULT 0, 
	FL_WEBBANKING NUMBER(*,0) DEFAULT 0
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPT_TYPES ***
 exec bpa.alter_policies('DPT_TYPES');


COMMENT ON TABLE BARS.DPT_TYPES IS 'Типы депозитных договоров физ.лиц';
COMMENT ON COLUMN BARS.DPT_TYPES.FL_WEBBANKING IS '';
COMMENT ON COLUMN BARS.DPT_TYPES.TYPE_ID IS 'Числ.код типа договора';
COMMENT ON COLUMN BARS.DPT_TYPES.TYPE_NAME IS 'Наименование типа договора';
COMMENT ON COLUMN BARS.DPT_TYPES.TYPE_CODE IS 'Симв.код типа договора';
COMMENT ON COLUMN BARS.DPT_TYPES.SORT_ORD IS 'Порядок сортировки';
COMMENT ON COLUMN BARS.DPT_TYPES.FL_ACTIVE IS 'Ознака активності продукту';
COMMENT ON COLUMN BARS.DPT_TYPES.FL_DEMAND IS 'Ознака депозитного продукту "До запитання"';




PROMPT *** Create  constraint PK_DPTTYPES ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_TYPES ADD CONSTRAINT PK_DPTTYPES PRIMARY KEY (TYPE_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTTYPES_TYPEID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_TYPES MODIFY (TYPE_ID CONSTRAINT CC_DPTTYPES_TYPEID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTTYPES_TYPENAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_TYPES MODIFY (TYPE_NAME CONSTRAINT CC_DPTTYPES_TYPENAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DPTTYPES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DPTTYPES ON BARS.DPT_TYPES (TYPE_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DPT_TYPES ***
grant SELECT                                                                 on DPT_TYPES       to BARSUPL;
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on DPT_TYPES       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPT_TYPES       to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_TYPES       to DPT_ADMIN;
grant SELECT                                                                 on DPT_TYPES       to DPT_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_TYPES       to VKLAD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPT_TYPES       to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on DPT_TYPES       to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPT_TYPES.sql =========*** End *** ===
PROMPT ===================================================================================== 
