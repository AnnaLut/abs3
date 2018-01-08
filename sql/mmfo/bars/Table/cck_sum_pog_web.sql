

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CCK_SUM_POG_WEB.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CCK_SUM_POG_WEB ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CCK_SUM_POG_WEB'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''CCK_SUM_POG_WEB'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CCK_SUM_POG_WEB ***
begin 
  execute immediate '
  CREATE TABLE BARS.CCK_SUM_POG_WEB 
   (	ACC NUMBER(*,0), 
	ND NUMBER(*,0), 
	KV NUMBER(*,0), 
	RNK NUMBER(*,0), 
	NMK VARCHAR2(58), 
	CC_ID VARCHAR2(20), 
	G1 NUMBER, 
	G2 NUMBER, 
	G3 NUMBER(24,0), 
	G4 NUMBER, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	REC_ID VARCHAR2(32)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CCK_SUM_POG_WEB ***
 exec bpa.alter_policies('CCK_SUM_POG_WEB');


COMMENT ON TABLE BARS.CCK_SUM_POG_WEB IS '';
COMMENT ON COLUMN BARS.CCK_SUM_POG_WEB.ACC IS '';
COMMENT ON COLUMN BARS.CCK_SUM_POG_WEB.ND IS '';
COMMENT ON COLUMN BARS.CCK_SUM_POG_WEB.KV IS '';
COMMENT ON COLUMN BARS.CCK_SUM_POG_WEB.RNK IS '';
COMMENT ON COLUMN BARS.CCK_SUM_POG_WEB.NMK IS '';
COMMENT ON COLUMN BARS.CCK_SUM_POG_WEB.CC_ID IS '';
COMMENT ON COLUMN BARS.CCK_SUM_POG_WEB.G1 IS '';
COMMENT ON COLUMN BARS.CCK_SUM_POG_WEB.G2 IS '';
COMMENT ON COLUMN BARS.CCK_SUM_POG_WEB.G3 IS '';
COMMENT ON COLUMN BARS.CCK_SUM_POG_WEB.G4 IS '';
COMMENT ON COLUMN BARS.CCK_SUM_POG_WEB.KF IS '';
COMMENT ON COLUMN BARS.CCK_SUM_POG_WEB.REC_ID IS '';



PROMPT *** Create  grants  CCK_SUM_POG_WEB ***
grant DELETE,INSERT,SELECT                                                   on CCK_SUM_POG_WEB to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CCK_SUM_POG_WEB.sql =========*** End *
PROMPT ===================================================================================== 
