

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KL_S130.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KL_S130 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KL_S130 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KL_S130 
   (	S130 VARCHAR2(2), 
	TXT VARCHAR2(160), 
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




PROMPT *** ALTER_POLICIES to KL_S130 ***
 exec bpa.alter_policies('KL_S130');


COMMENT ON TABLE BARS.KL_S130 IS '';
COMMENT ON COLUMN BARS.KL_S130.S130 IS '';
COMMENT ON COLUMN BARS.KL_S130.TXT IS '';
COMMENT ON COLUMN BARS.KL_S130.D_OPEN IS '';
COMMENT ON COLUMN BARS.KL_S130.D_CLOSE IS '';
COMMENT ON COLUMN BARS.KL_S130.D_MODE IS '';



PROMPT *** Create  grants  KL_S130 ***
grant SELECT                                                                 on KL_S130         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KL_S130         to BARS_DM;
grant SELECT                                                                 on KL_S130         to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KL_S130.sql =========*** End *** =====
PROMPT ===================================================================================== 
