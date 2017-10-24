

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBIU_MF1.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBIU_MF1 ***

  CREATE OR REPLACE TRIGGER BARS.TBIU_MF1 
---DISABLE
before insert or update ON BARS.MF1 for each row
begin

  -- ����� ������
  if (inserting) or :new.id is null  then
     select s_mf1.nextval into :new.id  from dual;
  end if;

  -- ���������

  :new.kva  := nvl(:new.kva,980);
  :new.kvb  := :new.kva;
  :new.datd := gl.bdate;
  :new.nd   := to_char(:new.ref);
  ---:new.id   := :new.ref;
--logger.info('MAK -1 ' ||  :old.tt );

  if nvl(:new.dk, 1) <> 0 then
      -- ����������
     :new.s  :=  abs(:new.s_100 *100) ;
 --    :new.tt := nvl( :new.tt,'PS2');

     if :new.tt is null then
             if :new.mfob != f_ourmfo then
             :new.tt := 'PS2';
             else
             :new.tt := nvl( :new.tt,'PS1');
             end if;
     end if;

  else
       -- ���������
     :new.s  :=  -  abs(:new.s_100 *100) ;
 --    :new.tt :=  nvl( :new.tt,'514');

    if :new.tt is null then
                 if :new.mfob != f_ourmfo then
                 :new.tt :=  '514';
                 else
                 :new.tt := nvl( :new.tt,'PS1');
                 end if;
    end if;

  end if;

-- ��������� VOB
--:new.vob  := 6;

    if :new.vob is null then
                     begin
                        select vob
                          into :new.vob
                          from tts_vob
                         where tt=:new.tt
                           and rownum = 1
                         order by ord asc;
                         exception when NO_DATA_FOUND THEN :new.vob  := 6;
                   end;
    end if;





--logger.info('MAK -1 ' ||  :new.tt );

  If nvl(:new.s,0) = 0 or (inserting) then
     -- ��� �����, �� �������
     :new.sos :=5;
  else

     if :old.sos=0 and :new.sos=5 then
        -- ��� ��������� ����� ������ ( ���������� ��������, ���� ),
        -- ������ ��������� sos=5. ��� ���� ������ �� ���������� ����������
        null;
     else
        -- ��� ��������� � ���������������� ������� ��� ����������� ������
        -- ������ ������ ��������� ��� ������ ��� ������
       :new.sos :=0;
     end if;

  end if;

  -- ������ �������� �����-�
  begin
    select substr(a.nms,1,38), c.okpo into :new.NAM_A, :new.OKPOA
    from customer c, accounts a
    where a.kv = :new.kva and a.nls=:new.nlsa and a.rnk=c.rnk ;
  EXCEPTION WHEN NO_DATA_FOUND THEN  :new.nlsa:= null;
  end;

end;


/
ALTER TRIGGER BARS.TBIU_MF1 ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBIU_MF1.sql =========*** End *** ==
PROMPT ===================================================================================== 
