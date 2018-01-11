

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_ALL_ENABLED_TRIGGERS.sql =========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_ALL_ENABLED_TRIGGERS ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_ALL_ENABLED_TRIGGERS ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_ALL_ENABLED_TRIGGERS 
   (	OWNER VARCHAR2(20), 
	TRIGGER_NAME VARCHAR2(200)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_ALL_ENABLED_TRIGGERS ***
 exec bpa.alter_policies('TMP_ALL_ENABLED_TRIGGERS');


COMMENT ON TABLE BARS.TMP_ALL_ENABLED_TRIGGERS IS '';
COMMENT ON COLUMN BARS.TMP_ALL_ENABLED_TRIGGERS.OWNER IS '';
COMMENT ON COLUMN BARS.TMP_ALL_ENABLED_TRIGGERS.TRIGGER_NAME IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_ALL_ENABLED_TRIGGERS.sql =========
PROMPT ===================================================================================== 
