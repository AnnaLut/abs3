

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/MIGR_MAILABON.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to MIGR_MAILABON ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table MIGR_MAILABON ***
begin 
  execute immediate '
  CREATE TABLE BARS.MIGR_MAILABON 
   (	ABON VARCHAR2(4), 
	NAME VARCHAR2(70), 
	ABON_TYPE NUMBER(*,0), 
	ABON_GROUP NUMBER(*,0), 
	FLAGS VARCHAR2(64), 
	OUTSESSIONS VARCHAR2(64), 
	OKPO VARCHAR2(14), 
	ID_FOLDER VARCHAR2(64), 
	ISP_OWNER NUMBER(*,0), 
	WHOLEISP NUMBER(*,0), 
	WHOLEDEPART VARCHAR2(30)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to MIGR_MAILABON ***
 exec bpa.alter_policies('MIGR_MAILABON');


COMMENT ON TABLE BARS.MIGR_MAILABON IS '';
COMMENT ON COLUMN BARS.MIGR_MAILABON.ABON IS '';
COMMENT ON COLUMN BARS.MIGR_MAILABON.NAME IS '';
COMMENT ON COLUMN BARS.MIGR_MAILABON.ABON_TYPE IS '';
COMMENT ON COLUMN BARS.MIGR_MAILABON.ABON_GROUP IS '';
COMMENT ON COLUMN BARS.MIGR_MAILABON.FLAGS IS '';
COMMENT ON COLUMN BARS.MIGR_MAILABON.OUTSESSIONS IS '';
COMMENT ON COLUMN BARS.MIGR_MAILABON.OKPO IS '';
COMMENT ON COLUMN BARS.MIGR_MAILABON.ID_FOLDER IS '';
COMMENT ON COLUMN BARS.MIGR_MAILABON.ISP_OWNER IS '';
COMMENT ON COLUMN BARS.MIGR_MAILABON.WHOLEISP IS '';
COMMENT ON COLUMN BARS.MIGR_MAILABON.WHOLEDEPART IS '';



PROMPT *** Create  grants  MIGR_MAILABON ***
grant SELECT                                                                 on MIGR_MAILABON   to BARSREADER_ROLE;
grant SELECT                                                                 on MIGR_MAILABON   to BARS_DM;
grant SELECT                                                                 on MIGR_MAILABON   to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on MIGR_MAILABON   to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/MIGR_MAILABON.sql =========*** End ***
PROMPT ===================================================================================== 
