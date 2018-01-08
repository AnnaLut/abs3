

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CCK_SUM_POG.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CCK_SUM_POG ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CCK_SUM_POG ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.CCK_SUM_POG 
   (	ACC NUMBER(*,0), 
	ND NUMBER(*,0), 
	KV NUMBER(*,0), 
	RNK NUMBER(*,0), 
	NMK VARCHAR2(58), 
	CC_ID VARCHAR2(20), 
	G1 NUMBER, 
	G2 NUMBER, 
	G3 NUMBER(24,0), 
	G4 NUMBER
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CCK_SUM_POG ***
 exec bpa.alter_policies('CCK_SUM_POG');


COMMENT ON TABLE BARS.CCK_SUM_POG IS '';
COMMENT ON COLUMN BARS.CCK_SUM_POG.ACC IS '';
COMMENT ON COLUMN BARS.CCK_SUM_POG.ND IS '';
COMMENT ON COLUMN BARS.CCK_SUM_POG.KV IS '';
COMMENT ON COLUMN BARS.CCK_SUM_POG.RNK IS '';
COMMENT ON COLUMN BARS.CCK_SUM_POG.NMK IS '';
COMMENT ON COLUMN BARS.CCK_SUM_POG.CC_ID IS '';
COMMENT ON COLUMN BARS.CCK_SUM_POG.G1 IS '';
COMMENT ON COLUMN BARS.CCK_SUM_POG.G2 IS '';
COMMENT ON COLUMN BARS.CCK_SUM_POG.G3 IS '';
COMMENT ON COLUMN BARS.CCK_SUM_POG.G4 IS '';




PROMPT *** Create  constraint NK_CCK_SUM_POG_ACC ***
begin   
 execute immediate '
  ALTER TABLE BARS.CCK_SUM_POG MODIFY (ACC CONSTRAINT NK_CCK_SUM_POG_ACC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_CCK_SUM_POG_RNK ***
begin   
 execute immediate '
  ALTER TABLE BARS.CCK_SUM_POG MODIFY (RNK CONSTRAINT NK_CCK_SUM_POG_RNK NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_CCK_SUM_POG_KV ***
begin   
 execute immediate '
  ALTER TABLE BARS.CCK_SUM_POG MODIFY (KV CONSTRAINT NK_CCK_SUM_POG_KV NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_CCK_SUM_POG_ND ***
begin   
 execute immediate '
  ALTER TABLE BARS.CCK_SUM_POG MODIFY (ND CONSTRAINT NK_CCK_SUM_POG_ND NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CCK_SUM_POG ***
grant INSERT,SELECT                                                          on CCK_SUM_POG     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CCK_SUM_POG     to BARS_DM;
grant SELECT                                                                 on CCK_SUM_POG     to ELT;
grant INSERT,SELECT                                                          on CCK_SUM_POG     to RCC_DEAL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CCK_SUM_POG     to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CCK_SUM_POG.sql =========*** End *** =
PROMPT ===================================================================================== 
