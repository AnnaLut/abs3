

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/Table/ESCR_REG_KIND.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  table ESCR_REG_KIND ***
begin 
  execute immediate '
  CREATE TABLE BARSAQ.ESCR_REG_KIND 
   (	ID NUMBER, 
	CODE VARCHAR2(100), 
	NAME VARCHAR2(250)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSAQ.ESCR_REG_KIND IS 'Довідник видів реєстрів';
COMMENT ON COLUMN BARSAQ.ESCR_REG_KIND.ID IS 'Ідентифікатор';
COMMENT ON COLUMN BARSAQ.ESCR_REG_KIND.CODE IS 'Код виду';
COMMENT ON COLUMN BARSAQ.ESCR_REG_KIND.NAME IS 'Назва виду';




PROMPT *** Create  constraint PK_REG_KIND ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.ESCR_REG_KIND ADD CONSTRAINT PK_REG_KIND PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_REG_KIND ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSAQ.PK_REG_KIND ON BARSAQ.ESCR_REG_KIND (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ESCR_REG_KIND ***
grant SELECT                                                                 on ESCR_REG_KIND   to BARSREADER_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/Table/ESCR_REG_KIND.sql =========*** End *
PROMPT ===================================================================================== 
