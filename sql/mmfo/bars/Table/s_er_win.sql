

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/S_ER_WIN.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to S_ER_WIN ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table S_ER_WIN ***
begin 
  execute immediate '
  CREATE TABLE BARS.S_ER_WIN 
   (	K_ER VARCHAR2(4), 
	N_ER VARCHAR2(60), 
	K_TASK VARCHAR2(10)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to S_ER_WIN ***
 exec bpa.alter_policies('S_ER_WIN');


COMMENT ON TABLE BARS.S_ER_WIN IS '';
COMMENT ON COLUMN BARS.S_ER_WIN.K_ER IS '';
COMMENT ON COLUMN BARS.S_ER_WIN.N_ER IS '';
COMMENT ON COLUMN BARS.S_ER_WIN.K_TASK IS '';



PROMPT *** Create  grants  S_ER_WIN ***
grant DELETE,INSERT,SELECT,UPDATE                                            on S_ER_WIN        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on S_ER_WIN        to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on S_ER_WIN        to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/S_ER_WIN.sql =========*** End *** ====
PROMPT ===================================================================================== 
