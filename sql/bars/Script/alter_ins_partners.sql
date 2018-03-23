declare
begin
  for i in (select t.id, ins_nls.*
              from ins_partners t
              join customer c
                on t.rnk = c.rnk
              join (select trim(' 265053011509 ') nls,
                          trim('  33908322  ') okpo, trim(' 300465  ') mfo
                     from dual
                   union
                   select trim(' 265053011596  ') nls,
                          trim('  20474912  ') okpo, trim(' 300465  ') mfo
                     from dual
                   union
                   select trim(' 265003011591  ') nls,
                          trim('  35529829  ') okpo, trim(' 300465  ') mfo
                     from dual
                   union
                   select trim(' 265033011590  ') nls,
                          trim('  20344871  ') okpo, trim(' 300465  ') mfo
                     from dual
                   union
                   select trim(' 265063011586  ') nls,
                          trim('  35429675  ') okpo, trim(' 300465  ') mfo
                     from dual
                   union
                   select trim(' 265073011592  ') nls,
                          trim('  36086124  ') okpo, trim(' 300465  ') mfo
                     from dual
                   union
                   select trim(' 265093011611  ') nls,
                          trim('  32310874  ') okpo, trim(' 300465  ') mfo
                     from dual
                   union
                   select trim(' 265013011662  ') nls,
                          trim('  34538696  ') okpo, trim(' 300465  ') mfo
                     from dual
                   union
                   select trim(' 26503301873 ') nls,
                          trim('  20842474  ') okpo, trim(' 300465  ') mfo
                     from dual
                   union
                   select trim(' 265003011588  ') nls,
                          trim('  13622789  ') okpo, trim(' 300465  ') mfo
                     from dual
                   union
                   select trim(' 265073011615  ') nls,
                          trim('  20782312  ') okpo, trim(' 300465  ') mfo
                     from dual
                   union
                   select trim(' 265023051146  ') nls,
                          trim('  24745673  ') okpo, trim(' 300465  ') mfo
                     from dual
                   union
                   select trim(' 26500100001839  ') nls,
                          trim('  35417298  ') okpo, trim(' 300465  ') mfo
                     from dual
                   union
                   select trim(' 265033021069  ') nls,
                          trim('  20113829  ') okpo, trim(' 300465  ') mfo
                     from dual
                   union
                   select trim(' 265013011604  ') nls,
                          trim('  20033533  ') okpo, trim(' 300465  ') mfo
                     from dual
                   union
                   select trim(' 26502301829 ') nls,
                          trim('  20602681  ') okpo, trim(' 300465  ') mfo
                     from dual
                   union
                   select trim(' 265043011603  ') nls,
                          trim('  30859524  ') okpo, trim(' 300465  ') mfo
                     from dual
                   union
                   select trim(' 265043011593  ') nls,
                          trim('  22229921  ') okpo, trim(' 300465  ') mfo
                     from dual
                   union
                   select trim(' 265073031718  ') nls,
                          trim('  21870998  ') okpo, trim(' 300465  ') mfo
                     from dual
                   union
                   select trim(' 265033011723  ') nls,
                          trim('  32109907  ') okpo, trim(' 300465  ') mfo
                     from dual
                   union
                   select trim(' 265083021608  ') nls,
                          trim('  31650052  ') okpo, trim(' 300465  ') mfo
                     from dual
                   union
                   select trim(' 265013011141  ') nls,
                          trim('  24175269  ') okpo, trim(' 300465  ') mfo
                     from dual
                   union
                   select trim(' 265093011585  ') nls,
                          trim('  32404600  ') okpo, trim(' 300465  ') mfo
                     from dual
                   union
                   select trim(' 26507100001133  ') nls,
                          trim('  30115243  ') okpo, trim(' 300465  ') mfo
                     from dual) ins_nls
                on c.okpo = ins_nls.okpo)
  loop
    update ins_partners t
       set t.nls = i.nls,
           t.mfo = i.mfo
     where t.id = i.id;
  end loop;
end;
/
commit;
/
