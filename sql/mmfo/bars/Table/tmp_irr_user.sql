

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_IRR_USER.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_IRR_USER ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_IRR_USER ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_IRR_USER 
   (	D DATE, 
	N NUMBER(38,0), 
	S NUMBER, 
	USERID NUMBER DEFAULT sys_context(''bars_global'',''user_id'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_IRR_USER ***
 exec bpa.alter_policies('TMP_IRR_USER');


COMMENT ON TABLE BARS.TMP_IRR_USER IS '';
COMMENT ON COLUMN BARS.TMP_IRR_USER.D IS '';
COMMENT ON COLUMN BARS.TMP_IRR_USER.N IS '';
COMMENT ON COLUMN BARS.TMP_IRR_USER.S IS '';
COMMENT ON COLUMN BARS.TMP_IRR_USER.USERID IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_IRR_USER.sql =========*** End *** 
PROMPT ===================================================================================== 
