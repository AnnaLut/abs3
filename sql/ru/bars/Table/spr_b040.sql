

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SPR_B040.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SPR_B040 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SPR_B040'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SPR_B040'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SPR_B040 ***
begin 
  execute immediate '
  CREATE TABLE BARS.SPR_B040 
   (	B040 VARCHAR2(20), 
	KNB VARCHAR2(27), 
	NKB NUMBER(*,0), 
	A012 CHAR(1), 
	KO NUMBER(*,0), 
	KU NUMBER(*,0), 
	TP CHAR(1), 
	B041 VARCHAR2(12), 
	D_OPEN DATE, 
	D_CLOSE DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SPR_B040 ***
 exec bpa.alter_policies('SPR_B040');


COMMENT ON TABLE BARS.SPR_B040 IS '������������� ��� (SPR_B040)';
COMMENT ON COLUMN BARS.SPR_B040.B040 IS '';
COMMENT ON COLUMN BARS.SPR_B040.KNB IS '';
COMMENT ON COLUMN BARS.SPR_B040.NKB IS '';
COMMENT ON COLUMN BARS.SPR_B040.A012 IS '';
COMMENT ON COLUMN BARS.SPR_B040.KO IS '';
COMMENT ON COLUMN BARS.SPR_B040.KU IS '';
COMMENT ON COLUMN BARS.SPR_B040.TP IS '';
COMMENT ON COLUMN BARS.SPR_B040.B041 IS '';
COMMENT ON COLUMN BARS.SPR_B040.D_OPEN IS '';
COMMENT ON COLUMN BARS.SPR_B040.D_CLOSE IS '';



PROMPT *** Create  grants  SPR_B040 ***
grant DELETE,INSERT,SELECT,UPDATE                                            on SPR_B040        to ABS_ADMIN;
grant DELETE,INSERT,SELECT,UPDATE                                            on SPR_B040        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SPR_B040        to RPBN002;
grant SELECT                                                                 on SPR_B040        to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SPR_B040        to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SPR_B040.sql =========*** End *** ====
PROMPT ===================================================================================== 
