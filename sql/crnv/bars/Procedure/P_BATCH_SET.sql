CREATE OR REPLACE PROCEDURE BARS.p_batch_set (xml_body       CLOB,
                                              ret_       OUT VARCHAR2)
IS
        n number:=0;
      --
        l_parser       dbms_xmlparser.parser;
        l_doc          dbms_xmldom.domdocument;
        l_analyticlist dbms_xmldom.DOMNodeList;
        l_analytic     dbms_xmldom.DOMNode;
        l_idn          number;
      --
       l_FIO      varchar2(4000);
       l_IDCODE   varchar2(4000);
       l_DOCTYPE  varchar2(4000);
       l_PASP_S   varchar2(4000);
       l_PASP_N   varchar2(4000);
       l_PASP_W   varchar2(4000);
       l_PASP_D   varchar2(4000);
       l_BIRTHDAT varchar2(4000);
       l_BIRTHPL  varchar2(4000);
       l_SEX      varchar2(4000);
       l_POSTIDX  varchar2(4000);
       l_REGION   varchar2(4000);
       l_DISTRICT varchar2(4000);
       l_CITY     varchar2(4000);
       l_ADDRESS  varchar2(4000);
       l_PHONE_H  varchar2(4000);
       l_PHONE_J  varchar2(4000);
       l_REGDATE  varchar2(4000);
       l_NLS      varchar2(4000);
       l_DATO     varchar2(4000);
       l_OST      varchar2(4000);
       l_SUM      varchar2(4000);
       l_DATN     varchar2(4000);
       l_BRANCH   varchar2(4000);
       l_BSD      varchar2(4000);
       l_OB22DE   varchar2(4000);
       l_BSN      varchar2(4000);
       l_OB22IE   varchar2(4000);
       l_BSD7     varchar2(4000);
       l_OB22D7   varchar2(4000);
       l_source   varchar2(4000);
       l_kv       varchar2(4000);
       l_nd       varchar2(4000);
       l_dptid    varchar2(4000);
       l_LANDCOD  varchar2(4000);
       l_FL       varchar2(4000);
       l_DZAGR    varchar2(4000);
       l_ref      varchar2(4000);
       l_data_batch dbms_xmldom.domnodelist;
       l_batch      dbms_xmldom.domelement;
       l_mfo varchar2(10);
       l_nbs varchar2(10);
       l_ob22 varchar2(10);
       l_kv_all number;
       l_sum_all number;
       l_acccard varchar2(4000);
       l_id varchar2(4000);
       l_mark varchar2(4000);
       l_kod_otd varchar2(4000);
       l_tvbv varchar2(4000);
       l_attr varchar2(4000);
       l_batch_id varchar2(4000);

       --Процедура оплаты
     procedure pay(p_mfo varchar2, p_nbs varchar2, p_kv number, p_sum number)
     is
     l_ref number;
     l_tt varchar2(3):='015';
     l_bankdate date:=bankdate();
     l_nam_a varchar2(38) :='NLSA++++';
     l_nam_b varchar2(38) := 'NLSB++++';
     l_mfo_a varchar2(10) :=f_ourmfo_g;
     l_mfo_b varchar2(10) :=f_ourmfo_g;
     l_okpo_a varchar2(10):=f_ourokpo;
     l_okpo_b varchar2(10):=f_ourokpo;
     l_nls_a varchar2(14);
     l_nls_b varchar2(14);
     l_nls_a2 varchar2(14);
     l_nls_b2 varchar2(14);
     l_nazn varchar2(160):= 'Зарахування в ЦРНВ';
     l_rec_resources exchange_of_resources%rowtype;

  begin
    select e.* into l_rec_resources from exchange_of_resources e where e.mfo=p_mfo;
    l_nls_a:=vkrzn(substr(l_mfo_a,1,5), '3739_'||substr(p_nbs,3,2)||p_mfo);
    logger.info('mos'||l_nls_a);
    l_nls_b:=vkrzn(substr(l_mfo_a,1,5),
                                        case p_nbs
                                            when '2620' then '2620_030'||p_mfo
                                            when '2630' then '2630_046'||p_mfo
                                            when '2635' then '2630_038'||p_mfo
                                        end
    );
    l_nls_a2:= l_rec_resources.nls_3902;
    l_nls_b2:= vkrzn(substr(l_mfo_a,1,5), '3739_99'||p_mfo);
      begin
      gl.ref(l_ref);
      gl.in_doc3(ref_   => l_ref,
                 tt_    => l_tt,
                 vob_   => 6,
                 nd_    => l_ref,
                 pdat_  => sysdate,
                 vdat_  => l_bankdate,
                 dk_    => 1,
                 kv_    => p_kv,
                 s_     => p_sum,
                 kv2_   => p_kv,
                 s2_    => p_sum,
                 sk_    => null,
                 data_  => l_bankdate,
                 datp_  => l_bankdate,
                 nam_a_ => l_nam_a,
                 nlsa_  => l_nls_a,
                 mfoa_  => l_mfo_a,
                 nam_b_ => l_nam_b,
                 nlsb_  => l_nls_b,
                 mfob_  => l_mfo_b,
                 nazn_  => substr(l_nazn, 1, 160),
                 d_rec_ => null,
                 id_a_  => l_okpo_a,
                 id_b_  => l_okpo_b,
                 id_o_  => null,
                 sign_  => null,
                 sos_   => 0,
                 prty_  => null,
                 uid_   => null);

                  paytt(null,
                        l_ref,
                        l_bankdate,
                        l_tt,
                        1,
                        p_kv,
                        l_nls_a,
                        p_sum,
                        p_kv,
                        l_nls_b,
                        p_sum);
                  paytt(null,
                        l_ref,
                        l_bankdate,
                        l_tt,
                        1,
                        p_kv,
                        l_nls_a2,
                        p_sum,
                        p_kv,
                        l_nls_b2,
                        p_sum);
                gl.pay(2, l_ref, l_bankdate);
       end;
     end;
  BEGIN

    tuda;
   execute immediate 'alter session set ddl_lock_timeout=30';

   l_parser := dbms_xmlparser.newparser;

    dbms_xmlparser.parseclob(l_parser, xml_body);

    l_doc := dbms_xmlparser.getdocument(l_parser);

    l_data_batch := dbms_xmldom.getelementsbytagname(l_doc, 'data_batch');

    l_analyticlist := dbms_xmldom.getelementsbytagname(l_doc, 'immdeposit');
     for m in 0 .. dbms_xmldom.getlength(l_data_batch) - 1
    loop

        l_batch := dbms_xmldom.makeelement(dbms_xmldom.item(l_data_batch, m));

        l_nbs:=trim(dbms_xmldom.getattribute(l_batch, 'bsd')) ;
        l_mfo:=trim(dbms_xmldom.getattribute(l_batch, 'mfo')) ;
        l_ob22:=dbms_xmldom.getattribute(l_batch, 'ob22') ;
        l_kv_all:=to_number(trim(dbms_xmldom.getattribute(l_batch, 'kv')));
        l_sum_all :=to_number(trim(dbms_xmldom.getattribute(l_batch, 'sum')));
    end loop;
    logger.info('mos: l_mfo='||l_mfo||', l_nbs='||l_nbs||', l_kv_all='||l_kv_all||', l_sum_all='||l_sum_all);
   begin
       savepoint sp_before;
    for i in 0 .. dbms_xmldom.getlength(l_analyticlist) - 1

    loop
     -- счетчик транзакций
     l_idn := i + 1;

     l_analytic := dbms_xmldom.item(l_analyticlist, i);

     dbms_xslprocessor.valueof(l_analytic, 'FIO/text()', l_FIO      );
     dbms_xslprocessor.valueof(l_analytic, 'IDCODE/text()', l_IDCODE   );
     dbms_xslprocessor.valueof(l_analytic, 'DOCTYPE/text()', l_DOCTYPE  );
     dbms_xslprocessor.valueof(l_analytic, 'PASP_S/text()', l_PASP_S   );
     dbms_xslprocessor.valueof(l_analytic, 'PASP_N/text()', l_PASP_N   );
     dbms_xslprocessor.valueof(l_analytic, 'PASP_W/text()', l_PASP_W   );
     dbms_xslprocessor.valueof(l_analytic, 'PASP_D/text()', l_PASP_D   );
     dbms_xslprocessor.valueof(l_analytic, 'BIRTHDAT/text()', l_BIRTHDAT );
     dbms_xslprocessor.valueof(l_analytic, 'BIRTHPL/text()', l_BIRTHPL  );
     dbms_xslprocessor.valueof(l_analytic, 'SEX/text()', l_SEX      );
     dbms_xslprocessor.valueof(l_analytic, 'POSTIDX/text()', l_POSTIDX  );
     dbms_xslprocessor.valueof(l_analytic, 'REGION/text()', l_REGION   );
     dbms_xslprocessor.valueof(l_analytic, 'DISTRICT/text()', l_DISTRICT );
     dbms_xslprocessor.valueof(l_analytic, 'CITY/text()', l_CITY     );
     dbms_xslprocessor.valueof(l_analytic, 'ADDRESS/text()', l_ADDRESS  );
     dbms_xslprocessor.valueof(l_analytic, 'PHONE_H/text()', l_PHONE_H  );
     dbms_xslprocessor.valueof(l_analytic, 'PHONE_J/text()', l_PHONE_J  );
     dbms_xslprocessor.valueof(l_analytic, 'REGDATE/text()', l_REGDATE  );
     dbms_xslprocessor.valueof(l_analytic, 'NLS/text()', l_NLS      );
     dbms_xslprocessor.valueof(l_analytic, 'DATO/text()', l_DATO     );
     dbms_xslprocessor.valueof(l_analytic, 'OST/text()', l_OST      );
     dbms_xslprocessor.valueof(l_analytic, 'SUM/text()', l_SUM      );
     dbms_xslprocessor.valueof(l_analytic, 'DATN/text()', l_DATN     );
     dbms_xslprocessor.valueof(l_analytic, 'BRANCH/text()', l_BRANCH   );
     dbms_xslprocessor.valueof(l_analytic, 'BSD/text()', l_BSD      );
     dbms_xslprocessor.valueof(l_analytic, 'OB22DE/text()', l_OB22DE   );
     dbms_xslprocessor.valueof(l_analytic, 'BSN/text()', l_BSN      );
     dbms_xslprocessor.valueof(l_analytic, 'OB22IE/text()', l_OB22IE   );
     dbms_xslprocessor.valueof(l_analytic, 'BSD7/text()', l_BSD7     );
     dbms_xslprocessor.valueof(l_analytic, 'OB22D7/text()', l_OB22D7   );
     dbms_xslprocessor.valueof(l_analytic, 'source/text()', l_source   );
     dbms_xslprocessor.valueof(l_analytic, 'kv/text()', l_kv       );
     dbms_xslprocessor.valueof(l_analytic, 'nd/text()', l_nd       );
     dbms_xslprocessor.valueof(l_analytic, 'dptid/text()', l_dptid    );
     dbms_xslprocessor.valueof(l_analytic, 'LANDCOD/text()', l_LANDCOD  );
     dbms_xslprocessor.valueof(l_analytic, 'FL/text()', l_FL       );
     dbms_xslprocessor.valueof(l_analytic, 'DZAGR/text()', l_DZAGR    );
     dbms_xslprocessor.valueof(l_analytic, 'ref/text()', l_ref      );
     dbms_xslprocessor.valueof(l_analytic, 'acc_card/text()', l_acccard      );
     dbms_xslprocessor.valueof(l_analytic, 'id/text()', l_id      );
     dbms_xslprocessor.valueof(l_analytic, 'mark/text()', l_mark      );
     dbms_xslprocessor.valueof(l_analytic, 'kod_otd/text()', l_kod_otd      );
     dbms_xslprocessor.valueof(l_analytic, 'tvbv/text()', l_tvbv      );
     dbms_xslprocessor.valueof(l_analytic, 'attr/text()', l_attr      );  
     dbms_xslprocessor.valueof(l_analytic, 'batch_id/text()', l_batch_id);


        
        
                             migraas.dpt2immobile(p_FIO => decode_base_to_row(l_fio),
                                           p_IDCODE => l_idcode,
                                           p_DOCTYPE => l_doctype,
                                           p_PASP_S => decode_base_to_row(l_pasp_s),
                                           p_PASP_N => l_pasp_n,
                                           p_PASP_W => decode_base_to_row(l_pasp_w),
                                           p_PASP_D => to_date(l_pasp_d,'dd/mm/yyyy'),
                                           p_BIRTHDAT => to_date(l_birthdat,'dd/mm/yyyy'),
                                           p_BIRTHPL => decode_base_to_row(l_birthpl),
                                           p_SEX => to_number(l_sex),
                                           p_POSTIDX => decode_base_to_row(l_postidx),
                                           p_REGION => decode_base_to_row(l_region),
                                           p_DISTRICT => decode_base_to_row(l_district),
                                           p_CITY => decode_base_to_row(l_city),
                                           p_ADDRESS => decode_base_to_row(l_address),
                                           p_PHONE_H => l_phone_h,
                                           p_PHONE_J => l_phone_j,
                                           p_REGDATE => to_date(l_regdate, 'dd/mm/yyyy'),
                                           p_NLS => l_nls,
                                           p_DATO => to_date(l_dato,'dd/mm/yyyy'),
                                           p_OST => to_number(l_ost),
                                           p_SUM => to_number(l_sum),
                                           p_DATN => to_date(l_datn, 'dd/mm/yyyy'),
                                           p_BRANCH => l_branch,
                                           p_BSD => l_bsd,
                                           p_OB22DE => l_ob22de,
                                           p_BSN => l_bsn,
                                           p_OB22IE => l_ob22ie,
                                           p_BSD7 => l_bsd7,
                                           p_OB22D7 => l_ob22d7,
                                           p_source => decode_base_to_row(l_source),
                                           p_kv => to_number(l_kv),
                                           p_nd => decode_base_to_row(l_nd),
                                           p_dptid => to_number(l_dptid),
                                           p_err => ret_,
                                           p_LANDCOD => to_number(l_landcod),
                                           p_FL => to_number(l_fl),
                                           p_DZAGR => to_date(l_dzagr, 'dd/mm/yyyy'),
                                           p_ref => to_number(l_ref),
                                           p_acccard => nvl(l_acccard,' '),
                                           p_id => nvl(l_id,' '),
                                           p_mark=> nvl(l_mark,' '),
                                           p_kod_otd => nvl(l_kod_otd,' '),
                                           p_tvbv => nvl(l_tvbv,' '),
                                           p_attr => nvl(l_attr,' '),
                                           p_batch_id=>nvl(l_batch_id,0));

      if ret_!='Ok' then raise_application_error(-20000, ret_); end if;

      n:=n+1;

    end loop;

       pay(l_mfo, l_nbs, l_kv_all, l_sum_all);
    exception when others then
        rollback to sp_before;
        ret_:=substr('ERR:'||sqlerrm,1,4000);
        end;

    dbms_xmlparser.freeparser(l_parser);

    DBMS_XMLDOM.freeDocument(l_doc);

END p_batch_set;
/

