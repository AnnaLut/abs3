

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CC_RAZ_KOMIS.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CC_RAZ_KOMIS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CC_RAZ_KOMIS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CC_RAZ_KOMIS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CC_RAZ_KOMIS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CC_RAZ_KOMIS ***
begin 
  execute immediate '
  CREATE TABLE BARS.CC_RAZ_KOMIS 
   (	KOMIS CHAR(6), 
	NAME VARCHAR2(100), 
	SEGMENT NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CC_RAZ_KOMIS ***
 exec bpa.alter_policies('CC_RAZ_KOMIS');


COMMENT ON TABLE BARS.CC_RAZ_KOMIS IS '';
COMMENT ON COLUMN BARS.CC_RAZ_KOMIS.KOMIS IS 'Код разовой комиссии';
COMMENT ON COLUMN BARS.CC_RAZ_KOMIS.NAME IS 'Наименование разовой комиссии';
COMMENT ON COLUMN BARS.CC_RAZ_KOMIS.SEGMENT IS '';




PROMPT *** Create  constraint CC_RAZ_KOMIS_PK ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_RAZ_KOMIS ADD CONSTRAINT CC_RAZ_KOMIS_PK PRIMARY KEY (KOMIS)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_CC_RAZ_KOMIS_K ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_RAZ_KOMIS MODIFY (KOMIS CONSTRAINT NK_CC_RAZ_KOMIS_K NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_CC_RAZ_KOMIS_N ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_RAZ_KOMIS MODIFY (NAME CONSTRAINT NK_CC_RAZ_KOMIS_N NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index CC_RAZ_KOMIS_PK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.CC_RAZ_KOMIS_PK ON BARS.CC_RAZ_KOMIS (KOMIS) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CC_RAZ_KOMIS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on CC_RAZ_KOMIS    to ABS_ADMIN;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CC_RAZ_KOMIS    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CC_RAZ_KOMIS    to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CC_RAZ_KOMIS    to RCC_DEAL;
grant FLASHBACK,SELECT                                                       on CC_RAZ_KOMIS    to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CC_RAZ_KOMIS.sql =========*** End *** 
PROMPT ===================================================================================== 
