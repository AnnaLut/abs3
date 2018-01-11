

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DICT_PURPOSE_TRANS.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DICT_PURPOSE_TRANS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DICT_PURPOSE_TRANS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DICT_PURPOSE_TRANS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DICT_PURPOSE_TRANS ***
begin 
  execute immediate '
  CREATE TABLE BARS.DICT_PURPOSE_TRANS 
   (	ID NUMBER, 
	NAME VARCHAR2(500)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DICT_PURPOSE_TRANS ***
 exec bpa.alter_policies('DICT_PURPOSE_TRANS');


COMMENT ON TABLE BARS.DICT_PURPOSE_TRANS IS '';
COMMENT ON COLUMN BARS.DICT_PURPOSE_TRANS.ID IS '';
COMMENT ON COLUMN BARS.DICT_PURPOSE_TRANS.NAME IS '';




PROMPT *** Create  constraint SYS_C0011213 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DICT_PURPOSE_TRANS ADD PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009420 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DICT_PURPOSE_TRANS MODIFY (NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index SYS_C0011213 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.SYS_C0011213 ON BARS.DICT_PURPOSE_TRANS (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DICT_PURPOSE_TRANS ***
grant SELECT                                                                 on DICT_PURPOSE_TRANS to BARSREADER_ROLE;
grant SELECT                                                                 on DICT_PURPOSE_TRANS to BARS_DM;
grant SELECT                                                                 on DICT_PURPOSE_TRANS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DICT_PURPOSE_TRANS.sql =========*** En
PROMPT ===================================================================================== 
