

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/S_UCH.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to S_UCH ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''S_UCH'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''S_UCH'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''S_UCH'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table S_UCH ***
begin 
  execute immediate '
  CREATE TABLE BARS.S_UCH 
   (	MFO NUMBER(*,0), 
	NCKS CHAR(4), 
	NCKSO CHAR(4), 
	NB VARCHAR2(38), 
	KORSH NUMBER(14,0), 
	N_MO CHAR(1), 
	U_MO CHAR(1), 
	MFO_G NUMBER(*,0), 
	M_UR NUMBER(*,0), 
	F_BL CHAR(1), 
	F_VA CHAR(1), 
	F_SL CHAR(1), 
	S_SS CHAR(10)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to S_UCH ***
 exec bpa.alter_policies('S_UCH');


COMMENT ON TABLE BARS.S_UCH IS '';
COMMENT ON COLUMN BARS.S_UCH.MFO IS '';
COMMENT ON COLUMN BARS.S_UCH.NCKS IS '';
COMMENT ON COLUMN BARS.S_UCH.NCKSO IS '';
COMMENT ON COLUMN BARS.S_UCH.NB IS '';
COMMENT ON COLUMN BARS.S_UCH.KORSH IS '';
COMMENT ON COLUMN BARS.S_UCH.N_MO IS '';
COMMENT ON COLUMN BARS.S_UCH.U_MO IS '';
COMMENT ON COLUMN BARS.S_UCH.MFO_G IS '';
COMMENT ON COLUMN BARS.S_UCH.M_UR IS '';
COMMENT ON COLUMN BARS.S_UCH.F_BL IS '';
COMMENT ON COLUMN BARS.S_UCH.F_VA IS '';
COMMENT ON COLUMN BARS.S_UCH.F_SL IS '';
COMMENT ON COLUMN BARS.S_UCH.S_SS IS '';



PROMPT *** Create  grants  S_UCH ***
grant DELETE,INSERT,SELECT,UPDATE                                            on S_UCH           to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on S_UCH           to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/S_UCH.sql =========*** End *** =======
PROMPT ===================================================================================== 
