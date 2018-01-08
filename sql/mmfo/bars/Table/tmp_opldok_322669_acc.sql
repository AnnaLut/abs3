

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_OPLDOK_322669_ACC.sql =========***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_OPLDOK_322669_ACC ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_OPLDOK_322669_ACC ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_OPLDOK_322669_ACC 
   (	REF NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_OPLDOK_322669_ACC ***
 exec bpa.alter_policies('TMP_OPLDOK_322669_ACC');


COMMENT ON TABLE BARS.TMP_OPLDOK_322669_ACC IS '';
COMMENT ON COLUMN BARS.TMP_OPLDOK_322669_ACC.REF IS '';




PROMPT *** Create  constraint SYS_C00138033 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_OPLDOK_322669_ACC MODIFY (REF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_OPLDOK_322669_ACC ***
grant SELECT                                                                 on TMP_OPLDOK_322669_ACC to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_OPLDOK_322669_ACC.sql =========***
PROMPT ===================================================================================== 
