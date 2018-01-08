

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ESCR_REG_TYPES.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ESCR_REG_TYPES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ESCR_REG_TYPES'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ESCR_REG_TYPES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ESCR_REG_TYPES ***
begin 
  execute immediate '
  CREATE TABLE BARS.ESCR_REG_TYPES 
   (	ID NUMBER, 
	CODE VARCHAR2(100), 
	NAME VARCHAR2(250)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ESCR_REG_TYPES ***
 exec bpa.alter_policies('ESCR_REG_TYPES');


COMMENT ON TABLE BARS.ESCR_REG_TYPES IS 'Таблиця типів реєстрів';
COMMENT ON COLUMN BARS.ESCR_REG_TYPES.ID IS 'Ідентифікатор';
COMMENT ON COLUMN BARS.ESCR_REG_TYPES.CODE IS 'Код типу';
COMMENT ON COLUMN BARS.ESCR_REG_TYPES.NAME IS 'Найменування типу';




PROMPT *** Create  constraint PK_REG_TYPE_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.ESCR_REG_TYPES ADD CONSTRAINT PK_REG_TYPE_ID PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_REG_TYPE_ID ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_REG_TYPE_ID ON BARS.ESCR_REG_TYPES (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ESCR_REG_TYPES ***
grant SELECT                                                                 on ESCR_REG_TYPES  to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on ESCR_REG_TYPES  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ESCR_REG_TYPES  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ESCR_REG_TYPES.sql =========*** End **
PROMPT ===================================================================================== 
