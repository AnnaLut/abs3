

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/XOZ_RU_CA.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to XOZ_RU_CA ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''XOZ_RU_CA'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''XOZ_RU_CA'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table XOZ_RU_CA ***
begin 
  execute immediate '
  CREATE TABLE BARS.XOZ_RU_CA 
   (	REF1 NUMBER, 
	REFD_RU NUMBER, 
	RECD_RU NUMBER, 
	RECD_CA NUMBER, 
	REFK_CA NUMBER, 
	REF2 NUMBER
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to XOZ_RU_CA ***
 exec bpa.alter_policies('XOZ_RU_CA');


COMMENT ON TABLE BARS.XOZ_RU_CA IS 'Обмін запитами та платежами міх РУ та ЦА';
COMMENT ON COLUMN BARS.XOZ_RU_CA.REF1 IS 'Первинний реф виникнення деб заборг в РУ';
COMMENT ON COLUMN BARS.XOZ_RU_CA.REFD_RU IS 'РЕФ деб запиту від РУ на ЦА ( в РУ)';
COMMENT ON COLUMN BARS.XOZ_RU_CA.RECD_RU IS 'Рек відправленого деб запиту від РУ на ЦА ( в РУ)';
COMMENT ON COLUMN BARS.XOZ_RU_CA.RECD_CA IS 'Рек отриманого деб запиту від РУ на ЦА ( в ЦА)';
COMMENT ON COLUMN BARS.XOZ_RU_CA.REFK_CA IS 'Реф сплати отриманого деб запиту від РУ на ЦА ( в ЦА)';
COMMENT ON COLUMN BARS.XOZ_RU_CA.REF2 IS 'реф закриття  деб заборг в РУ';



PROMPT *** Create  grants  XOZ_RU_CA ***
grant SELECT                                                                 on XOZ_RU_CA       to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT                                                   on XOZ_RU_CA       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on XOZ_RU_CA       to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/XOZ_RU_CA.sql =========*** End *** ===
PROMPT ===================================================================================== 
