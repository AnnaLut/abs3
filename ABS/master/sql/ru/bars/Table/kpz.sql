

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KPZ.sql =========*** Run *** =========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KPZ ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KPZ'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KPZ'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KPZ ***
begin 
  execute immediate '
  CREATE TABLE BARS.KPZ 
   (	KOD NUMBER(*,0), 
	NAME VARCHAR2(20), 
	KPZ_MIN NUMBER, 
	KPZ_MAX NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KPZ ***
 exec bpa.alter_policies('KPZ');


COMMENT ON TABLE BARS.KPZ IS 'Зважений коеф.покриття боргу забезпеченням';
COMMENT ON COLUMN BARS.KPZ.KOD IS 'Код КПЗ';
COMMENT ON COLUMN BARS.KPZ.NAME IS 'Назва КПЗ';
COMMENT ON COLUMN BARS.KPZ.KPZ_MIN IS 'Значення КПЗ (min)';
COMMENT ON COLUMN BARS.KPZ.KPZ_MAX IS 'Значення КПЗ (max)';



PROMPT *** Create  grants  KPZ ***
grant SELECT                                                                 on KPZ             to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KPZ             to RCC_DEAL;
grant SELECT                                                                 on KPZ             to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KPZ.sql =========*** End *** =========
PROMPT ===================================================================================== 
