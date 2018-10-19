
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/pkg_escr_reg_utl.sql =========*** Ru
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.PKG_ESCR_REG_UTL IS
  c_branch VARCHAR2(4000) := sys_context(bars_context.context_ctx,
                                         bars_context.ctxpar_userbranch);
  /**********************************************
    FUNCTION header_version
    DESCRIPTION: повертає версіяю специфікації пакету
  *********************************************/
  FUNCTION header_version RETURN VARCHAR2;
  /**********************************************
    FUNCTION body_version
   DESCRIPTION: повертає версіяю тіла пакету
  *********************************************/
  FUNCTION body_version RETURN VARCHAR2;

  /**********************************************
     PROCEDURE : p_reg_create
     DESCRIPTION: створення реєстру
  *********************************************/
  PROCEDURE p_reg_create(in_date_from escr_register.date_from%TYPE,
                         in_date_to   escr_register.date_to%TYPE,
                         in_reg_type  escr_reg_types.code%TYPE,
                         in_reg_kind  escr_reg_kind.code%TYPE,
                         in_reg_level escr_register.reg_level%TYPE,
                         in_oper_type escr_reg_mapping.oper_type%TYPE default 1,
                         in_obj_list  number_list,
                         out_reg_id   IN OUT escr_register.id%TYPE);
  /************************************************************
     PROCEDURE   p_mapping
     DESCRIPTION: додає зв*язки між об*єктами реєстру
  **************************************************************/
  PROCEDURE p_mapping(in_in_doc_id    escr_reg_mapping.in_doc_id%TYPE,
                      in_in_doc_type  escr_reg_mapping.in_doc_type%TYPE,
                      in_out_doc_id   number_list,
                      in_out_doc_type escr_reg_mapping.out_doc_type%TYPE,
                      in_oper_type    escr_reg_mapping.oper_type %TYPE,
                      in_oper_date    DATE DEFAULT SYSDATE);
  /***************************************************************
     PROCEDURE   p_get_status_ID
     DESCRIPTION: ПО  КОДУ СТАТУСУ ОТРИМУЄМО ЙОГО ID
  **************************************************************/
  PROCEDURE p_get_status_id(in_status_code escr_reg_status.code%TYPE,
                            out_status_id  OUT escr_reg_status.id%TYPE

                            );
  /***************************************************************
     PROCEDURE   p_get_status_ID
     DESCRIPTION: ПО  ID СТАТУСУ ОТРИМУЄМО ЙОГО CODE
  **************************************************************/
  PROCEDURE p_get_status_code(in_status_id    escr_reg_status.id%TYPE,
                              out_status_code OUT escr_reg_status.code%TYPE

                              );
  /***************************************************************
     PROCEDURE   p_get_status_name
     DESCRIPTION: ПО  КОДУ СТАТУСУ ОТРИМУЄМО ЙОГО ІМ`Я
  **************************************************************/
  PROCEDURE p_get_status_name(in_status_code  escr_reg_status.code%TYPE,
                              out_status_name OUT escr_reg_status.name%TYPE

                              );
  /**********************************************
     PROCEDURE   P_SET_REG_OUT_NUMBER
     DESCRIPTION: ВСТАНОВЛЮЄ ЗОВНІШНІЙ НОМЕР РЕЄСТРА
  *********************************************/
  PROCEDURE p_set_reg_out_number(in_reg_id     escr_register.id%TYPE,
                                 in_out_number escr_register.outer_number%TYPE DEFAULT NULL);
  /**********************************************
     PROCEDURE P_SET_CREDIT_STATUS
     DESCRIPTION: ВСТАНОВЛЮЄ СТАТУС КРЕДИТНОГО ДОГОВОРУ В nd_txt
  *********************************************/
  PROCEDURE p_set_credit_status(in_obj_id         IN escr_reg_obj_state.obj_id%TYPE,
                                in_status_code    IN escr_reg_status.code%TYPE,
                                in_status_comment IN escr_reg_obj_state.status_comment%TYPE DEFAULT NULL,
                                in_set_date       IN DATE);
  /**********************************************
     PROCEDURE P_get_reg_deals
     DESCRIPTION: повертає колекцію кредитів, які включені в реєстр
  *********************************************/
  PROCEDURE p_get_reg_deals(in_reg_id     escr_register.id%TYPE,
                            In_check_flag number default 0 -- перевіряємо чи ні статуси КД
                           ,
                            out_deal_list OUT number_list);
  /**********************************************
     PROCEDURE P_SET_OBJ_STATUS
     DESCRIPTION: ВСТАНОВЛЮЄ СТАТУС РЕЄСТРУ ЧИ КРЕДИТУ В РЕЄСТРІ
  *********************************************/
  PROCEDURE p_set_obj_status(in_obj_id         escr_reg_obj_state.obj_id%TYPE,
                             in_obj_type       escr_reg_obj_state.obj_type%TYPE,
                             in_status_code    escr_reg_status.code%TYPE,
                             in_status_comment escr_reg_obj_state.status_comment%TYPE DEFAULT NULL,
                             in_obj_check      NUMBER DEFAULT 1,
                             in_set_date       escr_reg_obj_state.set_date%TYPE DEFAULT SYSDATE,
                             in_oper_level     NUMBER DEFAULT 0,
                             in_repay_flag     number DEFAULT 0 -- на ЦБД статус 11 може бут змінено на 7 для переплати
                             );
  /**********************************************
     PROCEDURE  p_reg_del
     DESCRIPTION: Видалення реєстру
  *********************************************/
   PROCEDURE p_reg_del(in_reg_id     escr_register.id%TYPE,
                      in_check_flag number default 1);
  /************************************************************
     PROCEDURE   p_unmapping
     DESCRIPTION: Видаляє зв*язки між об*єктами реєстру
  **************************************************************/
  PROCEDURE p_unmapping(in_doc_id    number_list,
                        in_oper_type escr_reg_mapping.oper_type %TYPE);
  /**********************************************
     PROCEDURE   p_received_xml
     DESCRIPTION: Процедура отримує від РУ на вході xml файл і запсиує в таблицю
  *********************************************/
  PROCEDURE p_received_xml(in_reg_xml IN CLOB, in_flag NUMBER DEFAULT 0);

  PROCEDURE p_xml_parse(in_reg_xml IN CLOB DEFAULT NULL,
                        in_file_id NUMBER DEFAULT NULL);
  /**********************************************
     PROCEDURE   p_gen_pay
     DESCRIPTION: Процедура створення платіжних документів
  *********************************************/
  PROCEDURE p_gen_pay(in_reg_list number_list);
  /***************************************************************
     PROCEDURE   p_get_reg_id
     DESCRIPTION:
  **************************************************************/
  PROCEDURE p_get_reg_id(in_obj_id    NUMBER,
                         in_oper_type NUMBER,
                         out_reg_id   OUT escr_register.id%TYPE);
  /***************************************************************
     PROCEDURE   p_get_reg_status_id
     DESCRIPTION: отримуємо ID поточного статусу об*єкта
  **************************************************************/
  PROCEDURE p_get_obj_status_id(in_obj_id     NUMBER,
                                in_obj_type   NUMBER,
                                out_status_id OUT escr_reg_status.id%TYPE);
  /******************************************************************************
     PROCEDURE   p_get_reg_list
     DESCRIPTION: визначає к-сть реєстрів,яких НЕ вистачає до повного комплекту
  *****************************************************************************/
  PROCEDURE p_get_reg_list(in_reg_id       escr_register.id%TYPE,
                           out_branch_list OUT VARCHAR2);

  PROCEDURE p_check_before_create(in_obj_list    IN number_list DEFAULT NULL,
                                  in_reg_kind    in escr_reg_kind.code%TYPE DEFAULT NULL,
                                  out_check_flag OUT NUMBER);
  PROCEDURE p_sync_state;
  /************************************************************
     PROCEDURE    p_check_after_create
     DESCRIPTION: Перевірки після створення реєстру на ЦБД
  **************************************************************/
  PROCEDURE p_check_after_create;
  /***************************************************************
     PROCEDURE   p_change_comp_sum
     DESCRIPTION: Розрахунок нової суми КД та суми компенсації,
     для випадків, коли КД компенсують частково
  **************************************************************/
  PROCEDURE p_change_comp_sum(in_deal_id       escr_reg_header.deal_id%TYPE,
                              in_new_good_cost escr_reg_header.new_good_cost%TYPE);
  /**********************************************
     PROCEDURE  p_event_del
     DESCRIPTION: Видалення енергоефективного заходу,
     у випадку,якщо його не погоджуно ДУУ
  *********************************************/
  PROCEDURE p_event_del(in_deal_id  escr_reg_body.deal_id%TYPE,
                        in_event_id escr_reg_body.id%TYPE);
  /********************************************************
     PROCEDURE p_set_new_sum
     DESCRIPTION: Встановлюються нова вартість товару
                  сума кредиту та сума компенсації для
                  КД по яким ДЕЕ не погодив початкові суми
  *******************************************************/
  PROCEDURE p_set_new_sum(in_deal_id       number,
                          in_new_good_cost number,
                          in_new_deal_sum  number,
                          in_new_comp_sum  number);
  /**********************************************
     PROCEDURE   p_check_comp_sum
     DESCRIPTION: Процедура перевірки суми, к-сті
                  реєстрів ,які будуть оплачуватися
  *********************************************/
  PROCEDURE p_check_comp_sum(in_reg_id      escr_register.id%type,
                             out_deal_count out number,
                             out_deal_sum   out number,
                             out_good_cost  out number,
                             out_comp_sum   out number);
  /**********************************************
     PROCEDURE    p_reg_repay
     DESCRIPTION: Переплати у випадку помилки під основної оплати
                  Фактично зміна стасутів об*єктів, що дозволить  виконати
                  повторну оплату
  *********************************************/
  PROCEDURE p_reg_repay(in_reg_list number_list);
END pkg_escr_reg_utl;
/
CREATE OR REPLACE PACKAGE BODY BARS.PKG_ESCR_REG_UTL IS

  g_body_version   CONSTANT VARCHAR2(64) := 'VERSION 8.7.5 21/09/2018';
  g_header_version CONSTANT VARCHAR2(64) := 'VERSION 8.7.3 05/05/2018';

  c_err_txt VARCHAR2(4000);
  --константи
  lc_new_line    CONSTANT VARCHAR2(5) := chr(13) || chr(10);
  lc_date_format CONSTANT VARCHAR2(10) := 'DD/MM/YYYY';
  --змінні, які викор в багатьох процедурах пакету
  user_name VARCHAR2(400);
  p_new_id  NUMBER;

  l_credit_list    number_list := number_list();
  l_reg_list       number_list := number_list();
  l_status_id      escr_reg_status.id%TYPE;
  l_reg_id         escr_register.id%TYPE;
  l_status_name    escr_reg_status.name%TYPE;
  l_reg_type_id    escr_reg_types.id%TYPE;
  l_reg_kind_id    escr_reg_kind.id%TYPE;
  l_reg_union_flag escr_register.reg_union_flag%TYPE DEFAULT 0;
  l_in_flag        NUMBER;
  l_out_flag       NUMBER;
  --  типи
  TYPE t_register IS TABLE OF escr_register%ROWTYPE;
  TYPE t_reg_header IS TABLE OF escr_reg_header%ROWTYPE;
  TYPE t_reg_body IS TABLE OF escr_reg_body%ROWTYPE;
  TYPE t_reg_mapping IS TABLE OF escr_reg_mapping%ROWTYPE;
  TYPE t_vw_escr_list_for_sync IS TABLE OF vw_escr_list_for_sync%ROWTYPE;
  /**********************************************
    FUNCTION HEADER_VERSION
    DESCRIPTION: ПОВЕРТАЄ ВЕРСІЮ СПЕЦИФІКАЦІЇ ПАКЕТУ
  *********************************************/
  FUNCTION header_version RETURN VARCHAR2 IS
  BEGIN
    RETURN 'PACKAGE HEADER DOCSIGN ' || g_header_version || '.';
  END header_version;

  /**********************************************
    FUNCTION BODY_VERSION
   DESCRIPTION: ПОВЕРТАЄ ВЕРСІЮ ТІЛА ПАКЕТУ
  *********************************************/
  FUNCTION body_version RETURN VARCHAR2 IS
  BEGIN
    RETURN 'PACKAGE BODY DOCSIGN ' || g_body_version || '.';
  END body_version;
  PROCEDURE p_get_user_name(in_user_id    staff$base.id%TYPE DEFAULT user_id,
                            out_user_name OUT VARCHAR2) IS
  BEGIN
    BEGIN
      SELECT t.fio
        INTO out_user_name
        FROM staff$base t
       WHERE t.id = in_user_id;
    EXCEPTION
      WHEN OTHERS THEN
        out_user_name := 'НЕ ВИЗНАЧЕНО';
    END;

  END p_get_user_name;
  /***************************************************************
     PROCEDURE   P_GET_NEW_ID
     DESCRIPTION: ГЕНЕРУЄ НОВИЙ ID ДЛЯ ОБ'ЄКТІВ
  **************************************************************/
  PROCEDURE p_get_new_id(in_obj_name IN VARCHAR2, out_id OUT NUMBER) IS
    p_kf VARCHAR(20);
  BEGIN
    IF in_obj_name = 'ESCR_REGISTER' THEN
      BEGIN
        SELECT t.code
          INTO p_kf
          FROM regions t
         WHERE t.kf = (SELECT getglobaloption('MFO') FROM dual);
      EXCEPTION
        WHEN no_data_found THEN
          out_id := to_number(to_char(s_escr.nextval));
      END;
      out_id := to_number(to_char(s_escr.nextval) || p_kf);
    ELSE
      out_id := s_escr.nextval;
    END IF;
  END p_get_new_id;
  /***************************************************************
     PROCEDURE   p_get_type_ID
     DESCRIPTION: ПО  КОДУ типу реєстра ОТРИМУЄМО ЙОГО ID
  **************************************************************/
  PROCEDURE p_get_type_id(in_type_code escr_reg_types.code%TYPE,
                          out_type_id  OUT escr_reg_types.id%TYPE

                          )

   IS
  BEGIN
    BEGIN
      SELECT t.id
        INTO out_type_id
        FROM escr_reg_types t
       WHERE t.code = in_type_code;
    EXCEPTION
      WHEN OTHERS THEN
        out_type_id := -999;
    END;
  END p_get_type_id;
  /***************************************************************
     PROCEDURE   p_get_kind_ID
     DESCRIPTION: ПО  КОДУ типу реєстра ОТРИМУЄМО ЙОГО ID
  **************************************************************/
  PROCEDURE p_get_kind_id(in_kind_code escr_reg_kind.code%TYPE,
                          out_kind_id  OUT escr_reg_kind.id%TYPE

                          ) IS
  BEGIN
    BEGIN
      SELECT t.id
        INTO out_kind_id
        FROM escr_reg_kind t
       WHERE t.code = in_kind_code;
    EXCEPTION
      WHEN OTHERS THEN
        out_kind_id := -999;
    END;
  END p_get_kind_id;
  /***************************************************************
     PROCEDURE   p_check_kind_id
     DESCRIPTION: ПО  КОДУ типу реєстра ОТРИМУЄМО ЙОГО ID
  **************************************************************/
  PROCEDURE p_check_kind_id(in_kind_code escr_reg_kind.code%TYPE,
                            out_flag     OUT escr_reg_kind.valid_until%TYPE

                            ) IS
  BEGIN
    BEGIN
      SELECT t.valid_until
        INTO out_flag
        FROM escr_reg_kind t
       WHERE t.code = in_kind_code;
    EXCEPTION
      WHEN OTHERS THEN
        out_flag := NULL;
    END;
  END p_check_kind_id;
  /***************************************************************
     PROCEDURE   p_get_status_ID
     DESCRIPTION: ПО  КОДУ СТАТУСУ ОТРИМУЄМО ЙОГО ID
  **************************************************************/
  PROCEDURE p_get_status_id(in_status_code escr_reg_status.code%TYPE,
                            out_status_id  OUT escr_reg_status.id%TYPE

                            ) IS
  BEGIN
    BEGIN
      SELECT t.id
        INTO out_status_id
        FROM escr_reg_status t
       WHERE t.code = in_status_code;
    EXCEPTION
      WHEN OTHERS THEN
        out_status_id := -999;
    END;
  END p_get_status_id;
  /***************************************************************
     PROCEDURE   p_get_status_ID
     DESCRIPTION: ПО  ID СТАТУСУ ОТРИМУЄМО ЙОГО CODE
  **************************************************************/
  PROCEDURE p_get_status_code(in_status_id    escr_reg_status.id%TYPE,
                              out_status_code OUT escr_reg_status.code%TYPE

                              ) IS
  BEGIN
    BEGIN
      SELECT t.code
        INTO out_status_code
        FROM escr_reg_status t
       WHERE t.id = in_status_id;
    EXCEPTION
      WHEN OTHERS THEN
        out_status_code := -999;
    END;
  END p_get_status_code;
  /***************************************************************
     PROCEDURE   p_get_status_name
     DESCRIPTION: ПО  КОДУ СТАТУСУ ОТРИМУЄМО ЙОГО ІМ`Я
  **************************************************************/
  PROCEDURE p_get_status_name(in_status_code  escr_reg_status.code%TYPE,
                              out_status_name OUT escr_reg_status.name%TYPE

                              ) IS
  BEGIN
    BEGIN
      SELECT t.name
        INTO out_status_name
        FROM escr_reg_status t
       WHERE t.code = in_status_code;
    EXCEPTION
      WHEN OTHERS THEN
        out_status_name := -999;
    END;
  END p_get_status_name;
  /**********************************************
     PROCEDURE p_get_reg_union_flag
     DESCRIPTION: повертає ознаку об*єднани реєстр чи ні
  *********************************************/
  PROCEDURE p_get_reg_union_flag(in_reg_id          escr_register.id%TYPE,
                                 out_reg_union_flag OUT escr_register.reg_union_flag%TYPE) IS

  BEGIN
    BEGIN
      SELECT t.reg_union_flag
        INTO out_reg_union_flag
        FROM escr_register t
       WHERE t.id = in_reg_id;
    EXCEPTION
      WHEN no_data_found THEN
        NULL;
    END;

  END p_get_reg_union_flag;
  /**********************************************
     PROCEDURE P_get_reg_register
     DESCRIPTION: повертає колекцію залежних реєстрів
  *********************************************/
  PROCEDURE p_get_reg_register(in_reg_id    escr_register.id%TYPE,
                               out_reg_list OUT number_list) IS

    out_reg_list1 number_list := number_list();
  BEGIN

    BEGIN
      SELECT t.out_doc_id
        BULK COLLECT
        INTO out_reg_list1
        FROM escr_reg_mapping t
       WHERE t.in_doc_id = in_reg_id
         AND t.oper_type = 1;
    EXCEPTION
      WHEN no_data_found THEN
        NULL;
    END;

    out_reg_list := out_reg_list1;
  END p_get_reg_register;
  /**********************************************
     PROCEDURE P_get_reg_deals
     DESCRIPTION: повертає колекцію кредитів, які включені в реєстр
  *********************************************/
  PROCEDURE p_get_reg_deals(in_reg_id     escr_register.id%TYPE,
                            in_check_flag NUMBER DEFAULT 0 -- перевіряємо чи ні статуси КД
                           ,
                            out_deal_list OUT number_list) IS

    all_deal_list   number_list := number_list();
    valid_deal_list number_list := number_list();
    --final_deal_list number_list := number_list();

  BEGIN

    BEGIN
      SELECT t.out_doc_id
        BULK COLLECT
        INTO all_deal_list
        FROM escr_reg_mapping t
       WHERE t.in_doc_id = in_reg_id
         AND t.oper_type = 0;
    EXCEPTION
      WHEN no_data_found THEN
        NULL;
    END;
    /*Якщо на ЦБД є несинхронізовані КД,
    то важливо не перезатерти по ним статуси при оплаті і виключити їх зі списку для оплати*/
    IF in_check_flag IN (7, 11) THEN
      BEGIN

        SELECT t.deal_id
          BULK COLLECT
          INTO valid_deal_list
          FROM escr_reg_header t
         WHERE t.deal_id IN (SELECT * FROM TABLE(all_deal_list))
           AND t.credit_status_id NOT IN (9, 5)
            or t.credit_status_id is null;
      EXCEPTION
        WHEN no_data_found THEN
          NULL;
      END;
      out_deal_list := valid_deal_list;
    ELSE

      out_deal_list := all_deal_list;
    END IF;
  END p_get_reg_deals;
  /**********************************************
     PROCEDURE P_SET_CREDIT_STATUS
     DESCRIPTION: ВСТАНОВЛЮЄ СТАТУС КРЕДИТНОГО ДОГОВОРУ В nd_txt
  *********************************************/
  PROCEDURE p_set_credit_status(in_obj_id         IN escr_reg_obj_state.obj_id%TYPE,
                                in_status_code    IN escr_reg_status.code%TYPE,
                                in_status_comment IN escr_reg_obj_state.status_comment%TYPE DEFAULT NULL,
                                in_set_date       IN DATE) IS
    l_flag NUMBER;
    v_curr_branch branch.branch%type := bc.current_branch_code();
  BEGIN
    p_get_status_id(in_status_code => in_status_code,
                    out_status_id  => l_status_id);
    p_get_status_name(in_status_code  => in_status_code,
                      out_status_name => l_status_name);
    BEGIN
      SELECT COUNT(1) INTO l_flag FROM cc_tag t WHERE t.tag LIKE 'ES%';
    END;
    IF l_flag >= 1 THEN
      for r in (select kf from cc_deal where nd = in_obj_id)
      loop
        bc.go(r.kf);
      end loop;
      cck_app.set_nd_txt(in_obj_id, 'ES000', l_status_id);
      cck_app.set_nd_txt(in_obj_id, 'ES005', l_status_name);
      cck_app.set_nd_txt(in_obj_id, 'ES006', in_set_date);
      cck_app.set_nd_txt(in_obj_id, 'ES007', in_status_comment);
      IF l_status_id = 11 THEN
        cck_app.set_nd_txt(in_obj_id, 'ES003', trunc(SYSDATE));
      END IF;
    END IF;
    bc.go(v_curr_branch);
    UPDATE escr_reg_header t
       SET t.credit_status_id = l_status_id
     WHERE t.deal_id = in_obj_id;

  END p_set_credit_status;

  /**********************************************
     PROCEDURE P_SET_OBJ_STATUS
     DESCRIPTION: ВСТАНОВЛЮЄ СТАТУС РЕЄСТРУ ЧИ КРЕДИТУ В РЕЄСТРІ
  *********************************************/
  PROCEDURE p_set_obj_status(in_obj_id         escr_reg_obj_state.obj_id%TYPE,
                             in_obj_type       escr_reg_obj_state.obj_type%TYPE,
                             in_status_code    escr_reg_status.code%TYPE,
                             in_status_comment escr_reg_obj_state.status_comment%TYPE DEFAULT NULL,
                             in_obj_check      NUMBER DEFAULT 1, --Перевіряти зв*язки цього Об*єкту чи  ні (для реєстру)
                             in_set_date       escr_reg_obj_state.set_date%TYPE DEFAULT SYSDATE,
                             in_oper_level     NUMBER DEFAULT 0,
                             in_repay_flag     number DEFAULT 0 -- на ЦБД статус 11 може бут змінено на 7 для переплати
                             )

   IS
    l_obj_status_id escr_reg_status.id%TYPE;
    l_max_status_id NUMBER;
    -- in_obj_type Тип вхідного  об'єкта (1 -реєстр,0-кредит)
    p_obj_list number_list := number_list();
  BEGIN
    --   _escrRegister.SetComment(deals.deals.deal[i].deal_id, String.Empty, status_code, 0, 1, cmd);
    p_get_status_id(in_status_code => in_status_code,
                    out_status_id  => l_status_id);

    -- Перевіряємо попередній статус об*єкта.Перевірку не виконуємо для помилки валідації.Вона може щоразу мат різні коментарі
    IF l_status_id <> 16 THEN
      BEGIN
        SELECT MAX(t.status_id) keep(dense_rank LAST ORDER BY t.id)
          INTO l_max_status_id
          FROM bars.escr_reg_obj_state t
         WHERE obj_id = in_obj_id;
      EXCEPTION
        WHEN no_data_found THEN
          l_max_status_id := NULL;
      END;
    ELSE
      l_max_status_id := NULL;
    END IF;
    -- Якщо максимальний статус КД-11,тобто оплачений,то виходимо з процедури.
    if l_max_status_id = 11 and in_repay_flag = 0 then
      return;
    end if;

    IF l_max_status_id <> l_status_id OR l_max_status_id IS NULL or
       (l_max_status_id = 11 and in_repay_flag = 1) THEN
      --ОТРИМУЄМО НОВИЙ ID
      p_get_new_id(in_obj_name => 'ESCR_REG_OBJ_STATE', out_id => p_new_id);
      -- ОТРИМУЄМО ПІБ КОРИСТУВАЧА
      p_get_user_name(out_user_name => user_name);
      -- Проставляємо статус об*єкту, для якого ініціалізували зміну  статусу
      INSERT INTO escr_reg_obj_state
        (id,
         obj_id,
         obj_type,
         status_id,
         status_comment,
         user_id,
         user_name,
         set_date)
      VALUES
        (p_new_id,
         in_obj_id,
         in_obj_type,
         l_status_id,
         in_status_comment,
         user_id,
         user_name,
         in_set_date) log errors INTO err$_escr_reg_obj_state
        ('INSERT') reject LIMIT unlimited;
      IF in_obj_type = 1 AND in_obj_check = 0 THEN
        UPDATE escr_register t
           SET t.status_id = l_status_id log errors INTO err$_escr_reg_obj_state('UPDATE') reject LIMIT unlimited;
      END IF;
      -- Якщо тип об*єкту,якому змінюють статус -0 (кредит), то вносимо відповідні зміни в доппараматри
      IF in_obj_type = 0 AND in_obj_check = 0 AND in_oper_level in (0, 1) THEN
        p_set_credit_status(in_obj_id         => in_obj_id,
                            in_status_code    => in_status_code,
                            in_status_comment => in_status_comment,
                            in_set_date       => in_set_date);
      END IF;
      IF in_obj_type = 0 AND in_obj_check = 1 THEN
        IF in_oper_level = 0 THEN
          p_set_credit_status(in_obj_id         => in_obj_id,
                              in_status_code    => in_status_code,
                              in_status_comment => in_status_comment,
                              in_set_date       => in_set_date);
        END IF;
        p_get_reg_id(in_obj_id    => in_obj_id,
                     in_oper_type => 0,
                     out_reg_id   => l_reg_id);
        p_get_obj_status_id(in_obj_id     => l_reg_id,
                            in_obj_type   => 1,
                            out_status_id => l_obj_status_id);
        IF l_status_id <> l_obj_status_id THEN
          INSERT INTO escr_reg_obj_state
            (id,
             obj_id,
             obj_type,
             status_id,
             status_comment,
             user_id,
             user_name,
             set_date)
          VALUES
            (p_new_id,
             l_reg_id,
             1,
             l_status_id,
             in_status_comment,
             user_id,
             user_name,
             in_set_date) log errors INTO err$_escr_reg_obj_state
            ('INSERT') reject LIMIT unlimited;
        END IF;
      END IF;
      --Перевірка чи має реєстр пов*язані реєстри
      IF in_obj_type = 1 AND in_obj_check = 1 THEN
        p_get_reg_union_flag(in_reg_id          => in_obj_id,
                             out_reg_union_flag => l_reg_union_flag);
      END IF;

      --Якщо тип об*єкта 1 і рєєстр немає пов*язаних реєстрів, то оновлюємо статуси лише кредитам в цьому реєстрі
      IF in_obj_type = 1 AND in_obj_check = 1 AND l_reg_union_flag = 0 THEN

        UPDATE escr_register t
           SET t.status_id = l_status_id,
               t.user_id   = user_id,
               t.user_name = user_name
         WHERE t.id = in_obj_id;
        p_get_reg_deals(in_reg_id     => in_obj_id,
                        in_check_flag => l_status_id,
                        out_deal_list => l_credit_list);

        FOR i IN 1 .. l_credit_list.count LOOP
          INSERT INTO escr_reg_obj_state
            (id,
             obj_id,
             obj_type,
             status_id,
             status_comment,
             user_id,
             user_name,
             set_date)
          VALUES
            (s_escr.nextval,
             l_credit_list(i),
             0,
             l_status_id,
             in_status_comment,
             user_id,
             user_name,
             in_set_date);
          p_set_credit_status(in_obj_id         => l_credit_list(i),
                              in_status_code    => in_status_code,
                              in_status_comment => in_status_comment,
                              in_set_date       => in_set_date);
        END LOOP;
      END IF;
      --Якщо тип об*єкта 1 і рєєстр МАЄ пов*язані реєстри, то оновлюємо статуси цим реєстрам
      IF in_obj_type = 1 AND in_obj_check = 1 AND l_reg_union_flag = 1 THEN
        UPDATE escr_register t
           SET t.status_id = l_status_id,
               t.user_id   = user_id,
               t.user_name = user_name
         WHERE t.id = in_obj_id;
        p_get_reg_register(in_reg_id    => in_obj_id,
                           out_reg_list => l_reg_list);
        UPDATE escr_register t
           SET t.status_id = l_status_id,
               t.user_id   = user_id,
               t.user_name = user_name
         WHERE t.id IN (SELECT * FROM TABLE(l_reg_list));
        FOR i IN 1 .. l_reg_list.count LOOP
          INSERT INTO escr_reg_obj_state
            (id,
             obj_id,
             obj_type,
             status_id,
             status_comment,
             user_id,
             user_name,
             set_date)
          VALUES
            (s_escr.nextval,
             l_reg_list(i),
             1,
             l_status_id,
             in_status_comment,
             user_id,
             user_name,
             in_set_date);
          p_get_reg_deals(in_reg_id     => l_reg_list(i),
                          in_check_flag => l_status_id,
                          out_deal_list => l_credit_list);

          FOR i IN 1 .. l_credit_list.count LOOP
            INSERT INTO escr_reg_obj_state
              (id,
               obj_id,
               obj_type,
               status_id,
               status_comment,
               user_id,
               user_name,
               set_date)
            VALUES
              (s_escr.nextval,
               l_credit_list(i),
               0,
               l_status_id,
               in_status_comment,
               user_id,
               user_name,
               in_set_date);
            p_set_credit_status(in_obj_id         => l_credit_list(i),
                                in_status_code    => in_status_code,
                                in_status_comment => in_status_comment,
                                in_set_date       => in_set_date);
          END LOOP;
        END LOOP;
      END IF;
    END IF;
  END p_set_obj_status;

  /**********************************************
     PROCEDURE p_get_obj_status_id
     DESCRIPTION: ВСТАНОВЛЮЄ СТАТУС РЕЄСТРУ ЧИ КРЕДИТУ В РЕЄСТРІ
  *********************************************/
  PROCEDURE p_get_obj_status(in_obj_id   escr_register.id%TYPE,
                             in_obj_type escr_reg_obj_state.obj_type%TYPE,
                             out_status  OUT escr_reg_status.id%TYPE) IS

  BEGIN

    BEGIN
      SELECT t.status_id
        INTO out_status
        FROM escr_reg_obj_state t
       WHERE t.set_date =
             (SELECT MAX(t1.set_date) FROM escr_reg_obj_state t1)
         AND t.obj_type = in_obj_type
         AND t.obj_id = in_obj_id;
    EXCEPTION
      WHEN OTHERS THEN
        out_status := -999;
    END;
  END p_get_obj_status;
  /**********************************************
     PROCEDURE p_set_reg_union_flag
     DESCRIPTION: Встановлює признак, що реєстр об*єднано з кількох реєстрів того ж виду і типу
  *********************************************/
  PROCEDURE p_set_reg_union_flag(in_reg_id escr_register.id%TYPE) IS

  BEGIN
    UPDATE escr_register t
       SET t.reg_union_flag = 1,
           t.inner_number   = t.inner_number || ' об''єднаний'
     WHERE t.id = in_reg_id;

  END p_set_reg_union_flag;
  /***************************************************************
     PROCEDURE   p_deal_in_reg
     DESCRIPTION: ПЕРЕВІРЯЄ ЧИ ВКЛЮЧЕНО КРЕДИТНИЙ ДОГОВІР В РЕЄСТР
  **************************************************************/
  PROCEDURE p_deal_in_reg(in_deal_list number_list,
                          out_err_txt  OUT VARCHAR2) IS
  BEGIN
    NULL;
  END p_deal_in_reg;
  /***************************************************************
     PROCEDURE   p_reg_has_in_mapping
     DESCRIPTION: ПЕРЕВІРЯЄ має реєстр зв*язки по входу
  **************************************************************/
  PROCEDURE p_reg_has_in_mapping(in_reg_id    escr_register.id%TYPE,
                                 out_has_flag OUT NUMBER) IS
  BEGIN
    BEGIN
      SELECT COUNT(t.id)
        INTO out_has_flag
        FROM escr_reg_mapping t
       WHERE t.in_doc_id = in_reg_id;
    END;
  END p_reg_has_in_mapping;
  /***************************************************************
     PROCEDURE   p_reg_has_out_mapping
     DESCRIPTION: ПЕРЕВІРЯЄ має реєстр зв*язки по входу
  **************************************************************/
  PROCEDURE p_reg_has_out_mapping(in_reg_id    escr_register.id%TYPE,
                                  out_has_flag OUT NUMBER) IS
  BEGIN
    BEGIN
      SELECT COUNT(t.id)
        INTO out_has_flag
        FROM escr_reg_mapping t
       WHERE t.out_doc_id = in_reg_id;
    END;
  END p_reg_has_out_mapping;
  /******************************************************************************
     PROCEDURE   p_get_reg_list
     DESCRIPTION: визначає к-сть реєстрів,яких НЕ вистачає до повного комплекту
  *****************************************************************************/
  PROCEDURE p_get_reg_list(in_reg_id       escr_register.id%TYPE,
                           out_branch_list OUT VARCHAR2) IS
    l_reg_list     number_list;
    l_reg_list_all number_list;
    l_reg_list_dif number_list;
  BEGIN
    BEGIN
      SELECT DISTINCT substr(REPLACE(t.branch, '/', ''), 1, 6)
        BULK COLLECT
        INTO l_reg_list
        FROM escr_register t
       WHERE t.id IN (SELECT t1.out_doc_id
                        FROM escr_reg_mapping t1
                       WHERE t1.oper_type = 1
                         AND t1.in_doc_type = 1
                         AND t1.out_doc_type = 1
                         AND t1.in_doc_id = in_reg_id);
    EXCEPTION
      WHEN no_data_found THEN
        NULL;
    END;
    BEGIN
      SELECT DISTINCT t.kf BULK COLLECT INTO l_reg_list_all FROM regions t;
    EXCEPTION
      WHEN no_data_found THEN
        NULL;
    END;
    l_reg_list_dif := l_reg_list_all MULTISET except DISTINCT l_reg_list;
    IF l_reg_list_dif IS NOT NULL THEN
      FOR i IN 1 .. l_reg_list_dif.count LOOP
        out_branch_list := l_reg_list_dif(i) || ' ,' || out_branch_list;
      END LOOP;
    END IF;
    out_branch_list :=  /*'24/' || l_reg_list_dif.count ||' '||lc_new_line
                                                                                                                                                                                                                                         ||*/
     substr(out_branch_list,
                              1,
                              length(out_branch_list) - 1);
  END p_get_reg_list;
  /***************************************************************
     PROCEDURE   P_GET_REG_ID
     DESCRIPTION: отримуємо ID реєстра, в який включено кредит (in_oper_type=0)
                  чи реєстра, в який включено реєстр (in_oper_type=1)
  **************************************************************/
  PROCEDURE p_get_reg_id(in_obj_id    NUMBER,
                         in_oper_type NUMBER,
                         out_reg_id   OUT escr_register.id%TYPE) IS
  BEGIN
    BEGIN
      SELECT t.in_doc_id
        INTO out_reg_id
        FROM escr_reg_mapping t
       WHERE t.oper_type = in_oper_type
         AND t.out_doc_id = in_obj_id;
    EXCEPTION
      WHEN OTHERS THEN
        NULL;
    END;
  END p_get_reg_id;
  /***************************************************************
     PROCEDURE   p_get_reg_status_id
     DESCRIPTION: отримуємо ID поточного статусу об*єкта
  **************************************************************/
  PROCEDURE p_get_obj_status_id(in_obj_id     NUMBER,
                                in_obj_type   NUMBER,
                                out_status_id OUT escr_reg_status.id%TYPE) IS
  BEGIN
    BEGIN
      SELECT t.status_id
        INTO out_status_id
        FROM escr_reg_obj_state t
       WHERE t.id = (SELECT MAX(t1.id)
                       FROM escr_reg_obj_state t1
                      WHERE t1.obj_id = in_obj_id
                        AND t1.obj_type = in_obj_type);
    EXCEPTION
      WHEN OTHERS THEN
        NULL;
    END;
  END p_get_obj_status_id;

  /************************************************************
     PROCEDURE   P_MAPPING
     DESCRIPTION: ДОДАЄ ЗВ*ЯЗКИ МІЖ ОБ*ЄКТАМИ РЕЄСТРУ
  **************************************************************/
  PROCEDURE p_after_mapping_check(in_in_doc_id    escr_reg_mapping.in_doc_id%TYPE,
                                  in_in_doc_type  escr_reg_mapping.in_doc_type%TYPE,
                                  in_out_doc_id   number_list,
                                  in_out_doc_type escr_reg_mapping.out_doc_type%TYPE,
                                  in_oper_type    escr_reg_mapping.oper_type %TYPE,
                                  in_oper_date    DATE DEFAULT SYSDATE) IS

  BEGIN
    -- DOC_TYPE МОЖЕ ПРИЙМАТИ ЗНАЧЕННЯ 1 -РЕЄСТР,0-КРЕДИТ
    -- OPER_TYPE 0-РЕЄСТР-КРЕДИТ,1- РЕЄСТР-РЕЄСТР
    ---!!!!ДОДАТИ перевірку на статус

    FORALL i IN in_out_doc_id.first .. in_out_doc_id.last

      INSERT INTO escr_reg_mapping
        (id,
         in_doc_id,
         in_doc_type,
         out_doc_id,
         out_doc_type,
         branch,
         oper_type,
         oper_date)
      VALUES
        (s_escr.nextval,
         in_in_doc_id,
         in_in_doc_type,
         in_out_doc_id(i),
         in_out_doc_type,
         c_branch,
         in_oper_type,
         in_oper_date) log errors INTO err$_escr_reg_mapping
        ('INSERT') reject LIMIT unlimited;
    --Проставляємо ознаку,що реєстр об*єднаний,якщо тип мапінгу реєстр-реєстр
    IF in_oper_type = 1 AND in_in_doc_type = 1 THEN
      p_set_reg_union_flag(in_reg_id => in_in_doc_id);
    END IF;
  END p_after_mapping_check;

  /************************************************************
     PROCEDURE    p_check_after_create
     DESCRIPTION: Перевірки після створення реєстру на ЦБД
  **************************************************************/
  PROCEDURE p_check_after_create IS
    l_boiler_count   number_list;
    l_material_count number_list;
    l_customer_okpo  number_list;
    l_deal_id        number_list;

  BEGIN
    BEGIN
      SELECT COUNT(CASE
                     WHEN substr(t.deal_product, 1, 6) IN
                          ('220347', '220257', '220373') THEN
                      1
                   END) boiler_count,
             COUNT(CASE
                     WHEN substr(t.deal_product, 1, 6) IN
                          ('220258', '220348', '220374') THEN
                      2
                   END) material_count,
             t.customer_okpo
        BULK COLLECT
        INTO l_boiler_count, l_material_count, l_customer_okpo
        FROM escr_reg_header t
       WHERE extract(YEAR FROM t.deal_date_from) >= '2017'
       GROUP BY t.customer_okpo
      HAVING COUNT(*) > 1;
    END;

    IF l_material_count.count > 0 THEN
      BEGIN
        SELECT t.deal_id
          BULK COLLECT
          INTO l_deal_id
          FROM escr_reg_header t
         WHERE substr(t.deal_product, 1, 6) IN
               ('220258', '220348', '220374')
           AND extract(YEAR FROM t.deal_date_from) >= '2017'
           AND t.customer_okpo IN (SELECT * FROM TABLE(l_customer_okpo));
      END;
      IF l_deal_id.count > 0 THEN
        FOR i IN 1 .. l_deal_id.count LOOP
          NULL;
          p_set_obj_status(in_obj_id         => l_deal_id(i),
                           in_obj_type       => 0,
                           in_status_code    => 'DUPLICATE_DEAL',
                           in_status_comment => 'Позичальник перевищив допустиму к-сть КД по матеріалам',
                           in_obj_check      => 0,
                           in_set_date       => SYSDATE,
                           in_oper_level     => 1);
        END LOOP;
      END IF;
    ELSIF l_boiler_count.count > 0 THEN
      BEGIN
        SELECT t.deal_id
          BULK COLLECT
          INTO l_deal_id
          FROM escr_reg_header t
         WHERE substr(t.deal_product, 1, 6) IN
               ('220347', '220257', '220373')
           AND extract(YEAR FROM t.deal_date_from) >= '2017'
           AND t.customer_okpo IN (SELECT * FROM TABLE(l_customer_okpo));
      END;
      IF l_deal_id.count > 0 THEN
        FOR i IN 1 .. l_deal_id.count LOOP
          NULL;
          p_set_obj_status(in_obj_id         => l_deal_id(i),
                           in_obj_type       => 0,
                           in_status_code    => 'DUPLICATE_DEAL',
                           in_status_comment => 'Позичальник перевищив допустиму к-сть КД по котлам',
                           in_obj_check      => 0,
                           in_set_date       => SYSDATE,
                           in_oper_level     => 1);
        END LOOP;
      END IF;

    END IF;

  END p_check_after_create;
  /************************************************************
     PROCEDURE   p_check_before_create
     DESCRIPTION: Перевірка реєстра до сторення
  **************************************************************/
  PROCEDURE p_check_before_create(in_obj_list    IN number_list DEFAULT NULL,
                                  in_reg_kind    IN escr_reg_kind.code%TYPE DEFAULT NULL,
                                  out_check_flag OUT NUMBER) IS
    l_invalid  number_list;
    l_deal_id  number_list;
    l_multiset number_list;
    l_improved number_list;

  BEGIN

    out_check_flag := 0;
    l_deal_id      := number_list();
    l_invalid      := number_list();
    --  Відбираємо всі некоректні КД,для подальшого виправлення статусів (ДООПРАЦЮВАТИ)
    /* BEGIN
      SELECT t.nd BULK COLLECT
        INTO l_invalid
        FROM nd_txt t
       WHERE t.tag = 'ES000'
         AND t.txt = 16;
    EXCEPTION
      WHEN no_data_found THEN
        NULL;
    END;*/
    --Якщо в портфелі є хоч один КД з некоректною вартістю товару, то виходимо з процедури
    BEGIN
      SELECT COUNT(*)
        INTO out_check_flag
        FROM bars.vw_escr_errors t
       WHERE t.err_type_code = 'GOOD_COST';
    END;
    IF out_check_flag <> 0 THEN
      out_check_flag := -999;
    END IF;

    --

    --При нагоді переписати vw_escr_invalid_credits -вона дуже важка
    IF out_check_flag = 0 THEN

      FOR c IN (SELECT t.deal_id,
                       listagg(t.rn || '.' || t.description || chr(13) ||
                               chr(10)) within GROUP(ORDER BY t.rn, t.deal_id, t.description) reg_errors
                  FROM (SELECT t1.deal_id,
                               t2.description,
                               row_number() over(PARTITION BY t1.deal_id ORDER BY t1.deal_id) rn
                          FROM bars.vw_escr_invalid_credits t1,
                               bars.escr_errors_types       t2
                         WHERE t1.error_id = t2.id) t
                 GROUP BY t.deal_id) LOOP

        /* pkg_escr_reg_utl.p_set_credit_status(in_obj_id         => c.deal_id
        ,in_status_code    => 'VALID_ERROR'
        ,in_status_comment => substr(c.reg_errors
                                    ,1
                                    ,4000)
        ,in_set_date       => SYSDATE);
        */
        pkg_escr_reg_utl.p_set_obj_status(in_obj_id         => c.deal_id,
                                          in_obj_type       => 0,
                                          in_status_code    => 'VALID_ERROR',
                                          in_status_comment => substr(c.reg_errors,
                                                                      1,
                                                                      4000));
      END LOOP;
      /*      COMMIT;*/
      BEGIN
        SELECT deal_id
          BULK COLLECT
          INTO l_deal_id
          FROM vw_escr_reg_all_credits t
         WHERE t.credit_status_id = 16;
      EXCEPTION
        WHEN no_data_found THEN
          NULL;
      END;
      -- Проставляємо статус Доопрацьовано по всім КД, які не попали в помилкові, але були невалідні при минулих перевірках (ДООПРАЦЮВАТИ)
      /*    l_improved := l_invalid MULTISET except l_deal_id;
      FOR i IN 1 .. l_improved.count
      LOOP
        pkg_escr_reg_utl.p_set_obj_status(in_obj_id         => l_improved(i)
                                         ,in_obj_type       => 0
                                         ,in_status_code    => 'IMPROVED'
                                         ,in_status_comment => '');
      END LOOP;*/
      -- Перевірка чи намагаються включити в реєстр помилкові КД
      l_multiset := l_deal_id MULTISET INTERSECT in_obj_list;
      IF l_multiset.count > 0 THEN
        out_check_flag := -999;
      ELSE
        out_check_flag := 0;
      END IF;
    END IF;
  END p_check_before_create;
  /************************************************************
     PROCEDURE   P_MAPPING
     DESCRIPTION: ДОДАЄ ЗВ*ЯЗКИ МІЖ ОБ*ЄКТАМИ РЕЄСТРУ
  **************************************************************/
  PROCEDURE p_mapping(in_in_doc_id    escr_reg_mapping.in_doc_id%TYPE,
                      in_in_doc_type  escr_reg_mapping.in_doc_type%TYPE,
                      in_out_doc_id   number_list,
                      in_out_doc_type escr_reg_mapping.out_doc_type%TYPE,
                      in_oper_type    escr_reg_mapping.oper_type %TYPE,
                      in_oper_date    DATE DEFAULT SYSDATE) IS
    l_reg_id        escr_register.id%TYPE;
    l_in_out_doc_id number_list := in_out_doc_id;
  BEGIN
    -- DOC_TYPE МОЖЕ ПРИЙМАТИ ЗНАЧЕННЯ 1 -РЕЄСТР,0-КРЕДИТ
    -- OPER_TYPE 0-РЕЄСТР-КРЕДИТ,1- РЕЄСТР-РЕЄСТР
    ---!!!!ДОДАТИ перевірку на статус
    IF in_oper_type = 1 THEN
      FOR i IN l_in_out_doc_id.first .. l_in_out_doc_id.last LOOP
        l_reg_id := l_in_out_doc_id(i);
        p_get_reg_union_flag(in_reg_id          => l_reg_id,
                             out_reg_union_flag => l_reg_union_flag);
        IF l_reg_union_flag = 1 THEN
          UPDATE escr_reg_mapping t
             SET t.in_doc_id = in_in_doc_id, t.oper_date = in_oper_date
           WHERE t.oper_type = 1
             AND t.in_doc_id = l_in_out_doc_id(i) log errors INTO
           err$_escr_reg_mapping('update') reject LIMIT unlimited;
          l_in_out_doc_id.delete(i);
        END IF;

      END LOOP;
    END IF;
    --FORALL i IN in_out_doc_id.first .. in_out_doc_id.last
    FORALL i IN INDICES OF l_in_out_doc_id
      INSERT INTO escr_reg_mapping
        (id,
         in_doc_id,
         in_doc_type,
         out_doc_id,
         out_doc_type,
         branch,
         oper_type,
         oper_date)
      VALUES
        (s_escr.nextval,
         in_in_doc_id,
         in_in_doc_type,
         in_out_doc_id(i),
         in_out_doc_type,
         c_branch,
         in_oper_type,
         in_oper_date) log errors INTO err$_escr_reg_mapping
        ('INSERT') reject LIMIT unlimited;
    --Проставляємо ознаку,що реєстр об*єднаний,якщо тип мапінгу реєстр-реєстр
    IF in_oper_type = 1 AND in_in_doc_type = 1 THEN
      p_set_reg_union_flag(in_reg_id => in_in_doc_id);
    END IF;
  END p_mapping;
  /************************************************************
     PROCEDURE   p_unmapping
     DESCRIPTION: Видаляє зв*язки між об*єктами реєстру
  **************************************************************/
  PROCEDURE p_unmapping(in_doc_id    number_list,
                        in_oper_type escr_reg_mapping.oper_type %TYPE

                        ) IS
  BEGIN
    -- OPER_TYPE 0-РЕЄСТР-КРЕДИТ,1- РЕЄСТР-РЕЄСТР
    ---!!!!ДОДАТИ перевірку на статус
    IF in_oper_type = 1 THEN
      FORALL i IN in_doc_id.first .. in_doc_id.last
        DELETE FROM escr_reg_mapping t
         WHERE t.oper_type = 1
           AND t.in_doc_id = in_doc_id(i);
    END IF;
    IF in_oper_type = 0 THEN
      FORALL i IN in_doc_id.first .. in_doc_id.last
        DELETE FROM escr_reg_mapping t
         WHERE t.oper_type = 0
           AND t.out_doc_id = in_doc_id(i);
      FORALL i IN in_doc_id.first .. in_doc_id.last
        DELETE FROM escr_reg_header t WHERE t.deal_id = in_doc_id(i);
      FORALL i IN in_doc_id.first .. in_doc_id.last
        DELETE FROM escr_reg_body t WHERE t.deal_id = in_doc_id(i);
      FORALL i IN in_doc_id.first .. in_doc_id.last
        DELETE FROM nd_txt t
         WHERE (t.tag = 'ES000' OR t.tag = 'ES005')
           AND t.nd = in_doc_id(i);
    END IF;
    FOR i IN 1 .. in_doc_id.count LOOP
      p_reg_del(in_reg_id => in_doc_id(i));
    END LOOP;
  END p_unmapping;

  /**********************************************
     PROCEDURE  P_REG_CREATE
     DESCRIPTION: СТВОРЕННЯ РЕЄСТРУ
  *********************************************/
  PROCEDURE p_reg_create(in_date_from escr_register.date_from%TYPE,
                         in_date_to   escr_register.date_to%TYPE,
                         in_reg_type  escr_reg_types.code%TYPE,
                         in_reg_kind  escr_reg_kind.code%TYPE,
                         in_reg_level escr_register.reg_level%TYPE,
                         in_oper_type escr_reg_mapping.oper_type%TYPE default 1,
                         in_obj_list  number_list,
                         out_reg_id   IN OUT escr_register.id%TYPE) IS
    l_inner_number escr_register.inner_number%TYPE;
    l_create_date  escr_register.create_date%TYPE := SYSDATE;
    l_check_flag   NUMBER;

  BEGIN
    -- in_reg_level може приймати значення 1-ЦА,0-РУ

    p_get_user_name(out_user_name => user_name);
    --Визначаємо ID типу, виду реєстру та статусу
    p_get_status_id(in_status_code => 'ADD_TO_REGISTER',
                    out_status_id  => l_status_id);
    p_get_kind_id(in_kind_code => in_reg_kind,
                  out_kind_id  => l_reg_kind_id);
    p_get_type_id(in_type_code => in_reg_type,
                  out_type_id  => l_reg_type_id);
    IF in_oper_type = 0 THEN
      p_check_before_create(in_obj_list    => in_obj_list,
                            in_reg_kind    => in_reg_kind,
                            out_check_flag => l_check_flag);
    ELSE
      l_check_flag := 0;
    END IF;
    --ДОДАЄМО НОВИЙ ЗАПИС В РЕЄСТР

    IF l_check_flag <> -999 THEN
      IF out_reg_id IS NULL THEN
        --ГЕНЕРУЄМО НОВИЙ ID
        p_get_new_id(in_obj_name => 'ESCR_REGISTER', out_id => out_reg_id);
        --ФОРМУЄМО ВНУТРІШНІЙ НОМЕР РЕЄСТРУ
        l_inner_number := 'Реєстр № ' || out_reg_id || ' за період з ' ||
                          to_char(in_date_from, lc_date_format) || ' по ' ||
                          to_char(in_date_to, lc_date_format) ||
                          ' відділення ' || c_branch;
        INSERT INTO escr_register
          (id,
           inner_number,
           outer_number,
           create_date,
           date_from,
           date_to,
           reg_type_id,
           reg_kind_id,
           branch,
           reg_level,
           user_id,
           user_name,
           status_id,
           reg_union_flag)
        VALUES
          (out_reg_id,
           l_inner_number,
           NULL,
           l_create_date,
           trunc(in_date_from),
           trunc(in_date_to),
           l_reg_type_id,
           l_reg_kind_id,
           c_branch,
           in_reg_level,
           user_id,
           user_name,
           l_status_id,
           l_reg_union_flag) log errors INTO err$_escr_register
          ('INSERT') reject LIMIT unlimited;
        --ВСТАНОВЛЮЄМО СТАТУТ РЕЄСТРА
        -- DOC_TYPE МОЖЕ ПРИЙМАТИ ЗНАЧЕННЯ 1 -РЕЄСТР,0-КРЕДИТ
        -- OPER_TYPE 0-РЕЄСТР-КРЕДИТ,1- РЕЄСТР-РЕЄСТР
        ---!!!!ДОДАТИ перевірку на статус
      END IF;
      IF in_obj_list IS NOT NULL AND in_oper_type = 0 AND in_reg_level = 0 THEN
        p_mapping(in_in_doc_id    => out_reg_id,
                  in_in_doc_type  => 1,
                  in_out_doc_id   => in_obj_list,
                  in_out_doc_type => 0,
                  in_oper_type    => in_oper_type,
                  in_oper_date    => SYSDATE);
        p_set_obj_status(in_obj_id      => out_reg_id,
                         in_obj_type    => 1,
                         in_status_code => 'ADD_TO_REGISTER',
                         in_set_date    => l_create_date);
      END IF;
      IF in_obj_list IS NOT NULL AND in_oper_type = 1 AND in_reg_level = 0 THEN
        p_mapping(in_in_doc_id    => out_reg_id,
                  in_in_doc_type  => 1,
                  in_out_doc_id   => in_obj_list,
                  in_out_doc_type => 1,
                  in_oper_type    => in_oper_type,
                  in_oper_date    => SYSDATE);
        p_set_obj_status(in_obj_id      => out_reg_id,
                         in_obj_type    => 1,
                         in_status_code => 'ADD_TO_REGISTER',
                         in_set_date    => l_create_date);
      END IF;
      IF in_obj_list IS NOT NULL AND in_oper_type = 1 AND in_reg_level = 1 THEN
        p_mapping(in_in_doc_id    => out_reg_id,
                  in_in_doc_type  => 1,
                  in_out_doc_id   => in_obj_list,
                  in_out_doc_type => 1,
                  in_oper_type    => in_oper_type,
                  in_oper_date    => SYSDATE);
        /*p_set_obj_status(in_obj_id      => out_reg_id
        ,in_obj_type    => 1
        ,in_status_code => 'RECEIVED'
        ,in_set_date    => l_create_date);*/
      END IF;
    ELSIF l_check_flag <> 0 THEN
      out_reg_id := l_check_flag; --веб виводить повідомлення, що є помилкові КД і реєстр не може бути створено
    END IF;
    -- out_reg_id:=-998;
  END p_reg_create;
  /**********************************************
     PROCEDURE  p_event_del
     DESCRIPTION: Видалення енергоефективного заходу,
     у випадку,якщо його не погоджуно ДУУ
  *********************************************/
  PROCEDURE p_event_del(in_deal_id  escr_reg_body.deal_id%TYPE,
                        in_event_id escr_reg_body.id%TYPE) IS
  BEGIN
    DELETE FROM escr_reg_body t
     WHERE t.id = in_event_id
       AND t.deal_id = in_deal_id;
  END p_event_del;
  /**********************************************
     PROCEDURE  p_reg_del
     DESCRIPTION: Видалення реєстру
  *********************************************/
  PROCEDURE p_reg_del(in_reg_id     escr_register.id%TYPE,
                      in_check_flag number default 1) IS
  BEGIN
    -- перевіряємо чи має реєстр зв*язки по входу і виходу
    p_reg_has_in_mapping(in_reg_id => in_reg_id, out_has_flag => l_in_flag);
    p_reg_has_out_mapping(in_reg_id    => in_reg_id,
                          out_has_flag => l_out_flag);
    if in_check_flag = 1 then
      IF l_in_flag = 0 AND l_out_flag = 0 THEN
        DELETE FROM escr_register t WHERE t.id = in_reg_id;
      END IF;
    elsif in_check_flag = 0 then
      delete from escr_reg_mapping t
       where t.out_doc_id = in_reg_id
         and t.oper_type = 1;
      delete from escr_reg_body t
       where t.deal_id in (select t1.out_doc_id
                             from escr_reg_mapping t1
                            where t1.in_doc_id = in_reg_id
                              and t1.oper_type = 0);
      delete from nd_txt t
       where t.nd in (select t1.out_doc_id
                        from escr_reg_mapping t1
                       where t1.in_doc_id = in_reg_id
                         and t1.oper_type = 0)
         and t.tag = 'ES000';
      delete from escr_reg_header t
       where t.deal_id in (select t1.out_doc_id
                             from escr_reg_mapping t1
                            where t1.in_doc_id = in_reg_id
                              and t1.oper_type = 0);
      delete from escr_reg_mapping t
       where t.in_doc_id = in_reg_id
         and t.oper_type = 0;
      delete from escr_register t where t.id = in_reg_id;
    end if;
  END p_reg_del;
  /**********************************************
     PROCEDURE   P_SET_REG_OUT_NUMBER
     DESCRIPTION: ВСТАНОВЛЮЄ ЗОВНІШНІЙ НОМЕР РЕЄСТРА
  *********************************************/
  PROCEDURE p_set_reg_out_number(in_reg_id     escr_register.id%TYPE,
                                 in_out_number escr_register.outer_number%TYPE DEFAULT NULL) IS
  BEGIN
    --ДОДАТИ ПЕРЕВІРКУ НА ІСНУВАННЯ  REG_ID
    UPDATE escr_register
       SET outer_number = in_out_number
     WHERE id = in_reg_id;
    --cck_app.set_nd_txt(in_obj_id, 'ES007', in_status_comment);
    BEGIN

      pkg_escr_reg_utl.p_set_obj_status(in_obj_id         => in_reg_id,
                                        in_obj_type       => 1,
                                        in_status_code    => 'CONFIRMED_GVI',
                                        in_status_comment => '',
                                        in_obj_check      => 1,
                                        in_set_date       => SYSDATE,
                                        in_oper_level     => 1);
    END;

  END p_set_reg_out_number;
  /**********************************************
     PROCEDURE   f_convert_to_number
     DESCRIPTION: конверту тип в число
  *********************************************/
  FUNCTION f_convert_to_number(p_str VARCHAR2) RETURN NUMBER IS
  BEGIN
    RETURN to_number(REPLACE(REPLACE(p_str,
                                     ',',
                                     substr(to_char(11 / 10), 2, 1)),
                             '.',
                             substr(to_char(11 / 10), 2, 1)));
  EXCEPTION
    WHEN OTHERS THEN
      raise_application_error(-20000, SQLERRM, TRUE);
  END f_convert_to_number;
  /**********************************************
     PROCEDURE   p_received_xml
     DESCRIPTION: Процедура отримує від РУ на вході xml файл і запсиує в таблицю
  *********************************************/
  PROCEDURE p_received_xml(in_reg_xml IN CLOB, in_flag NUMBER DEFAULT 0) IS
  BEGIN
    bars_audit.info('ESCR.p_received_xml.Ok');
    p_get_new_id(in_obj_name => 'escr_reg_xml_files', out_id => p_new_id);
    INSERT INTO escr_reg_xml_files
      (id,
       branch,
       CLOB,
       oper_date,
       reg_count,
       reg_header_count,
       reg_body_count,
       err_text)
    VALUES
      (p_new_id, c_branch, in_reg_xml, SYSDATE, 0, 0, 0, NULL) log errors INTO err$_escr_reg_xml_files
      ('INSERT') reject LIMIT unlimited;
    IF in_flag = 0 THEN
      --p_xml_parse(in_reg_xml => in_reg_xml);
      p_xml_parse(in_file_id => p_new_id);
    END IF;
  END p_received_xml;

  /**********************************************
     PROCEDURE   p_reg_ins_from_xml
     DESCRIPTION: формує колекцію реєстрів і роботь вставку в таблицю escr_register
  *********************************************/

  PROCEDURE p_reg_ins_xml(in_dom_doc IN xmldom.domdocument,
                          in_file_id NUMBER DEFAULT NULL) IS

    l_escrparamlist dbms_xmldom.domnodelist;
    l_escrparam     dbms_xmldom.domnode;

    h     VARCHAR2(100) := 'bars.pkg_escr_reg_utls.p_reg_ins_xml.';
    l_str VARCHAR2(2000);

    l_reg_rec            t_register := t_register();
    l_reg_count          NUMBER;
    l_error_count_before NUMBER;
    l_error_count_after  NUMBER;
  BEGIN

    bars_audit.trace(h || 'Started');
    begin
      select count(t.id)
        into l_error_count_before
        from err$_escr_register t;
    exception
      when others then
        l_error_count_before := 0;
    end;
    --  Формуємо колекцію реєстрів
    l_escrparamlist := dbms_xmldom.getelementsbytagname(in_dom_doc,
                                                        'EscrParam');
    FOR i IN 0 .. dbms_xmldom.getlength(l_escrparamlist) - 1 LOOP
      l_escrparam := dbms_xmldom.item(l_escrparamlist, i);

      l_reg_rec.extend;

      dbms_xslprocessor.valueof(l_escrparam, 'register/ID/text()', l_str);
      l_reg_rec(l_reg_rec.last).id := f_convert_to_number(l_str);

      dbms_xslprocessor.valueof(l_escrparam,
                                'register/INNER_NUMBER/text()',
                                l_str);
      l_reg_rec(l_reg_rec.last).inner_number := TRIM(l_str);

      dbms_xslprocessor.valueof(l_escrparam,
                                'register/OUTER_NUMBER/text()',
                                l_str);
      l_reg_rec(l_reg_rec.last).outer_number := TRIM(l_str);

      l_reg_rec(l_reg_rec.last).create_date := SYSDATE;

      dbms_xslprocessor.valueof(l_escrparam,
                                'register/DATE_FROM/text()',
                                l_str);
      l_reg_rec(l_reg_rec.last).date_from := to_date(substr(l_str, 1, 10),
                                                     'yyyy-mm-dd');

      dbms_xslprocessor.valueof(l_escrparam,
                                'register/DATE_TO/text()',
                                l_str);
      l_reg_rec(l_reg_rec.last).date_to := to_date(substr(l_str, 1, 10),
                                                   'yyyy-mm-dd');

      dbms_xslprocessor.valueof(l_escrparam,
                                'register/REG_TYPE_ID/text()',
                                l_str);
      l_reg_rec(l_reg_rec.last).reg_type_id := f_convert_to_number(l_str);

      dbms_xslprocessor.valueof(l_escrparam,
                                'register/REG_KIND_ID/text()',
                                l_str);
      l_reg_rec(l_reg_rec.last).reg_kind_id := f_convert_to_number(l_str);

      dbms_xslprocessor.valueof(l_escrparam,
                                'register/BRANCH/text()',
                                l_str);
      l_reg_rec(l_reg_rec.last).branch := TRIM(l_str);

      dbms_xslprocessor.valueof(l_escrparam,
                                'register/REG_LEVEL/text()',
                                l_str);
      l_reg_rec(l_reg_rec.last).reg_level := f_convert_to_number(l_str);

      dbms_xslprocessor.valueof(l_escrparam,
                                'register/USER_ID/text()',
                                l_str);
      l_reg_rec(l_reg_rec.last).user_id := f_convert_to_number(l_str);

      dbms_xslprocessor.valueof(l_escrparam,
                                'register/USER_NAME/text()',
                                l_str);
      l_reg_rec(l_reg_rec.last).user_name :=  /*TRIM(convert(*/
       l_str
      /*,'CL8MSWIN1251'
                                                                                                                                                                                                                                                         ,'UTF8'))*/
        ;

      dbms_xslprocessor.valueof(l_escrparam,
                                'register/STATUS_ID/text()',
                                l_str);
      l_reg_rec(l_reg_rec.last).status_id := f_convert_to_number(l_str);

      dbms_xslprocessor.valueof(l_escrparam,
                                'register/REG_UNION_FLAG/text()',
                                l_str);
      l_reg_rec(l_reg_rec.last).reg_union_flag := 0;
      l_reg_rec(l_reg_rec.last).file_id := in_file_id;
      -- dbms_xmldom.freedocument(in_dom_doc);
    END LOOP;

    --Вставка в таблицю  escr_register всіх реєстрів з коелкції
    BEGIN
      FORALL j IN l_reg_rec.first .. l_reg_rec.last
        INSERT INTO escr_register t
        VALUES l_reg_rec
          (j) log errors INTO err$_escr_register
          ('INSERT') reject LIMIT unlimited;
    END;
    begin
      select count(t.id)
        into l_error_count_after
        from err$_escr_register t;
    exception
      when others then
        l_error_count_after := 0;
    end;
    if l_error_count_after <> l_error_count_before then
      RAISE_APPLICATION_ERROR(-20001,
                              'Помилка при створенні реєстру на ЦБД. Деталі в таблиці err$_escr_register  ');
    end if;
    l_reg_count := l_reg_rec.count;
    UPDATE escr_reg_xml_files t
       SET t.reg_count = l_reg_count
     WHERE t.id = in_file_id;
    --Проставляємо реєстрам статуси
    FOR i IN 1 .. l_reg_rec.count LOOP
      p_set_obj_status(in_obj_id      => l_reg_rec(i).id,
                       in_obj_type    => 1,
                       in_status_code => 'RECEIVED',
                       in_obj_check   => 1 /*0*/);
    END LOOP;

    --очистка,якщо виникли помилки
    l_reg_rec.delete();
    l_reg_rec := NULL;
    bars_audit.trace(h || ' finished.');
  END p_reg_ins_xml;
  /*****************************************************************************
     PROCEDURE   p_reg_header_ins_xml
     DESCRIPTION: парсінг xml і вставка в таблицю escr_reg_header
  *****************************************************************************/

  PROCEDURE p_reg_header_ins_xml(in_dom_doc IN xmldom.domdocument,
                                 in_file_id NUMBER DEFAULT 0) IS

    h                   VARCHAR2(100) := 'bars.pkg_escr_reg_utls.p_reg_header_ins_xml.';
    l_escrdealparamlist dbms_xmldom.domnodelist;
    l_escrdealparam     dbms_xmldom.domnode;

    l_reg_header         t_reg_header := t_reg_header();
    l_reg_mapping        t_reg_mapping := t_reg_mapping();
    l_str                VARCHAR(4000);
    l_reg_header_count   NUMBER;
    l_error_count_before NUMBER;
    l_error_count_after  NUMBER;
    l_error_count_before_1 NUMBER;
    l_error_count_after_1   NUMBER;
  BEGIN

    bars_audit.trace(h || 'Started');
    begin
      select count(t.id)
        into l_error_count_before
        from err$_escr_reg_header t;
    exception
      when others then
        l_error_count_before := 0;
    end;
    begin
      select count(t.id)
        into l_error_count_before_1
        from err$_escr_reg_mapping t;
    exception
      when others then
        l_error_count_before_1 := 0;
    end;
    --Формуємо колекцію кредитів ,а також мапінг між кредитами та реєстрами
    l_escrdealparamlist := dbms_xmldom.getelementsbytagname(in_dom_doc,
                                                            'EscrDealParam');

    dbms_output.put_line(dbms_xmldom.getlength(l_escrdealparamlist));
    FOR i IN 0 .. dbms_xmldom.getlength(l_escrdealparamlist) - 1 LOOP
      l_escrdealparam := dbms_xmldom.item(l_escrdealparamlist, i);

      l_reg_header.extend;
      l_reg_header(l_reg_header.last).id := s_escr.nextval;
      dbms_xslprocessor.valueof(l_escrdealparam,
                                'credit/CUSTOMER_ID/text()',
                                l_str);
      l_reg_header(l_reg_header.last).customer_id := f_convert_to_number(l_str);

      dbms_xslprocessor.valueof(l_escrdealparam,
                                'credit/CUSTOMER_NAME/text()',
                                l_str);

      l_reg_header(l_reg_header.last).customer_name := l_str;

      dbms_xslprocessor.valueof(l_escrdealparam,
                                'credit/CUSTOMER_OKPO/text()',
                                l_str);
      l_reg_header(l_reg_header.last).customer_okpo := l_str;

      dbms_xslprocessor.valueof(l_escrdealparam,
                                'credit/CUSTOMER_REGION/text()',
                                l_str);

      l_reg_header(l_reg_header.last).customer_region := l_str;

      dbms_xslprocessor.valueof(l_escrdealparam,
                                'credit/CUSTOMER_FULL_ADDRESS/text()',
                                l_str);

      l_reg_header(l_reg_header.last).customer_full_address := l_str;

      dbms_xslprocessor.valueof(l_escrdealparam,
                                'credit/SUBS_NUMB/text()',
                                l_str);

      l_reg_header(l_reg_header.last).subs_numb := l_str;

      dbms_xslprocessor.valueof(l_escrdealparam,
                                'credit/SUBS_DATE/text()',
                                l_str);

      l_reg_header(l_reg_header.last).subs_date := to_date(substr(l_str,
                                                                  1,
                                                                  10),
                                                           'yyyy-mm-dd');

      dbms_xslprocessor.valueof(l_escrdealparam,
                                'credit/SUBS_DOC_TYPE/text()',
                                l_str);

      l_reg_header(l_reg_header.last).subs_doc_type := l_str;
      l_reg_mapping.extend;
      dbms_xslprocessor.valueof(l_escrdealparam,
                                'credit/DEAL_ID/text()',
                                l_str);
      l_reg_header(l_reg_header.last).deal_id := f_convert_to_number(l_str);
      l_reg_mapping(l_reg_mapping.last).out_doc_id := f_convert_to_number(l_str);
      dbms_xslprocessor.valueof(l_escrdealparam,
                                'credit/DEAL_NUMBER/text()',
                                l_str);
      l_reg_header(l_reg_header.last).deal_number := l_str;
      dbms_xslprocessor.valueof(l_escrdealparam,
                                'credit/DEAL_DATE_FROM/text()',
                                l_str);
      l_reg_header(l_reg_header.last).deal_date_from := to_date(substr(l_str,
                                                                       1,
                                                                       10),
                                                                'yyyy-mm-dd');
      dbms_xslprocessor.valueof(l_escrdealparam,
                                'credit/DEAL_DATE_TO/text()',
                                l_str);
      l_reg_header(l_reg_header.last).deal_date_to := to_date(substr(l_str,
                                                                     1,
                                                                     10),
                                                              'yyyy-mm-dd');
      dbms_xslprocessor.valueof(l_escrdealparam,
                                'credit/DEAL_TERM/text()',
                                l_str);
      l_reg_header(l_reg_header.last).deal_term := l_str;
      dbms_xslprocessor.valueof(l_escrdealparam,
                                'credit/DEAL_PRODUCT/text()',
                                l_str);
      l_reg_header(l_reg_header.last).deal_product := l_str;
      dbms_xslprocessor.valueof(l_escrdealparam,
                                'credit/DEAL_PRODUCT/text()',
                                l_str);
      l_reg_header(l_reg_header.last).deal_product := l_str;
      dbms_xslprocessor.valueof(l_escrdealparam,
                                'credit/DEAL_STATE/text()',
                                l_str);
      l_reg_header(l_reg_header.last).deal_state := l_str;

      dbms_xslprocessor.valueof(l_escrdealparam,
                                'credit/DEAL_TYPE_NAME/text()',
                                l_str);
      l_reg_header(l_reg_header.last).deal_type_name := l_str;
      dbms_xslprocessor.valueof(l_escrdealparam,
                                'credit/DEAL_SUM/text()',
                                l_str);
      -- l_reg_header(l_reg_header.last).deal_sum := replace(l_str,'.',',');
      l_reg_header(l_reg_header.last).deal_sum := l_str;
      dbms_xslprocessor.valueof(l_escrdealparam,
                                'credit/GOOD_COST/text()',
                                l_str);
      --l_reg_header(l_reg_header.last).good_cost := replace(l_str,'.',',');
      l_reg_header(l_reg_header.last).good_cost := l_str;
      dbms_xslprocessor.valueof(l_escrdealparam,
                                'credit/NLS/text()',
                                l_str);
      l_reg_header(l_reg_header.last).nls := l_str;

      dbms_xslprocessor.valueof(l_escrdealparam,
                                'credit/DOC_DATE/text()',
                                l_str);
      l_reg_header(l_reg_header.last).doc_date := to_date(substr(l_str,
                                                                 1,
                                                                 10),
                                                          'yyyy-mm-dd');
      dbms_xslprocessor.valueof(l_escrdealparam,
                                'credit/COMP_SUM/text()',
                                l_str);
      --l_reg_header(l_reg_header.last).comp_sum := replace(l_str,'.',',');
      l_reg_header(l_reg_header.last).comp_sum := l_str;
      dbms_xslprocessor.valueof(l_escrdealparam,
                                'credit/BRANCH_CODE/text()',
                                l_str);
      l_reg_header(l_reg_header.last).branch_code := l_str;
      dbms_xslprocessor.valueof(l_escrdealparam,
                                'credit/BRANCH_NAME/text()',
                                l_str);
      l_reg_header(l_reg_header.last).branch_name := l_str;
      dbms_xslprocessor.valueof(l_escrdealparam,
                                'credit/MFO/text()',
                                l_str);
      l_reg_header(l_reg_header.last).mfo := l_str;
      UPDATE escr_reg_xml_files t
         SET t.branch = l_str
       WHERE t.id = in_file_id;
      dbms_xslprocessor.valueof(l_escrdealparam,
                                'credit/USER_ID/text()',
                                l_str);
      l_reg_header(l_reg_header.last).user_id := l_str;
      dbms_xslprocessor.valueof(l_escrdealparam,
                                'credit/USER_NAME/text()',
                                l_str);
      l_reg_header(l_reg_header.last).user_name := l_str;

      --заповнюємо колекцію мапінгу

      l_reg_mapping(l_reg_mapping.last).id := s_escr.nextval;
      dbms_xslprocessor.valueof(l_escrdealparam,
                                'credit/REG_ID/text()',
                                l_str);
      l_reg_mapping(l_reg_mapping.last).in_doc_id := f_convert_to_number(l_str);
      l_reg_mapping(l_reg_mapping.last).in_doc_type := 1;
      l_reg_mapping(l_reg_mapping.last).out_doc_type := 0;
      l_reg_mapping(l_reg_mapping.last).branch := c_branch;
      l_reg_mapping(l_reg_mapping.last).oper_date := SYSDATE;
      l_reg_mapping(l_reg_mapping.last).oper_type := 0;

    END LOOP;

    /*    --очищаємо таблиці,що містять помилкові записи
    BEGIN
      EXECUTE IMMEDIATE ' truncate table  ERR$_escr_reg_header';
    END;*/
    BEGIN
      FORALL j IN l_reg_header.first .. l_reg_header.last
        INSERT INTO escr_reg_header t
        VALUES l_reg_header
          (j) log errors INTO err$_escr_reg_header
          ('INSERT') reject LIMIT unlimited;
      -- l_reg_header.delete;
    END;

    BEGIN
      FORALL j IN l_reg_mapping.first .. l_reg_mapping.last
        INSERT INTO escr_reg_mapping t
        VALUES l_reg_mapping
          (j) log errors INTO err$_escr_reg_mapping
          ('INSERT') reject LIMIT unlimited;
      l_reg_mapping.delete;
      bars_audit.trace(h || 'Finished');
    END;
    begin
      select count(t.id)
        into l_error_count_after
        from err$_escr_reg_header t;
    exception
      when others then
        l_error_count_after := 0;
    end;
    if l_error_count_after <> l_error_count_before then
      RAISE_APPLICATION_ERROR(-20001,
                              'Помилка при додаванні інформації по КД на ЦБД. Деталі в таблиці err$_escr_reg_header  ');
    end if;
        begin
      select count(t.id)
        into l_error_count_after_1
        from err$_escr_reg_mapping t;
    exception
      when others then
        l_error_count_after_1 := 0;
    end;
    if l_error_count_after_1 <> l_error_count_before_1 then
      RAISE_APPLICATION_ERROR(-20001,
                              'Помилка при додаванні інформації по КД на ЦБД. Деталі в таблиці err$_escr_reg_mapping  ');
    end if;
    --Проставляємо по кредитам  статуси
    FOR i IN 1 .. l_reg_header.count LOOP
      p_set_obj_status(in_obj_id         => l_reg_header(i).deal_id,
                       in_obj_type       => 0,
                       in_status_code    => 'RECEIVED',
                       in_status_comment => NULL,
                       in_obj_check      => 0,
                       in_set_date       => SYSDATE,
                       in_oper_level     => 1);
    END LOOP;
    l_reg_header_count := l_reg_header.count;
    UPDATE escr_reg_xml_files t
       SET t.reg_header_count = l_reg_header_count
     WHERE t.id = in_file_id;
    --очистка,якщо виникли помилки
    l_reg_header.delete();
    l_reg_header := NULL;
    l_reg_mapping.delete();
    l_reg_mapping := NULL;

    -- dbms_xmldom.freedocument(in_dom_doc);
  END p_reg_header_ins_xml;
  /**********************************************
     PROCEDURE   p_reg_body_ins__xml
     DESCRIPTION: парсінг
  *********************************************/

  PROCEDURE p_reg_body_ins_xml(in_dom_doc IN xmldom.domdocument,
                               in_file_id NUMBER DEFAULT 0) IS

    h                     VARCHAR2(100) := 'bars.pkg_escr_reg_utls.p_reg_body_ins_xml.';
    l_escreventsparamlist dbms_xmldom.domnodelist;
    l_escreventsparam     dbms_xmldom.domnode;

    l_reg_body       t_reg_body := t_reg_body();
    l_str            VARCHAR(4000);
    l_reg_body_count NUMBER;
    l_error_count_before NUMBER;
    l_error_count_after  NUMBER;
  BEGIN

    bars_audit.trace(h || 'Started');
    begin
      select count(t.id)
        into l_error_count_before
        from err$_escr_reg_body t;
    exception
      when others then
        l_error_count_before := 0;
    end;
    --Формуємо колекцію кредитів ,а також мапінг між кредитами та реєстрами
    l_escreventsparamlist := dbms_xmldom.getelementsbytagname(in_dom_doc,
                                                              'EscrHeaderEvents');

    dbms_output.put_line(dbms_xmldom.getlength(l_escreventsparamlist));
    FOR i IN 0 .. dbms_xmldom.getlength(l_escreventsparamlist) - 1 LOOP
      l_escreventsparam := dbms_xmldom.item(l_escreventsparamlist, i);

      l_reg_body.extend;
      l_reg_body(l_reg_body.last).id := s_escr.nextval;
      dbms_xslprocessor.valueof(l_escreventsparam, 'DEAL_ID/text()', l_str);
      l_reg_body(l_reg_body.last).deal_id := f_convert_to_number(l_str);
      dbms_xslprocessor.valueof(l_escreventsparam,
                                'DEAL_ADR_ID/text()',
                                l_str);
      l_reg_body(l_reg_body.last).deal_adr_id := f_convert_to_number(l_str);
      dbms_xslprocessor.valueof(l_escreventsparam,
                                'DEAL_REGION/text()',
                                l_str);
      l_reg_body(l_reg_body.last).deal_region := l_str;
      dbms_xslprocessor.valueof(l_escreventsparam,
                                'DEAL_FULL_ADDRESS/text()',
                                l_str);
      l_reg_body(l_reg_body.last).deal_full_address := l_str;
      dbms_xslprocessor.valueof(l_escreventsparam,
                                'DEAL_BUILD_ID/text()',
                                l_str);
      l_reg_body(l_reg_body.last).deal_build_id := f_convert_to_number(l_str);
      dbms_xslprocessor.valueof(l_escreventsparam,
                                'DEAL_EVENT_ID/text()',
                                l_str);
      l_reg_body(l_reg_body.last).deal_event_id := f_convert_to_number(l_str);

    END LOOP;
    --очищаємо таблиці,що містять помилкові записи
    /* BEGIN
      EXECUTE IMMEDIATE ' truncate table  ERR$_escr_reg_body';
    END;*/
    BEGIN
      FORALL j IN l_reg_body.first .. l_reg_body.last
        INSERT INTO escr_reg_body t
        VALUES l_reg_body
          (j) log errors INTO err$_escr_reg_body
          ('INSERT') reject LIMIT unlimited;
      -- l_reg_header.delete;
    END;
    begin
      select count(t.id)
        into l_error_count_after
        from err$_escr_reg_body t;
    exception
      when others then
        l_error_count_after := 0;
    end;
    if l_error_count_after <> l_error_count_before then
      RAISE_APPLICATION_ERROR(-20001,
                              'Помилка при додаванні інформації по КД на ЦБД. Деталі в таблиці err$_escr_reg_body  ');
    end if;
    l_reg_body_count := l_reg_body.count;
    UPDATE escr_reg_xml_files t
       SET t.reg_body_count = l_reg_body_count
     WHERE t.id = in_file_id;
    --очистка,якщо виникли помилки
    l_reg_body.delete();
    l_reg_body := NULL;

    -- dbms_xmldom.freedocument(in_dom_doc);
  END p_reg_body_ins_xml;
  /**********************************************
     PROCEDURE   p_xml_parse
     DESCRIPTION: парсінг отриманого xml
  *********************************************/

  PROCEDURE p_xml_parse(in_reg_xml IN CLOB DEFAULT NULL,
                        in_file_id NUMBER DEFAULT NULL) IS
    l_doc     dbms_xmldom.domdocument;
    h         VARCHAR2(100) := 'bars.pkg_escr_reg_utls.p_xml_parse.';
    l_parser  dbms_xmlparser.parser;
    l_reg_xml CLOB;
  BEGIN
    IF in_file_id IS NOT NULL THEN
      BEGIN
        SELECT t.clob
          INTO l_reg_xml
          FROM escr_reg_xml_files t
         WHERE t.id = in_file_id;
      EXCEPTION
        WHEN no_data_found THEN
          l_reg_xml := in_reg_xml;
      END;
    ELSE
      l_reg_xml := in_reg_xml;
    END IF;
    bars_audit.trace(h || 'Started');
    -- dbms_session.set_nls('NLS_DATE_FORMAT', '''DD/MON/YYYY''');
    l_parser := dbms_xmlparser.newparser;
    dbms_xmlparser.parseclob(l_parser, l_reg_xml);
    bars_audit.trace(h || 'clob loaded');

    l_doc := dbms_xmlparser.getdocument(l_parser);
    bars_audit.trace(h || 'getdocument done');

    p_reg_ins_xml(l_doc, in_file_id);
    p_reg_header_ins_xml(l_doc, in_file_id);
    p_reg_body_ins_xml(l_doc, in_file_id);
    --Перевірка на дублі
    begin
      p_check_after_create;
    exception
      when others then
        bars_audit.error('PKG_ESCR_REG_UTL.P_CHECK_AFTER_CREATE Реєстри, створені по файлу  in_file_id= ' ||
                         in_file_id ||
                         ' не пройшли перевірку на дублікати.');
    end;
    --
    dbms_xmlparser.freeparser(l_parser);
    dbms_xmldom.freedocument(l_doc);
  END p_xml_parse;
  /********************************************************
     PROCEDURE p_set_new_sum
     DESCRIPTION: Встановлюються нова вартість товару
                  сума кредиту та сума компенсації для
                  КД по яким ДЕЕ не погодив початкові суми
  *******************************************************/
  PROCEDURE p_set_new_sum(in_deal_id       NUMBER,
                          in_new_good_cost NUMBER,
                          in_new_deal_sum  NUMBER,
                          in_new_comp_sum  NUMBER) IS
    v_curr_branch branch.branch%type := bc.current_branch_code();
  BEGIN
    logger.info('ESCR.p_set_new_sum in_deal_id=' || in_deal_id ||
                ' ,in_new_good_cost=' || in_new_good_cost);
    for r in (select kf from cc_deal where nd = in_deal_id)
    loop
      bc.go(r.kf);
    end loop;
    cck_app.set_nd_txt(in_deal_id, 'ES010', in_new_good_cost);
    cck_app.set_nd_txt(in_deal_id, 'ES011', in_new_deal_sum);
    cck_app.set_nd_txt(in_deal_id, 'ES012', in_new_comp_sum);
    bc.go(v_curr_branch);

  END p_set_new_sum;
  /***************************************************************
     PROCEDURE   p_change_comp_sum
     DESCRIPTION: Розрахунок нової суми КД та суми компенсації,
     для випадків, коли КД компенсують частково
  **************************************************************/
  PROCEDURE p_change_comp_sum(in_deal_id       escr_reg_header.deal_id%TYPE,
                              in_new_good_cost escr_reg_header.new_good_cost%TYPE) IS
    l_new_comp_sum NUMBER;
  BEGIN
    UPDATE bars.escr_reg_header t
       SET t.new_good_cost = in_new_good_cost
     WHERE t.deal_id = in_deal_id;
    UPDATE bars.escr_reg_header t
       SET t.new_deal_sum = t.deal_sum * (t.new_good_cost / t.good_cost)
     WHERE t.deal_id = in_deal_id;

    FOR rez IN (SELECT *
                  FROM bars.vw_escr_reg_header_ca t
                 WHERE t.deal_id = in_deal_id) LOOP
      CASE
        WHEN rez.deal_date_from <= to_date('26/08/2015', 'dd/mm/yyyy') AND
             round(rez.deal_sum * 0.3, 2) <= 5000 AND rez.subs_numb IS NULL AND
             rez.reg_type_id = 1 THEN
          l_new_comp_sum := round(rez.new_deal_sum * 0.2, 2);
        WHEN rez.deal_date_from <= to_date('26/08/2015', 'dd/mm/yyyy') AND
             round(rez.deal_sum * 0.2, 2) > 5000 AND rez.subs_numb IS NULL AND
             rez.reg_type_id = 1 THEN
          l_new_comp_sum := 5000;
        WHEN rez.deal_date_from <= to_date('26/08/2015', 'dd/mm/yyyy') AND
             round(rez.new_deal_sum * 0.3, 2) <= 10000 AND
             rez.subs_numb IS NULL AND rez.reg_type_id = 2 THEN
          l_new_comp_sum := round(rez.new_deal_sum * 0.3, 2);
        WHEN rez.deal_date_from <= to_date('26/08/2015', 'dd/mm/yyyy') AND
             round(rez.new_deal_sum * 0.3, 2) > 10000 AND
             rez.subs_numb IS NULL AND rez.reg_type_id = 2 THEN
          l_new_comp_sum := 10000;
        WHEN rez.deal_date_from >= to_date('27/08/2015', 'dd/mm/yyyy') AND
             rez.deal_date_from < to_date('19/09/2016', 'dd/mm/yyyy') AND
             round(rez.deal_sum * 0.2, 2) > 12000 AND rez.subs_numb IS NULL AND
             rez.reg_type_id = 1 THEN
          l_new_comp_sum := 12000;
        WHEN rez.deal_date_from >= to_date('27/08/2015', 'dd/mm/yyyy') AND
             rez.deal_date_from < to_date('19/09/2016', 'dd/mm/yyyy') AND
             round(rez.deal_sum * 0.2, 2) > 12000 AND rez.subs_numb IS NULL AND
             rez.reg_type_id = 1 THEN
          l_new_comp_sum := 12000;
        WHEN rez.deal_date_from >= to_date('27/08/2015', 'dd/mm/yyyy') AND
             rez.deal_date_from < to_date('19/09/2016', 'dd/mm/yyyy') AND
             round(rez.new_deal_sum * 0.2, 2) <= 12000 AND
             rez.subs_numb IS NULL AND rez.reg_type_id = 1 THEN
          l_new_comp_sum := round(rez.new_deal_sum * 0.2, 2);
        WHEN rez.deal_date_from >= to_date('27/08/2015', 'dd/mm/yyyy') AND
             rez.deal_date_from < to_date('19/09/2016', 'dd/mm/yyyy') AND
             round(rez.new_deal_sum * 0.7, 2) <= 12000 AND
             rez.subs_numb IS NOT NULL AND rez.reg_type_id = 1 THEN
          l_new_comp_sum := round(rez.new_deal_sum * 0.7, 2);
        WHEN rez.deal_date_from >= to_date('27/08/2015', 'dd/mm/yyyy') AND
             rez.deal_date_from < to_date('19/09/2016', 'dd/mm/yyyy') AND
             round(rez.new_deal_sum * 0.7, 2) > 12000 AND
             rez.subs_numb IS NOT NULL AND rez.reg_type_id = 1 THEN
          l_new_comp_sum := 12000;
        WHEN rez.deal_date_from >= to_date('27/08/2015', 'dd/mm/yyyy') AND
             rez.deal_date_from < to_date('19/09/2016', 'dd/mm/yyyy') AND
             round(rez.deal_sum * 0.2, 2) > 12000 AND rez.subs_numb IS NULL AND
             rez.reg_type_id = 1 THEN
          l_new_comp_sum := 12000;
        WHEN rez.deal_date_from >= to_date('27/08/2015', 'dd/mm/yyyy') AND
             rez.deal_date_from < to_date('19/09/2016', 'dd/mm/yyyy') AND
             round(rez.new_deal_sum * 0.3, 2) > 14000 AND
             rez.subs_numb IS NULL AND rez.reg_type_id = 2 THEN
          l_new_comp_sum := 14000;
        WHEN rez.deal_date_from >= to_date('27/08/2015', 'dd/mm/yyyy') AND
             rez.deal_date_from < to_date('19/09/2016', 'dd/mm/yyyy') AND
             round(rez.new_deal_sum * 0.3, 2) <= 14000 AND
             rez.subs_numb IS NULL AND rez.reg_type_id = 2 THEN
          l_new_comp_sum := round(rez.new_deal_sum * 0.3, 2);
        WHEN rez.deal_date_from >= to_date('27/08/2015', 'dd/mm/yyyy') AND
             rez.deal_date_from < to_date('19/09/2016', 'dd/mm/yyyy') AND
             round(rez.new_deal_sum * 0.7, 2) <= 14000 AND
             rez.subs_numb IS NOT NULL AND rez.reg_type_id = 2 THEN
          l_new_comp_sum := round(rez.new_deal_sum * 0.7, 2);
        WHEN rez.deal_date_from >= to_date('27/08/2015', 'dd/mm/yyyy') AND
             rez.deal_date_from < to_date('19/09/2016', 'dd/mm/yyyy') AND
             round(rez.new_deal_sum * 0.7, 2) > 14000 AND
             rez.subs_numb IS NOT NULL AND rez.reg_type_id = 2 THEN
          l_new_comp_sum := 14000;
        WHEN rez.deal_date_from >= to_date('19/09/2016', 'dd/mm/yyyy') AND
             round(rez.new_deal_sum * 0.35, 2) > 12000 AND
             rez.subs_numb IS NOT NULL AND rez.reg_type_id = 1 THEN
          l_new_comp_sum := 12000;
        WHEN rez.deal_date_from >= to_date('19/09/2016', 'dd/mm/yyyy') AND
             round(rez.deal_sum * 0.35, 2) <= 12000 AND
             rez.subs_numb IS NOT NULL AND rez.reg_type_id = 1 THEN
          l_new_comp_sum := round(rez.new_deal_sum * 0.35, 2);
        WHEN rez.deal_date_from >= to_date('19/09/2016', 'dd/mm/yyyy') AND
             round(rez.new_deal_sum * 0.2, 2) > 12000 AND
             rez.subs_numb IS NULL AND rez.reg_type_id = 1 THEN
          l_new_comp_sum := 12000;
        WHEN rez.deal_date_from >= to_date('19/09/2016', 'dd/mm/yyyy') AND
             round(rez.new_deal_sum * 0.2, 2) <= 12000 AND
             rez.subs_numb IS NULL AND rez.reg_type_id = 1 THEN
          l_new_comp_sum := round(rez.new_deal_sum * 0.2, 2);
        WHEN rez.deal_date_from >= to_date('19/09/2016', 'dd/mm/yyyy') AND
             round(rez.new_deal_sum * 0.35, 2) > 14000 AND
             rez.reg_type_id = 2 THEN
          l_new_comp_sum := 14000;
        WHEN rez.deal_date_from >= to_date('19/09/2016', 'dd/mm/yyyy') AND
             round(rez.new_deal_sum * 0.35, 2) <= 14000 AND
             rez.reg_type_id = 2 THEN
          l_new_comp_sum := round(rez.new_deal_sum * 0.35, 2);
      END CASE;
    END LOOP;
    UPDATE bars.escr_reg_header t
       SET t.new_comp_sum = l_new_comp_sum
     WHERE t.deal_id = in_deal_id;
  END p_change_comp_sum;
  /**********************************************
     PROCEDURE   p_check_comp_sum
     DESCRIPTION: Процедура перевірки суми, к-сті
                  реєстрів ,які будуть оплачуватися
  *********************************************/
  PROCEDURE p_check_comp_sum(in_reg_id      escr_register.id%type,
                             out_deal_count out number,
                             out_deal_sum   out number,
                             out_good_cost  out number,
                             out_comp_sum   out number) is

    l_deal_count number;
    l_deal_sum   number;
    l_good_cost  number;
    l_comp_sum   number;
  begin
    begin
      select count(rez.deal_id),
             sum(rez.deal_sum),
             sum(rez.good_cost),
             sum(rez.comp_sum)
        into l_deal_count, l_deal_sum, l_good_cost, l_comp_sum
        from (select in_reg_id reg_id,
                     er.deal_id,
                     er.deal_sum,
                     er.good_cost,
                     er.comp_sum,
                     reg.outer_number
                from escr_reg_header er,
                     (select  t.id,t1.in_doc_id
                        from escr_register t, escr_reg_mapping t1
                       where t1.in_doc_id = in_reg_id
                         and t1.out_doc_id = t.id) r,
                    escr_reg_mapping em,
                       escr_register reg
                 where em.in_doc_id = r.id
                   and er.deal_id = em.out_doc_id
                   and reg.id=r.in_doc_id
                   and er.credit_status_id = 7
                   and reg.outer_number is not null
              union all
              select in_reg_id reg_id,
                     er.deal_id,
                     er.deal_sum,
                     er.good_cost,
                     er.comp_sum,
                     r.outer_number
                from escr_reg_header  er,
                     escr_reg_mapping em,
                     escr_register    r
               where r.id = in_reg_id
                 and er.deal_id = em.out_doc_id
                 and em.in_doc_id = r.id
                 and er.credit_status_id = 7
                 and r.outer_number is not null) rez
       group by rez.reg_id;
    exception
      when no_data_found then
        out_deal_count := 0;
        out_deal_sum   := 0;
        out_good_cost  := 0;
        out_comp_sum   := 0;
    end;
    out_deal_count := nvl(l_deal_count, 0);
    out_deal_sum   := nvl(l_deal_sum, 0);
    out_good_cost  := nvl(l_good_cost, 0);
    out_comp_sum   := nvl(l_comp_sum, 0);
  end p_check_comp_sum;
  /**********************************************
     PROCEDURE    p_reg_repay
     DESCRIPTION: Переплати у випадку помилки під основної оплати
                  Фактично зміна стасутів об*єктів, що дозволить  виконати
                  повторну оплату
  *********************************************/
  PROCEDURE p_reg_repay(in_reg_list number_list) IS
  begin
    FOR i IN 1 .. in_reg_list.count LOOP
      pkg_escr_reg_utl.p_set_obj_status(in_obj_id         => in_reg_list(i),
                                        in_obj_type       => 1,
                                        in_status_code    => 'CONFIRMED_GVI',
                                        in_status_comment => '',
                                        in_obj_check      => 1,
                                        in_set_date       => sysdate,
                                        in_oper_level     => 1,
                                        in_repay_flag     => 1);
    end loop;
  end p_reg_repay;

  /**********************************************
     PROCEDURE   p_gen_pay
     DESCRIPTION: Процедура створення платіжних документів
  *********************************************/
  PROCEDURE p_gen_pay(in_reg_list number_list) IS
    oo       oper%ROWTYPE;
    aa       accounts%ROWTYPE;
    l_nlsa   oper.nlsa%TYPE;
    l_dblink VARCHAR2(100);
    l_user   VARCHAR2(100);
  BEGIN
    --DB-link
    BEGIN
      SELECT p.val
        INTO l_dblink
        FROM params$base p
       WHERE p.par = 'ESCR_LDBL';
    EXCEPTION
      WHEN no_data_found THEN
        NULL;
    END;
    --ACC
    BEGIN
      SELECT p.val
        INTO l_nlsa
        FROM params$base p
       WHERE p.par = 'ESCR_ACC_TEMP';
    EXCEPTION
      WHEN no_data_found THEN
        NULL;
    END;
    --USER
    BEGIN
      SELECT p.val
        INTO l_user
        FROM params$base p
       WHERE p.par = 'ESCR_USER';
    EXCEPTION
      WHEN no_data_found THEN
        NULL;
    END;
    oo.nlsa := l_nlsa;
    EXECUTE IMMEDIATE '
    declare
      l_g_mfo accounts.kf%type;
    begin
      bars.bars_login.login_user@' || l_dblink ||
                      '(null, null, null, null);
      l_g_mfo := bars.f_ourmfo_g@' || l_dblink || ';
      bars.bars_context.subst_branch@' || l_dblink ||
                      '(''/'' || l_g_mfo || ''/'');
    end;';

    BEGIN
      EXECUTE IMMEDIATE 'select acc,
       kf,
       nls,
       kv,
       branch,
       nlsalt,
       nbs,
       nbs2,
       daos,
       dapp,
       isp,
       nms,
       lim,
       ostb,
       ostc,
       ostf,
       ostq,
       dos,
       kos,
       dosq,
       kosq,
       pap,
       tip,
       vid,
       trcn,
       mdate,
       dazs,
       sec,
       accc,
       blkd,
       blkk,
       pos,
       seci,
       seco,
       grp,
       ostx,
       rnk,
       notifier_ref,
       tobo,
       bdate,
       opt,
       ob22,
       dappq,
       send_sms
                         from bars.accounts@' ||
                        l_dblink ||
                        ' where kv = ''980''
                          and nls = :p_nlsa
                          and dazs is null'
        INTO aa
        USING oo.nlsa;
    EXCEPTION
      WHEN no_data_found THEN
        raise_application_error(- (20203),
                                '\ не знайдено рах.' || l_nlsa || '/' ||
                                gl.baseval);
    END;
    oo.nam_b := 'Відшкодування коштів по ЕЗКР';
    oo.nam_a := substr(aa.nms, 1, 38);
    oo.nlsa  := aa.nls;
    oo.mfoa  := aa.kf;
    oo.kv    := aa.kv;
    FOR i IN 1 .. in_reg_list.count LOOP

      FOR k IN (select er.id,
                       er.customer_name,
                       er.customer_okpo,
                       er.deal_id,
                       er.deal_number,
                       er.deal_date_from,
                       er.deal_date_to,
                       er.deal_sum,
                       er.good_cost,
                       er.comp_sum,
                       er.branch_code,
                       er.branch_name,
                       er.mfo,
                       er.credit_status_id,
                       reg.OUTER_NUMBER reg_n
                  from escr_reg_header er,
                       (select t.id,t1.in_doc_id, t.OUTER_NUMBER
                          from escr_register t, escr_reg_mapping t1
                         where t1.in_doc_id = in_reg_list(i)
                           and t1.out_doc_id = t.id) r,
                       escr_reg_mapping em,
                       escr_register reg
                 where em.in_doc_id = r.id
                   and er.deal_id = em.out_doc_id
                   and reg.id=r.in_doc_id
                   and er.credit_status_id = 7
                   and reg.outer_number is not null
                union all
                select er.id,
                       er.customer_name,
                       er.customer_okpo,
                       er.deal_id,
                       er.deal_number,
                       er.deal_date_from,
                       er.deal_date_to,
                       er.deal_sum,
                       er.good_cost,
                       er.comp_sum,
                       er.branch_code,
                       er.branch_name,
                       er.mfo,
                       er.credit_status_id,
                       r.OUTER_NUMBER reg_n
                  from escr_reg_header  er,
                       escr_reg_mapping em,
                       escr_register    r
                 where r.id = in_reg_list(i)
                   and er.deal_id = em.out_doc_id
                   and em.in_doc_id = r.id
                   and er.credit_status_id = 7
                   and r.outer_number is not null) LOOP
        EXECUTE IMMEDIATE 'begin bars.gl.ref@' || l_dblink ||
                          '(:p_REF); end;'
          USING IN OUT oo.ref;
        oo.s    := k.comp_sum * 100;
        oo.nlsb := vkrzn(substr(k.mfo, 1, 5), '3739005');
        oo.nd   := substr(k.deal_number, 1, 10);
        oo.mfob := k.mfo;

        BEGIN
          SELECT mfo INTO oo.id_b FROM banks WHERE mfo = k.mfo;
        EXCEPTION
          WHEN no_data_found THEN
            raise_application_error(- (20203),
                                    '\ не знайдено в banks_RU MFO=' ||
                                    k.mfo);
        END;

        BEGIN
          EXECUTE IMMEDIATE 'select OKPO
                                 from bars.banks_ru@' ||
                            l_dblink || ' where MFO = :p_mfoa'
            INTO oo.id_a
            USING oo.mfoa;
        EXCEPTION
          WHEN no_data_found THEN
            oo.id_a := NULL;
        END;

        BEGIN
          EXECUTE IMMEDIATE 'select OKPO
                                 from bars.banks_ru@' ||
                            l_dblink || ' where MFO = :p_mfob'
            INTO oo.id_b
            USING oo.mfob;
        EXCEPTION
          WHEN no_data_found THEN
            oo.id_b := NULL;
        END;
        --   oo.id_b := k.G03 ;
        ---  oo.nazn := ND;SDATE;CC_ID;OKPO;NMK

        IF /*instr(k.customer_okpo, 'Відмітка про відсутність')>0  and*/
         length(TRIM(k.customer_okpo)) > 10 THEN
          oo.nazn := substr(k.reg_n || ';' || k.deal_id || ';' ||
                            to_char(k.deal_date_from, 'dd/mm/yyyy') || ';' ||
                            k.deal_number || ';' || k.customer_name || ';',
                            1,
                            160);
        ELSE
          oo.nazn := substr(k.reg_n || ';' || k.deal_id || ';' ||
                            to_char(k.deal_date_from, 'dd/mm/yyyy') || ';' ||
                            k.deal_number || ';' || k.customer_okpo || ';' ||
                            k.customer_name || ';',
                            1,
                            160);
        END IF;
        IF oo.mfob <> oo.mfoa THEN
          oo.tt := '310';
        ELSE
          oo.tt := '015';
        END IF;
        EXECUTE IMMEDIATE '
    begin
      savepoint before_pay;
      begin
        bars.gl.in_doc3@' || l_dblink ||
                          '(ref_   => :p_ref,
                            tt_    => :p_tt,
                            vob_   => 6,
                            nd_    => :p_nd,
                            pdat_  => SYSDATE,
                            vdat_  => bars.gl.bd@' ||
                          l_dblink || ',
                            dk_    => 1,
                            kv_    => :p_kv,
                            s_     => :p_s,
                            kv2_   => :p_kv,
                            s2_    => :p_s,
                            sk_    => null,
                            data_  => bars.gl.bd@' ||
                          l_dblink || ',
                            datp_  => bars.gl.bd@' ||
                          l_dblink || ',
                            nam_a_ => :p_nam_a,
                            nlsa_  => :p_nlsa,
                            mfoa_  => :p_mfoa,
                            nam_b_ => :p_nam_b,
                            nlsb_  => :p_nlsb,
                            mfob_  => :p_mfob,
                            nazn_  => :p_nazn,
                            d_rec_ => null,
                            id_a_  => :p_okpoa,
                            id_b_  => :p_okpob,
                            id_o_  => null,
                            sign_  => null,
                            sos_   => 1,
                            prty_  => null,
                            uid_   => ' || l_user || ');
        bars.PAYTT@' || l_dblink || '(0,
                       :p_ref,
                       bars.gl.bd@' || l_dblink || ',
                       :p_tt,
                       1,
                       :p_kv,
                       :p_nlsa,
                       :p_s,
                       :p_kv,
                       :p_nlsb,
                       :p_s);
      exception
        when others then

          rollback to before_pay;
          raise;
      end;
    end;'
          USING oo.ref, oo.tt, oo.nd, oo.kv, oo.s, oo.nam_a, oo.nlsa, oo.mfoa, oo.nam_b, oo.nlsb, oo.mfob, oo.nazn, oo.id_a, oo.id_b;
        UPDATE escr_reg_header
           SET payment_ref = oo.ref, CREDIT_STATUS_ID = 11
         WHERE deal_id = k.deal_id
           AND customer_okpo = k.customer_okpo;
      END LOOP;
    END LOOP;

    FOR i IN 1 .. in_reg_list.count LOOP
      p_set_obj_status(in_reg_list(i),
                       1,
                       'SETTLE_ACCOUNT',
                       NULL,
                       1,
                       SYSDATE);
    END LOOP;

  END p_gen_pay;
  /**********************************************
     FUNCTION   p_sync_state
     DESCRIPTION: Функція синхронізації статусів з ЦА
  *********************************************/
  FUNCTION decodeclobfrombase64(p_clob CLOB) RETURN CLOB IS
    l_clob   CLOB;
    l_len    NUMBER;
    l_pos    NUMBER := 1;
    l_buf    VARCHAR2(32767);
    l_amount NUMBER := 32767;
  BEGIN
    l_len := dbms_lob.getlength(p_clob);
    dbms_lob.createtemporary(l_clob, TRUE);

    WHILE l_pos <= l_len LOOP
      dbms_lob.read(p_clob, l_amount, l_pos, l_buf);
      l_buf := utl_encode.text_decode(l_buf, encoding => utl_encode.base64);
      l_pos := l_pos + l_amount;
      dbms_lob.writeappend(l_clob, length(l_buf), l_buf);
    END LOOP;

    RETURN l_clob;
  END;

  PROCEDURE p_sync_state IS
    --l_url         VARCHAR2(1000);
    l_url         params$global.val%TYPE := getglobaloption('ESCR_URL_RU');
    l_wallet_path VARCHAR2(256); --:= getglobaloption('OWWALLETPATH');
    l_wallet_pwd  VARCHAR2(256); --:= getglobaloption('OWWALETPWD');
    l_response    wsm_mgr.t_response;
    l_cursor      SYS_REFCURSOR;
    l_deals       t_vw_escr_list_for_sync;
    l_id          staff$base.id%TYPE;
    l_branch      staff$base.branch%TYPE;

    -- Для теста
    --l_url := BRANCH_ATTRIBUTE_UTL.GET_VALUE ('/300465/','ESCR_URL_RU');
  BEGIN

    BEGIN
      BEGIN
        SELECT branch INTO l_branch FROM staff$base WHERE id = user_id;
      EXCEPTION
        WHEN no_data_found THEN
          NULL;
      END;
      IF l_branch = '/' THEN
        BEGIN
          SELECT id INTO l_id FROM staff$base WHERE logname = 'TECH_ESCR';
        EXCEPTION
          WHEN no_data_found THEN
            NULL;
        END;
        EXECUTE IMMEDIATE 'alter session set current_schema=BARS';
        bars.bars_login.login_user(sys_guid, l_id, NULL, NULL);
      ELSE
        NULL;
      END IF;
    EXCEPTION
      WHEN no_data_found THEN
        BEGIN
          SELECT id INTO l_id FROM staff$base WHERE logname = 'TECH_ESCR';
        EXCEPTION
          WHEN no_data_found THEN
            NULL;
        END;
        EXECUTE IMMEDIATE 'alter session set current_schema=BARS';
        bars.bars_login.login_user(sys_guid, l_id, NULL, NULL);
    END;

    BEGIN
      SELECT MAX(val)
        INTO l_wallet_path
        FROM web_barsconfig
       WHERE key = 'SMPP.Wallet_dir';
    END;

    BEGIN
      SELECT MAX(val)
        INTO l_wallet_pwd
        FROM web_barsconfig
       WHERE key = 'SMPP.Wallet_pass';
    END;

    OPEN l_cursor FOR
    /*      SELECT rm.* \*DEAL_ID,
                                                 decode(rm.credit_status_id, 11, rm.credit_status_id, null) as state_id,
                                                 null as comment,
                                                 decode(rm.credit_status_id, 11, 'true', 'false') as is_set*\
                        FROM vw_escr_reg_header rm
                       WHERE rm.credit_status_id IN (1, 2, 3, 16, 6, 7, 5, 12, -999)
                         AND rm.credit_status_id IS NOT NULL;
                */
      SELECT t.deal_id,
             t.credit_status_id,
             TO_NUMBER(NULL) state_id,
             t.kf,
             '' AS "COMMENT",
             'false' AS is_set
        FROM vw_escr_list_for_sync t;
    LOOP
      FETCH l_cursor BULK COLLECT
        INTO l_deals LIMIT 100;
      DECLARE
        l_root     xmltype;
        l_dealsxml xmltype;
        l_xml      xmltype;
        l_clb      VARCHAR2(4000);
        l_tmp      DECIMAL;
      BEGIN
        SELECT xmlelement("root", xmlelement("mfo", f_ourmfo_g))
          INTO l_root
          FROM dual;
        SELECT xmlelement("deals", NULL) INTO l_dealsxml FROM dual;
        IF l_deals.count = 0 THEN
          RETURN;
        END IF;
        FOR i IN 1 .. l_deals.count LOOP
          SELECT xmlagg(xmlelement("deal",
                                   xmlelement("deal_id", l_deals(i).deal_id),
                                   xmlelement("state_id",
                                              l_deals(i).credit_status_id),
                                   xmlelement("is_set", 'false')))
            INTO l_xml
            FROM dual;
          SELECT appendchildxml(l_dealsxml, 'deals', l_xml)
            INTO l_dealsxml
            FROM dual;
        END LOOP;
        SELECT appendchildxml(l_root, 'root', l_dealsxml)
          INTO l_root
          FROM dual;

        UPDATE tmp_klp_clob
           SET c = l_root.getclobval()
         WHERE namef = 'EWA';
        /*bars.logger.info('ESCR syncstate body:' || '<?xml version="1.0"?>' ||
        l_root.getclobval());*/
        wsm_mgr.prepare_request(p_url         => l_url ||
                                                 'createregister/syncstate',
                                p_action      => NULL,
                                p_http_method => wsm_mgr.g_http_post,
                                p_wallet_path => l_wallet_path,
                                p_wallet_pwd  => l_wallet_pwd,
                                p_body        => '<?xml version="1.0"?>' ||
                                                 l_root.getclobval());

        wsm_mgr.add_header(p_name  => 'Content-Type',
                           p_value => 'application/xml;charset=utf-8');
        -- iicaaou iaoia aaa-na?aena
        wsm_mgr.execute_api(l_response);
        /*bars.logger.info('ESCR l_response' || '<?xml version="1.0"?>' ||
        l_response.cdoc);*/
        l_response.cdoc := decodeclobfrombase64(dbms_lob.substr(l_response.cdoc,
                                                                length(l_response.cdoc) - 2,
                                                                2));
      END;
      EXIT WHEN l_cursor%NOTFOUND;
    END LOOP;

    /*wsm_mgr.prepare_request(p_url         => l_url ||
                                             'createregister/syncstate'
                           ,p_action      => NULL
                           ,p_http_method => wsm_mgr.g_http_get
                           ,p_wallet_path => l_wallet_path
                           ,p_wallet_pwd  => l_wallet_pwd
                           ,p_body        => 'sync states');

    wsm_mgr.add_header(p_name  => 'Content-Type'
                      ,p_value => 'text/plain; charset=utf-8');
    -- iicaaou iaoia aaa-na?aena
    wsm_mgr.execute_api(l_response);

    l_response.cdoc := decodeclobfrombase64(dbms_lob.substr(l_response.cdoc
                                                           ,length(l_response.cdoc) - 2
                                                           ,2));*/
    --return l_response;
  END p_sync_state;
END pkg_escr_reg_utl;
/
 show err;
 
PROMPT *** Create  grants  PKG_ESCR_REG_UTL ***
grant EXECUTE                                                                on PKG_ESCR_REG_UTL to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/pkg_escr_reg_utl.sql =========*** En
 PROMPT ===================================================================================== 
 