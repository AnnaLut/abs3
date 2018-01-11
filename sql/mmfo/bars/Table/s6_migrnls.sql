

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/S6_MIGRNLS.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to S6_MIGRNLS ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table S6_MIGRNLS ***
begin 
  execute immediate '
  CREATE TABLE BARS.S6_MIGRNLS 
   (	NLS_FIL VARCHAR2(14), 
	KV NUMBER, 
	NLS_BARS VARCHAR2(14), 
	FILIAL VARCHAR2(12)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to S6_MIGRNLS ***
 exec bpa.alter_policies('S6_MIGRNLS');


COMMENT ON TABLE BARS.S6_MIGRNLS IS 'Справочник счетов миграции филиалов';
COMMENT ON COLUMN BARS.S6_MIGRNLS.NLS_FIL IS 'Счёт в филиале';
COMMENT ON COLUMN BARS.S6_MIGRNLS.KV IS 'Валюта';
COMMENT ON COLUMN BARS.S6_MIGRNLS.NLS_BARS IS 'Счёт в БАРСе';
COMMENT ON COLUMN BARS.S6_MIGRNLS.FILIAL IS 'Код МФО филиала';



PROMPT *** Create  grants  S6_MIGRNLS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on S6_MIGRNLS      to ABS_ADMIN;
grant SELECT                                                                 on S6_MIGRNLS      to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on S6_MIGRNLS      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on S6_MIGRNLS      to BARS_DM;
grant SELECT                                                                 on S6_MIGRNLS      to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on S6_MIGRNLS      to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on S6_MIGRNLS      to WR_REFREAD;



PROMPT *** Create SYNONYM  to S6_MIGRNLS ***

  CREATE OR REPLACE PUBLIC SYNONYM S6_MIGRNLS FOR BARS.S6_MIGRNLS;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/S6_MIGRNLS.sql =========*** End *** ==
PROMPT ===================================================================================== 
