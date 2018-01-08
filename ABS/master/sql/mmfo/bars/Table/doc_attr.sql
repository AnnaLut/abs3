

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DOC_ATTR.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DOC_ATTR ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DOC_ATTR'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DOC_ATTR'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''DOC_ATTR'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DOC_ATTR ***
begin 
  execute immediate '
  CREATE TABLE BARS.DOC_ATTR 
   (	ID VARCHAR2(35), 
	NAME VARCHAR2(140), 
	FIELD VARCHAR2(35), 
	SSQL VARCHAR2(1000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DOC_ATTR ***
 exec bpa.alter_policies('DOC_ATTR');


COMMENT ON TABLE BARS.DOC_ATTR IS 'Атрибуты договора';
COMMENT ON COLUMN BARS.DOC_ATTR.ID IS 'Мнем. имя';
COMMENT ON COLUMN BARS.DOC_ATTR.NAME IS 'Семант. имя';
COMMENT ON COLUMN BARS.DOC_ATTR.FIELD IS 'Вспомогат. поле';
COMMENT ON COLUMN BARS.DOC_ATTR.SSQL IS 'Вид SQL-запроса';




PROMPT *** Create  constraint PK_DOCATTR ***
begin   
 execute immediate '
  ALTER TABLE BARS.DOC_ATTR ADD CONSTRAINT PK_DOCATTR PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009080 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DOC_ATTR MODIFY (ID NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DOCATTR_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DOC_ATTR MODIFY (NAME CONSTRAINT CC_DOCATTR_NAME_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DOCATTR ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DOCATTR ON BARS.DOC_ATTR (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DOC_ATTR ***
grant SELECT                                                                 on DOC_ATTR        to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DOC_ATTR        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DOC_ATTR        to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on DOC_ATTR        to CC_DOC;
grant DELETE,INSERT,SELECT,UPDATE                                            on DOC_ATTR        to DPT_ADMIN;
grant DELETE,INSERT,SELECT,UPDATE                                            on DOC_ATTR        to START1;
grant SELECT                                                                 on DOC_ATTR        to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DOC_ATTR        to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on DOC_ATTR        to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DOC_ATTR.sql =========*** End *** ====
PROMPT ===================================================================================== 
