

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CL_2_AC_SCAN.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CL_2_AC_SCAN ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CL_2_AC_SCAN'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CL_2_AC_SCAN ***
begin 
  execute immediate '
  CREATE TABLE BARS.CL_2_AC_SCAN 
   (	LAST_DT DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CL_2_AC_SCAN ***
 exec bpa.alter_policies('CL_2_AC_SCAN');


COMMENT ON TABLE BARS.CL_2_AC_SCAN IS '';
COMMENT ON COLUMN BARS.CL_2_AC_SCAN.LAST_DT IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CL_2_AC_SCAN.sql =========*** End *** 
PROMPT ===================================================================================== 
