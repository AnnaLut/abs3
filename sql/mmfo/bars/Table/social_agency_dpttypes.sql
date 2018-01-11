

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SOCIAL_AGENCY_DPTTYPES.sql =========**
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SOCIAL_AGENCY_DPTTYPES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SOCIAL_AGENCY_DPTTYPES'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SOCIAL_AGENCY_DPTTYPES'', ''FILIAL'' , null, ''C'', ''C'', ''C'');
               bpa.alter_policy_info(''SOCIAL_AGENCY_DPTTYPES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SOCIAL_AGENCY_DPTTYPES ***
begin 
  execute immediate '
  CREATE TABLE BARS.SOCIAL_AGENCY_DPTTYPES 
   (	AGNTYPE NUMBER(38,0), 
	DPTTYPE NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SOCIAL_AGENCY_DPTTYPES ***
 exec bpa.alter_policies('SOCIAL_AGENCY_DPTTYPES');


COMMENT ON TABLE BARS.SOCIAL_AGENCY_DPTTYPES IS 'Перелік допустимих типів договорів для типів органів соціального захисту';
COMMENT ON COLUMN BARS.SOCIAL_AGENCY_DPTTYPES.AGNTYPE IS 'Код типу органу соц.захисту';
COMMENT ON COLUMN BARS.SOCIAL_AGENCY_DPTTYPES.DPTTYPE IS 'Код типу договору';




PROMPT *** Create  constraint PK_SOCAGNDPTYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.SOCIAL_AGENCY_DPTTYPES ADD CONSTRAINT PK_SOCAGNDPTYPE PRIMARY KEY (AGNTYPE, DPTTYPE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SOCAGNDPTYPE_AGN_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SOCIAL_AGENCY_DPTTYPES MODIFY (AGNTYPE CONSTRAINT CC_SOCAGNDPTYPE_AGN_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SOCAGNDPTYPE_DPT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SOCIAL_AGENCY_DPTTYPES MODIFY (DPTTYPE CONSTRAINT CC_SOCAGNDPTYPE_DPT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SOCAGNDPTYPE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SOCAGNDPTYPE ON BARS.SOCIAL_AGENCY_DPTTYPES (AGNTYPE, DPTTYPE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SOCIAL_AGENCY_DPTTYPES ***
grant SELECT                                                                 on SOCIAL_AGENCY_DPTTYPES to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SOCIAL_AGENCY_DPTTYPES to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SOCIAL_AGENCY_DPTTYPES to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on SOCIAL_AGENCY_DPTTYPES to DPT_ADMIN;
grant SELECT                                                                 on SOCIAL_AGENCY_DPTTYPES to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SOCIAL_AGENCY_DPTTYPES to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on SOCIAL_AGENCY_DPTTYPES to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SOCIAL_AGENCY_DPTTYPES.sql =========**
PROMPT ===================================================================================== 
