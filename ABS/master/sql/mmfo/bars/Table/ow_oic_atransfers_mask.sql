PROMPT ===================================================================================== 
PROMPT *** Run *** ===== Scripts /Sql/BARS/Table/ow_oic_atransfers_mask.sql ==== *** Run *** 
PROMPT ===================================================================================== 

BEGIN 
   execute immediate  
      'begin  
          bpa.alter_policy_info(''ow_oic_atransfers_mask'', ''CENTER'' , null, null, null, null);
          bpa.alter_policy_info(''ow_oic_atransfers_mask'', ''FILIAL'' , null, null, null, null);
          bpa.alter_policy_info(''ow_oic_atransfers_mask'', ''WHOLE'' , null, null, null, null);
          null;
       end; 
      '; 
END; 
/

PROMPT *** Create  table ow_oic_atransfers_mask ***
begin 
   execute immediate '
   CREATE TABLE ow_oic_atransfers_mask  
   (
      mask       varchar2(6) not null,
      nbs        char(4)             ,
      ob22       char(2)             ,
      nms        varchar(70)         ,
      tip        char(3)             ,
      vid        integer             ,
      s180       varchar2(1)         ,
      r011       varchar2(1)         ,
      r013       varchar2(1)         ,
      field_name varchar2(30)
   ) TABLESPACE BRSSMLD ';
exception when others then       
   if sqlcode=-955 then null; else raise; end if; 
end; 
/

PROMPT *** ALTER_POLICIES to ow_oic_atransfers_mask ***
exec bpa.alter_policies('ow_oic_atransfers_mask');

COMMENT ON TABLE  BARS.ow_oic_atransfers_mask            IS 'Налаштування параметрів рахунків для обслуговування комісій по терміналам';
COMMENT ON COLUMN BARS.ow_oic_atransfers_mask.mask       IS 'Маска пошуку';
COMMENT ON COLUMN BARS.ow_oic_atransfers_mask.nbs        IS 'Балансовый номер рахунку';
COMMENT ON COLUMN BARS.ow_oic_atransfers_mask.ob22       IS 'Спец СБ OB22 внутр аналитика';
COMMENT ON COLUMN BARS.ow_oic_atransfers_mask.nms        IS 'Найменування рахунку';
COMMENT ON COLUMN BARS.ow_oic_atransfers_mask.tip        IS 'Тип рахунку';
COMMENT ON COLUMN BARS.ow_oic_atransfers_mask.vid        IS 'Код виду рахунку';
COMMENT ON COLUMN BARS.ow_oic_atransfers_mask.s180       IS 'S180 Код срока кред/деп счетов';
COMMENT ON COLUMN BARS.ow_oic_atransfers_mask.r011       IS 'R011 Специальный параметр';
COMMENT ON COLUMN BARS.ow_oic_atransfers_mask.r013       IS 'R013 Специальный параметр';
COMMENT ON COLUMN BARS.ow_oic_atransfers_mask.field_name IS 'Поле в таблиці ow_oic_atransfers_acc';

PROMPT *** Create  grants  ow_oic_atransfers_mask ***
grant SELECT, INSERT, UPDATE, DELETE on ow_oic_atransfers_mask to BARS_ACCESS_DEFROLE;

PROMPT ===================================================================================== 
PROMPT *** End *** ===== Scripts /Sql/BARS/Table/ow_oic_atransfers_mask.sql ==== *** End ***
PROMPT ===================================================================================== 
