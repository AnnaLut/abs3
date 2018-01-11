

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_VIP_FLAGS.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_VIP_FLAGS ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_VIP_FLAGS ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_VIP_FLAGS 
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




PROMPT *** ALTER_POLICIES to TMP_VIP_FLAGS ***
 exec bpa.alter_policies('TMP_VIP_FLAGS');


COMMENT ON TABLE BARS.TMP_VIP_FLAGS IS '';
COMMENT ON COLUMN BARS.TMP_VIP_FLAGS.MFO IS '';
COMMENT ON COLUMN BARS.TMP_VIP_FLAGS.RNK IS '';
COMMENT ON COLUMN BARS.TMP_VIP_FLAGS.VIP IS '';
COMMENT ON COLUMN BARS.TMP_VIP_FLAGS.KVIP IS '';
COMMENT ON COLUMN BARS.TMP_VIP_FLAGS.DATBEG IS '';
COMMENT ON COLUMN BARS.TMP_VIP_FLAGS.DATEND IS '';
COMMENT ON COLUMN BARS.TMP_VIP_FLAGS.COMMENTS IS '';
COMMENT ON COLUMN BARS.TMP_VIP_FLAGS.CM_FLAG IS '';
COMMENT ON COLUMN BARS.TMP_VIP_FLAGS.CM_TRY IS '';
COMMENT ON COLUMN BARS.TMP_VIP_FLAGS.FIO_MANAGER IS '';
COMMENT ON COLUMN BARS.TMP_VIP_FLAGS.PHONE_MANAGER IS '';
COMMENT ON COLUMN BARS.TMP_VIP_FLAGS.MAIL_MANAGER IS '';
COMMENT ON COLUMN BARS.TMP_VIP_FLAGS.ACCOUNT_MANAGER IS '';



PROMPT *** Create  grants  TMP_VIP_FLAGS ***
grant SELECT                                                                 on TMP_VIP_FLAGS   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_VIP_FLAGS.sql =========*** End ***
PROMPT ===================================================================================== 
