
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/saldo_utl.sql =========*** Run *** =
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.SALDO_UTL is
    type t_saldo_lines is table of saldoa%rowtype;

    type r_attribute_value_by_date is record
    (
         date_from       date,
         date_through    date,
         number_value    number,
         string_value    varchar2(4000 byte),
         date_value      date,
         blob_value      blob,
         clob_value      clob,
         nested_table_identifier number
    );
    type t_attribute_value_by_date is table of r_attribute_value_by_date;

    function pipe_saldo_line(
        p_account_id in integer,
        p_date in date default null)
    return t_saldo_lines
    pipelined;

    function pipe_attribute_value_by_date(
        p_attribute_id in integer,
        p_object_id in integer,
        p_value_date in date default null)
    return t_attribute_value_by_date
    pipelined;
end;
/
CREATE OR REPLACE PACKAGE BODY BARS.SALDO_UTL as
    function pipe_saldo_line(
        p_account_id in integer,
        p_date in date default null)
    return t_saldo_lines
    pipelined
    is
    begin
        for i in (select s.*
                  from   saldoa s
                  where  s.acc = p_account_id and
                         s.fdat <= p_date
                  order by s.fdat desc) loop
            pipe row(i);
            exit;
        end loop;
    end;

    function pipe_attribute_value_by_date(
        p_attribute_id in integer,
        p_object_id in integer,
        p_value_date in date default null)
    return t_attribute_value_by_date
    pipelined
    is
    begin
        for i in (select t.value_date,
                         lead(t.value_date - 1, 1) over (order by t.value_date),
                         t.number_value,
                         t.string_value,
                         t.date_value,
                         t.blob_value,
                         t.clob_value,
                         t.nested_table_id
                  from   attribute_value_by_date t
                  where  t.attribute_id = p_attribute_id and
                         t.object_id = p_object_id and
                         tools.compare_range_borders(t.value_date, p_value_date) <= 0
                  order by t.value_date desc nulls last) loop
            pipe row(i);
            exit;
        end loop;
    end;
end;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/saldo_utl.sql =========*** End *** =
 PROMPT ===================================================================================== 
 