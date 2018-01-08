

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/MIGR_RU.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to MIGR_RU ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''MIGR_RU'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''MIGR_RU'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''MIGR_RU'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table MIGR_RU ***
begin 
  execute immediate '
  CREATE TABLE BARS.MIGR_RU 
   (	TIP VARCHAR2(6), 
	OLD_KF VARCHAR2(6), 
	OLD_VAL VARCHAR2(25), 
	NEW_KF VARCHAR2(6), 
	NEW_VAL VARCHAR2(25), 
	BDAT DATE, 
	COMM VARCHAR2(100)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to MIGR_RU ***
 exec bpa.alter_policies('MIGR_RU');


COMMENT ON TABLE BARS.MIGR_RU IS 'Таблиця Миграционных ключей';
COMMENT ON COLUMN BARS.MIGR_RU.TIP IS 'Вид ключа';
COMMENT ON COLUMN BARS.MIGR_RU.OLD_KF IS 'МФО прописки ключа начальное';
COMMENT ON COLUMN BARS.MIGR_RU.OLD_VAL IS 'Значение ключа начальное';
COMMENT ON COLUMN BARS.MIGR_RU.NEW_KF IS 'МФО прописки ключа после миграции';
COMMENT ON COLUMN BARS.MIGR_RU.NEW_VAL IS 'Значение прописки ключа после миграции';
COMMENT ON COLUMN BARS.MIGR_RU.BDAT IS 'Банк-дата в МФО=New_KF';
COMMENT ON COLUMN BARS.MIGR_RU.COMM IS '';



PROMPT *** Create  grants  MIGR_RU ***
grant SELECT                                                                 on MIGR_RU         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on MIGR_RU         to BARS_DM;
grant SELECT                                                                 on MIGR_RU         to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/MIGR_RU.sql =========*** End *** =====
PROMPT ===================================================================================== 
