

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SPR_OBL_.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SPR_OBL_ ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SPR_OBL_'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SPR_OBL_'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''SPR_OBL_'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SPR_OBL_ ***
begin 
  execute immediate '
  CREATE TABLE BARS.SPR_OBL_ 
   (	C_REG NUMBER(*,0), 
	NAME_REG VARCHAR2(20), 
	KOD_REG CHAR(1)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SPR_OBL_ ***
 exec bpa.alter_policies('SPR_OBL_');


COMMENT ON TABLE BARS.SPR_OBL_ IS '';
COMMENT ON COLUMN BARS.SPR_OBL_.C_REG IS '';
COMMENT ON COLUMN BARS.SPR_OBL_.NAME_REG IS '';
COMMENT ON COLUMN BARS.SPR_OBL_.KOD_REG IS '';



PROMPT *** Create  grants  SPR_OBL_ ***
grant SELECT                                                                 on SPR_OBL_        to BARS_DM;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SPR_OBL_        to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to SPR_OBL_ ***

  CREATE OR REPLACE PUBLIC SYNONYM SPR_OBL_ FOR BARS.SPR_OBL_;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SPR_OBL_.sql =========*** End *** ====
PROMPT ===================================================================================== 
