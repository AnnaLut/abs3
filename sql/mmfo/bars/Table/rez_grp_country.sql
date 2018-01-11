

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/REZ_GRP_COUNTRY.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to REZ_GRP_COUNTRY ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''REZ_GRP_COUNTRY'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''REZ_GRP_COUNTRY'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''REZ_GRP_COUNTRY'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table REZ_GRP_COUNTRY ***
begin 
  execute immediate '
  CREATE TABLE BARS.REZ_GRP_COUNTRY 
   (	GRP NUMBER(*,0), 
	PR NUMBER, 
	NAME VARCHAR2(35)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to REZ_GRP_COUNTRY ***
 exec bpa.alter_policies('REZ_GRP_COUNTRY');


COMMENT ON TABLE BARS.REZ_GRP_COUNTRY IS '';
COMMENT ON COLUMN BARS.REZ_GRP_COUNTRY.GRP IS '';
COMMENT ON COLUMN BARS.REZ_GRP_COUNTRY.PR IS '';
COMMENT ON COLUMN BARS.REZ_GRP_COUNTRY.NAME IS '';




PROMPT *** Create  constraint XPK_REZ_GRP_COUNTRY ***
begin   
 execute immediate '
  ALTER TABLE BARS.REZ_GRP_COUNTRY ADD CONSTRAINT XPK_REZ_GRP_COUNTRY PRIMARY KEY (GRP)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_REZ_GRP_COUNTRY ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_REZ_GRP_COUNTRY ON BARS.REZ_GRP_COUNTRY (GRP) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  REZ_GRP_COUNTRY ***
grant SELECT                                                                 on REZ_GRP_COUNTRY to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on REZ_GRP_COUNTRY to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on REZ_GRP_COUNTRY to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on REZ_GRP_COUNTRY to RCC_DEAL;
grant SELECT                                                                 on REZ_GRP_COUNTRY to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on REZ_GRP_COUNTRY to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on REZ_GRP_COUNTRY to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/REZ_GRP_COUNTRY.sql =========*** End *
PROMPT ===================================================================================== 
