

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/WCS_REF_COUNT.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to WCS_REF_COUNT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''WCS_REF_COUNT'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_REF_COUNT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table WCS_REF_COUNT ***
begin 
  execute immediate '
  CREATE TABLE BARS.WCS_REF_COUNT 
   (	COUNT NUMBER, 
	TAB_NAME VARCHAR2(29)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to WCS_REF_COUNT ***
 exec bpa.alter_policies('WCS_REF_COUNT');


COMMENT ON TABLE BARS.WCS_REF_COUNT IS '';
COMMENT ON COLUMN BARS.WCS_REF_COUNT.COUNT IS '';
COMMENT ON COLUMN BARS.WCS_REF_COUNT.TAB_NAME IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/WCS_REF_COUNT.sql =========*** End ***
PROMPT ===================================================================================== 
