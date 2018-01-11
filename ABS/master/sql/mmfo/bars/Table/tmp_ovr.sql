

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_OVR.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_OVR ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TMP_OVR'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_OVR'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_OVR'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_OVR ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_OVR 
   (	DAT DATE, 
	ID NUMBER(*,0), 
	DK NUMBER(*,0), 
	NLSA VARCHAR2(15), 
	NLSB VARCHAR2(15), 
	S NUMBER(38,0), 
	TXT VARCHAR2(35), 
	BRANCH VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_OVR ***
 exec bpa.alter_policies('TMP_OVR');


COMMENT ON TABLE BARS.TMP_OVR IS '';
COMMENT ON COLUMN BARS.TMP_OVR.DAT IS '';
COMMENT ON COLUMN BARS.TMP_OVR.ID IS '';
COMMENT ON COLUMN BARS.TMP_OVR.DK IS '';
COMMENT ON COLUMN BARS.TMP_OVR.NLSA IS '';
COMMENT ON COLUMN BARS.TMP_OVR.NLSB IS '';
COMMENT ON COLUMN BARS.TMP_OVR.S IS '';
COMMENT ON COLUMN BARS.TMP_OVR.TXT IS '';
COMMENT ON COLUMN BARS.TMP_OVR.BRANCH IS '';




PROMPT *** Create  constraint CC_TMPOVR_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_OVR MODIFY (BRANCH CONSTRAINT CC_TMPOVR_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_OVR ***
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_OVR         to BARS009;
grant SELECT                                                                 on TMP_OVR         to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT                                                   on TMP_OVR         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_OVR         to BARS_DM;
grant DELETE,INSERT,SELECT                                                   on TMP_OVR         to ELT;
grant SELECT                                                                 on TMP_OVR         to RCC_DEAL;
grant SELECT                                                                 on TMP_OVR         to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TMP_OVR         to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to TMP_OVR ***

  CREATE OR REPLACE PUBLIC SYNONYM TMP_OVR FOR BARS.TMP_OVR;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_OVR.sql =========*** End *** =====
PROMPT ===================================================================================== 
