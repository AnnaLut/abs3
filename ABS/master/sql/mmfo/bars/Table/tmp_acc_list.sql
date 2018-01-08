

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_ACC_LIST.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_ACC_LIST ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_ACC_LIST ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_ACC_LIST 
   (	ACC NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_ACC_LIST ***
 exec bpa.alter_policies('TMP_ACC_LIST');


COMMENT ON TABLE BARS.TMP_ACC_LIST IS '';
COMMENT ON COLUMN BARS.TMP_ACC_LIST.ACC IS '';



PROMPT *** Create  grants  TMP_ACC_LIST ***
grant SELECT                                                                 on TMP_ACC_LIST    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_ACC_LIST.sql =========*** End *** 
PROMPT ===================================================================================== 
