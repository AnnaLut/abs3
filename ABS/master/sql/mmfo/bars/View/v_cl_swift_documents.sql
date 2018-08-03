create or replace view v_cl_swift_documents as
select  o.ref,
        (select to_char(ov.dat, 'dd.mm.yyyy')
           from oper_visa ov
          where ov.ref = o.ref
            and ov.groupid = 25) date_start_sdo,
        (select to_char(ov.dat, 'hh24.mi.ss')
           from oper_visa ov
          where ov.ref = o.ref
            and ov.groupid = 25) time_start_sdo,
        (select ov.username
           from oper_visa ov
          where ov.ref = o.ref
            and ov.groupid = 25) username_start_sdo,
        'AT "Ощадбанк"' first_name_bank_start_sdo,
        (select ov.kf
           from oper_visa ov
          where ov.ref = o.ref
            and ov.groupid = 25) code_bank_start_sdo,
        (select br.name
           from banks_ru br
          where br.mfo = (select ov.kf
                            from oper_visa ov
                           where ov.ref = o.ref
                             and ov.groupid = 25)) name_bank_start_sdo,
       o.nd,
       o.datd,
       o.kv,
       trim(to_char(o.s/100,'99999999999999999999999999999999999999999999999999.99')) s,
       f_sumpr(o.s, o.kv, 'M') sumpr,
       o.nlsa,
       o.nam_a,
       (select c.adr
          from customer c,
               accounts a
         where a.rnk = c.rnk
           and a.nls = o.nlsa
           and a.kv = o.kv) adr,
       (select bb.nb
          from banks$base bb
         where bb.mfo = o.mfoa) payer_bank_name,
       (select 'Україна, ' || bav.attribute_value
          from branch_attribute_value bav
         where bav.attribute_code = 'ADDRESS'
           and bav.branch_code = '\'||gl.kf||'\') address_payer_bank,
       (select sb.name
          from sw_banks sb
         where sb.bic = (select ow.value
                           from operw ow
                          where ow.ref = o.ref
                            and ow.tag = '56A')) name_bank_mediator,
       (select ow.value
          from operw ow
         where ow.ref = o.ref
           and ow.tag = '56A') bic_mediator,
       (select sb.office||', '||sb.city||', '||sb.country
          from sw_banks sb
         where sb.bic = (select ow.value
                           from operw ow
                          where ow.ref = o.ref
                            and ow.tag = '56A')) address_bank_mediator,
       (select case substr(ow.value,1,1) when '/' then substr(ow.value, 2, instr(ow.value,chr(10) - 1)) else null end
          from operw ow
         where ow.ref = o.ref
           and ow.tag = '56A') acc_bank_beneficar,
       (select sb.name
          from sw_banks sb
         where sb.bic = (select case substr(ow.value,1,1) when '/' then substr(ow.value, instr(ow.value, chr(13) + 1), 11) else substr(ow.value, 1, 11) end
                           from operw ow
                          where ow.ref = o.ref
                            and ow.tag = '56A')) name_bank_beneficar,
       (select case substr(ow.value,1,1) when '/' then substr(ow.value, instr(ow.value, chr(13) + 1), 11) else substr(ow.value, 1, 11) end
          from operw ow
         where ow.ref = o.ref
           and ow.tag = '56A') bic_bank_beneficar,
        (select sb.office||', '||sb.city||', '||sb.country
          from sw_banks sb
         where sb.bic = (select case substr(ow.value,1,1) when '/' then substr(ow.value, instr(ow.value, chr(13) + 1), 11) else substr(ow.value, 1, 11) end
                           from operw ow
                          where ow.ref = o.ref
                            and ow.tag = '56A')) address_bank_beneficar,
        (select substr(ow.value, 2, 33)
           from operw ow
          where ow.ref = o.ref
            and ow.tag = '59') acc_beneficar,
        (select substr(ow.value, instr(ow.value, '\', 1, 2) + 1, 33)
           from operw ow
          where ow.ref = o.ref
            and ow.tag = '59') name_beneficar,
        (select substr(ow.value, instr(ow.value, '\', 1, 3) + 1, 33)
           from operw ow
          where ow.ref = o.ref
            and ow.tag = '59') address_beneficar,
        (select ow.value
           from operw ow
          where ow.ref = o.ref
            and ow.tag = '70') remit_info,
        (select ow.value
           from operw ow
          where ow.ref = o.ref
            and ow.tag = '71A') detail_charge,
        o.mfoa code_payer_bank,
        (select c.okpo
          from customer c,
               accounts a
         where a.rnk = c.rnk
           and a.nls = o.nlsa
           and a.kv = o.kv) okpo_payer,
        (select ow.value
           from operw ow
          where ow.ref = o.ref
            and ow.tag = 'N') code_oper,
        (select ow.value
           from operw ow
          where ow.ref = o.ref
            and ow.tag = 'n') code_country,
        (select substr(ow.value, 1, instr(ow.value,',') - 1)
           from operw ow
          where ow.ref = o.ref
            and ow.tag = 'CLV01') signature1,
        (select substr(ow.value, 1, instr(ow.value,',') - 1)
           from operw ow
          where ow.ref = o.ref
            and ow.tag = 'CLV02') signature2,
        (select to_char(ov.dat, 'dd.mm.yyyy')
           from oper_visa ov
          where ov.ref = o.ref
            and ov.groupid = 7) date_val_kont,
        (select to_char(ov.dat, 'hh24.mi.ss')
           from oper_visa ov
          where ov.ref = o.ref
            and ov.groupid = 7) time_val_kont,
        (select ov.username
           from oper_visa ov
          where ov.ref = o.ref
            and ov.groupid = 7) username_val_kont,
        'AT "Ощадбанк"' first_name_bank_val_kont,
        (select ov.kf
           from oper_visa ov
          where ov.ref = o.ref
            and ov.groupid = 7) code_bank_val_kont,
        (select br.name
           from banks_ru br
          where br.mfo = (select ov.kf
                            from oper_visa ov
                           where ov.ref = o.ref
                             and ov.groupid = 7)) name_bank_val_kont,
        (select to_char(ov.dat, 'dd.mm.yyyy')
           from oper_visa ov
          where ov.ref = o.ref
            and ov.groupid = 11) date_complete,
        (select to_char(ov.dat, 'hh24.mi.ss')
           from oper_visa ov
          where ov.ref = o.ref
            and ov.groupid = 11) time_complete,
        (select ov.username
           from oper_visa ov
          where ov.ref = o.ref
            and ov.groupid = 11) username_complete,
        'AT "Ощадбанк"' first_name_bank_complete,
        (select ov.kf
           from oper_visa ov
          where ov.ref = o.ref
            and ov.groupid = 11) code_bank_complete,
        (select br.name
           from banks_ru br
          where br.mfo = (select ov.kf
                            from oper_visa ov
                           where ov.ref = o.ref
                             and ov.groupid = 11)) name_bank_complete

  from tmp_cl_payment tcp, oper o
 where tcp.ref = o.ref
   and tcp.type = 2;

grant select on v_cl_swift_documents to bars_access_defrole;
