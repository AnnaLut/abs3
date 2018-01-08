

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ADR_HOMEPART_TYPE.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ADR_HOMEPART_TYPE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ADR_HOMEPART_TYPE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ADR_HOMEPART_TYPE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ADR_HOMEPART_TYPE ***
begin 
  execute immediate '
  CREATE TABLE BARS.ADR_HOMEPART_TYPE 
   (	ID NUMBER(22,0), 
	NAME VARCHAR2(300 CHAR), 
	VALUE VARCHAR2(300 CHAR)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ADR_HOMEPART_TYPE ***
 exec bpa.alter_policies('ADR_HOMEPART_TYPE');


COMMENT ON TABLE BARS.ADR_HOMEPART_TYPE IS '';
COMMENT ON COLUMN BARS.ADR_HOMEPART_TYPE.ID IS '';
COMMENT ON COLUMN BARS.ADR_HOMEPART_TYPE.NAME IS '';
COMMENT ON COLUMN BARS.ADR_HOMEPART_TYPE.VALUE IS '';



PROMPT *** Create  grants  ADR_HOMEPART_TYPE ***
grant SELECT                                                                 on ADR_HOMEPART_TYPE to BARSREADER_ROLE;
grant SELECT                                                                 on ADR_HOMEPART_TYPE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ADR_HOMEPART_TYPE.sql =========*** End
PROMPT ===================================================================================== 
