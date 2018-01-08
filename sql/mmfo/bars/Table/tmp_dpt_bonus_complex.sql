

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_DPT_BONUS_COMPLEX.sql =========***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_DPT_BONUS_COMPLEX ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_DPT_BONUS_COMPLEX ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_DPT_BONUS_COMPLEX 
   (	VIDD NUMBER(38,0), 
	FUNC_NAME VARCHAR2(4000), 
	FUNC_ACTIVITY CHAR(1)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_DPT_BONUS_COMPLEX ***
 exec bpa.alter_policies('TMP_DPT_BONUS_COMPLEX');


COMMENT ON TABLE BARS.TMP_DPT_BONUS_COMPLEX IS '';
COMMENT ON COLUMN BARS.TMP_DPT_BONUS_COMPLEX.VIDD IS '';
COMMENT ON COLUMN BARS.TMP_DPT_BONUS_COMPLEX.FUNC_NAME IS '';
COMMENT ON COLUMN BARS.TMP_DPT_BONUS_COMPLEX.FUNC_ACTIVITY IS '';




PROMPT *** Create  constraint SYS_C00137505 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_DPT_BONUS_COMPLEX MODIFY (VIDD NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00137506 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_DPT_BONUS_COMPLEX MODIFY (FUNC_NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00137507 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_DPT_BONUS_COMPLEX MODIFY (FUNC_ACTIVITY NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_DPT_BONUS_COMPLEX ***
grant SELECT                                                                 on TMP_DPT_BONUS_COMPLEX to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_DPT_BONUS_COMPLEX.sql =========***
PROMPT ===================================================================================== 
