

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_OPERW_1.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_OPERW_1 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_OPERW_1 ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_OPERW_1 
   (	TAG CHAR(5)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_OPERW_1 ***
 exec bpa.alter_policies('TMP_OPERW_1');


COMMENT ON TABLE BARS.TMP_OPERW_1 IS '';
COMMENT ON COLUMN BARS.TMP_OPERW_1.TAG IS '';




PROMPT *** Create  constraint SYS_C002779048 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_OPERW_1 MODIFY (TAG NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_OPERW_1.sql =========*** End *** =
PROMPT ===================================================================================== 
