

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KL_Z280.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KL_Z280 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KL_Z280'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KL_Z280'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KL_Z280'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KL_Z280 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KL_Z280 
   (	Z280 CHAR(2), 
	TXT VARCHAR2(144), 
	D_OPEN DATE, 
	D_CLOSE DATE, 
	D_MODE DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KL_Z280 ***
 exec bpa.alter_policies('KL_Z280');


COMMENT ON TABLE BARS.KL_Z280 IS '';
COMMENT ON COLUMN BARS.KL_Z280.Z280 IS '';
COMMENT ON COLUMN BARS.KL_Z280.TXT IS '';
COMMENT ON COLUMN BARS.KL_Z280.D_OPEN IS '';
COMMENT ON COLUMN BARS.KL_Z280.D_CLOSE IS '';
COMMENT ON COLUMN BARS.KL_Z280.D_MODE IS '';



PROMPT *** Create  grants  KL_Z280 ***
grant SELECT                                                                 on KL_Z280         to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on KL_Z280         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KL_Z280         to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on KL_Z280         to START1;
grant SELECT                                                                 on KL_Z280         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KL_Z280.sql =========*** End *** =====
PROMPT ===================================================================================== 
