

PROMPT ===================================================================================== 
PROMPT *** Run *** === Scripts /Sql/BARS/Table/BPK_PARAMETERS_LIST.sql ====*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ACC_PAR ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BPK_PARAMETERS_LIST'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''BPK_PARAMETERS_LIST'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''BPK_PARAMETERS_LIST'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BPK_PARAMETERS_LIST ***
begin 
  execute immediate '
create table BPK_PARAMETERS_LIST (
       param_code varchar2(30),
       param_name varchar2(255),
       controll_type varchar2(50),
       data_type varchar2(10),
       data_source clob,
       comm varchar2(255)
)';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/
begin
  execute immediate '
alter table BPK_PARAMETERS_LIST
  add constraint PK_BPK_PARAMETERS_LIST primary key (PARAM_CODE)
  using index 
  tablespace BRSDYND
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  )';
exception when others then       
  if sqlcode=-02260 then null; else raise; end if; 

end;
/
COMMENT ON TABLE BARS.BPK_PARAMETERS_LIST IS 'Опис параметрів договору БПК';
COMMENT ON COLUMN BARS.BPK_PARAMETERS_LIST.param_code IS 'Код параметру';
COMMENT ON COLUMN BARS.BPK_PARAMETERS_LIST.param_name IS 'Назва параметру';
COMMENT ON COLUMN BARS.BPK_PARAMETERS_LIST.controll_type IS 'Тип елементу на формі WEB';
COMMENT ON COLUMN BARS.BPK_PARAMETERS_LIST.data_type IS 'Тип даних(тип:довжина)';
COMMENT ON COLUMN BARS.BPK_PARAMETERS_LIST.data_source IS 'Джерело даних (назва таблиці, запит, JSON-структура)';
COMMENT ON COLUMN BARS.BPK_PARAMETERS_LIST.comm IS 'Коментар до параметру';


PROMPT *** Create  grants  BPK_PARAMETERS_LIST ***
grant SELECT                                                                 on BPK_PARAMETERS_LIST  to BARSUPL;
grant DELETE,INSERT,SELECT,UPDATE                                            on BPK_PARAMETERS_LIST  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on BPK_PARAMETERS_LIST  to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on BPK_PARAMETERS_LIST  to OW;
grant SELECT                                                                 on BPK_PARAMETERS_LIST  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BPK_PARAMETERS_LIST.sql ====*** End **
PROMPT ===================================================================================== 
