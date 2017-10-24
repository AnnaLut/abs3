

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_AGRK_ACC.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_AGRK_ACC ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_AGRK_ACC ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_AGRK_ACC 
   (	NLS VARCHAR2(15)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_AGRK_ACC ***
 exec bpa.alter_policies('TMP_AGRK_ACC');


COMMENT ON TABLE BARS.TMP_AGRK_ACC IS '';
COMMENT ON COLUMN BARS.TMP_AGRK_ACC.NLS IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_AGRK_ACC.sql =========*** End *** 
PROMPT ===================================================================================== 
