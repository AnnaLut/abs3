

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_PRIOCOM_CLIENTS.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_PRIOCOM_CLIENTS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TMP_PRIOCOM_CLIENTS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_PRIOCOM_CLIENTS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_PRIOCOM_CLIENTS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_PRIOCOM_CLIENTS ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.TMP_PRIOCOM_CLIENTS 
   (	INPUT_ID NUMBER(*,0), 
	MFO VARCHAR2(6), 
	KOD_FIL NUMBER(*,0), 
	IDENT VARCHAR2(14), 
	LNAME VARCHAR2(64), 
	FNAME VARCHAR2(64), 
	SNAME VARCHAR2(64), 
	BIRTHDAY DATE, 
	BIRTHPLACE VARCHAR2(64), 
	ISSTOCKHOLDER NUMBER(*,0), 
	ISVIP NUMBER(*,0), 
	ISRESIDENT NUMBER(*,0), 
	REGDATE DATE, 
	DEBTORCLASS NUMBER(*,0), 
	GENDER VARCHAR2(1), 
	ADDR VARCHAR2(70), 
	K040 VARCHAR2(3), 
	K060 VARCHAR2(2), 
	PASPDOUBLE VARCHAR2(8), 
	PASPSERIES VARCHAR2(6), 
	PASPDATE DATE, 
	PASPISSUER VARCHAR2(70), 
	RESULT NUMBER(*,0), 
	MESSAGE VARCHAR2(4000), 
	CODE NUMBER(*,0)
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_PRIOCOM_CLIENTS ***
 exec bpa.alter_policies('TMP_PRIOCOM_CLIENTS');


COMMENT ON TABLE BARS.TMP_PRIOCOM_CLIENTS IS '';
COMMENT ON COLUMN BARS.TMP_PRIOCOM_CLIENTS.INPUT_ID IS '';
COMMENT ON COLUMN BARS.TMP_PRIOCOM_CLIENTS.MFO IS '';
COMMENT ON COLUMN BARS.TMP_PRIOCOM_CLIENTS.KOD_FIL IS '';
COMMENT ON COLUMN BARS.TMP_PRIOCOM_CLIENTS.IDENT IS '';
COMMENT ON COLUMN BARS.TMP_PRIOCOM_CLIENTS.LNAME IS '';
COMMENT ON COLUMN BARS.TMP_PRIOCOM_CLIENTS.FNAME IS '';
COMMENT ON COLUMN BARS.TMP_PRIOCOM_CLIENTS.SNAME IS '';
COMMENT ON COLUMN BARS.TMP_PRIOCOM_CLIENTS.BIRTHDAY IS '';
COMMENT ON COLUMN BARS.TMP_PRIOCOM_CLIENTS.BIRTHPLACE IS '';
COMMENT ON COLUMN BARS.TMP_PRIOCOM_CLIENTS.ISSTOCKHOLDER IS '';
COMMENT ON COLUMN BARS.TMP_PRIOCOM_CLIENTS.ISVIP IS '';
COMMENT ON COLUMN BARS.TMP_PRIOCOM_CLIENTS.ISRESIDENT IS '';
COMMENT ON COLUMN BARS.TMP_PRIOCOM_CLIENTS.REGDATE IS '';
COMMENT ON COLUMN BARS.TMP_PRIOCOM_CLIENTS.DEBTORCLASS IS '';
COMMENT ON COLUMN BARS.TMP_PRIOCOM_CLIENTS.GENDER IS '';
COMMENT ON COLUMN BARS.TMP_PRIOCOM_CLIENTS.ADDR IS '';
COMMENT ON COLUMN BARS.TMP_PRIOCOM_CLIENTS.K040 IS '';
COMMENT ON COLUMN BARS.TMP_PRIOCOM_CLIENTS.K060 IS '';
COMMENT ON COLUMN BARS.TMP_PRIOCOM_CLIENTS.PASPDOUBLE IS '';
COMMENT ON COLUMN BARS.TMP_PRIOCOM_CLIENTS.PASPSERIES IS '';
COMMENT ON COLUMN BARS.TMP_PRIOCOM_CLIENTS.PASPDATE IS '';
COMMENT ON COLUMN BARS.TMP_PRIOCOM_CLIENTS.PASPISSUER IS '';
COMMENT ON COLUMN BARS.TMP_PRIOCOM_CLIENTS.RESULT IS '';
COMMENT ON COLUMN BARS.TMP_PRIOCOM_CLIENTS.MESSAGE IS '';
COMMENT ON COLUMN BARS.TMP_PRIOCOM_CLIENTS.CODE IS '';



PROMPT *** Create  grants  TMP_PRIOCOM_CLIENTS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_PRIOCOM_CLIENTS to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_PRIOCOM_CLIENTS to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_PRIOCOM_CLIENTS.sql =========*** E
PROMPT ===================================================================================== 
