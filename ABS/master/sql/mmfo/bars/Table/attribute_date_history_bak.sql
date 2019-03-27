

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ATTRIBUTE_DATE_HISTORY_BAK.sql =======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ATTRIBUTE_DATE_HISTORY_BAK ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ATTRIBUTE_DATE_HISTORY_BAK ***
begin 
  execute immediate '
  CREATE TABLE BARS.ATTRIBUTE_DATE_HISTORY_BAK 
   (	ID NUMBER(10,0), 
	VALUE DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ATTRIBUTE_DATE_HISTORY_BAK ***
 exec bpa.alter_policies('ATTRIBUTE_DATE_HISTORY_BAK');


COMMENT ON TABLE BARS.ATTRIBUTE_DATE_HISTORY_BAK IS '';
COMMENT ON COLUMN BARS.ATTRIBUTE_DATE_HISTORY_BAK.ID IS '';
COMMENT ON COLUMN BARS.ATTRIBUTE_DATE_HISTORY_BAK.VALUE IS '';



PROMPT *** Create  grants  ATTRIBUTE_DATE_HISTORY_BAK ***
grant SELECT                                                                 on ATTRIBUTE_DATE_HISTORY_BAK to BARSREADER_ROLE;
grant SELECT                                                                 on ATTRIBUTE_DATE_HISTORY_BAK to BARS_DM;
grant SELECT                                                                 on ATTRIBUTE_DATE_HISTORY_BAK to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ATTRIBUTE_DATE_HISTORY_BAK.sql =======
PROMPT ===================================================================================== 