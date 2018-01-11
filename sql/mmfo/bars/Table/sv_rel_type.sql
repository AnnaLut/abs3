

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SV_REL_TYPE.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SV_REL_TYPE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SV_REL_TYPE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SV_REL_TYPE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SV_REL_TYPE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SV_REL_TYPE ***
begin 
  execute immediate '
  CREATE TABLE BARS.SV_REL_TYPE 
   (	ID NUMBER(10,0), 
	NAME VARCHAR2(100)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SV_REL_TYPE ***
 exec bpa.alter_policies('SV_REL_TYPE');


COMMENT ON TABLE BARS.SV_REL_TYPE IS 'Взаємозв’язки особи з банком ';
COMMENT ON COLUMN BARS.SV_REL_TYPE.ID IS 'Iд.';
COMMENT ON COLUMN BARS.SV_REL_TYPE.NAME IS 'Взаємозв’язки особи з банком ';




PROMPT *** Create  constraint PK_SVRELTYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.SV_REL_TYPE ADD CONSTRAINT PK_SVRELTYPE PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SVRELTYPE_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SV_REL_TYPE ADD CONSTRAINT CC_SVRELTYPE_ID_NN CHECK (ID IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SVRELTYPE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SVRELTYPE ON BARS.SV_REL_TYPE (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SV_REL_TYPE ***
grant SELECT                                                                 on SV_REL_TYPE     to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on SV_REL_TYPE     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SV_REL_TYPE     to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on SV_REL_TYPE     to RPBN002;
grant SELECT                                                                 on SV_REL_TYPE     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SV_REL_TYPE.sql =========*** End *** =
PROMPT ===================================================================================== 
