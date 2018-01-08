

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ORG_PFU.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ORG_PFU ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ORG_PFU ***
begin 
  execute immediate '
  CREATE TABLE BARS.ORG_PFU 
   (	KOD_UPF NUMBER(20,0), 
	NAME_UPF VARCHAR2(60)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ORG_PFU ***
 exec bpa.alter_policies('ORG_PFU');


COMMENT ON TABLE BARS.ORG_PFU IS 'установы ПФ(спец. справочник для Ощад.б.)';
COMMENT ON COLUMN BARS.ORG_PFU.KOD_UPF IS '';
COMMENT ON COLUMN BARS.ORG_PFU.NAME_UPF IS '';




PROMPT *** Create  constraint XPK_ORG_PFU ***
begin   
 execute immediate '
  ALTER TABLE BARS.ORG_PFU ADD CONSTRAINT XPK_ORG_PFU PRIMARY KEY (KOD_UPF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_ORG_PFU ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_ORG_PFU ON BARS.ORG_PFU (KOD_UPF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ORG_PFU ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on ORG_PFU         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ORG_PFU         to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on ORG_PFU         to CORP_CLIENT;
grant DELETE,INSERT,SELECT,UPDATE                                            on ORG_PFU         to ORG_PFU;
grant INSERT,SELECT,UPDATE                                                   on ORG_PFU         to RPBN001;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on ORG_PFU         to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on ORG_PFU         to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ORG_PFU.sql =========*** End *** =====
PROMPT ===================================================================================== 
