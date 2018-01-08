

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_ACCOUNTS_COUNT.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_ACCOUNTS_COUNT ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_ACCOUNTS_COUNT ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.TMP_ACCOUNTS_COUNT 
   (	ID NUMBER, 
	C NUMBER, 
	D NUMBER, 
	E NUMBER, 
	F NUMBER, 
	G NUMBER, 
	H NUMBER, 
	I NUMBER, 
	J NUMBER, 
	K NUMBER
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_ACCOUNTS_COUNT ***
 exec bpa.alter_policies('TMP_ACCOUNTS_COUNT');


COMMENT ON TABLE BARS.TMP_ACCOUNTS_COUNT IS '';
COMMENT ON COLUMN BARS.TMP_ACCOUNTS_COUNT.ID IS '';
COMMENT ON COLUMN BARS.TMP_ACCOUNTS_COUNT.C IS '';
COMMENT ON COLUMN BARS.TMP_ACCOUNTS_COUNT.D IS '';
COMMENT ON COLUMN BARS.TMP_ACCOUNTS_COUNT.E IS '';
COMMENT ON COLUMN BARS.TMP_ACCOUNTS_COUNT.F IS '';
COMMENT ON COLUMN BARS.TMP_ACCOUNTS_COUNT.G IS '';
COMMENT ON COLUMN BARS.TMP_ACCOUNTS_COUNT.H IS '';
COMMENT ON COLUMN BARS.TMP_ACCOUNTS_COUNT.I IS '';
COMMENT ON COLUMN BARS.TMP_ACCOUNTS_COUNT.J IS '';
COMMENT ON COLUMN BARS.TMP_ACCOUNTS_COUNT.K IS '';



PROMPT *** Create  grants  TMP_ACCOUNTS_COUNT ***
grant SELECT                                                                 on TMP_ACCOUNTS_COUNT to BARSREADER_ROLE;
grant SELECT                                                                 on TMP_ACCOUNTS_COUNT to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_ACCOUNTS_COUNT to BARS_DM;
grant SELECT                                                                 on TMP_ACCOUNTS_COUNT to START1;
grant SELECT                                                                 on TMP_ACCOUNTS_COUNT to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TMP_ACCOUNTS_COUNT to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_ACCOUNTS_COUNT.sql =========*** En
PROMPT ===================================================================================== 
