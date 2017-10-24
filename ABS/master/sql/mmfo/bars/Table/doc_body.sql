

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DOC_BODY.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DOC_BODY ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DOC_BODY'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DOC_BODY'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''DOC_BODY'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DOC_BODY ***
begin 
  execute immediate '
  CREATE TABLE BARS.DOC_BODY 
   (	ND NUMBER(38,0), 
	ID NUMBER(*,0), 
	SPECIFIC VARCHAR2(30), 
	INFORM VARCHAR2(50), 
	F_SIZE NUMBER(38,0), 
	BODY LONG RAW
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DOC_BODY ***
 exec bpa.alter_policies('DOC_BODY');


COMMENT ON TABLE BARS.DOC_BODY IS 'Архив эл.документов';
COMMENT ON COLUMN BARS.DOC_BODY.ND IS 'Реф.осн.дог.';
COMMENT ON COLUMN BARS.DOC_BODY.ID IS 'Реф. эл.док.';
COMMENT ON COLUMN BARS.DOC_BODY.SPECIFIC IS 'Спецификация файла';
COMMENT ON COLUMN BARS.DOC_BODY.INFORM IS 'Комментарий';
COMMENT ON COLUMN BARS.DOC_BODY.F_SIZE IS 'Размер файла';
COMMENT ON COLUMN BARS.DOC_BODY.BODY IS '';




PROMPT *** Create  constraint PK_DOCBODY ***
begin   
 execute immediate '
  ALTER TABLE BARS.DOC_BODY ADD CONSTRAINT PK_DOCBODY PRIMARY KEY (ND, ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DOCBODY ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DOCBODY ON BARS.DOC_BODY (ND, ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DOC_BODY ***
grant DELETE,INSERT,SELECT                                                   on DOC_BODY        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DOC_BODY        to BARS_DM;
grant DELETE,INSERT,SELECT                                                   on DOC_BODY        to RCC_DEAL;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DOC_BODY.sql =========*** End *** ====
PROMPT ===================================================================================== 
