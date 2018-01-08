

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DOC_ERROR_BEHAVIOR.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DOC_ERROR_BEHAVIOR ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DOC_ERROR_BEHAVIOR ***
begin 
  execute immediate '
  CREATE TABLE BARS.DOC_ERROR_BEHAVIOR 
   (	ORA_ERROR NUMBER(*,0), 
	APP_ERROR NUMBER(*,0), 
	IGNORE_COUNT NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DOC_ERROR_BEHAVIOR ***
 exec bpa.alter_policies('DOC_ERROR_BEHAVIOR');


COMMENT ON TABLE BARS.DOC_ERROR_BEHAVIOR IS 'Специальные ошибки при импорте документов';
COMMENT ON COLUMN BARS.DOC_ERROR_BEHAVIOR.ORA_ERROR IS 'Код ошибки ORACLE';
COMMENT ON COLUMN BARS.DOC_ERROR_BEHAVIOR.APP_ERROR IS 'Прикладной код ошибки';
COMMENT ON COLUMN BARS.DOC_ERROR_BEHAVIOR.IGNORE_COUNT IS 'Количество попыток оплаты с игнорированием ошибки';




PROMPT *** Create  constraint PK_DOCERRBEHAVIOR ***
begin   
 execute immediate '
  ALTER TABLE BARS.DOC_ERROR_BEHAVIOR ADD CONSTRAINT PK_DOCERRBEHAVIOR PRIMARY KEY (ORA_ERROR, APP_ERROR)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DOCERRBEHAVIOR_ORAERR_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DOC_ERROR_BEHAVIOR MODIFY (ORA_ERROR CONSTRAINT CC_DOCERRBEHAVIOR_ORAERR_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DOCERRBEHAVIOR_APPERR_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DOC_ERROR_BEHAVIOR MODIFY (APP_ERROR CONSTRAINT CC_DOCERRBEHAVIOR_APPERR_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DOCERRBEHAVIOR_TRYCOUNT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DOC_ERROR_BEHAVIOR MODIFY (IGNORE_COUNT CONSTRAINT CC_DOCERRBEHAVIOR_TRYCOUNT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DOCERRBEHAVIOR ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DOCERRBEHAVIOR ON BARS.DOC_ERROR_BEHAVIOR (ORA_ERROR, APP_ERROR) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DOC_ERROR_BEHAVIOR ***
grant SELECT                                                                 on DOC_ERROR_BEHAVIOR to BARSREADER_ROLE;
grant SELECT                                                                 on DOC_ERROR_BEHAVIOR to BARS_DM;
grant SELECT                                                                 on DOC_ERROR_BEHAVIOR to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DOC_ERROR_BEHAVIOR to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DOC_ERROR_BEHAVIOR.sql =========*** En
PROMPT ===================================================================================== 
