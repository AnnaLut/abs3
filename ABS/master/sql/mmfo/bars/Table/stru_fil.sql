

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/STRU_FIL.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to STRU_FIL ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''STRU_FIL'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''STRU_FIL'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''STRU_FIL'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table STRU_FIL ***
begin 
  execute immediate '
  CREATE TABLE BARS.STRU_FIL 
   (	A010 CHAR(2), 
	NAME CHAR(8), 
	POLE CHAR(8), 
	T_LEN CHAR(8), 
	TXT VARCHAR2(100)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to STRU_FIL ***
 exec bpa.alter_policies('STRU_FIL');


COMMENT ON TABLE BARS.STRU_FIL IS '';
COMMENT ON COLUMN BARS.STRU_FIL.A010 IS '';
COMMENT ON COLUMN BARS.STRU_FIL.NAME IS '';
COMMENT ON COLUMN BARS.STRU_FIL.POLE IS '';
COMMENT ON COLUMN BARS.STRU_FIL.T_LEN IS '';
COMMENT ON COLUMN BARS.STRU_FIL.TXT IS '';



PROMPT *** Create  grants  STRU_FIL ***
grant DELETE,INSERT,SELECT,UPDATE                                            on STRU_FIL        to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on STRU_FIL        to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/STRU_FIL.sql =========*** End *** ====
PROMPT ===================================================================================== 
