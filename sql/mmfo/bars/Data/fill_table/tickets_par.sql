update tickets_par p
   set p.txt = 'SELECT decode(t.fli,1,o2.nlsb,
         decode(o.tt,''901'',o2.nlsb,
           decode(o.tt,''PK7'',o2.nlsb,
             decode(o.tt,''PKR'',o2.nlsb,
               decode(o.tt,''PKX'',o2.nlsb,
                 decode(o.tt,''PKS'',o2.nlsb,
                   decode(o.tt,''PKA'',o2.nlsb,a.nls)))))))
  from opldok o, accounts a, oper o2, tts t
 where o.ref=:nRecID
   and a.acc=o.acc
   and o.ref=o2.ref
   and o.dk=1
   and o.tt=t.tt
   and (o.tt in (''8K2'',''8K3'',''8K7'',''8K8'',
                 ''ALK'',
                 ''DU%'',
                 ''FX7'',''FX8'',''FXM'',''FXP'',
                 ''K27'',
                 ''MB1'',''MBO'',
                 ''NM1'',
                 ''OW3'')
        or
        o.tt in (select tt from tts_vob where vob=6)
       )
   and o.tt not in (''015'',''101'',''445'',''KK1'',''PO3'',''ELT'',''I00'',''G02'')'
 where p.par = 'U_ALK_NLSK'
   and p.rep_prefix = 'DEFAULT';

update tickets_par p
   set p.txt = 'SELECT a.NLS 
  from opldok o,accounts a 
 where ref=:nRecID  
   and a.acc=o.acc 
   and o.dk=1 
   and tt in (''015'',
              ''101'',
              ''445'',
              ''DPJ'',
              ''ELT'',
              ''KK1'',
              ''G02'')'
 where p.par = 'U_015_tts'
   and p.rep_prefix = 'DEFAULT';
   commit;
/
