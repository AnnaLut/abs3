

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KL_S580.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KL_S580 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KL_S580 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KL_S580 
   (	S580 VARCHAR2(1), 
	TXT VARCHAR2(64), 
	PROC NUMBER(3,0), 
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




PROMPT *** ALTER_POLICIES to KL_S580 ***
 exec bpa.alter_policies('KL_S580');


COMMENT ON TABLE BARS.KL_S580 IS '';
COMMENT ON COLUMN BARS.KL_S580.S580 IS '';
COMMENT ON COLUMN BARS.KL_S580.TXT IS '';
COMMENT ON COLUMN BARS.KL_S580.PROC IS '';
COMMENT ON COLUMN BARS.KL_S580.DATA_O IS '';
COMMENT ON COLUMN BARS.KL_S580.DATA_C IS '';
COMMENT ON COLUMN BARS.KL_S580.DATA_M IS '';



PROMPT *** Create  grants  KL_S580 ***
grant SELECT                                                                 on KL_S580         to BARSREADER_ROLE;
grant SELECT                                                                 on KL_S580         to BARSUPL;
grant DELETE,INSERT,SELECT,UPDATE                                            on KL_S580         to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on KL_S580         to RPBN002;
grant SELECT                                                                 on KL_S580         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KL_S580.sql =========*** End *** =====
PROMPT ===================================================================================== 
