

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KL_D050.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KL_D050 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KL_D050'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KL_D050'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KL_D050'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KL_D050 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KL_D050 
   (	D050 VARCHAR2(5), 
	D051 VARCHAR2(2), 
	D052 VARCHAR2(1), 
	TXT VARCHAR2(135), 
	TXT64 VARCHAR2(64), 
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




PROMPT *** ALTER_POLICIES to KL_D050 ***
 exec bpa.alter_policies('KL_D050');


COMMENT ON TABLE BARS.KL_D050 IS '';
COMMENT ON COLUMN BARS.KL_D050.D050 IS '';
COMMENT ON COLUMN BARS.KL_D050.D051 IS '';
COMMENT ON COLUMN BARS.KL_D050.D052 IS '';
COMMENT ON COLUMN BARS.KL_D050.TXT IS '';
COMMENT ON COLUMN BARS.KL_D050.TXT64 IS '';
COMMENT ON COLUMN BARS.KL_D050.D_OPEN IS '';
COMMENT ON COLUMN BARS.KL_D050.D_CLOSE IS '';
COMMENT ON COLUMN BARS.KL_D050.D_MODE IS '';



PROMPT *** Create  grants  KL_D050 ***
grant SELECT                                                                 on KL_D050         to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KL_D050.sql =========*** End *** =====
PROMPT ===================================================================================== 
