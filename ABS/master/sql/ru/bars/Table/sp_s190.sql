

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SP_S190.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SP_S190 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SP_S190'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SP_S190'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SP_S190 ***
begin 
  execute immediate '
  CREATE TABLE BARS.SP_S190 
   (	S190 CHAR(1), 
	TXT VARCHAR2(48)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SP_S190 ***
 exec bpa.alter_policies('SP_S190');


COMMENT ON TABLE BARS.SP_S190 IS 'Справочник кодов пролонгации';
COMMENT ON COLUMN BARS.SP_S190.S190 IS 'Код пролонгации';
COMMENT ON COLUMN BARS.SP_S190.TXT IS 'Наименование';



PROMPT *** Create  grants  SP_S190 ***
grant DELETE,INSERT,SELECT,UPDATE                                            on SP_S190         to ABS_ADMIN;
grant DELETE,INSERT,SELECT,UPDATE                                            on SP_S190         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SP_S190         to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SP_S190         to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SP_S190.sql =========*** End *** =====
PROMPT ===================================================================================== 
