

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CIN_KOM.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CIN_KOM ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CIN_KOM'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CIN_KOM'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CIN_KOM'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CIN_KOM ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.CIN_KOM 
   (	RNK NUMBER(*,0), 
	NMK VARCHAR2(35), 
	NLS_2909 VARCHAR2(14), 
	ID NUMBER(*,0), 
	NAME VARCHAR2(35), 
	MFO VARCHAR2(12), 
	NLS VARCHAR2(14), 
	REF NUMBER(*,0), 
	S NUMBER(19,2), 
	KA2 NUMBER(19,2), 
	KA1 NUMBER(19,2), 
	KB2 NUMBER(19,2), 
	KB1 NUMBER(19,2), 
	DAT1 DATE, 
	DAT2 DATE, 
	VDAT DATE, 
	KC0 NUMBER(19,2), 
	A2 NUMBER(19,2), 
	B1 NUMBER(19,2), 
	B2 NUMBER(19,2), 
	C0 NUMBER(19,2)
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CIN_KOM ***
 exec bpa.alter_policies('CIN_KOM');


COMMENT ON TABLE BARS.CIN_KOM IS '';
COMMENT ON COLUMN BARS.CIN_KOM.RNK IS '';
COMMENT ON COLUMN BARS.CIN_KOM.NMK IS '';
COMMENT ON COLUMN BARS.CIN_KOM.NLS_2909 IS '';
COMMENT ON COLUMN BARS.CIN_KOM.ID IS '';
COMMENT ON COLUMN BARS.CIN_KOM.NAME IS '';
COMMENT ON COLUMN BARS.CIN_KOM.MFO IS '';
COMMENT ON COLUMN BARS.CIN_KOM.NLS IS '';
COMMENT ON COLUMN BARS.CIN_KOM.REF IS '';
COMMENT ON COLUMN BARS.CIN_KOM.S IS '';
COMMENT ON COLUMN BARS.CIN_KOM.KA2 IS '';
COMMENT ON COLUMN BARS.CIN_KOM.KA1 IS '';
COMMENT ON COLUMN BARS.CIN_KOM.KB2 IS '';
COMMENT ON COLUMN BARS.CIN_KOM.KB1 IS '';
COMMENT ON COLUMN BARS.CIN_KOM.DAT1 IS '';
COMMENT ON COLUMN BARS.CIN_KOM.DAT2 IS '';
COMMENT ON COLUMN BARS.CIN_KOM.VDAT IS '';
COMMENT ON COLUMN BARS.CIN_KOM.KC0 IS '';
COMMENT ON COLUMN BARS.CIN_KOM.A2 IS '';
COMMENT ON COLUMN BARS.CIN_KOM.B1 IS '';
COMMENT ON COLUMN BARS.CIN_KOM.B2 IS '';
COMMENT ON COLUMN BARS.CIN_KOM.C0 IS '';



PROMPT *** Create  grants  CIN_KOM ***
grant DELETE,INSERT,SELECT,UPDATE                                            on CIN_KOM         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CIN_KOM         to BARS_DM;
grant SELECT                                                                 on CIN_KOM         to PYOD001;
grant DELETE,INSERT,SELECT,UPDATE                                            on CIN_KOM         to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CIN_KOM.sql =========*** End *** =====
PROMPT ===================================================================================== 
