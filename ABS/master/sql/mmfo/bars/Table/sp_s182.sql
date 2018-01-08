

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SP_S182.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SP_S182 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SP_S182'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SP_S182'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SP_S182'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SP_S182 ***
begin 
  execute immediate '
  CREATE TABLE BARS.SP_S182 
   (	S182 CHAR(1), 
	TXT VARCHAR2(48)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SP_S182 ***
 exec bpa.alter_policies('SP_S182');


COMMENT ON TABLE BARS.SP_S182 IS 'Классификатор видов кредитов';
COMMENT ON COLUMN BARS.SP_S182.S182 IS '';
COMMENT ON COLUMN BARS.SP_S182.TXT IS '';



PROMPT *** Create  grants  SP_S182 ***
grant DELETE,INSERT,SELECT,UPDATE                                            on SP_S182         to ABS_ADMIN;
grant SELECT                                                                 on SP_S182         to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SP_S182         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SP_S182         to BARS_DM;
grant SELECT                                                                 on SP_S182         to START1;
grant SELECT                                                                 on SP_S182         to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SP_S182         to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on SP_S182         to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SP_S182.sql =========*** End *** =====
PROMPT ===================================================================================== 
