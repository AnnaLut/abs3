

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OVR_TERM_TRZ.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OVR_TERM_TRZ ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OVR_TERM_TRZ'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''OVR_TERM_TRZ'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OVR_TERM_TRZ ***
begin 
  execute immediate '
  CREATE TABLE BARS.OVR_TERM_TRZ 
   (	ACC NUMBER, 
	DATVZ DATE, 
	DATSP DATE, 
	TRZ NUMBER(*,0), 
	ACC1 NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OVR_TERM_TRZ ***
 exec bpa.alter_policies('OVR_TERM_TRZ');


COMMENT ON TABLE BARS.OVR_TERM_TRZ IS 'Плановые авто-даты выноса на просрочку (тормозной путь)';
COMMENT ON COLUMN BARS.OVR_TERM_TRZ.ACC1 IS 'Нарушитель';
COMMENT ON COLUMN BARS.OVR_TERM_TRZ.ACC IS 'Ответчик';
COMMENT ON COLUMN BARS.OVR_TERM_TRZ.DATVZ IS 'Факт-дата возникновения события';
COMMENT ON COLUMN BARS.OVR_TERM_TRZ.DATSP IS 'План-дата выноса на просрочку';
COMMENT ON COLUMN BARS.OVR_TERM_TRZ.TRZ IS 'Код события:
1=Превышение ТБ ОВР и несвоевременная оплата %/комиссии, 15.
2=Превышение лимита после пересмотра – до конца тек.мес, 15.
3=Превышение лимита после смены лимита согласно графика, 15.); -- не бывает
4=Другие причины (заводятся в ручном режиме ) , 30 ';



PROMPT *** Create  grants  OVR_TERM_TRZ ***
grant SELECT                                                                 on OVR_TERM_TRZ    to BARSREADER_ROLE;
grant SELECT                                                                 on OVR_TERM_TRZ    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OVR_TERM_TRZ.sql =========*** End *** 
PROMPT ===================================================================================== 
