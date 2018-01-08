

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_PFNOTPAY.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_PFNOTPAY ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_PFNOTPAY ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.TMP_PFNOTPAY 
   (	ND NUMBER, 
	BRANCH VARCHAR2(30), 
	RNK NUMBER, 
	ACC NUMBER, 
	DATE_BAN DATE, 
	DATE_END DATE
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_PFNOTPAY ***
 exec bpa.alter_policies('TMP_PFNOTPAY');


COMMENT ON TABLE BARS.TMP_PFNOTPAY IS '';
COMMENT ON COLUMN BARS.TMP_PFNOTPAY.ND IS '';
COMMENT ON COLUMN BARS.TMP_PFNOTPAY.BRANCH IS '';
COMMENT ON COLUMN BARS.TMP_PFNOTPAY.RNK IS '';
COMMENT ON COLUMN BARS.TMP_PFNOTPAY.ACC IS '';
COMMENT ON COLUMN BARS.TMP_PFNOTPAY.DATE_BAN IS '';
COMMENT ON COLUMN BARS.TMP_PFNOTPAY.DATE_END IS '';



PROMPT *** Create  grants  TMP_PFNOTPAY ***
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_PFNOTPAY    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_PFNOTPAY    to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_PFNOTPAY    to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_PFNOTPAY.sql =========*** End *** 
PROMPT ===================================================================================== 
