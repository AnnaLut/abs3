declare
  l_ir       bars.int_ratn.ir%type;
  l_baserate bars.br_tier_edit.rate%type;
  l_rate bars.int_ratn%rowtype;
  error_cnt  number;
  acc_cnt number;
  p_dat date := trunc(sysdate);
  last_chng_date date;
  l_err varchar2(200);
begin

  bc.go('/'); -- ������������ �� ����

  for rec in (select kf from mv_kf) loop
   bc.go(rec.kf);
 
   begin
     select nvl(max (chng_dat),p_dat)
     into last_chng_date
     from tmp_tier_dpt
     where kf = rec.kf;
   exception when no_data_found
     then last_chng_date := p_dat;
   end; 
  
   
     select count(*) 
     into acc_cnt
     from bars.accounts;
     
    for q in (select distinct br, kv from bars.Tmp_Tier_Dpt where kf = rec.kf) loop

      -- ������� ���������� ������� ���-�� ��������     
      -- ��������������, ���� ������ ��� ������ ���������� �����������
      --  delete from bars.br_tier_edit where br_id = q.br and kv = q.kv and bdate = last_chng_date;
                        
                        select nvl(min(rate),0)  -- �� ����� ������ ���������� �������� ����������� "�������" ������
                          into l_baserate
                          from bars.br_tier_edit be 
                         where br_id = q.br
                           and kv = q.kv
                           and bdate = (select max(bdate) from bars.br_tier_edit where br_id = be.br_id and kv = be.kv);
   
                       error_cnt := 0;

                       for i in (select * from bars.tmp_tier_dpt 
                                 where br = q.br and kv = q.kv 
                                 and kf = rec.kf 
                                 and nvl(trim(note),'-') <> 'OK') loop
                            
                             -- ��������������, ���� ������ ��� ������ ���������� �����������
                             --delete from bars.int_ratn where acc = i.acc and bdat = last_chng_date+1 and id = 1;
                             
                             if acc_cnt = 0 then --#1
                                update bars.Tmp_Tier_Dpt x
                                        set x.chng_dat = null,
                                            x.base_rate = null,
                                            x.count_ir = null,
                                            x.new_ir = null,
                                            x.note = '��� KF = '||rec.kf||' ��� ������� � ������� accounts'
                                        where x.deposit_id = i.deposit_id
                                          and x.acc = i.acc
                                          and x.kf = i.kf; 
                                
                                else  --#1
                                      l_ir := acrn.fproc(i.acc, p_dat); -- ���������� ������� "�����" (IR + ����� �� �����)
                                       
                                     if l_ir = 0 and l_baserate > 0 then --#2
                                        
                                        update bars.Tmp_Tier_Dpt x
                                        set x.chng_dat = p_dat,
                                            x.base_rate = l_baserate,
                                            x.count_ir = 0,
                                            x.new_ir = null,
                                            x.note = '������������ ����� = 0, � ����������� ����� �� ������ '||to_char(q.br)||' ����� '||to_char(l_baserate)
                                        where x.deposit_id = i.deposit_id
                                          and x.acc = i.acc
                                          and x.kf = i.kf; 
                                          
                                     else  --#2
           
                                        -- ������� ����� ������ � ������, ��� ����� = IR + ����� �� ����� - ���.�������� ������� ������
                                       begin
                                       
                                       INSERT into bars.int_ratn (acc, id, bdat, ir, br, op) 
                                        VALUES (i.acc, 1, p_dat + 1, l_ir - l_baserate, q.br, 1);
                                        
                                        update bars.Tmp_Tier_Dpt x
                                        set x.base_rate = l_baserate,
                                            x.count_ir = l_ir,
                                            x.new_ir = l_ir - l_baserate,
                                            x.chng_dat = p_dat,
                                            x.note = 'OK'
                                        where x.deposit_id = i.deposit_id
                                          and x.acc = i.acc
                                          and x.kf = i.kf;    
                                    
                                       exception  when dup_val_on_index then
                                        
                                        UPDATE bars.int_ratn 
                                              SET ir = l_ir - l_baserate,
                                                  op = 1
                                        WHERE acc = i.acc and bdat = p_dat + 1 and id = 1;
                                        
                                        update bars.Tmp_Tier_Dpt x
                                        set x.base_rate = l_baserate,
                                            x.count_ir = l_ir,
                                            x.new_ir = l_ir - l_baserate,
                                            x.chng_dat = p_dat,
                                            x.note = 'OK'
                                        where x.deposit_id = i.deposit_id
                                          and x.acc = i.acc
                                          and x.kf = i.kf;
                                            
                                       when others then
                                            bars_audit.error('COBUSUPABS-6487: ������ ��������� ���������� �������� ��������  dpt_id = '||
                                            to_char(i.deposit_id)||' acc = '||to_char(i.acc)||' ir = '||to_char(l_ir)||' dat = '||to_char(p_dat,'DD/MM/YYYY'));     
                                            error_cnt := error_cnt + 1;
                                            
                                            l_err := substr(sqlerrm, 1,190);

                                            update bars.Tmp_Tier_Dpt x
                                            set x.base_rate = l_baserate,
                                            x.count_ir = l_ir,
                                            x.new_ir = l_ir - l_baserate,
                                            x.note = l_err
                                            where x.deposit_id = i.deposit_id
                                             and x.acc = i.acc
                                             and x.kf = i.kf;
                                       end;
                                       end if; --#2
                                    end if; --#1
                            end loop;  -- ��������� ������������ �������� �� ���������� ������ � ������
                            
                            if error_cnt > 500 then
                              bars_error.raise_nerror( 'DPT', 'GENERAL_ERROR_CODE', '������ � ������ ������� (����� 500 ������ ��� ��������� ���������)',
                              ' br_id = '||to_char(q.br), 'kv = '||to_char(q.kv), ' kf = '||to_char(rec.kf), ' date = '||to_char(p_dat,'DD/MM/YYYY'));
                            end if;  
                            
                            -- ��������� �������� ����������� ������ - ������������� ������� ��� ���� ����
                            begin
                             insert into bars.br_tier_edit (br_id, bdate, kv, s, rate) 
                              select be.br_id, p_dat + 1, be.kv, be.s, l_baserate
                              from br_tier_edit be where br_id = q.br and kv = q.kv
                              and bdate = (select max(bdate) from br_tier_edit where br_id = q.br and kv = q.kv);
                            exception
                             when dup_val_on_index then
                               update bars.br_tier_edit 
                               set rate = l_baserate
                               where bdate = p_dat + 1
                                 and kv = q.kv
                                 and br_id = q.br;
                              when others then
                                bars_audit.error('COBUSUPABS-6487: ������ ��������� ������ br_id = '||
                                to_char(q.br)||' kv = '||to_char(q.kv)||' kf = '||to_char(rec.kf)||' date = '||to_char(p_dat,'DD/MM/YYYY')); 
                             end;               
                              
                            commit;
    end loop; -- ��������� ������������ ����������� ������ � �������
  
  end loop;
  bc.home;

end;
/
