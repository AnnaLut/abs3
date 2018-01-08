

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KL_S180.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KL_S180 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KL_S180'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KL_S180'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KL_S180'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KL_S180 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KL_S180 
   (	S180 CHAR(1), 
	S181 CHAR(1), 
	S183 CHAR(1), 
	S184 CHAR(1), 
	TXT VARCHAR2(48), 
	DATA_O DATE, 
	DATA_C DATE, 
	DATA_M DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE USERS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KL_S180 ***
 exec bpa.alter_policies('KL_S180');


COMMENT ON TABLE BARS.KL_S180 IS '';
COMMENT ON COLUMN BARS.KL_S180.S180 IS '';
COMMENT ON COLUMN BARS.KL_S180.S181 IS '';
COMMENT ON COLUMN BARS.KL_S180.S183 IS '';
COMMENT ON COLUMN BARS.KL_S180.S184 IS '';
COMMENT ON COLUMN BARS.KL_S180.TXT IS '';
COMMENT ON COLUMN BARS.KL_S180.DATA_O IS '';
COMMENT ON COLUMN BARS.KL_S180.DATA_C IS '';
COMMENT ON COLUMN BARS.KL_S180.DATA_M IS '';



PROMPT *** Create  grants  KL_S180 ***
grant SELECT                                                                 on KL_S180         to BARSREADER_ROLE;
grant SELECT                                                                 on KL_S180         to BARSUPL;
grant SELECT                                                                 on KL_S180         to BARS_DM;
grant SELECT                                                                 on KL_S180         to UPLD;



PROMPT *** Create SYNONYM  to KL_S180 ***

  CREATE OR REPLACE PUBLIC SYNONYM KL_S180 FOR BARS.KL_S180;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KL_S180.sql =========*** End *** =====
PROMPT ===================================================================================== 
