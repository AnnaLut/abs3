

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/RNK2TBL.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to RNK2TBL ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''RNK2TBL'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''RNK2TBL'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''RNK2TBL'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table RNK2TBL ***
begin 
  execute immediate '
  CREATE TABLE BARS.RNK2TBL 
   (	RNKFROM NUMBER, 
	RNKTO NUMBER, 
	SDATE DATE, 
	TBL VARCHAR2(64), 
	CNT NUMBER(*,0), 
	ID NUMBER(*,0), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to RNK2TBL ***
 exec bpa.alter_policies('RNK2TBL');


COMMENT ON TABLE BARS.RNK2TBL IS '';
COMMENT ON COLUMN BARS.RNK2TBL.KF IS '';
COMMENT ON COLUMN BARS.RNK2TBL.RNKFROM IS '';
COMMENT ON COLUMN BARS.RNK2TBL.RNKTO IS '';
COMMENT ON COLUMN BARS.RNK2TBL.SDATE IS '';
COMMENT ON COLUMN BARS.RNK2TBL.TBL IS '';
COMMENT ON COLUMN BARS.RNK2TBL.CNT IS '';
COMMENT ON COLUMN BARS.RNK2TBL.ID IS '';




PROMPT *** Create  index IK_R2 ***
begin   
 execute immediate '
  CREATE INDEX BARS.IK_R2 ON BARS.RNK2TBL (RNKTO) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index IK_RFROM2 ***
begin   
 execute immediate '
  CREATE INDEX BARS.IK_RFROM2 ON BARS.RNK2TBL (RNKFROM) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  RNK2TBL ***
grant DELETE,INSERT,SELECT,UPDATE                                            on RNK2TBL         to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on RNK2TBL         to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/RNK2TBL.sql =========*** End *** =====
PROMPT ===================================================================================== 
