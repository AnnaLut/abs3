

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/FORM_STRU_.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to FORM_STRU_ ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''FORM_STRU_'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''FORM_STRU_'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''FORM_STRU_'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table FORM_STRU_ ***
begin 
  execute immediate '
  CREATE TABLE BARS.FORM_STRU_ 
   (	KODF CHAR(2), 
	NATR NUMBER, 
	NAME VARCHAR2(70), 
	VAL VARCHAR2(70), 
	ISCODE CHAR(1), 
	A017 CHAR(1), 
	CODE_SORT NUMBER
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to FORM_STRU_ ***
 exec bpa.alter_policies('FORM_STRU_');


COMMENT ON TABLE BARS.FORM_STRU_ IS '';
COMMENT ON COLUMN BARS.FORM_STRU_.KODF IS '';
COMMENT ON COLUMN BARS.FORM_STRU_.NATR IS '';
COMMENT ON COLUMN BARS.FORM_STRU_.NAME IS '';
COMMENT ON COLUMN BARS.FORM_STRU_.VAL IS '';
COMMENT ON COLUMN BARS.FORM_STRU_.ISCODE IS '';
COMMENT ON COLUMN BARS.FORM_STRU_.A017 IS '';
COMMENT ON COLUMN BARS.FORM_STRU_.CODE_SORT IS '';




PROMPT *** Create  constraint SYS_C009623 ***
begin   
 execute immediate '
  ALTER TABLE BARS.FORM_STRU_ MODIFY (KODF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009624 ***
begin   
 execute immediate '
  ALTER TABLE BARS.FORM_STRU_ MODIFY (NATR NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  FORM_STRU_ ***
grant SELECT                                                                 on FORM_STRU_      to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on FORM_STRU_      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on FORM_STRU_      to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on FORM_STRU_      to START1;
grant SELECT                                                                 on FORM_STRU_      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/FORM_STRU_.sql =========*** End *** ==
PROMPT ===================================================================================== 
