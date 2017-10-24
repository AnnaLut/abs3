

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KL_S080.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KL_S080 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KL_S080'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KL_S080'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KL_S080'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KL_S080 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KL_S080 
   (	S080 VARCHAR2(1), 
	S081 VARCHAR2(1), 
	S082 VARCHAR2(1), 
	TXT VARCHAR2(48), 
	REZ VARCHAR2(3), 
	DATA_O DATE, 
	DATA_C DATE, 
	DATA_M DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KL_S080 ***
 exec bpa.alter_policies('KL_S080');


COMMENT ON TABLE BARS.KL_S080 IS '';
COMMENT ON COLUMN BARS.KL_S080.S080 IS '';
COMMENT ON COLUMN BARS.KL_S080.S081 IS '';
COMMENT ON COLUMN BARS.KL_S080.S082 IS '';
COMMENT ON COLUMN BARS.KL_S080.TXT IS '';
COMMENT ON COLUMN BARS.KL_S080.REZ IS '';
COMMENT ON COLUMN BARS.KL_S080.DATA_O IS '';
COMMENT ON COLUMN BARS.KL_S080.DATA_C IS '';
COMMENT ON COLUMN BARS.KL_S080.DATA_M IS '';



PROMPT *** Create  grants  KL_S080 ***
grant SELECT                                                                 on KL_S080         to BARSUPL;
grant SELECT                                                                 on KL_S080         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KL_S080         to BARS_DM;
grant SELECT                                                                 on KL_S080         to UPLD;



PROMPT *** Create SYNONYM  to KL_S080 ***

  CREATE OR REPLACE PUBLIC SYNONYM KL_S080 FOR BARS.KL_S080;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KL_S080.sql =========*** End *** =====
PROMPT ===================================================================================== 
