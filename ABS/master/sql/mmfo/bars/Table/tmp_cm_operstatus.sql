

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_CM_OPERSTATUS.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_CM_OPERSTATUS ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_CM_OPERSTATUS ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_CM_OPERSTATUS 
   (	ID NUMBER(22,0), 
	NAME VARCHAR2(100)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_CM_OPERSTATUS ***
 exec bpa.alter_policies('TMP_CM_OPERSTATUS');


COMMENT ON TABLE BARS.TMP_CM_OPERSTATUS IS '';
COMMENT ON COLUMN BARS.TMP_CM_OPERSTATUS.ID IS '';
COMMENT ON COLUMN BARS.TMP_CM_OPERSTATUS.NAME IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_CM_OPERSTATUS.sql =========*** End
PROMPT ===================================================================================== 
