

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/IMPORT_TYPES.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to IMPORT_TYPES ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table IMPORT_TYPES ***
begin 
  execute immediate '
  CREATE TABLE BARS.IMPORT_TYPES 
   (	FILE_TYPE NUMBER(*,0), 
	NAME VARCHAR2(200)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to IMPORT_TYPES ***
 exec bpa.alter_policies('IMPORT_TYPES');


COMMENT ON TABLE BARS.IMPORT_TYPES IS '';
COMMENT ON COLUMN BARS.IMPORT_TYPES.FILE_TYPE IS '';
COMMENT ON COLUMN BARS.IMPORT_TYPES.NAME IS '';



PROMPT *** Create  grants  IMPORT_TYPES ***
grant SELECT                                                                 on IMPORT_TYPES    to BARSREADER_ROLE;
grant SELECT                                                                 on IMPORT_TYPES    to BARS_DM;
grant SELECT                                                                 on IMPORT_TYPES    to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on IMPORT_TYPES    to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/IMPORT_TYPES.sql =========*** End *** 
PROMPT ===================================================================================== 
