

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KL_D110.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KL_D110 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KL_D110 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KL_D110 
   (	D110 VARCHAR2(1), 
	TXT VARCHAR2(50)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KL_D110 ***
 exec bpa.alter_policies('KL_D110');


COMMENT ON TABLE BARS.KL_D110 IS '';
COMMENT ON COLUMN BARS.KL_D110.D110 IS '';
COMMENT ON COLUMN BARS.KL_D110.TXT IS '';



PROMPT *** Create  grants  KL_D110 ***
grant SELECT                                                                 on KL_D110         to BARSREADER_ROLE;
grant SELECT                                                                 on KL_D110         to BARS_DM;
grant SELECT                                                                 on KL_D110         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KL_D110.sql =========*** End *** =====
PROMPT ===================================================================================== 
