

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/PRVN_EVENT_TYPE.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to PRVN_EVENT_TYPE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''PRVN_EVENT_TYPE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''PRVN_EVENT_TYPE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''PRVN_EVENT_TYPE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table PRVN_EVENT_TYPE ***
begin 
  execute immediate '
  CREATE TABLE BARS.PRVN_EVENT_TYPE 
   (	ID NUMBER(1,0), 
	NAME VARCHAR2(500)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to PRVN_EVENT_TYPE ***
 exec bpa.alter_policies('PRVN_EVENT_TYPE');


COMMENT ON TABLE BARS.PRVN_EVENT_TYPE IS 'Типи подій дефолту';
COMMENT ON COLUMN BARS.PRVN_EVENT_TYPE.ID IS 'Ід. номер';
COMMENT ON COLUMN BARS.PRVN_EVENT_TYPE.NAME IS 'Найменування';




PROMPT *** Create  constraint SYS_C0012079 ***
begin   
 execute immediate '
  ALTER TABLE BARS.PRVN_EVENT_TYPE ADD PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index SYS_C0012079 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.SYS_C0012079 ON BARS.PRVN_EVENT_TYPE (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  PRVN_EVENT_TYPE ***
grant SELECT                                                                 on PRVN_EVENT_TYPE to BARSREADER_ROLE;
grant SELECT                                                                 on PRVN_EVENT_TYPE to BARSUPL;
grant SELECT                                                                 on PRVN_EVENT_TYPE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on PRVN_EVENT_TYPE to BARS_DM;
grant SELECT                                                                 on PRVN_EVENT_TYPE to START1;
grant SELECT                                                                 on PRVN_EVENT_TYPE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/PRVN_EVENT_TYPE.sql =========*** End *
PROMPT ===================================================================================== 
