

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/RS_TMP_REPORT_ATTR.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to RS_TMP_REPORT_ATTR ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''RS_TMP_REPORT_ATTR'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''RS_TMP_REPORT_ATTR'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''RS_TMP_REPORT_ATTR'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table RS_TMP_REPORT_ATTR ***
begin 
  execute immediate '
  CREATE TABLE BARS.RS_TMP_REPORT_ATTR 
   (	SESSION_ID NUMBER, 
	ATTR_NAME VARCHAR2(30), 
	ATTR_VALUE VARCHAR2(254)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to RS_TMP_REPORT_ATTR ***
 exec bpa.alter_policies('RS_TMP_REPORT_ATTR');


COMMENT ON TABLE BARS.RS_TMP_REPORT_ATTR IS 'Система формирования каталогизированных запросов для WEB. Дополнительные атрибулы отчета.';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_ATTR.SESSION_ID IS 'Идентификатор сессии';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_ATTR.ATTR_NAME IS 'Имя атрибута';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_ATTR.ATTR_VALUE IS 'Значение атрибута';




PROMPT *** Create  constraint XPK_RS_TMP_REPORT_ATTR ***
begin   
 execute immediate '
  ALTER TABLE BARS.RS_TMP_REPORT_ATTR ADD CONSTRAINT XPK_RS_TMP_REPORT_ATTR PRIMARY KEY (SESSION_ID, ATTR_NAME)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_RS_TMP_REPORT_ATTR_SID ***
begin   
 execute immediate '
  ALTER TABLE BARS.RS_TMP_REPORT_ATTR ADD CONSTRAINT FK_RS_TMP_REPORT_ATTR_SID FOREIGN KEY (SESSION_ID)
	  REFERENCES BARS.RS_TMP_SESSION_DATA (SESSION_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_RS_TMP_REPORT_ATTR_ATTR ***
begin   
 execute immediate '
  ALTER TABLE BARS.RS_TMP_REPORT_ATTR ADD CONSTRAINT FK_RS_TMP_REPORT_ATTR_ATTR FOREIGN KEY (ATTR_NAME)
	  REFERENCES BARS.ZAPROS_ATTR (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_RS_TMP_REPORT_ATTR_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.RS_TMP_REPORT_ATTR MODIFY (ATTR_NAME CONSTRAINT CC_RS_TMP_REPORT_ATTR_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_RS_TMP_REPORT_ATTR ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_RS_TMP_REPORT_ATTR ON BARS.RS_TMP_REPORT_ATTR (SESSION_ID, ATTR_NAME) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  RS_TMP_REPORT_ATTR ***
grant SELECT                                                                 on RS_TMP_REPORT_ATTR to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on RS_TMP_REPORT_ATTR to BARS_DM;
grant SELECT                                                                 on RS_TMP_REPORT_ATTR to RS;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on RS_TMP_REPORT_ATTR to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/RS_TMP_REPORT_ATTR.sql =========*** En
PROMPT ===================================================================================== 
