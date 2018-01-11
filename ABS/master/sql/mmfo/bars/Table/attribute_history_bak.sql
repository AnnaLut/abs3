

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ATTRIBUTE_HISTORY_BAK.sql =========***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ATTRIBUTE_HISTORY_BAK ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ATTRIBUTE_HISTORY_BAK ***
begin 
  execute immediate '
  CREATE TABLE BARS.ATTRIBUTE_HISTORY_BAK 
   (	ID NUMBER(10,0), 
	OBJECT_ID NUMBER(12,0), 
	ATTRIBUTE_ID NUMBER(5,0), 
	VALUE_DATE DATE, 
	USER_ID NUMBER(5,0), 
	SYS_TIME DATE, 
	IS_DELETE CHAR(1)
   ) PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
  TABLESPACE BRSDYND 
  PARTITION BY RANGE (ATTRIBUTE_ID) INTERVAL (1) 
 (PARTITION INITIAL_PARTITION  VALUES LESS THAN (1) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSDYND ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ATTRIBUTE_HISTORY_BAK ***
 exec bpa.alter_policies('ATTRIBUTE_HISTORY_BAK');


COMMENT ON TABLE BARS.ATTRIBUTE_HISTORY_BAK IS '';
COMMENT ON COLUMN BARS.ATTRIBUTE_HISTORY_BAK.SYS_TIME IS '';
COMMENT ON COLUMN BARS.ATTRIBUTE_HISTORY_BAK.IS_DELETE IS '';
COMMENT ON COLUMN BARS.ATTRIBUTE_HISTORY_BAK.ID IS '';
COMMENT ON COLUMN BARS.ATTRIBUTE_HISTORY_BAK.OBJECT_ID IS '';
COMMENT ON COLUMN BARS.ATTRIBUTE_HISTORY_BAK.ATTRIBUTE_ID IS '';
COMMENT ON COLUMN BARS.ATTRIBUTE_HISTORY_BAK.VALUE_DATE IS '';
COMMENT ON COLUMN BARS.ATTRIBUTE_HISTORY_BAK.USER_ID IS '';



PROMPT *** Create  grants  ATTRIBUTE_HISTORY_BAK ***
grant SELECT                                                                 on ATTRIBUTE_HISTORY_BAK to BARSREADER_ROLE;
grant SELECT                                                                 on ATTRIBUTE_HISTORY_BAK to BARS_DM;
grant SELECT                                                                 on ATTRIBUTE_HISTORY_BAK to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ATTRIBUTE_HISTORY_BAK.sql =========***
PROMPT ===================================================================================== 
