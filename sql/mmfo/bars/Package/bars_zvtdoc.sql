
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/bars_zvtdoc.sql =========*** Run ***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.BARS_ZVTDOC 
is
    -----------------------------------------------------------------
    --                                                             --
    --         Работа кассы (для Ощадбанка)                        --
    --                                                             --
    -----------------------------------------------------------------


    -----------------------------------------------------------------
    -- Константы                                                   --
    -----------------------------------------------------------------

    VERSION_HEAD      constant varchar2(64)  := 'version 1.0  25/04/2016';

    -----------------------------------------------------------------
    -- Переменные
    -----------------------------------------------------------------


    ------------------------------------------------------------------
    -- HEADER_VERSION
    --
    --
    --
    function header_version return varchar2;



    ------------------------------------------------------------------
    -- BODY_VERSION
    --
    --
    --
    function body_version return varchar2;


    ------------------------------------------------------------------
    -- GET_PARTITION_DATE
    --
    --  Получить дату партиции для таблицы PART_ZVT_DOC
    --
    function get_partition_date(p_part_name varchar2) return date;

    ------------------------------------------------------------------
    -- PURGE_TABLE
    --
    --  Очистка накопительной таблицы для отчета до указанной даты
    --
    procedure purge_table(p_date date);

    ------------------------------------------------------------------
    -- NEST_REPORT_TABLE
    --
    --  Население накопительной таблицы для выполнения отчета
    --
    procedure nest_report_table (p_date date);

	------------------------------------------------------------------
    -- PURGE_ZVT_TABLE_FOR_DATE
    --
    --  Очистка накопительной таблицы для отчета за указанную дату
    --
    procedure purge_table_for_date(p_date date);

    ------------------------------------------------------------------
    -- NEST_REPORT_TABLE_FOR_ALL
    --
    --  Население накопительной таблицы для выполнения отчета для всех МФО на кол-во дней назад относительно банковской даты
    --
    procedure nest_report_table_for_all (p_days_before number);



end bars_zvtdoc;
/
CREATE OR REPLACE PACKAGE BODY BARS.BARS_ZVTDOC 
is
    -----------------------------------------------------------------
    --                                                             --
    --         Свод документов дня                                 --
    -- 04.12.2017 Сухова - добавлено население виртуальніми оборотами по переходу на форі йплан счетов
    -- В будущем желательно убрать. чтобы не делать лишний поиск ,                                    
    -----------------------------------------------------------------


    -----------------------------------------------------------------
    -- Константы                                                   --
    -----------------------------------------------------------------

    VERSION_BODY      constant varchar2(64)  := 'version 1.0  25/04/2016';
    G_TRACE           constant varchar2(64)  := 'bars_zvtdoc.';
    G_MODULE          constant varchar2(64)  := 'ZVT';
	G_DATA_INTERVAL   constant number        := 10;  -- время удержания данных накопительной таблице вколличестве дней

    -----------------------------------------------------------------
    -- Переменные
    -----------------------------------------------------------------


    ------------------------------------------------------------------
    -- HEADER_VERSION
    --
    --
    --
    function header_version return varchar2 is
    begin
       return 'Package header bars_zvtdoc: '||VERSION_HEAD;
    end header_version;




    ------------------------------------------------------------------
    -- BODY_VERSION
    --
    --
    --
    function body_version return varchar2 is
    begin
       return 'Package body bars_zvtdoc: '||VERSION_BODY;
    end body_version;




    ------------------------------------------------------------------
    -- GET_PARTITION_DATE
    --
    --  Получить дату партиции для таблицы PART_ZVT_DOC
    --
    function get_partition_date(p_part_name varchar2) return date
    is
      l_chr varchar2(500);
    begin
       select high_value into l_chr from user_tab_partitions where table_name = 'PART_ZVT_DOC' and partition_name =  p_part_name;
       return  to_date( substr(l_chr,11,10), 'yyyy-mm-dd');
    exception when no_data_found then return null;
    end;

	------------------------------------------------------------------
    -- DROP_PARTITION
    --
    --  Удаленеи партиции накопительной таблицы
    --
    procedure drop_partition(p_partition_name varchar2, p_date date)
	is
	    PART_NOT_EXISTS exception;
        pragma exception_init(PART_NOT_EXISTS, -2149);

        RESOURCE_BUSY exception;
        pragma exception_init(RESOURCE_BUSY, -54 );

        CANT_DROP_LAST_PART exception;
        pragma exception_init(CANT_DROP_LAST_PART, -14758 );

        l_trace      varchar2(100) := g_trace||'drop_partition: ';
	begin
	   execute immediate  'alter table part_zvt_doc drop partition '||p_partition_name;
			 bars_audit.info(l_trace||'партиция '|| p_partition_name ||' за дату '|| to_char(p_date,'dd/mm/yyyy') ||' удалена' );
          exception when CANT_DROP_LAST_PART then null;
                    when PART_NOT_EXISTS     then null;
                    when RESOURCE_BUSY       then null;
	end;


	------------------------------------------------------------------
    -- PURGE_TABLE_FOR_DATE
    --
    --  Очистка накопительной таблицы для отчета за указанную дату
    --
    procedure purge_table_for_date(p_date date)
	is
	   l_trace      varchar2(100) := g_trace||'purge_table_for_date: ';
	   l_partname   varchar2(100);
	begin
	   select partition_name
	     into l_partname
      	 from user_tab_partitions
		where table_name = 'PART_ZVT_DOC'
	      and bars_zvtdoc.get_partition_date(partition_name) =  p_date;
	   drop_partition (l_partname, p_date);
    exception when no_data_found then null;
	end;


	------------------------------------------------------------------
    -- PURGE_TABLE
    --
    --  Очистка накопительной таблицы для отчета до указанной даты
    --
    procedure purge_table(p_date date)
    is
        l_trace varchar2(100) := g_trace||'purge_table: ';
    begin
       bars_audit.info(l_trace||'старт выполнения' );
       for c in (select partition_name, bars_zvtdoc.get_partition_date(partition_name) part_date
      	           from user_tab_partitions
				  where table_name = 'PART_ZVT_DOC'
				    and bars_zvtdoc.get_partition_date(partition_name) <  p_date
			    ) loop
		     drop_partition (c.partition_name, c.part_date);
      end loop;

    end;


    ------------------------------------------------------------------
    -- NEST_REPORT_TABLE
    --
    --  Население накопительной таблицы для выполнения отчета на дату
    --
    procedure nest_report_table (p_date date)
    is
        p_fdat         date    ;
        s_fdat         char(10);
        nls_           accounts.nls%type;
        sleep_timeout  constant number := 2;
        l_isclear      boolean;
        l_trace        varchar2(100) := g_trace||'nest_report_table: ';


    begin

        bars_audit.info(l_trace||' старт сбора данных для свода дня для: '|| to_char (p_date,'dd.mm.yyyy')|| ' для '||sys_context('bars_context','user_mfo'));

        if sys_context('bars_context','user_branch') not like '/______/' then
           BARS_ERROR.RAISE_NERROR(G_MODULE, 'ONLY_ON_MFO_LEVEL');
        end if;

        if p_date is null then return; end if;


        p_fdat := nvl( p_date, gl.bd);
        s_fdat := to_char (p_fdat,'dd.mm.yyyy');


        execute immediate 'truncate table Tmp_zvt ';

        -- наполнить врем табл
        insert into tmp_zvt (ref,stmt,dk,s,sq,accd,acck, tt)
        select ref,stmt,dk,s,sq,decode( dk,0,acc,null), decode(dk,1,acc, null) , tt
          from opldok
		 where sos >= 4  and fdat = p_fdat ;

        -- развернуть врем табл
        update Tmp_zvt t
          set t.acck=(select acck from Tmp_zvt where dk=1 and ref=t.ref and stmt=t.stmt)
        where dk = 0 ;

        delete from Tmp_zvt where dk=1 ;

        commit;

        -- сбор статистики
        --dbms_stats.gather_table_stats('bars', 'Tmp_zvt');

          DELETE FROM part_zvt_doc WHERE FDAT = p_fdat AND KF = sys_context('bars_context','user_mfo');

        -- наполнение проводок отч.даты для других реальн. экв из проводки
        insert into part_zvt_doc (fdat,isp,kv,tt,ref,stmt,nlsd,nlsk,branch,tema,sq,s, kf)
        select p_fdat, p.userid, ad.kv, o.tt, p.ref, o.stmt, ad.nls nlsd, ak.nls nlsk,
             zvt_b(nvl(ad.nbs,substr(ad.nls,1,4)),nvl(ak.nbs,substr(ak.nls,1,4)),ad.branch,ak.branch,p.branch ) branch,
             zvt_f(nvl(ad.nbs,substr(ad.nls,1,4)),nvl(ak.nbs,substr(ak.nls,1,4)),ad.branch,ak.branch,o.tt,p.mfoa,p.mfob,p.tt) tema,
             o.SQ,
             o.S*sign(ZVT_F(nvl(ad.nbs,substr(ad.nls,1,4)),nvl(ak.NBS,substr(ak.nls,1,4)),ad.branch,ak.branch,o.tt,p.MFOA,p.MFOB,p.TT)) S,
			 sys_context('bars_context','user_mfo')
        from tmp_zvt o,
             oper p,
             (select a.nbs, a.acc,a.kv,a.nls,a.branch from accounts a, saldoa s
               where  a.acc=s.acc and s.fdat=p_fdat and s.dos >0) ad,
             (select a.nbs,a.acc,a.kv,a.nls,a.branch from accounts a, saldoa s
               where  a.acc=s.acc and s.fdat=p_fdat and s.kos >0) ak
        where o.ref  = p.ref
          and o.accd = ad.acc
          and o.acck = ak.acc
          and ( ad.nbs not like '8%' or ak.nbs not like '8%');

        update part_zvt_doc set branch = substr(branch,1,8) where abs(tema) = 14 and fdat = p_fdat;


        for k in ( select kv,nlsd,nlsk, rowid ri
                     from part_zvt_doc
                    where fdat = p_fdat
                      and ( nlsd like '86%' and nlsk not like '8%' or
                            nlsk like '86%' and nlsd not like '8%'
                          )
                  ) loop
            begin

                If k.nlsd like '86%' then

                    select rod.nls
                    into nls_
                    from accounts rod, accounts doc
                    where doc.kv = k.kv and doc.nls = k.nlsd and doc.accc = rod.acc;

                    update PART_ZVT_DOC set nlsd = nls_ where rowid = k.RI;

                else
                    select rod.nls into nls_
                    from accounts rod, accounts doc
                    where doc.kv = k.kv and doc.nls = k.nlsk and doc.accc = rod.acc;

                    update PART_ZVT_DOC set nlsk = nls_ where rowid = k.RI;
                end if;

            exception when no_data_found then null;
            end;
        end loop;

        -- В будущем желательно убрать. чтобы не делать лишний поиск
        insert into part_zvt_doc (fdat, isp, kv, tt, ref, stmt, nlsd,nlsk,branch,tema,sq,s, kf)
        select dat_alt, isp, kv, '024', -1,  0, decode (zn,1,nlsalt,nls),  decode(zn,1,nls,nlsalt), branch, 80, gl.p_icurval(kv,vx,p_FDAT), vx, kf
        from (select dat_alt, isp, kv, ABS(fost(acc,(p_FDAT-1))) vx, sign(fost(acc,(p_FDAT-1))) zn,  nls, nlsalt, branch, kf
              from accounts where nlsalt is not null and dat_alt = p_FDAT and fost(acc,(p_FDAT-1)) <>0 
              );

    end;


    ------------------------------------------------------------------
    -- NEST_REPORT_TABLE_FOR_ALL
    --
    --  Население накопительной таблицы для выполнения отчета для всех МФО на кол-во дней назад относительно банковской даты
    --
    procedure nest_report_table_for_all (p_days_before number)
    is
       l_bankdate date;
       l_curr_branch branch.branch%type;
    begin
        l_curr_branch := sys_context('bars_context','user_branch');

        select max(fdat) into l_bankdate
        from ( select fdat, row_number() over (order by fdat desc) n
                from fdat
               where fdat <= ( select max(fdat) from fdat
                                where fdat < trunc(sysdate)
                             )
             ) fd
        where n = p_days_before;
  
         purge_table_for_date(l_bankdate);     
          
        for c in (select kf from mv_kf) loop
           bc.go('/'||c.kf||'/');
           nest_report_table( l_bankdate );
        end loop;

        bc.go(l_curr_branch);

    end;



end bars_zvtdoc;
/
 show err;
 
PROMPT *** Create  grants  BARS_ZVTDOC ***
grant EXECUTE                                                                on BARS_ZVTDOC     to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on BARS_ZVTDOC     to RPBN001;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/bars_zvtdoc.sql =========*** End ***
 PROMPT ===================================================================================== 
 