

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/VIP_FLAGS_UPDATE.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to VIP_FLAGS_UPDATE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''VIP_FLAGS_UPDATE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''VIP_FLAGS_UPDATE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''VIP_FLAGS_UPDATE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table VIP_FLAGS_UPDATE ***
begin 
  execute immediate '
  CREATE TABLE BARS.VIP_FLAGS_UPDATE 
   (	MFO VARCHAR2(6), 
	RNK VARCHAR2(20), 
	DATBEG DATE, 
	DATEND DATE, 
	VIP VARCHAR2(10), 
	KVIP VARCHAR2(10), 
	COMMENTS VARCHAR2(500), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to VIP_FLAGS_UPDATE ***
 exec bpa.alter_policies('VIP_FLAGS_UPDATE');


COMMENT ON TABLE BARS.VIP_FLAGS_UPDATE IS '';
COMMENT ON COLUMN BARS.VIP_FLAGS_UPDATE.MFO IS 'Код банку';
COMMENT ON COLUMN BARS.VIP_FLAGS_UPDATE.RNK IS 'Реєстраційний номер клієнта (РНК)';
COMMENT ON COLUMN BARS.VIP_FLAGS_UPDATE.DATBEG IS 'Дата встановлення клієнту ознаки VIP';
COMMENT ON COLUMN BARS.VIP_FLAGS_UPDATE.DATEND IS 'Дата закінчення дії ознаки VIP';
COMMENT ON COLUMN BARS.VIP_FLAGS_UPDATE.VIP IS 'Код ознаки VIP';
COMMENT ON COLUMN BARS.VIP_FLAGS_UPDATE.KVIP IS 'Код категорії VIP клієнта';
COMMENT ON COLUMN BARS.VIP_FLAGS_UPDATE.COMMENTS IS 'Коментар';
COMMENT ON COLUMN BARS.VIP_FLAGS_UPDATE.KF IS '';




PROMPT *** Create  constraint PK_VIPFLAGSUPD ***
begin   
 execute immediate '
  ALTER TABLE BARS.VIP_FLAGS_UPDATE ADD CONSTRAINT PK_VIPFLAGSUPD PRIMARY KEY (MFO, RNK, DATBEG)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_VIPFLAGSUPD ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_VIPFLAGSUPD ON BARS.VIP_FLAGS_UPDATE (MFO, RNK, DATBEG) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index IDX_VIPFLAGSUPD_DATBEG ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_VIPFLAGSUPD_DATBEG ON BARS.VIP_FLAGS_UPDATE (DATBEG) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  VIP_FLAGS_UPDATE ***
grant SELECT                                                                 on VIP_FLAGS_UPDATE to BARSUPL;
grant DELETE,INSERT,SELECT,UPDATE                                            on VIP_FLAGS_UPDATE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on VIP_FLAGS_UPDATE to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on VIP_FLAGS_UPDATE to START1;
grant SELECT                                                                 on VIP_FLAGS_UPDATE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/VIP_FLAGS_UPDATE.sql =========*** End 
PROMPT ===================================================================================== 
