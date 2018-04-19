PROMPT *** Create  procedure P_JOB_KOMIS_NON_CASH ***

create or replace procedure P_JOB_KOMIS_NON_CASH 
is
  l_tt       oper.tt%type := 'K26';
  l_s        oper.s%type;
  l_branch   accounts.branch%type;
  l_rnk      accounts.rnk%type;
  l_nbs      accounts.nbs%type;
  l_ob22     accounts.ob22%type;
  l_segment  number;
begin

  for i in( select kf from MV_KF )
  loop

    BARS_CONTEXT.SUBST_MFO( i.KF );

    for c in ( select o.REF, o.NLSB, KV2, o.S, o.VDAT
                    , ( select count(1) -- ознака вже утриманої комісії
                          from OPLDOK t
                         where t.REF = k.REF
                           and t.TT = 'K26'
                      ) as PYMT_F
                    , ( select count(1) -- ознака надходження по ВПС
                          from BANKS$BASE b
                         where b.MFOU = '300465'
                           and b.MFO  = o.MFOA
                      ) as VPS_F
                 from KOMIS_NON_CASH k
                 join OPER o
                   on ( o.REF = k.REF )
                where k.KF = i.KF
             )
    loop

      savepoint sp_before;

      delete KOMIS_NON_CASH
       where REF = c.REF;

      if ( c.KV2 = 980 and c.PYMT_F = 0 and c.VPS_F = 0 )
      then

        begin

          select a.branch, a.RNK, a.NBS, a.OB22
            into l_branch, l_rnk, l_nbs, l_ob22
            from ACCOUNTS a
           where a.NLS = c.NLSB
             and a.KV  = c.KV2;

          if ( l_nbs = '2620' and l_ob22 = '34')
          then -- COBUSUPABS-5211
            logger.info( $$PLSQL_UNIT||': REF='||to_char(c.REF)||' блокування Спеціальних рахунків (2620/34) на здійснення видаткових операцій(комісія) NLS ='||c.NLSB );
          else

            l_segment := ATTRIBUTE_UTL.GET_NUMBER_VALUE( l_rnk, 'CUSTOMER_SEGMENT_FINANCIAL', BANKDATE );

            if ( l_segment in (1,2) )
            then /*[Пн 28.11.2016 - Рибалко Наталія Іванівна]: VIP клиент определяется по признаку в "закладке" СЕГМЕНТ КЛИЕНТА - СЕГМЕНТ ФИНАНСОВЫЙ - Прайвет или Премиум*/
              logger.info( $$PLSQL_UNIT||': REF='||to_char(c.REF)||' NOT COMIS2620 CUSTOMER_SEGMENT_FINANCIAL='||LIST_UTL.GET_ITEM_NAME('CUSTOMER_SEGMENT_FINANCIAL',l_segment) );
            else

              l_s := F_TARIF( 70, c.KV2, c.NLSB, c.S );

              logger.financial( $$PLSQL_UNIT||': REF='||to_char(c.REF)||' COMIS2620 CUSTOMER_SEGMENT_FINANCIAL='||LIST_UTL.GET_ITEM_NAME('CUSTOMER_SEGMENT_FINANCIAL',l_segment) );

              GL.PAYV( 0, c.ref, c.vdat, l_tt, 1, 980, c.nlsb, l_s, 980, nbs_ob22_null('6510','17',l_branch), l_s );
              GL.PAY2( 2, c.ref, gl.bd );

            end if;

          end if;

        exception
          when OTHERS then
            rollback to SP_BEFORE;
            logger.error( $$PLSQL_UNIT||': помилка оплати REF='||to_char(c.REF)||chr(10)||sqlerrm );
        end;

      end if;

    end loop;

    commit;

    BARS_CONTEXT.SET_CONTEXT;

  end loop;

end P_JOB_KOMIS_NON_CASH;
/

show err;
