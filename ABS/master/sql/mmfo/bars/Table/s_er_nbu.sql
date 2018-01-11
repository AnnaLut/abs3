

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/S_ER_NBU.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to S_ER_NBU ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''S_ER_NBU'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''S_ER_NBU'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''S_ER_NBU'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table S_ER_NBU ***
begin 
  execute immediate '
  CREATE TABLE BARS.S_ER_NBU 
   (	K_ER CHAR(4), 
	N_ER VARCHAR2(60)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to S_ER_NBU ***
 exec bpa.alter_policies('S_ER_NBU');


COMMENT ON TABLE BARS.S_ER_NBU IS '';
COMMENT ON COLUMN BARS.S_ER_NBU.K_ER IS '';
COMMENT ON COLUMN BARS.S_ER_NBU.N_ER IS '';



PROMPT *** Create  grants  S_ER_NBU ***
grant SELECT                                                                 on S_ER_NBU        to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on S_ER_NBU        to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on S_ER_NBU        to S_ER_NBU;
grant SELECT                                                                 on S_ER_NBU        to UPLD;
grant FLASHBACK,SELECT                                                       on S_ER_NBU        to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/S_ER_NBU.sql =========*** End *** ====
PROMPT ===================================================================================== 
