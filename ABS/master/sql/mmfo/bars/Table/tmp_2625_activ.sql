

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_2625_ACTIV.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_2625_ACTIV ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_2625_ACTIV ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_2625_ACTIV 
   (	NLS VARCHAR2(14), 
	OKPO VARCHAR2(10)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_2625_ACTIV ***
 exec bpa.alter_policies('TMP_2625_ACTIV');


COMMENT ON TABLE BARS.TMP_2625_ACTIV IS '';
COMMENT ON COLUMN BARS.TMP_2625_ACTIV.NLS IS '';
COMMENT ON COLUMN BARS.TMP_2625_ACTIV.OKPO IS '';



PROMPT *** Create  grants  TMP_2625_ACTIV ***
grant SELECT                                                                 on TMP_2625_ACTIV  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_2625_ACTIV.sql =========*** End **
PROMPT ===================================================================================== 
