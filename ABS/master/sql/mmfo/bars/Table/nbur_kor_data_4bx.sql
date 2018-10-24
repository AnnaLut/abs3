
PROMPT ===================================================================================== 
PROMPT *** Run *** ======= Scripts /Sql/BARS/Table/NBUR_KOR_DATA_4BX.sql ======= *** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to NBUR_KOR_DATA_4BX ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NBUR_KOR_DATA_4BX'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''NBUR_KOR_DATA_4BX'', ''FILIAL'' , null, ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''NBUR_KOR_DATA_4BX'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NBUR_KOR_DATA_4BX ***
begin 
  execute immediate '
  CREATE TABLE BARS.NBUR_KOR_DATA_4BX 
   (	REPORT_DATE     DATE, 
        KF NUMBER DEFAULT sys_context(''bars_context'',''user_mfo''), 
        EKP       VARCHAR2(6), 
	F058      VARCHAR2(1),
	Q003_2    NUMBER, 
	T070      NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


PROMPT *** ALTER_POLICIES to NBUR_KOR_DATA_4BX ***
 exec bpa.alter_policies('NBUR_KOR_DATA_4BX');


COMMENT ON TABLE  BARS.NBUR_KOR_DATA_4BX IS '4BX Дані про дотримання вимог щодо достатності регулятивного капіталу та економічних нормативів';
COMMENT ON COLUMN BARS.NBUR_KOR_DATA_4BX.REPORT_DATE IS 'Звiтна дата';
comment on column BARS.NBUR_KOR_DATA_4BX.KF  is 'Код філії';
COMMENT ON COLUMN BARS.NBUR_KOR_DATA_4BX.EKP     IS 'Код показника';
COMMENT ON COLUMN BARS.NBUR_KOR_DATA_4BX.F058    IS 'Код підгрупи банківської групи';
COMMENT ON COLUMN BARS.NBUR_KOR_DATA_4BX.Q003_2  IS 'Порядковий номер підгрупи';
COMMENT ON COLUMN BARS.NBUR_KOR_DATA_4BX.T070    IS 'Сума -грн.eквівалент';

PROMPT *** Create  grants  NBUR_KOR_DATA_4BX ***
grant SELECT                                          on NBUR_KOR_DATA_4BX   to BARSREADER_ROLE;
grant SELECT                                          on NBUR_KOR_DATA_4BX   to BARSUPL;
grant DELETE,INSERT,SELECT,UPDATE                     on NBUR_KOR_DATA_4BX   to BARS_ACCESS_DEFROLE;
grant SELECT                                          on NBUR_KOR_DATA_4BX   to RPBN002;
grant SELECT                                          on NBUR_KOR_DATA_4BX   to UPLD;


PROMPT ===================================================================================== 
PROMPT *** End *** ======= Scripts /Sql/BARS/Table/NBUR_KOR_DATA_4BX.sql ======= *** End ***
PROMPT ===================================================================================== 

