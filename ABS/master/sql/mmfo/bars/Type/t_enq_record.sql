

 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/type/t_enq_record.sql =========*** Run *** =
 PROMPT ===================================================================================== 
 

declare 
  v_num integer;
  v_type varchar2(30) := 'T_ENQ_RECORD';
begin
  select count(1) into v_num
    from user_types 
    where type_name = v_type;
  if v_num = 0 then
    execute immediate 'CREATE OR REPLACE TYPE '||v_type||' as object
     (ExternalId          number,
      ClientRegisterCode  varchar2(12),
      ClientAccountNum    varchar2(15),
      ClientAccountMfo    varchar2(6),
      CollectionPointCode varchar2(100),
      Document            varchar2(100),
      Notes               varchar2(100),
      ExpectedDate        varchar2(10),
      Priority            varchar2(10))';
  end if;
end;

/

 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/type/t_enq_record.sql =========*** End *** =
 PROMPT ===================================================================================== 
 