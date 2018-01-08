

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/RNKP_KOD.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to RNKP_KOD ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table RNKP_KOD ***
begin 
  execute immediate '
  CREATE TABLE BARS.RNKP_KOD 
   (	RNK NUMBER, 
	KODK NUMBER, 
	KODU NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to RNKP_KOD ***
 exec bpa.alter_policies('RNKP_KOD');


COMMENT ON TABLE BARS.RNKP_KOD IS 'Связка РНК корпоративных клиентов с кодами корпораций';
COMMENT ON COLUMN BARS.RNKP_KOD.RNK IS 'РНК клиента, который входит в корпорацию';
COMMENT ON COLUMN BARS.RNKP_KOD.KODK IS 'Код корпорации';
COMMENT ON COLUMN BARS.RNKP_KOD.KODU IS 'Код учереждения корпорации';




PROMPT *** Create  constraint XUK_RNKPKOD_RNKKOD ***
begin   
 execute immediate '
  ALTER TABLE BARS.RNKP_KOD ADD CONSTRAINT XUK_RNKPKOD_RNKKOD UNIQUE (RNK, KODK)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XUK_RNKPKOD_RNKKOD ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XUK_RNKPKOD_RNKKOD ON BARS.RNKP_KOD (RNK, KODK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  RNKP_KOD ***
grant SELECT                                                                 on RNKP_KOD        to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on RNKP_KOD        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on RNKP_KOD        to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on RNKP_KOD        to CORP_CLIENT;
grant DELETE,INSERT,SELECT,UPDATE                                            on RNKP_KOD        to RNKP_KOD;
grant INSERT,SELECT,UPDATE                                                   on RNKP_KOD        to RPBN001;
grant SELECT                                                                 on RNKP_KOD        to START1;
grant SELECT                                                                 on RNKP_KOD        to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on RNKP_KOD        to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on RNKP_KOD        to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/RNKP_KOD.sql =========*** End *** ====
PROMPT ===================================================================================== 
