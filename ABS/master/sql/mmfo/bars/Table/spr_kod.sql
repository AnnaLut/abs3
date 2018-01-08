

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SPR_KOD.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SPR_KOD ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SPR_KOD'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SPR_KOD'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SPR_KOD'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SPR_KOD ***
begin 
  execute immediate '
  CREATE TABLE BARS.SPR_KOD 
   (	NAME CHAR(8), 
	TXT VARCHAR2(48), 
	POLE_IND VARCHAR2(90), 
	NAME_IND VARCHAR2(12), 
	DLSTRN NUMBER(*,0), 
	POLE_IND2 VARCHAR2(30), 
	FILTR_2 VARCHAR2(25)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SPR_KOD ***
 exec bpa.alter_policies('SPR_KOD');


COMMENT ON TABLE BARS.SPR_KOD IS '';
COMMENT ON COLUMN BARS.SPR_KOD.NAME IS '';
COMMENT ON COLUMN BARS.SPR_KOD.TXT IS '';
COMMENT ON COLUMN BARS.SPR_KOD.POLE_IND IS '';
COMMENT ON COLUMN BARS.SPR_KOD.NAME_IND IS '';
COMMENT ON COLUMN BARS.SPR_KOD.DLSTRN IS '';
COMMENT ON COLUMN BARS.SPR_KOD.POLE_IND2 IS '';
COMMENT ON COLUMN BARS.SPR_KOD.FILTR_2 IS '';



PROMPT *** Create  grants  SPR_KOD ***
grant SELECT                                                                 on SPR_KOD         to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on SPR_KOD         to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on SPR_KOD         to START1;
grant SELECT                                                                 on SPR_KOD         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SPR_KOD.sql =========*** End *** =====
PROMPT ===================================================================================== 
