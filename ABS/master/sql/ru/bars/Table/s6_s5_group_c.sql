

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/S6_S5_GROUP_C.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to S6_S5_GROUP_C ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table S6_S5_GROUP_C ***
begin 
  execute immediate '
  CREATE TABLE BARS.S6_S5_GROUP_C 
   (	GROUP_C VARCHAR2(1), 
	MASKA VARCHAR2(14)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to S6_S5_GROUP_C ***
 exec bpa.alter_policies('S6_S5_GROUP_C');


COMMENT ON TABLE BARS.S6_S5_GROUP_C IS '';
COMMENT ON COLUMN BARS.S6_S5_GROUP_C.GROUP_C IS '';
COMMENT ON COLUMN BARS.S6_S5_GROUP_C.MASKA IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/S6_S5_GROUP_C.sql =========*** End ***
PROMPT ===================================================================================== 
