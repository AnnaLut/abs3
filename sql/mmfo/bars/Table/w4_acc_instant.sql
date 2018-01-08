

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/W4_ACC_INSTANT.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to W4_ACC_INSTANT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''W4_ACC_INSTANT'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''W4_ACC_INSTANT'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''W4_ACC_INSTANT'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table W4_ACC_INSTANT ***
begin 
  execute immediate '
  CREATE TABLE BARS.W4_ACC_INSTANT 
   (	ACC NUMBER(22,0), 
	CARD_CODE VARCHAR2(32), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	BATCHID NUMBER, 
	STATE NUMBER(*,0), 
	RNK NUMBER, 
	REQID NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to W4_ACC_INSTANT ***
 exec bpa.alter_policies('W4_ACC_INSTANT');


COMMENT ON TABLE BARS.W4_ACC_INSTANT IS 'OW. Рахунки Instant';
COMMENT ON COLUMN BARS.W4_ACC_INSTANT.STATE IS '';
COMMENT ON COLUMN BARS.W4_ACC_INSTANT.RNK IS '';
COMMENT ON COLUMN BARS.W4_ACC_INSTANT.REQID IS '';
COMMENT ON COLUMN BARS.W4_ACC_INSTANT.KF IS '';
COMMENT ON COLUMN BARS.W4_ACC_INSTANT.BATCHID IS '';
COMMENT ON COLUMN BARS.W4_ACC_INSTANT.ACC IS 'ACC карт.рах. 2625';
COMMENT ON COLUMN BARS.W4_ACC_INSTANT.CARD_CODE IS 'Тип картки';




PROMPT *** Create  constraint PK_W4ACCINSTANT ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_ACC_INSTANT ADD CONSTRAINT PK_W4ACCINSTANT PRIMARY KEY (ACC)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_W4ACCINSTANT_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_ACC_INSTANT MODIFY (KF CONSTRAINT CC_W4ACCINSTANT_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_W4ACCINSTANT_ACC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_ACC_INSTANT MODIFY (ACC CONSTRAINT CC_W4ACCINSTANT_ACC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_W4ACCINSTANT_CARDCODE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_ACC_INSTANT MODIFY (CARD_CODE CONSTRAINT CC_W4ACCINSTANT_CARDCODE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_W4ACCINSTANT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_W4ACCINSTANT ON BARS.W4_ACC_INSTANT (ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  W4_ACC_INSTANT ***
grant SELECT                                                                 on W4_ACC_INSTANT  to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on W4_ACC_INSTANT  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on W4_ACC_INSTANT  to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on W4_ACC_INSTANT  to OW;
grant SELECT                                                                 on W4_ACC_INSTANT  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/W4_ACC_INSTANT.sql =========*** End **
PROMPT ===================================================================================== 
