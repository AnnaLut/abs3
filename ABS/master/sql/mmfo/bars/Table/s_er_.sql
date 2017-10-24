

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/S_ER_.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to S_ER_ ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''S_ER_'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''S_ER_'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''S_ER_'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table S_ER_ ***
begin 
  execute immediate '
  CREATE TABLE BARS.S_ER_ 
   (	K_ER CHAR(4), 
	N_ER VARCHAR2(60), 
	K_TASK CHAR(10)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to S_ER_ ***
 exec bpa.alter_policies('S_ER_');


COMMENT ON TABLE BARS.S_ER_ IS '';
COMMENT ON COLUMN BARS.S_ER_.K_ER IS '';
COMMENT ON COLUMN BARS.S_ER_.N_ER IS '';
COMMENT ON COLUMN BARS.S_ER_.K_TASK IS '';



PROMPT *** Create  grants  S_ER_ ***
grant DELETE,INSERT,SELECT,UPDATE                                            on S_ER_           to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on S_ER_           to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/S_ER_.sql =========*** End *** =======
PROMPT ===================================================================================== 
