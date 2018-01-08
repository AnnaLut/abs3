

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/S_ER.sql =========*** Run *** ========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to S_ER ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''S_ER'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''S_ER'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''S_ER'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table S_ER ***
begin 
  execute immediate '
  CREATE TABLE BARS.S_ER 
   (	K_ER VARCHAR2(4), 
	N_ER VARCHAR2(100), 
	K_TASK VARCHAR2(10)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to S_ER ***
 exec bpa.alter_policies('S_ER');


COMMENT ON TABLE BARS.S_ER IS '';
COMMENT ON COLUMN BARS.S_ER.K_ER IS '';
COMMENT ON COLUMN BARS.S_ER.N_ER IS '';
COMMENT ON COLUMN BARS.S_ER.K_TASK IS '';



PROMPT *** Create  grants  S_ER ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on S_ER            to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on S_ER            to BARS_CONNECT;
grant SELECT                                                                 on S_ER            to BARS_DM;
grant SELECT                                                                 on S_ER            to BASIC_INFO;
grant DELETE,INSERT,SELECT,UPDATE                                            on S_ER            to SEP_ROLE;
grant SELECT                                                                 on S_ER            to START1;
grant DELETE,INSERT,SELECT,UPDATE                                            on S_ER            to S_ER;
grant SELECT                                                                 on S_ER            to TOSS;
grant SELECT                                                                 on S_ER            to USER44801;
grant FLASHBACK,SELECT                                                       on S_ER            to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/S_ER.sql =========*** End *** ========
PROMPT ===================================================================================== 
