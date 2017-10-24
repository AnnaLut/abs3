

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KL_K150.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KL_K150 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KL_K150'', ''FILIAL'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KL_K150 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KL_K150 
   (	K150 CHAR(1), 
	TXT VARCHAR2(25), 
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




PROMPT *** ALTER_POLICIES to KL_K150 ***
 exec bpa.alter_policies('KL_K150');


COMMENT ON TABLE BARS.KL_K150 IS '';
COMMENT ON COLUMN BARS.KL_K150.K150 IS '';
COMMENT ON COLUMN BARS.KL_K150.TXT IS '';
COMMENT ON COLUMN BARS.KL_K150.DATA_O IS '';
COMMENT ON COLUMN BARS.KL_K150.DATA_C IS '';
COMMENT ON COLUMN BARS.KL_K150.DATA_M IS '';



PROMPT *** Create  grants  KL_K150 ***
grant SELECT                                                                 on KL_K150         to BARSUPL;
grant SELECT                                                                 on KL_K150         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KL_K150         to BARS_SUP;
grant DELETE,INSERT,SELECT,UPDATE                                            on KL_K150         to KL_K150;
grant SELECT                                                                 on KL_K150         to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on KL_K150         to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KL_K150.sql =========*** End *** =====
PROMPT ===================================================================================== 
