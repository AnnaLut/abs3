

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/AN_KL_K.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to AN_KL_K ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''AN_KL_K'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''AN_KL_K'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''AN_KL_K'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table AN_KL_K ***
begin 
  execute immediate '
  CREATE TABLE BARS.AN_KL_K 
   (	YYYYMM CHAR(6), 
	K1_980 NUMBER(8,4), 
	K2_980 NUMBER(8,4), 
	K3_980 NUMBER(8,4), 
	K4_980 NUMBER(8,4), 
	K5_980 NUMBER(8,4), 
	K1_840 NUMBER(8,4), 
	K2_840 NUMBER(8,4), 
	K3_840 NUMBER(8,4), 
	K4_840 NUMBER(8,4), 
	K5_840 NUMBER(8,4), 
	K1_978 NUMBER(8,4), 
	K2_978 NUMBER(8,4), 
	K3_978 NUMBER(8,4), 
	K4_978 NUMBER(8,4), 
	K5_978 NUMBER(8,4), 
	K1_810 NUMBER(8,4), 
	K2_810 NUMBER(8,4), 
	K3_810 NUMBER(8,4), 
	K4_810 NUMBER(8,4), 
	K5_810 NUMBER(8,4), 
	D360 NUMBER(*,0), 
	D30 NUMBER(*,0), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to AN_KL_K ***
 exec bpa.alter_policies('AN_KL_K');


COMMENT ON TABLE BARS.AN_KL_K IS '';
COMMENT ON COLUMN BARS.AN_KL_K.YYYYMM IS '';
COMMENT ON COLUMN BARS.AN_KL_K.K1_980 IS '';
COMMENT ON COLUMN BARS.AN_KL_K.K2_980 IS '';
COMMENT ON COLUMN BARS.AN_KL_K.K3_980 IS '';
COMMENT ON COLUMN BARS.AN_KL_K.K4_980 IS '';
COMMENT ON COLUMN BARS.AN_KL_K.K5_980 IS '';
COMMENT ON COLUMN BARS.AN_KL_K.K1_840 IS '';
COMMENT ON COLUMN BARS.AN_KL_K.K2_840 IS '';
COMMENT ON COLUMN BARS.AN_KL_K.K3_840 IS '';
COMMENT ON COLUMN BARS.AN_KL_K.K4_840 IS '';
COMMENT ON COLUMN BARS.AN_KL_K.K5_840 IS '';
COMMENT ON COLUMN BARS.AN_KL_K.K1_978 IS '';
COMMENT ON COLUMN BARS.AN_KL_K.K2_978 IS '';
COMMENT ON COLUMN BARS.AN_KL_K.K3_978 IS '';
COMMENT ON COLUMN BARS.AN_KL_K.K4_978 IS '';
COMMENT ON COLUMN BARS.AN_KL_K.K5_978 IS '';
COMMENT ON COLUMN BARS.AN_KL_K.K1_810 IS '';
COMMENT ON COLUMN BARS.AN_KL_K.K2_810 IS '';
COMMENT ON COLUMN BARS.AN_KL_K.K3_810 IS '';
COMMENT ON COLUMN BARS.AN_KL_K.K4_810 IS '';
COMMENT ON COLUMN BARS.AN_KL_K.K5_810 IS '';
COMMENT ON COLUMN BARS.AN_KL_K.D360 IS '';
COMMENT ON COLUMN BARS.AN_KL_K.D30 IS '';
COMMENT ON COLUMN BARS.AN_KL_K.KF IS '';




PROMPT *** Create  constraint XPK_AN_KL_K ***
begin   
 execute immediate '
  ALTER TABLE BARS.AN_KL_K ADD CONSTRAINT XPK_AN_KL_K PRIMARY KEY (KF, YYYYMM)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ANKLK_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.AN_KL_K MODIFY (KF CONSTRAINT CC_ANKLK_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_AN_KL_K ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_AN_KL_K ON BARS.AN_KL_K (KF, YYYYMM) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  AN_KL_K ***
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on AN_KL_K         to AN_KL;
grant SELECT                                                                 on AN_KL_K         to BARSREADER_ROLE;
grant ALTER,DELETE,FLASHBACK,INSERT,SELECT,UPDATE                            on AN_KL_K         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on AN_KL_K         to BARS_DM;
grant SELECT                                                                 on AN_KL_K         to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on AN_KL_K         to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on AN_KL_K         to WR_REFREAD;



PROMPT *** Create SYNONYM  to AN_KL_K ***

  CREATE OR REPLACE PUBLIC SYNONYM AN_KL_K FOR BARS.AN_KL_K;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/AN_KL_K.sql =========*** End *** =====
PROMPT ===================================================================================== 
