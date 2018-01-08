

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CUSTOMER_BUSS.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CUSTOMER_BUSS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CUSTOMER_BUSS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CUSTOMER_BUSS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CUSTOMER_BUSS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CUSTOMER_BUSS ***
begin 
  execute immediate '
  CREATE TABLE BARS.CUSTOMER_BUSS 
   (	EDRPOU VARCHAR2(14), 
	MFO NUMBER, 
	RNK NUMBER, 
	BUSSLINE VARCHAR2(250)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CUSTOMER_BUSS ***
 exec bpa.alter_policies('CUSTOMER_BUSS');


COMMENT ON TABLE BARS.CUSTOMER_BUSS IS 'Бізнес-напрямки клієнтів ДКБ і ММСБ (довідник)';
COMMENT ON COLUMN BARS.CUSTOMER_BUSS.EDRPOU IS 'ЕДРПОУ';
COMMENT ON COLUMN BARS.CUSTOMER_BUSS.MFO IS 'МФО';
COMMENT ON COLUMN BARS.CUSTOMER_BUSS.RNK IS 'Реєстраційній номер клієнта';
COMMENT ON COLUMN BARS.CUSTOMER_BUSS.BUSSLINE IS 'Бізнес-напрямок';



PROMPT *** Create  grants  CUSTOMER_BUSS ***
grant SELECT                                                                 on CUSTOMER_BUSS   to BARSREADER_ROLE;
grant SELECT                                                                 on CUSTOMER_BUSS   to BARS_DM;
grant SELECT                                                                 on CUSTOMER_BUSS   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CUSTOMER_BUSS.sql =========*** End ***
PROMPT ===================================================================================== 
