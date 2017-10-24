

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SPRAV.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SPRAV ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SPRAV'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SPRAV'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SPRAV'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SPRAV ***
begin 
  execute immediate '
  CREATE TABLE BARS.SPRAV 
   (	FIO VARCHAR2(40), 
	TAB_N NUMBER(*,0), 
	N_KONV NUMBER(*,0), 
	VID_VYPL NUMBER(*,0), 
	VYPL NUMBER(*,0), 
	SBON VARCHAR2(19), 
	TEX_N CHAR(10), 
	NLS NUMBER(14,0)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SPRAV ***
 exec bpa.alter_policies('SPRAV');


COMMENT ON TABLE BARS.SPRAV IS '';
COMMENT ON COLUMN BARS.SPRAV.FIO IS '';
COMMENT ON COLUMN BARS.SPRAV.TAB_N IS '';
COMMENT ON COLUMN BARS.SPRAV.N_KONV IS '';
COMMENT ON COLUMN BARS.SPRAV.VID_VYPL IS '';
COMMENT ON COLUMN BARS.SPRAV.VYPL IS '';
COMMENT ON COLUMN BARS.SPRAV.SBON IS '';
COMMENT ON COLUMN BARS.SPRAV.TEX_N IS '';
COMMENT ON COLUMN BARS.SPRAV.NLS IS '';



PROMPT *** Create  grants  SPRAV ***
grant DELETE,INSERT,SELECT,UPDATE                                            on SPRAV           to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on SPRAV           to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SPRAV.sql =========*** End *** =======
PROMPT ===================================================================================== 
