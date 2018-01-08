

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_W4_ACC_INSTANT.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_W4_ACC_INSTANT ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_W4_ACC_INSTANT ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_W4_ACC_INSTANT 
   (	ACC NUMBER(22,0), 
	CARD_CODE VARCHAR2(32), 
	KF VARCHAR2(6), 
	BATCHID NUMBER, 
	STATE NUMBER(*,0), 
	RNK NUMBER, 
	REQID NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_W4_ACC_INSTANT ***
 exec bpa.alter_policies('TMP_W4_ACC_INSTANT');


COMMENT ON TABLE BARS.TMP_W4_ACC_INSTANT IS '';
COMMENT ON COLUMN BARS.TMP_W4_ACC_INSTANT.ACC IS '';
COMMENT ON COLUMN BARS.TMP_W4_ACC_INSTANT.CARD_CODE IS '';
COMMENT ON COLUMN BARS.TMP_W4_ACC_INSTANT.KF IS '';
COMMENT ON COLUMN BARS.TMP_W4_ACC_INSTANT.BATCHID IS '';
COMMENT ON COLUMN BARS.TMP_W4_ACC_INSTANT.STATE IS '';
COMMENT ON COLUMN BARS.TMP_W4_ACC_INSTANT.RNK IS '';
COMMENT ON COLUMN BARS.TMP_W4_ACC_INSTANT.REQID IS '';




PROMPT *** Create  constraint SYS_C00132468 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_W4_ACC_INSTANT MODIFY (ACC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00132469 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_W4_ACC_INSTANT MODIFY (CARD_CODE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00132470 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_W4_ACC_INSTANT MODIFY (KF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_W4_ACC_INSTANT ***
grant SELECT                                                                 on TMP_W4_ACC_INSTANT to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_W4_ACC_INSTANT.sql =========*** En
PROMPT ===================================================================================== 
