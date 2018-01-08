

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_OPLDOK_300465_ACC.sql =========***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_OPLDOK_300465_ACC ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_OPLDOK_300465_ACC ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_OPLDOK_300465_ACC 
   (	REF NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_OPLDOK_300465_ACC ***
 exec bpa.alter_policies('TMP_OPLDOK_300465_ACC');


COMMENT ON TABLE BARS.TMP_OPLDOK_300465_ACC IS '';
COMMENT ON COLUMN BARS.TMP_OPLDOK_300465_ACC.REF IS '';



PROMPT *** Create  grants  TMP_OPLDOK_300465_ACC ***
grant SELECT                                                                 on TMP_OPLDOK_300465_ACC to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_OPLDOK_300465_ACC.sql =========***
PROMPT ===================================================================================== 
