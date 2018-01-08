

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SB_R016.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SB_R016 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SB_R016'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SB_R016'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SB_R016'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SB_R016 ***
begin 
  execute immediate '
  CREATE TABLE BARS.SB_R016 
   (	R020 CHAR(4), 
	OB22 CHAR(2), 
	D_OPEN DATE, 
	D_CLOSE DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SB_R016 ***
 exec bpa.alter_policies('SB_R016');


COMMENT ON TABLE BARS.SB_R016 IS 'Классификатор ОБ (SB_R016)';
COMMENT ON COLUMN BARS.SB_R016.R020 IS '';
COMMENT ON COLUMN BARS.SB_R016.OB22 IS '';
COMMENT ON COLUMN BARS.SB_R016.D_OPEN IS '';
COMMENT ON COLUMN BARS.SB_R016.D_CLOSE IS '';



PROMPT *** Create  grants  SB_R016 ***
grant DELETE,INSERT,SELECT,UPDATE                                            on SB_R016         to ABS_ADMIN;
grant DELETE,INSERT,SELECT,UPDATE                                            on SB_R016         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SB_R016         to BARS_DM;
grant SELECT                                                                 on SB_R016         to RPBN002;
grant SELECT                                                                 on SB_R016         to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SB_R016         to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SB_R016.sql =========*** End *** =====
PROMPT ===================================================================================== 
