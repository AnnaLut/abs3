

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_2625_KK_V.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_2625_KK_V ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_2625_KK_V ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_2625_KK_V 
   (	FIO VARCHAR2(100), 
	OKPO VARCHAR2(10), 
	KK_2625 VARCHAR2(14), 
	MOB_PHONE VARCHAR2(30), 
	BRANCH_KK VARCHAR2(30), 
	NOT_KK_2625 VARCHAR2(14), 
	MOB_PHONE2 VARCHAR2(30), 
	BRANCH_NOT_KK VARCHAR2(30), 
	SER VARCHAR2(4), 
	PASSP VARCHAR2(6), 
	ORGAN VARCHAR2(200), 
	PDATE VARCHAR2(10), 
	BDAY VARCHAR2(10)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_2625_KK_V ***
 exec bpa.alter_policies('TMP_2625_KK_V');


COMMENT ON TABLE BARS.TMP_2625_KK_V IS '';
COMMENT ON COLUMN BARS.TMP_2625_KK_V.FIO IS '';
COMMENT ON COLUMN BARS.TMP_2625_KK_V.OKPO IS '';
COMMENT ON COLUMN BARS.TMP_2625_KK_V.KK_2625 IS '';
COMMENT ON COLUMN BARS.TMP_2625_KK_V.MOB_PHONE IS '';
COMMENT ON COLUMN BARS.TMP_2625_KK_V.BRANCH_KK IS '';
COMMENT ON COLUMN BARS.TMP_2625_KK_V.NOT_KK_2625 IS '';
COMMENT ON COLUMN BARS.TMP_2625_KK_V.MOB_PHONE2 IS '';
COMMENT ON COLUMN BARS.TMP_2625_KK_V.BRANCH_NOT_KK IS '';
COMMENT ON COLUMN BARS.TMP_2625_KK_V.SER IS '';
COMMENT ON COLUMN BARS.TMP_2625_KK_V.PASSP IS '';
COMMENT ON COLUMN BARS.TMP_2625_KK_V.ORGAN IS '';
COMMENT ON COLUMN BARS.TMP_2625_KK_V.PDATE IS '';
COMMENT ON COLUMN BARS.TMP_2625_KK_V.BDAY IS '';



PROMPT *** Create  grants  TMP_2625_KK_V ***
grant SELECT                                                                 on TMP_2625_KK_V   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_2625_KK_V.sql =========*** End ***
PROMPT ===================================================================================== 
