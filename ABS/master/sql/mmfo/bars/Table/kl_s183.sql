

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KL_S183.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KL_S183 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KL_S183'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KL_S183'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KL_S183'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KL_S183 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KL_S183 
   (	S183 VARCHAR2(1), 
	S181 VARCHAR2(1), 
	TXT VARCHAR2(48), 
	DATA_O DATE, 
	DATA_C DATE, 
	DATA_M DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KL_S183 ***
 exec bpa.alter_policies('KL_S183');


COMMENT ON TABLE BARS.KL_S183 IS 'Классификатор НБУ (KL_S183)';
COMMENT ON COLUMN BARS.KL_S183.S183 IS '';
COMMENT ON COLUMN BARS.KL_S183.S181 IS '';
COMMENT ON COLUMN BARS.KL_S183.TXT IS '';
COMMENT ON COLUMN BARS.KL_S183.DATA_O IS '';
COMMENT ON COLUMN BARS.KL_S183.DATA_C IS '';
COMMENT ON COLUMN BARS.KL_S183.DATA_M IS '';



PROMPT *** Create  grants  KL_S183 ***
grant DELETE,INSERT,SELECT,UPDATE                                            on KL_S183         to ABS_ADMIN;
grant SELECT                                                                 on KL_S183         to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on KL_S183         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KL_S183         to BARS_DM;
grant SELECT                                                                 on KL_S183         to START1;
grant SELECT                                                                 on KL_S183         to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on KL_S183         to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KL_S183.sql =========*** End *** =====
PROMPT ===================================================================================== 
