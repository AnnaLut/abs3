CREATE OR REPLACE PACKAGE BODY BARS.BRATES_UTL
 as
l_br_type brates.br_type%type;
l_br_id number;
procedure add_rates(p_br_id number, p_bdate date, p_kv number, p_s number, p_rate number)  as
    begin
     
     l_br_id :=to_number(pul.Get_Mas_Ini_VAL('BR_ID'));
     
         select br_type
            into l_br_type
         from brates where br_id=l_br_id;

      if p_bdate<gl.bd then
        bars_error.raise_nerror( 'BRS', 'GENERAL_ERROR_CODE', '���������� �������� ²�������� ������ � ����� ������ �� ���ʲ�����!' );
      end if;  

      if  l_br_type in (2, 3, 5, 6, 7)  then  --   ����������� ���������� ������
            begin
              insert into br_tier_edit(  br_id,   bdate,    kv,   rate,   s, branch)
              values                  (l_br_id, p_bdate , p_kv, p_rate, p_s, '/'||f_ourmfo||'/') ;
            exception when dup_val_on_index then  bars_error.raise_nerror( 'BRS', 'GENERAL_ERROR_CODE', '���� ²�������� ������ ��� ���Ӫ!' );
            end;

      else

       if p_s is null or p_s=0 then
            begin                                    --  ���������� ���������� ������
              insert into br_normal_edit(  br_id,   bdate,    kv,   rate,     branch)
              values                    (l_br_id, p_bdate , p_kv, p_rate, '/'||f_ourmfo||'/') ;
            exception when dup_val_on_index then  bars_error.raise_nerror( 'BRS', 'GENERAL_ERROR_CODE', '���� ²�������� ������ ��� ���Ӫ!' );
            end;
       else
         bars_error.raise_nerror( 'BRS', 'GENERAL_ERROR_CODE', '��� "�����ί ²�������ί ������" �������� ���� ²������!' );
       end if;  

        end if;

    end;

procedure upd_rates(p_br_id number, p_bdate date, p_kv number, p_s number, p_rate number) as
    begin

        if p_bdate>=gl.bd then
                select br_type
                   into l_br_type
                from brates where br_id=p_br_id;

                if l_br_type in (2, 3, 5, 6, 7)  then  --   ����������� ���������� ������

                      update br_tier_edit
                           set RATE = p_rate
                         where BR_ID = p_br_id
                           and BDATE = p_bdate
                           and KV    = p_kv
                           and S     = p_s
                           and nvl(substr(branch, 2,6), f_ourmfo)=f_ourmfo;

                else
                                                        --  ���������� ���������� ������
                      update br_normal_edit
                           set RATE = p_rate
                         where BR_ID = p_br_id
                           and BDATE = p_bdate
                           and KV    = p_kv
                           and nvl(substr(branch, 2,6), f_ourmfo)=f_ourmfo;

                end if;

        else  bars_error.raise_nerror( 'BRS', 'GENERAL_ERROR_CODE', '���������� �̲������ ²�������� ������ � ����� ������ �� ���ʲ�����!!' );

        end if;

    end;

procedure del_rates(p_br_id number, p_bdate date, p_kv number, p_s number, p_rate number) as
    begin

       if  p_bdate>=gl.bd then

                select br_type
                  into l_br_type
                 from brates where br_id=p_br_id;

            if l_br_type in (2, 3, 5, 6, 7)  then  --   ����������� ���������� ������

                delete from br_tier_edit
                       where BR_ID = p_br_id
                       and BDATE = p_bdate
                       and KV    = p_kv
                       and rate     = p_rate
                       and S     = p_s
                       and nvl(substr(branch, 2,6), f_ourmfo)=f_ourmfo;

            else
                                                    --  ���������� ���������� ������
                delete from br_normal_edit
                       where BR_ID = p_br_id
                       and BDATE = p_bdate
                       and rate    = p_rate
                       and KV    = p_kv
                       and nvl(substr(branch, 2,6), f_ourmfo)=f_ourmfo;

            end if;

       else  bars_error.raise_nerror( 'BRS', 'GENERAL_ERROR_CODE', '���������� �������� ²�������� ������ � ����� ������ �� ���ʲ�����!!' );

       end if;

    end;

end BRATES_UTL;
/

grant execute on bars.brates_utl to bars_access_defrole;