

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/FORM_STRU_I.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to FORM_STRU_I ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''FORM_STRU_I'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''FORM_STRU_I'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''FORM_STRU_I'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table FORM_STRU_I ***
begin 
  execute immediate '
  CREATE TABLE BARS.FORM_STRU_I 
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




PROMPT *** ALTER_POLICIES to FORM_STRU_I ***
 exec bpa.alter_policies('FORM_STRU_I');


COMMENT ON TABLE BARS.FORM_STRU_I IS '';
COMMENT ON COLUMN BARS.FORM_STRU_I.KODF IS '';
COMMENT ON COLUMN BARS.FORM_STRU_I.NATR IS '';
COMMENT ON COLUMN BARS.FORM_STRU_I.NAME IS '';
COMMENT ON COLUMN BARS.FORM_STRU_I.VAL IS '';
COMMENT ON COLUMN BARS.FORM_STRU_I.ISCODE IS '';
COMMENT ON COLUMN BARS.FORM_STRU_I.A017 IS '';
COMMENT ON COLUMN BARS.FORM_STRU_I.CODE_SORT IS '';




PROMPT *** Create  constraint SYS_C008490 ***
begin   
 execute immediate '
  ALTER TABLE BARS.FORM_STRU_I MODIFY (KODF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008491 ***
begin   
 execute immediate '
  ALTER TABLE BARS.FORM_STRU_I MODIFY (NATR NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  FORM_STRU_I ***
grant DELETE,INSERT,SELECT,UPDATE                                            on FORM_STRU_I     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on FORM_STRU_I     to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on FORM_STRU_I     to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/FORM_STRU_I.sql =========*** End *** =
PROMPT ===================================================================================== 
