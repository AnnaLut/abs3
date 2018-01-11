

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KL_K060.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KL_K060 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KL_K060'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KL_K060'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KL_K060'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KL_K060 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KL_K060 
   (	K060 VARCHAR2(2), 
	K061 VARCHAR2(1), 
	TXT VARCHAR2(254), 
	D_OPEN DATE, 
	D_CLOSE DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KL_K060 ***
 exec bpa.alter_policies('KL_K060');


COMMENT ON TABLE BARS.KL_K060 IS '';
COMMENT ON COLUMN BARS.KL_K060.K060 IS '';
COMMENT ON COLUMN BARS.KL_K060.K061 IS '';
COMMENT ON COLUMN BARS.KL_K060.TXT IS '';
COMMENT ON COLUMN BARS.KL_K060.D_OPEN IS 'Дата відкриття коду';
COMMENT ON COLUMN BARS.KL_K060.D_CLOSE IS 'Дата закриття коду';



PROMPT *** Create  grants  KL_K060 ***
grant SELECT                                                                 on KL_K060         to BARSREADER_ROLE;
grant SELECT                                                                 on KL_K060         to BARS_DM;
grant SELECT                                                                 on KL_K060         to UPLD;



PROMPT *** Create SYNONYM  to KL_K060 ***

  CREATE OR REPLACE PUBLIC SYNONYM KL_K060 FOR BARS.KL_K060;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KL_K060.sql =========*** End *** =====
PROMPT ===================================================================================== 
