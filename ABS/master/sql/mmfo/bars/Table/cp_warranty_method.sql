

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CP_WARRANTY_METHOD.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CP_WARRANTY_METHOD ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CP_WARRANTY_METHOD'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CP_WARRANTY_METHOD'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CP_WARRANTY_METHOD'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CP_WARRANTY_METHOD ***
begin 
  execute immediate '
  CREATE TABLE BARS.CP_WARRANTY_METHOD 
   (	ID NUMBER(*,0), 
	NAME VARCHAR2(100), 
	DATE_OFF DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CP_WARRANTY_METHOD ***
 exec bpa.alter_policies('CP_WARRANTY_METHOD');


COMMENT ON TABLE BARS.CP_WARRANTY_METHOD IS 'Довідник методів зміни гарантії по пакету ЦП при чатковому погашенні/продажу';
COMMENT ON COLUMN BARS.CP_WARRANTY_METHOD.ID IS 'Ідентифікатор методу';
COMMENT ON COLUMN BARS.CP_WARRANTY_METHOD.NAME IS 'Назва методу';
COMMENT ON COLUMN BARS.CP_WARRANTY_METHOD.DATE_OFF IS 'Дата закінчення дії';




PROMPT *** Create  constraint PK_CP_WARRANTY_METHOD ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_WARRANTY_METHOD ADD CONSTRAINT PK_CP_WARRANTY_METHOD PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008828 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_WARRANTY_METHOD MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008829 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_WARRANTY_METHOD MODIFY (NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CP_WARRANTY_METHOD ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CP_WARRANTY_METHOD ON BARS.CP_WARRANTY_METHOD (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CP_WARRANTY_METHOD ***
grant INSERT,SELECT,UPDATE                                                   on CP_WARRANTY_METHOD to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CP_WARRANTY_METHOD to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CP_WARRANTY_METHOD.sql =========*** En
PROMPT ===================================================================================== 
