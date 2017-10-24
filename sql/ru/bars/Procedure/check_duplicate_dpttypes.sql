

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/CHECK_DUPLICATE_DPTTYPES.sql =====
PROMPT ===================================================================================== 


PROMPT *** Create  procedure CHECK_DUPLICATE_DPTTYPES ***

  CREATE OR REPLACE PROCEDURE BARS.CHECK_DUPLICATE_DPTTYPES 
  (p_vidd         in  dpt_vidd.vidd%type         ,
   p_typecod      in  dpt_vidd.type_cod%type     ,
   p_kv           in  dpt_vidd.kv%type           ,
   p_duration     in  dpt_vidd.duration%type     ,
   p_durationdays in  dpt_vidd.duration_days%type,
   p_termtype     in  dpt_vidd.term_type%type    ,
   p_bsd          in  dpt_vidd.bsd%type          ,
   p_bsn          in  dpt_vidd.bsn%type          ,
   p_bsa          in  dpt_vidd.bsa%type          ,
   p_minsumm      in  dpt_vidd.min_summ%type     ,
   p_limit        in  dpt_vidd.limit%type        ,
   p_maxlimit     in  dpt_vidd.max_limit%type    ,
   p_termadd      in  dpt_vidd.term_add%type     ,
   p_autoadd      in  dpt_vidd.auto_add%type     ,
   p_basey        in  dpt_vidd.basey%type        ,
   p_metr         in  dpt_vidd.metr%type         ,
   p_amrmetr      in  dpt_vidd.amr_metr%type     ,
   p_tipost       in  dpt_vidd.tip_ost%type      ,
   p_freqn        in  dpt_vidd.freq_n%type       ,
   p_freqk        in  dpt_vidd.freq_k%type       ,
   p_acc7         in  dpt_vidd.acc7%type         ,
   p_basem        in  dpt_vidd.basem%type        ,
   p_comproc      in  dpt_vidd.comproc%type      ,
   p_brid         in  dpt_vidd.br_id%type        ,
   p_bridl        in  dpt_vidd.br_id_l%type      ,
   p_brwd         in  dpt_vidd.br_wd%type        ,
   p_idstop       in  dpt_vidd.id_stop%type      ,
   p_fl2620       in  dpt_vidd.fl_2620%type      ,
   p_fldubl       in  dpt_vidd.fl_dubl%type      ,
   p_termdubl     in  dpt_vidd.term_dubl%type    ,
   p_extensionid  in  dpt_vidd.extension_id%type,
   p_messagetxt   out varchar2)
is
  l_messagetxt  varchar2(4000);
  l_messagedim  number := 4000;
begin
  for dupl in
     (select vidd, type_name name, flag
        from dpt_vidd
       where nvl(type_cod, '____') = nvl(p_typecod, '____')
         and kv                    = p_kv
         and duration              = p_duration
         and duration_days         = p_durationdays
         and term_type             = p_termtype
         and bsd                   = p_bsd
         and bsn                   = p_bsn
         and nvl(bsa,  '____')     = nvl(p_bsa,  '____')
         and nvl(min_summ,  0)     = nvl(p_minsumm,  0)
         and nvl(limit,     0)     = nvl(p_limit,    0)
         and nvl(max_limit, 0)     = nvl(p_maxlimit, 0)
         and nvl(term_add,  0)     = nvl(p_termadd,  0)
         and auto_add              = p_autoadd
         and basey                 = p_basey
         and metr                  = p_metr
         and amr_metr              = p_amrmetr
         and tip_ost               = p_tipost
         and freq_n                = p_freqn
         and freq_k                = p_freqk
         and acc7                  = p_acc7
         and basem                 = p_basem
         and comproc               = p_comproc
         and nvl(br_id,   0)       = nvl(p_brid,  0)
         and nvl(br_id_l, 0)       = nvl(p_bridl, 0)
         and nvl(br_wd,   0)       = nvl(p_brwd,  0)
         and id_stop               = p_idstop
         and fl_2620               = p_fl2620
         and fl_dubl               = p_fldubl
         and term_dubl             = p_termdubl
         and nvl(extension_id, 0)  = nvl(p_extensionid, 0)
         and (p_vidd is null or p_vidd != vidd)
       order by vidd)
  loop

    l_messagetxt := substr(l_messagetxt||chr(10)
                          ||'№ '||to_char(dupl.vidd)
                          ||' ('||
                          case when dupl.flag = 1 then 'акт.' else 'неакт.' end
                          ||')'
                          ||' <'||dupl.name||'>', 1, l_messagedim);

    if length(l_messagetxt) = l_messagedim then
       return;
    end if;

  end loop;

  p_messagetxt := l_messagetxt;

end;
/
show err;

PROMPT *** Create  grants  CHECK_DUPLICATE_DPTTYPES ***
grant EXECUTE                                                                on CHECK_DUPLICATE_DPTTYPES to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on CHECK_DUPLICATE_DPTTYPES to DPT_ADMIN;
grant EXECUTE                                                                on CHECK_DUPLICATE_DPTTYPES to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/CHECK_DUPLICATE_DPTTYPES.sql =====
PROMPT ===================================================================================== 
