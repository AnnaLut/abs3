

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_DPA_PARAMS_BACK.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_DPA_PARAMS_BACK ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_DPA_PARAMS_BACK ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_DPA_PARAMS_BACK 
   (	PAR VARCHAR2(10), 
	VAL VARCHAR2(100), 
	COMM VARCHAR2(100), 
	KF VARCHAR2(6)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_DPA_PARAMS_BACK ***
 exec bpa.alter_policies('TMP_DPA_PARAMS_BACK');


COMMENT ON TABLE BARS.TMP_DPA_PARAMS_BACK IS '';
COMMENT ON COLUMN BARS.TMP_DPA_PARAMS_BACK.PAR IS '';
COMMENT ON COLUMN BARS.TMP_DPA_PARAMS_BACK.VAL IS '';
COMMENT ON COLUMN BARS.TMP_DPA_PARAMS_BACK.COMM IS '';
COMMENT ON COLUMN BARS.TMP_DPA_PARAMS_BACK.KF IS '';




PROMPT *** Create  constraint SYS_C00132338 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_DPA_PARAMS_BACK MODIFY (KF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_DPA_PARAMS_BACK ***
grant SELECT                                                                 on TMP_DPA_PARAMS_BACK to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_DPA_PARAMS_BACK.sql =========*** E
PROMPT ===================================================================================== 
