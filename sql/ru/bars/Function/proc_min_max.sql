---========================================================================================

CREATE OR REPLACE FUNCTION BARS.PROC_MIN_MAX
                 ( 
                   S      NUMERIC,    -- ����� ��������  (� ���)
                   PR     NUMBER ,    -- % �� �����
                   S_MIN  NUMBER,     -- �� ����� ��    (� ���.KO� )
                   S_MAX  NUMBER      -- �� ����� ��    (� ���.KO� )
                 )       
----------------------------------------------------------------------------------------
--
--     ������� ���������� % (PR) �� ����� (S) � ������ ����������� S_MIN � S_MAX  
--                           
--  ��� �������� 470,471,472:   PR, S_MIN, S_MAX  - �������� � ������ ��� ���.��������� ��������
----------------------------------------------------------------------------------------

RETURN NUMERIC IS           
  sk_       NUMERIC ;   --  C���� ��������  (� ���)
BEGIN

  sk_ := round(S*PR/100, 0) ;

  if S_MIN > 0  and  sk_ < S_MIN*100 then 
     sk_ := S_MIN*100 ;
  end if;

  if S_MAX > 0  and  sk_ > S_MAX*100 then 
     sk_ := S_MAX*100 ;
  end if;

  RETURN sk_ ;   
          
END PROC_MIN_MAX;
/

grant execute on PROC_MIN_MAX to START1;

