
PROMPT ===================================================================================== 
PROMPT *** Run *** ======= Scripts /Sql/BARS/Table/NBUR_KOR_6EX_MREZ.sql ======= *** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to NBUR_KOR_6EX_MREZ ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NBUR_KOR_6EX_MREZ'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''NBUR_KOR_6EX_MREZ'', ''FILIAL'' , null, ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''NBUR_KOR_6EX_MREZ'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NBUR_KOR_6EX_MREZ ***
begin 
  execute immediate '
  CREATE TABLE BARS.NBUR_KOR_6EX_MREZ 
   (	KF NUMBER   DEFAULT     sys_context(''bars_context'',''user_mfo''), 
        SUM_MREZ    NUMBER(38)  constraint CC_NBURKOR6EXMREZ_MREZ_NN NOT NULL, 
        DATE_BEGIN  DATE        constraint CC_NBURKOR6EXMREZ_DATB_NN NOT NULL,
	    DATE_END    DATE
   ) 
   TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

begin 
    execute immediate 'ALTER TABLE BARS.NBUR_KOR_6EX_MREZ 
                       ADD CONSTRAINT NBUR_KOR_6EX_MREZ_PK
                       PRIMARY KEY (DATE_BEGIN) ';
exception when others then       
  if sqlcode=-2260 then null; else raise; end if; 
end; 
/
                      
 
PROMPT *** ALTER_POLICIES to NBUR_KOR_6EX_MREZ ***
 exec bpa.alter_policies('NBUR_KOR_6EX_MREZ');


COMMENT ON TABLE  BARS.NBUR_KOR_6EX_MREZ IS '6EX Дані про суму обов''язкового резерву для 6ЕХ';

comment on column BARS.NBUR_KOR_6EX_MREZ.KF         is 'Код філії';
COMMENT ON COLUMN BARS.NBUR_KOR_6EX_MREZ.SUM_MREZ   IS 'Сума обов''язкового резерву';
COMMENT ON COLUMN BARS.NBUR_KOR_6EX_MREZ.DATE_BEGIN IS 'Дата початку дії';
COMMENT ON COLUMN BARS.NBUR_KOR_6EX_MREZ.DATE_END   IS 'Дата закінчення дії';

PROMPT *** Create  grants  NBUR_KOR_6EX_MREZ ***
grant SELECT                                          on NBUR_KOR_6EX_MREZ   to BARSREADER_ROLE;
grant SELECT                                          on NBUR_KOR_6EX_MREZ   to BARSUPL;
grant DELETE,INSERT,SELECT,UPDATE                     on NBUR_KOR_6EX_MREZ   to BARS_ACCESS_DEFROLE;
grant SELECT                                          on NBUR_KOR_6EX_MREZ   to RPBN002;
grant SELECT                                          on NBUR_KOR_6EX_MREZ   to UPLD;


PROMPT ===================================================================================== 
PROMPT *** End *** ======= Scripts /Sql/BARS/Table/NBUR_KOR_6EX_MREZ.sql ======= *** End ***
PROMPT ===================================================================================== 

