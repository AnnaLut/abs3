 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/net_toss_utl.sql =========*** Run ***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.net_toss_utl is
  --------------------------------------------------
  --   пакет для обслуживания работы .net вертушек
  --


   -----------------------------------------------------------------
   --
   --    Константы
   --
   -----------------------------------------------------------------

   G_HEADER_VERSION  constant varchar2(64) := 'version 1.1 29.11.2018';
   G_MESS_ERROR      constant varchar2(64) := 'ERROR';
   G_MESS_INFO       constant varchar2(64) := 'INFO';
   -----------------------------------------------------------------
   --
   --    Голобальные переменные
   --
   -----------------------------------------------------------------

   G_TOSS_PHASE varchar2(10);

   -----------------------------------------------------------------
   -- HEADER_VERSION()
   --
   --     Функция возвращает строку с версией заголовка пакета
   --
   --
   --
   function header_version return varchar2;


   -----------------------------------------------------------------
   -- BODY_VERSION()
   --
   --     Функция возвращает строку с версией тела пакета
   --
   --
   --
   function body_version return varchar2;



   -----------------------------------------------------------------
   -- LOG_INFO ()
   --
   procedure log_info (p_mess varchar2);

   -----------------------------------------------------------------
   -- LOG_ERROR ()
   --
   procedure log_error (p_mess varchar2);


   -----------------------------------------------------------------
   -- INIT_TOSS_PHASE ()
   --
   --  
   procedure init_phase(p_phase varchar2);



end net_toss_utl;
/

show err;
 

 
 

CREATE OR REPLACE PACKAGE BODY BARS.net_toss_utl AS

  ---------------------------------------------------------
  --
  --  Пакет утилит для работы вертушки .net toss
  --
  ---------------------------------------------------------

  ----------------------------------------------
  --  константы
  ----------------------------------------------
  G_BODY_VERSION    constant varchar2(64) := 'version 1.1  28.11.2018';
  G_MODULE          constant char(3)      := 'TOS';    -- код модуля
  G_TRACE           constant varchar2(50) := 'net_toss_utl.';



   -----------------------------------------------------------------
   -- HEADER_VERSION()
   --
   --     Функция возвращает строку с версией заголовка пакета
   --
   --
   --
   function header_version return varchar2
   is
   begin
       return 'package header net_toss_utl: ' || G_HEADER_VERSION;
   end header_version;


   -----------------------------------------------------------------
   -- BODY_VERSION()
   --
   --     Функция возвращает строку с версией тела пакета
   --
   --
   --
   function body_version return varchar2
   is
   begin
       return 'package body net_toss_utl: ' || G_BODY_VERSION;
   end body_version;


   -----------------------------------------------------------------
   -- LOG_MESSGAE()
   --
   procedure log_message (p_mess varchar2, p_mess_type varchar2)
   is
      pragma autonomous_transaction;
   begin
      if G_TOSS_PHASE is null then 
        raise_application_error(-20001, 'Не инициализирована файза в net_toss_utl');
      end if;
      insert into net_toss_log(
         rec_id,     
         rec_date,   
         rec_bdate,   
         rec_type,   
         rec_message,
         rec_uname, 
         phase)
      values(s_nettosslog.nextval, 
             sysdate, 
             gl.bd,
             p_mess_type,  
             p_mess,
             nvl(sys_context('bars_global', 'user_name'), 'UNKNOWN'),  
             G_TOSS_PHASE);
       commit;
      
   end ;



   -----------------------------------------------------------------
   -- LOG_INFO ()
   --
   procedure log_info (p_mess varchar2) is
   begin
      log_message (p_mess, G_MESS_INFO);      
   end;

   -----------------------------------------------------------------
   -- LOG_INFO ()
   --
   procedure log_error (p_mess varchar2) is
   begin
      log_message (p_mess, G_MESS_ERROR);      
   end;


   -----------------------------------------------------------------
   -- INIT_TOSS_PHASE ()
   --
   --  
   procedure init_phase(p_phase varchar2)
   is
   begin
      G_TOSS_PHASE := p_phase;
   end;

end;
/

show err

grant EXECUTE                                                                on net_toss_utl         to  BARS_ACCESS_DEFROLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/package/net_toss_utl.sql =========*** End *** ===
PROMPT ===================================================================================== 



 