

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/VIP_FLAGS.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to VIP_FLAGS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''VIP_FLAGS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''VIP_FLAGS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''VIP_FLAGS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table VIP_FLAGS ***
begin 
  execute immediate '
  CREATE TABLE BARS.VIP_FLAGS 
   (	MFO VARCHAR2(6), 
	RNK VARCHAR2(20), 
	VIP VARCHAR2(10), 
	KVIP VARCHAR2(10), 
	DATBEG DATE, 
	DATEND DATE, 
	COMMENTS VARCHAR2(500), 
	CM_FLAG NUMBER(1,0), 
	CM_TRY NUMBER(10,0), 
	FIO_MANAGER VARCHAR2(250), 
	PHONE_MANAGER VARCHAR2(30), 
	MAIL_MANAGER VARCHAR2(100), 
	ACCOUNT_MANAGER NUMBER(10,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to VIP_FLAGS ***
 exec bpa.alter_policies('VIP_FLAGS');


COMMENT ON TABLE BARS.VIP_FLAGS IS '';
COMMENT ON COLUMN BARS.VIP_FLAGS.MAIL_MANAGER IS '';
COMMENT ON COLUMN BARS.VIP_FLAGS.ACCOUNT_MANAGER IS '';
COMMENT ON COLUMN BARS.VIP_FLAGS.MFO IS '';
COMMENT ON COLUMN BARS.VIP_FLAGS.RNK IS '';
COMMENT ON COLUMN BARS.VIP_FLAGS.VIP IS '';
COMMENT ON COLUMN BARS.VIP_FLAGS.KVIP IS '';
COMMENT ON COLUMN BARS.VIP_FLAGS.DATBEG IS '';
COMMENT ON COLUMN BARS.VIP_FLAGS.DATEND IS '';
COMMENT ON COLUMN BARS.VIP_FLAGS.COMMENTS IS '';
COMMENT ON COLUMN BARS.VIP_FLAGS.CM_FLAG IS 'Флаг отправки запроса в СМ: 1-на установку vip, 2-на снятие vip';
COMMENT ON COLUMN BARS.VIP_FLAGS.CM_TRY IS 'Количество попыток отправки запроса в СМ';
COMMENT ON COLUMN BARS.VIP_FLAGS.FIO_MANAGER IS '';
COMMENT ON COLUMN BARS.VIP_FLAGS.PHONE_MANAGER IS '';




PROMPT *** Create  constraint PK_VIP_FLAGS ***
begin   
 execute immediate '
  ALTER TABLE BARS.VIP_FLAGS ADD CONSTRAINT PK_VIP_FLAGS PRIMARY KEY (MFO, RNK)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_VIP_FLAGS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_VIP_FLAGS ON BARS.VIP_FLAGS (MFO, RNK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  VIP_FLAGS ***
grant SELECT                                                                 on VIP_FLAGS       to BARSUPL;
grant DELETE,INSERT,SELECT,UPDATE                                            on VIP_FLAGS       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on VIP_FLAGS       to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on VIP_FLAGS       to START1;
grant SELECT                                                                 on VIP_FLAGS       to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/VIP_FLAGS.sql =========*** End *** ===
PROMPT ===================================================================================== 
