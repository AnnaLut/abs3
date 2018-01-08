

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_RNK.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_RNK ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_RNK ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.TMP_RNK 
   (	RNK NUMBER(*,0), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_RNK ***
 exec bpa.alter_policies('TMP_RNK');


COMMENT ON TABLE BARS.TMP_RNK IS '';
COMMENT ON COLUMN BARS.TMP_RNK.RNK IS '';
COMMENT ON COLUMN BARS.TMP_RNK.KF IS '';




PROMPT *** Create  constraint CC_TMPRNK_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_RNK MODIFY (KF CONSTRAINT CC_TMPRNK_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_RNK ***
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on TMP_RNK         to AN_KL;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on TMP_RNK         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_RNK         to BARS_DM;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TMP_RNK         to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to TMP_RNK ***

  CREATE OR REPLACE PUBLIC SYNONYM TMP_RNK FOR BARS.TMP_RNK;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_RNK.sql =========*** End *** =====
PROMPT ===================================================================================== 
