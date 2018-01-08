

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/RNKP_KOD_ACC.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to RNKP_KOD_ACC ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''RNKP_KOD_ACC'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''RNKP_KOD_ACC'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''RNKP_KOD_ACC'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table RNKP_KOD_ACC ***
begin 
  execute immediate '
  CREATE TABLE BARS.RNKP_KOD_ACC 
   (	RNK NUMBER, 
	KODK NUMBER, 
	ACC NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to RNKP_KOD_ACC ***
 exec bpa.alter_policies('RNKP_KOD_ACC');


COMMENT ON TABLE BARS.RNKP_KOD_ACC IS 'Альтернативные коды корпораций для счета корп. клиента';
COMMENT ON COLUMN BARS.RNKP_KOD_ACC.RNK IS '';
COMMENT ON COLUMN BARS.RNKP_KOD_ACC.KODK IS '';
COMMENT ON COLUMN BARS.RNKP_KOD_ACC.ACC IS '';




PROMPT *** Create  constraint XPK_RNKPKODACC ***
begin   
 execute immediate '
  ALTER TABLE BARS.RNKP_KOD_ACC ADD CONSTRAINT XPK_RNKPKODACC PRIMARY KEY (RNK, KODK, ACC)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XFK_RNKPKODACC_KODK ***
begin   
 execute immediate '
  ALTER TABLE BARS.RNKP_KOD_ACC ADD CONSTRAINT XFK_RNKPKODACC_KODK FOREIGN KEY (KODK)
	  REFERENCES BARS.KOD_CLI (KOD_CLI) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XFK_RNKPKODACC_RNK ***
begin   
 execute immediate '
  ALTER TABLE BARS.RNKP_KOD_ACC ADD CONSTRAINT XFK_RNKPKODACC_RNK FOREIGN KEY (RNK)
	  REFERENCES BARS.CUSTOMER (RNK) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_RNKPKODACC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_RNKPKODACC ON BARS.RNKP_KOD_ACC (RNK, KODK, ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  RNKP_KOD_ACC ***
grant DELETE,INSERT,SELECT,UPDATE                                            on RNKP_KOD_ACC    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on RNKP_KOD_ACC    to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on RNKP_KOD_ACC    to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/RNKP_KOD_ACC.sql =========*** End *** 
PROMPT ===================================================================================== 
