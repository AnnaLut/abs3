

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_OPEN_PACK.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_OPEN_PACK ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_OPEN_PACK ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_OPEN_PACK 
   (	ID NUMBER, 
	FIO VARCHAR2(100), 
	OKPO VARCHAR2(20)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_OPEN_PACK ***
 exec bpa.alter_policies('TMP_OPEN_PACK');


COMMENT ON TABLE BARS.TMP_OPEN_PACK IS '';
COMMENT ON COLUMN BARS.TMP_OPEN_PACK.ID IS '';
COMMENT ON COLUMN BARS.TMP_OPEN_PACK.FIO IS '';
COMMENT ON COLUMN BARS.TMP_OPEN_PACK.OKPO IS '';



PROMPT *** Create  grants  TMP_OPEN_PACK ***
grant SELECT                                                                 on TMP_OPEN_PACK   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_OPEN_PACK.sql =========*** End ***
PROMPT ===================================================================================== 
