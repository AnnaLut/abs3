
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_sqlstatement_tech_accounts.sql ==
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_SQLSTATEMENT_TECH_ACCOUNTS (p_acc accounts.acc%type, p_kv accounts.kv%type, p_dat date) return clob
is 
   l_stmt clob;
   l_acc number :=23913501;
   l_accounts accounts%rowtype;
   l_sos_vx varchar2(30);
   l_sos_isx varchar2(30);
   l_sel clob;
   l_like clob;
   l_sab varchar2(30);
   l_s00 clob;
   l_s01 clob;
   l_mfo varchar2(10):=f_ourmfo;
   l_trace varchar2(1000) := 'sqlstmt_tech: ';
begin

bars_audit.info(l_trace||' отбор докмунетов для счета ='||p_acc||', вал.='||p_kv||', за дату '||to_date( p_dat,'dd/mm/yyyy' ));

select * into l_accounts from accounts where acc=p_acc;

if l_accounts.tip not in('L00', 'TUD', 'TUR', 'N00', 'N99', 'TNB') then 
 return l_stmt;
end if;

    if GetGlobalOption('NUMMODEL')='3' then
     
       -- ХЗ нашо, далі подивимося
        l_sel:='ARC_RRP.nd,   ARC_RRP.mfoa, ARC_RRP.mfob, ARC_RRP.nazn,
                ARC_RRP.sos,  ARC_RRP.rec,  ARC_RRP.ref , ARC_RRP.dk,  ARC_RRP.prty,
                ARC_RRP.fn_a, ARC_RRP.fn_b, ARC_RRP.dat_a,ARC_RRP.dat_b,   
                arc_rrp.nam_a, arc_rrp.nam_b, arc_rrp.nlsa, arc_rrp.nlsb, arc_rrp.s, arc_rrp.id_a, arc_rrp.id_b, ';
        if l_accounts.tip in('N00', 'N99', 'TNB') then 
            begin
                 SELECT sab into l_sab
                 FROM banks
                 WHERE mfo=l_mfo;
             exception when no_data_found then
                raise_application_error(-20000, 'Не знайдено електронну адресу для МФО '||l_mfo);    
             end;  
             
             if l_accounts.tip='N00' then
                    l_sos_vx:='>=3';
                    l_sos_isx:='> 3 ';
             elsif l_accounts.tip='N99' then
                    l_sos_vx:='< 3';
                    l_sos_isx:='';  
             elsif l_accounts.tip='TNB' then
                    l_sos_vx:='';
                    l_sos_isx:='=3';           
             end if; 
        elsif l_accounts.tip in('L00', 'TUD', 'TUR') then  
            begin   
             SELECT b.sab INTO l_sab from banks b, bank_acc a
                     where a.acc=p_acc and a.mfo=b.mfo;
             exception when no_data_found then
                 raise_application_error(-20000, 'Не знайдено електронну адресу банку');    
            end;    
            
            if l_accounts.tip='L00' then
                    l_sos_vx:='>=3';
                    l_sos_isx:='> 3 ';
             elsif l_accounts.tip in('TUD','TUR') then
                    l_sos_vx:='';
                    l_sos_isx:='=3';  
            end if;       

        end if;
        
       l_like:='__'||l_sab||'%';
    else
        if l_accounts.tip='T00' then
            l_s00:='(o.dk=arc_rrp.dk   AND o.txt=arc_rrp.fn_a AND arc_rrp.dat_a>=o.fdat AND arc_rrp.dat_a<o.fdat+1
                    OR o.dk=1-arc_rrp.dk AND o.txt=arc_rrp.fn_b AND arc_rrp.dat_b>=o.fdat AND arc_rrp.dat_b<o.fdat+1)';
            l_s01:='o.dk=arc_rrp.dk AND arc_rrp.dat_a>=o.fdat and arc_rrp.dat_a<o.fdat+1 AND o.txt=arc_rrp.fa_name)';        
        else
            l_s00:='(o.dk=1-arc_rrp.dk AND o.txt=arc_rrp.fn_a AND arc_rrp.dat_a>=o.fdat AND arc_rrp.dat_a<o.fdat+1
                    OR o.dk=arc_rrp.dk   AND o.txt=arc_rrp.fn_b AND arc_rrp.dat_b>=o.fdat AND arc_rrp.dat_b<o.fdat+1)';
            l_s01:='o.dk=1-arc_rrp.dk AND arc_rrp.dat_a>=o.fdat and arc_rrp.dat_a<o.fdat+1 AND o.txt=arc_rrp.fa_name)';         
        end if;    
             
                
    end if;
    
    
    if GetGlobalOption('NUMMODEL')='3' then 
        --Вхідні
         if l_accounts.tip in('N00','N99','L00') then
            --З НБУ файли і СТП
             if l_accounts.tip in('N00','N99') then
                l_stmt:=l_stmt||'SELECT decode(ARC_RRP.dk,0,ARC_RRP.s,0)/100 s0, decode(ARC_RRP.dk,1,ARC_RRP.s,0)/100 s1,'|| 
                         l_sel||' ARC_RRP.nlsB nls, ARC_RRP.nam_B nam';
             --з дирекції файли і СТП
             elsif l_accounts.tip='L00' then
                l_stmt:=l_stmt||'SELECT decode(ARC_RRP.dk,0,ARC_RRP.s,0)/100 s0,decode(ARC_RRP.dk,1,ARC_RRP.s,0)/100 s1,' ||
                         l_sel|| 'decode(ARC_RRP.mfob,'''||l_mfo||''',ARC_RRP.nlsB, ARC_RRP.nlsA) NLS,
                                    decode(ARC_RRP.mfob,'''||l_mfo||''',ARC_RRP.nam_B,ARC_RRP.nam_A) NAM'; 
             end if;
             
             l_stmt :=l_stmt||' FROM arc_rrp
                     WHERE ARC_RRP.fn_A like '''||l_like||''' and ARC_RRP.sos '|| l_sos_vx || '
                       and ARC_RRP.dat_A >= to_date('''||to_char(p_dat,'dd.mm.yyyy')||''',''dd.mm.yyyy'') and ARC_RRP.dat_A < to_date('''||to_char(p_dat+1,'dd.mm.yyyy')||''',''dd.mm.yyyy'')
                       and arc_rrp.s>0 and arc_rrp.dk<2 and arc_rrp.kv='||p_kv;
         
         end if;
         
         --Вихідні
         if l_accounts.tip in('N00','TNB','L00', 'TUR','TUD') then             
             if l_accounts.tip in('N00','L00') then
                l_stmt:=l_stmt||' UNION ALL ';
             end if;
             --на НБУ 
             if l_accounts.tip in('N00','TNB') then
                l_stmt:=l_stmt||'SELECT decode(ARC_RRP.dk,1,ARC_RRP.s,0)/100 s1, decode(ARC_RRP.dk,0,ARC_RRP.s,0)/100 s0,'||
                              l_sel||' ARC_RRP.nlsA nls, ARC_RRP.nam_A nam';  
             --на дирекцію                 
             elsif  l_accounts.tip in('L00','TUR','TUD') then 
                l_stmt:=l_stmt||'SELECT decode(ARC_RRP.dk,1,ARC_RRP.s,0)/100 s1, decode(ARC_RRP.dk,0,ARC_RRP.s,0)/100 s0,'||
                l_sel||'decode(ARC_RRP.mfoa,'''||l_mfo||''',ARC_RRP.nlsA, ARC_RRP.nlsB) NLS,
                        decode(ARC_RRP.mfoa,'''||l_mfo||''',ARC_RRP.nam_A,ARC_RRP.nam_B) NAM';                
             end if;
             
             l_stmt:=l_stmt||' FROM  arc_rrp
                            WHERE ARC_RRP.fn_B like '''||l_like||''' and ARC_RRP.sos'||l_sos_isx|| '
                              and ARC_RRP.dat_B >=to_date('''||to_char(p_dat,'dd.mm.yyyy')||''',''dd.mm.yyyy'') and ARC_RRP.dat_B < to_date('''||to_char(p_dat+1,'dd.mm.yyyy')||''',''dd.mm.yyyy'')
                              and arc_rrp.s>0 and arc_rrp.dk<2 and arc_rrp.kv='||p_kv;
             
         end if;     
        
        --l_stmt:=l_stmt||' ORDER BY 1 desc,2 desc';
        l_stmt:=l_stmt||' ';
         
     else
        l_stmt:=l_stmt||'
                        select distinct S1,S0,NLS,NAM,ND,MFOA,MFOB,NAZN,SOS,REC,REF,DATKA,DATKB,FN_A,FN_B,DK,PRTY, 
                               nam_a, nam_b, nlsa, nlsb , id_a, id_b
                        from (SELECT decode(o.dk,1,arc_rrp.s,0)/100 S1, 
                                     decode(o.dk,0,arc_rrp.s,0)/100 S0,
                                     decode('''||l_mfo||''',arc_rrp.mfoa,arc_rrp.nlsa, arc_rrp.mfob,arc_rrp.nlsb ,'''') NLS,
                                   decode('''||l_mfo||''',arc_rrp.mfoa,arc_rrp.nam_a,arc_rrp.mfob,arc_rrp.nam_b,'''') NAM,
                                   arc_rrp.ND, arc_rrp.MFOA, arc_rrp.MFOB, arc_rrp.NAZN, arc_rrp.SOS, arc_rrp.REC, t.REF, 
                                   za.datk DATKA, zb.datk DATKB, arc_rrp.FN_A, arc_rrp.FN_B, arc_rrp.DK, arc_rrp.PRTY,
                                    nam_a, nam_b, nlsa, nlsb, s,  id_a, id_b
                            FROM  opldok o, arc_rrp, t902 t, zag_a za, zag_b zb
                            WHERE (arc_rrp.blk is null or arc_rrp.blk>=0)
                              and arc_rrp.fn_a  = za.fn(+)  and arc_rrp.fn_b  = zb.fn(+)
                              and arc_rrp.dat_a = za.dat(+) and arc_rrp.dat_b = zb.dat(+)
                                  and arc_rrp.ref=t.ref(+) and arc_rrp.s>0 and arc_rrp.dk<2 and o.fdat=to_date('''||to_char(p_dat,'dd.mm.yyyy')||''',''dd.mm.yyyy'')
                                  and o.acc='||p_acc||' and '|| l_s00||'
                        UNION ALL
                        SELECT decode (o.dk,1,arc_rrp.s,0)/100 s1,decode(o.dk,0,arc_rrp.s,0)/100 s0,
                               decode('''||l_mfo||''',arc_rrp.mfoa,arc_rrp.nlsa, arc_rrp.mfob,arc_rrp.nlsb,'''') NLS,
                               decode('''||l_mfo||''',arc_rrp.mfoa,arc_rrp.nam_a,arc_rrp.mfob,arc_rrp.nam_b,'''') NAM,
                               arc_rrp.nd,arc_rrp.mfoa,
                               arc_rrp.mfob,arc_rrp.nazn,arc_rrp.sos,arc_rrp.rec,t.ref,za.datk,zb.datk,arc_rrp.fn_a,arc_rrp.fn_b,
                               arc_rrp.dk,arc_rrp.prty,
                               arc_rrp.nam_a, arc_rrp.nam_b, arc_rrp.nlsa, arc_rrp.nlsb, arc_rrp.s,
                               arc_rrp.id_a, arc_rrp.id_b
                        FROM  opldok o, arc_rrp, t902 t, zag_a za, zag_b zb
                        WHERE (arc_rrp.blk is null or arc_rrp.blk>=0)
                          and arc_rrp.fn_a  = za.fn(+)  and arc_rrp.fn_b  = zb.fn(+)
                          and arc_rrp.dat_a = za.dat(+) and arc_rrp.dat_b = zb.dat(+)
                              and arc_rrp.ref=t.ref(+)  and arc_rrp.s>0 and arc_rrp.dk<2  and o.fdat=to_date('''||to_char(p_dat,'dd.mm.yyyy')||''',''dd.mm.yyyy'')
                              and o.acc='||p_acc ||' and '||l_s01||' 
    ';
    end if;       
   
   l_stmt := 'select * from ( ' ||l_stmt || ')'; 
    bars_audit.info(l_trace||' запрос: '||l_stmt);

   return  l_stmt;
   
   
end f_sqlstatement_tech_accounts;
/
 show err;
 
PROMPT *** Create  grants  F_SQLSTATEMENT_TECH_ACCOUNTS ***
grant EXECUTE                                                                on F_SQLSTATEMENT_TECH_ACCOUNTS to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_sqlstatement_tech_accounts.sql ==
 PROMPT ===================================================================================== 
 