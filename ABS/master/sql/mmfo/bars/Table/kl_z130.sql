

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KL_Z130.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KL_Z130 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KL_Z130'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KL_Z130'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KL_Z130'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KL_Z130 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KL_Z130 
   (	Z130 VARCHAR2(2), 
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




PROMPT *** ALTER_POLICIES to KL_Z130 ***
 exec bpa.alter_policies('KL_Z130');


COMMENT ON TABLE BARS.KL_Z130 IS '';
COMMENT ON COLUMN BARS.KL_Z130.Z130 IS '';
COMMENT ON COLUMN BARS.KL_Z130.TXT IS '';
COMMENT ON COLUMN BARS.KL_Z130.D_OPEN IS '';
COMMENT ON COLUMN BARS.KL_Z130.D_CLOSE IS '';
COMMENT ON COLUMN BARS.KL_Z130.D_MODE IS '';



PROMPT *** Create  grants  KL_Z130 ***
grant SELECT                                                                 on KL_Z130         to BARSREADER_ROLE;
grant SELECT                                                                 on KL_Z130         to BARS_DM;
grant SELECT                                                                 on KL_Z130         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KL_Z130.sql =========*** End *** =====
PROMPT ===================================================================================== 
