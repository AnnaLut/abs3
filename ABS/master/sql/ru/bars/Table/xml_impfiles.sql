

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/XML_IMPFILES.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to XML_IMPFILES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''XML_IMPFILES'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''XML_IMPFILES'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table XML_IMPFILES ***
begin 
  execute immediate '
  CREATE TABLE BARS.XML_IMPFILES 
   (	FN VARCHAR2(30), 
	DAT DATE, 
	USERID NUMBER, 
	BRANCH VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch''), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to XML_IMPFILES ***
 exec bpa.alter_policies('XML_IMPFILES');


COMMENT ON TABLE BARS.XML_IMPFILES IS 'Архiв прийнятих файлiв iмпорту iз зовнiшнiх задач';
COMMENT ON COLUMN BARS.XML_IMPFILES.FN IS 'Iмя файлу iмпорту';
COMMENT ON COLUMN BARS.XML_IMPFILES.DAT IS 'Банкiвська дата обробки';
COMMENT ON COLUMN BARS.XML_IMPFILES.USERID IS '';
COMMENT ON COLUMN BARS.XML_IMPFILES.BRANCH IS 'Бранч де проходить обробка';
COMMENT ON COLUMN BARS.XML_IMPFILES.KF IS '';




PROMPT *** Create  constraint XFK_XMLIMPFILES ***
begin   
 execute immediate '
  ALTER TABLE BARS.XML_IMPFILES ADD CONSTRAINT XFK_XMLIMPFILES FOREIGN KEY (USERID)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XPK_XMLIMPFILES ***
begin   
 execute immediate '
  ALTER TABLE BARS.XML_IMPFILES ADD CONSTRAINT XPK_XMLIMPFILES PRIMARY KEY (KF, DAT, FN)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_XMLIMPFILES_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.XML_IMPFILES MODIFY (KF CONSTRAINT CC_XMLIMPFILES_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_XMLIMPFILES_BR_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.XML_IMPFILES MODIFY (BRANCH CONSTRAINT CC_XMLIMPFILES_BR_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_XMLIMPFILES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_XMLIMPFILES ON BARS.XML_IMPFILES (KF, DAT, FN) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index XIE_XMLIMPFILES_DATUSER ***
begin   
 execute immediate '
  CREATE INDEX BARS.XIE_XMLIMPFILES_DATUSER ON BARS.XML_IMPFILES (DAT, USERID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  XML_IMPFILES ***
grant INSERT,SELECT,UPDATE                                                   on XML_IMPFILES    to BARS_ACCESS_DEFROLE;
grant INSERT,SELECT,UPDATE                                                   on XML_IMPFILES    to OPER000;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on XML_IMPFILES    to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/XML_IMPFILES.sql =========*** End *** 
PROMPT ===================================================================================== 
