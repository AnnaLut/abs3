
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/pkg_dkbo_utl.sql =========*** Run **
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.PKG_DKBO_UTL is

  FUNCTION header_version RETURN VARCHAR2;
  FUNCTION body_version RETURN VARCHAR2;

   /**********************************************
    PROCEDURE p_questionnaire_answer_insert
  *********************************************/
   PROCEDURE p_quest_answ_ins
  (
    in_object_id       IN NUMBER
   ,in_attribute_code  IN attribute_kind.attribute_code%TYPE
   ,in_attribute_value IN VARCHAR2
  ) ;
   /**********************************************
    PROCEDURE p_acc_map_to_dkbo
    Додавання рахунків до ДКБО
  *********************************************/
  PROCEDURE p_acc_map_to_dkbo
  (
    in_customer_id    IN customer.rnk%TYPE
   ,in_deal_number    IN deal.deal_number%TYPE DEFAULT NULL
   ,in_acc_list       IN number_list DEFAULT NULL
   ,in_acc_nbs        IN accounts.nbs%TYPE DEFAULT null
   ,in_dkbo_date_from IN DATE DEFAULT trunc(SYSDATE)
   ,in_dkbo_date_to   IN DATE DEFAULT NULL
   ,out_deal_id      OUT deal.id%TYPE
  );
    /*****************************************************************************
    FUNCTION    f_dkbo_list_print
    DESCRIPTION використовується для друку договорів
  ******************************************************************************/
  FUNCTION f_dkbo_list_print
  (
    p_acc  accounts.acc%TYPE
   ,p_attr attribute_kind.attribute_code%TYPE
  ) RETURN VARCHAR2;
end pkg_dkbo_utl;
/
CREATE OR REPLACE PACKAGE BODY BARS.PKG_DKBO_UTL IS
  g_body_version     CONSTANT VARCHAR2(64) := 'version 5.9 08/06/2017';
  g_header_version   CONSTANT VARCHAR2(64) := 'version 5.9 08/06/2017';
  lc_new_line        CONSTANT VARCHAR2(5) := chr(13) || chr(10);
  lc_acc_list        CONSTANT attribute_kind.attribute_code%TYPE := 'DKBO_ACC_LIST';
  lc_date_format     CONSTANT VARCHAR2(10) := 'dd/mm/yyyy';
  lc_deal_type_code  CONSTANT VARCHAR2(30) := 'DKBO';
  lc_deal_state_code CONSTANT VARCHAR2(30) := 'CONNECTED';
  /*****************************************************************************
   deal attributes
  *****************************************************************************/
  deal_number   deal.deal_number%TYPE;
  deal_type_id  deal.deal_type_id%TYPE;
  deal_id       deal.id%TYPE;
  deal_date_to  deal.close_date%TYPE;
  deal_state_id deal.state_id%TYPE;
  /*****************************************************************************
    FUNCTION header_version
  *****************************************************************************/
  FUNCTION header_version RETURN VARCHAR2 IS
  BEGIN
    RETURN 'Package header DOCSIGN ' || g_header_version || '.';
  END header_version;

  /*****************************************************************************
    FUNCTION body_version
  *****************************************************************************/
  FUNCTION body_version RETURN VARCHAR2 IS
  BEGIN
    RETURN 'Package body DOCSIGN ' || g_body_version || '.';
  END body_version;
  /**********************************************
    FUNCTION  f_set_new_deal_numb
    Генеруємо новий номер ДКБО
  *********************************************/
  FUNCTION f_set_new_deal_numb(p_customer_id IN customer.rnk%TYPE , p_dkbo_date_from in date)
    RETURN VARCHAR2 IS
  BEGIN
    IF p_customer_id IS NOT NULL THEN
      deal_number := to_char(p_customer_id) || '/' ||
                     to_char(p_dkbo_date_from, 'ddmmyy');
    END IF;
    RETURN deal_number;
  END f_set_new_deal_numb;
  /******************************************************************************
    PROCEDURE        p_get_cust_deals_id
    DESCRIPTION      Визначаємо ID ДКБО  РНК клієнта
  ******************************************************************************/
  PROCEDURE p_get_cust_deals_id
  (
    p_customer_id customer.rnk%TYPE
   ,p_flag        NUMBER DEFAULT 1
   ,out_deal_id   OUT deal.id%TYPE
  ) IS
  BEGIN
    --Якщо 1,то активні договори ,0- закриті,null -всі
    IF p_flag = 1 THEN
      BEGIN
        SELECT d.id
          INTO out_deal_id
          FROM deal d
         WHERE 1 = 1
           AND d.customer_id = p_customer_id
           AND d.close_date IS NULL;
      EXCEPTION
        WHEN no_data_found THEN
          NULL;
        WHEN too_many_rows THEN
          NULL;
      END;
    ELSIF p_flag = 0 THEN
      BEGIN
        SELECT d.id
          INTO out_deal_id
          FROM deal d
         WHERE 1 = 1
           AND d.customer_id = p_customer_id
           AND d.close_date IS NOT NULL;
      EXCEPTION
        WHEN no_data_found THEN
          NULL;
      END;
    ELSE
      BEGIN
        SELECT d.id
          INTO out_deal_id
          FROM deal d
         WHERE 1 = 1
           AND d.customer_id = p_customer_id;
      EXCEPTION
        WHEN no_data_found THEN
          NULL;
      END;
    END IF;
  END p_get_cust_deals_id;
  /******************************************************************************
    PROCEDURE        p_get_deal_close_date
    DESCRIPTION      Визначаємо ID ДКБО  РНК клієнта
  ******************************************************************************/
  PROCEDURE p_get_deal_close_date
  (
    p_deal_id           deal.id%TYPE
   ,out_deal_close_date OUT deal.close_date%TYPE
  ) IS
  BEGIN
    BEGIN
      SELECT d.close_date
        INTO out_deal_close_date
        FROM deal d
       WHERE 1 = 1
         AND d.id = p_deal_id;
    EXCEPTION
      WHEN no_data_found THEN
        NULL;
    END;

  END p_get_deal_close_date;
  /******************************************************************************
    PROCEDURE        p_get_cust_deals_numb
    DESCRIPTION      Визначаємо ID ДКБО  РНК клієнта
  ******************************************************************************/
  PROCEDURE p_get_cust_deals_numb
  (
    p_customer_id customer.rnk%TYPE
   ,p_flag        NUMBER DEFAULT 1
   ,out_deal_numb OUT number_list
  ) IS
  BEGIN
    --Якщо 1,то активні договори ,0- закриті,null -всі
    IF p_flag = 1 THEN
      BEGIN
        SELECT d.deal_number BULK COLLECT
          INTO out_deal_numb
          FROM deal d
         WHERE 1 = 1
           AND d.customer_id = p_customer_id
           AND d.close_date IS NULL;
      EXCEPTION
        WHEN no_data_found THEN
          NULL;
      END;
    ELSIF p_flag = 0 THEN
      BEGIN
        SELECT d.deal_number BULK COLLECT
          INTO out_deal_numb
          FROM deal d
         WHERE 1 = 1
           AND d.customer_id = p_customer_id
           AND d.close_date IS NOT NULL;
      EXCEPTION
        WHEN no_data_found THEN
          NULL;
        WHEN too_many_rows THEN
          NULL;
      END;
    ELSE
      BEGIN
        SELECT d.deal_number BULK COLLECT
          INTO out_deal_numb
          FROM deal d
         WHERE 1 = 1
           AND d.customer_id = p_customer_id;
      EXCEPTION
        WHEN no_data_found THEN
          NULL;
        WHEN too_many_rows THEN
          NULL;
      END;
    END IF;
  END p_get_cust_deals_numb;
  /*****************************************************************************
      PROCEDURE       p_get_all_cust_acc
      DESCRIPTION     Визначаємо всі відкриті рахунки, що належать клієнту
  *****************************************************************************/
  PROCEDURE p_get_all_cust_acc
  (
    p_customer_id IN customer.rnk%TYPE
   ,p_nbs         IN accounts.nbs%TYPE
   ,out_acc_list  OUT number_list
  ) IS
  BEGIN
    SELECT DISTINCT a.acc BULK COLLECT
      INTO out_acc_list
      FROM accounts a
     WHERE a.nbs = p_nbs
       AND a.tip LIKE 'W4%'
       AND a.rnk = p_customer_id
       AND a.dazs IS NULL;
  EXCEPTION
    WHEN no_data_found THEN
      NULL;
    WHEN too_many_rows THEN
      NULL;
  END p_get_all_cust_acc;
  /*******************************************************************************
      PROCEDURE       p_get_DKBO_cust_acc
      DESCRIPTION     Визначаємо всі відкриті рахунки клієнта, які включені в ДКБО
  *******************************************************************************/
  PROCEDURE p_get_all_cust_acc
  (
    p_customer_id IN customer.rnk%TYPE
   ,out_acc_list  OUT number_list
  ) IS
  BEGIN
    BEGIN
        SELECT vs.number_values number_value BULK COLLECT
        INTO out_acc_list
        FROM /*attribute_value_by_date*/(select  max(t.nested_table_id) keep (dense_rank last order by t.value_date) nested_table_id ,
                                                 max(t.value_date) keep (dense_rank last order by t.value_date) value_date ,
                                                 max(t.number_value) keep (dense_rank last order by t.value_date) number_value ,
                                                 max(t.date_value) keep (dense_rank last order by t.value_date) date_value ,
                                                 t.object_id,
                                                 t.attribute_id
                                          from ATTRIBUTE_VALUE_BY_DATE t
                                          group by t.object_id, t.attribute_id) a
        JOIN deal d
          ON d.id = a.object_id
         AND d.customer_id = p_customer_id
        JOIN attribute_kind k
          ON k.id = a.attribute_id
         AND k.attribute_code = lc_acc_list
        JOIN object_type t
          ON t.id = d.deal_type_id
         AND t.type_code = lc_deal_type_code
        JOIN attribute_values vs
          on vs.nested_table_id = a.nested_table_id;
    EXCEPTION
      WHEN no_data_found THEN
        NULL;
      WHEN too_many_rows THEN
        NULL;
    END;
  END p_get_all_cust_acc;
  /*****************************************************************************
    PROCEDURE        p_get_deal_id
    DESCRIPTION      Визначаємо ID ДКБО по його номеру
  ******************************************************************************/
  PROCEDURE p_get_deal_id
  (
    in_deal_number deal.deal_number%TYPE
   ,out_deal_id    OUT deal.id%TYPE
  ) IS
  BEGIN
    IF in_deal_number IS NOT NULL THEN
      BEGIN
        SELECT d.id
          INTO out_deal_id
          FROM deal d
         WHERE 1 = 1
           AND d.deal_number = in_deal_number;
      EXCEPTION
        WHEN no_data_found THEN
          NULL;
        WHEN too_many_rows THEN
          out_deal_id := -999;
      END;
    END IF;
  END p_get_deal_id;
  /*****************************************************************************
    PROCEDURE        p_get_deal_id
    DESCRIPTION      Визначаємо ID ДКБО по його номеру
  ******************************************************************************/
  PROCEDURE p_get_deal_id
  (
    p_customer_id customer.rnk%TYPE DEFAULT NULL
   ,out_deal_id   OUT deal.id%TYPE
  ) IS
  BEGIN
    IF p_customer_id IS NOT NULL THEN
      BEGIN
        SELECT d.id
          INTO out_deal_id
          FROM deal d
         WHERE 1 = 1
           AND d.customer_id = p_customer_id
           AND d.close_date is null;
      EXCEPTION
        WHEN no_data_found THEN
          NULL;
        WHEN too_many_rows THEN
          out_deal_id := -999;
      END;
    END IF;
  END p_get_deal_id;
  /**********************************************
    PROCEDURE p_get_deal_type
  *********************************************/
  FUNCTION f_get_deal_type(in_deal_number IN INTEGER DEFAULT NULL)
    RETURN VARCHAR2 IS
  BEGIN
    BEGIN
      SELECT o.id
        INTO deal_type_id
        FROM object_type o
       WHERE o.type_code = lc_deal_type_code;
    EXCEPTION
      WHEN no_data_found THEN
        NULL;
    END;
    RETURN deal_type_id;
  END f_get_deal_type;
  /**********************************************
    FUNCTION f_get_deal_state
  *********************************************/
  FUNCTION f_get_deal_state(in_deal_number IN INTEGER DEFAULT NULL)
    RETURN NUMBER IS
  BEGIN
    BEGIN
      SELECT o.state_id
        INTO deal_state_id
        FROM object_state o
       WHERE o.state_code = lc_deal_state_code;
    EXCEPTION
      WHEN no_data_found THEN
        NULL;
    END;
    RETURN deal_state_id;
  END f_get_deal_state;
  /*****************************************************************************
    PROCEDURE p_acc_ins
    Додавання рахунків до ДКБО
  *****************************************************************************/
  PROCEDURE p_acc_ins
  (
    p_customer_id IN customer.rnk%TYPE
   ,p_deal_id     IN deal.id%TYPE
   ,p_acc_list    IN number_list
   ,p_acc_nbs     IN accounts.nbs%TYPE
  ) IS
    l_all_acc_list   number_list;
    l_acc_list_union number_list;
    p_in_acc_list    number_list;
    l_dkbo_acc_list  number_list;
  BEGIN
    p_in_acc_list := p_acc_list;

   IF p_in_acc_list IS NULL THEN
 --Визначаємо всі активні рахунки клієнта
      p_get_all_cust_acc(p_customer_id => p_customer_id
                        ,p_nbs         => p_acc_nbs
                        ,out_acc_list  => l_all_acc_list);
  --Визначаємо всі рахунки клієнта ,включені в ДКБО
    l_dkbo_acc_list  := bars.attribute_utl.get_number_values(p_object_id      => deal_id
                                                              ,p_attribute_code => lc_acc_list);
    if  l_all_acc_list.count>=1 then
     l_acc_list_union := l_all_acc_list MULTISET UNION DISTINCT
                          l_dkbo_acc_list;
      if l_acc_list_union <> l_dkbo_acc_list then --если список счетов присоединяется не такой, как есть сейчас (что бы не засорять историю)
        bars.attribute_utl.set_value(p_object_id      => deal_id
                                    ,p_attribute_code => lc_acc_list
                                    ,p_values         => l_acc_list_union);
      end if;
    elsif l_all_acc_list.count=0 then
       l_acc_list_union:=number_list();
       bars.deal_utl.set_deal_close_date(p_deal_id    => deal_id
                                         ,p_close_date => trunc(SYSDATE));
    end if;
    ELSIF p_in_acc_list IS NOT NULL THEN

      l_dkbo_acc_list  := bars.attribute_utl.get_number_values(p_object_id      => deal_id
                                                              ,p_attribute_code => lc_acc_list);
      l_acc_list_union := l_dkbo_acc_list MULTISET UNION DISTINCT
                          p_acc_list;
      bars.attribute_utl.set_value(p_object_id      => deal_id
                                  ,p_attribute_code => lc_acc_list
                                  ,p_values         => l_acc_list_union);
    END IF;
  END p_acc_ins;

  /**********************************************
    PROCEDURE p_acc_map_to_dkbo
    Додавання рахунків до ДКБО
  *********************************************/
 PROCEDURE p_acc_map_to_dkbo
  (
    in_customer_id    IN customer.rnk%TYPE
   ,in_deal_number    IN deal.deal_number%TYPE DEFAULT NULL
   ,in_acc_list       IN number_list DEFAULT NULL
   ,in_acc_nbs        IN accounts.nbs%TYPE default null
   ,in_dkbo_date_from IN DATE DEFAULT trunc(SYSDATE)
   ,in_dkbo_date_to   IN DATE DEFAULT NULL
   ,out_deal_id      OUT deal.id%TYPE
  ) IS
    l_all_acc_list   number_list;
    resourse_busy EXCEPTION;
    PRAGMA EXCEPTION_INIT(resourse_busy, -00054);
    CURSOR get_rnk (n_RNK customer.rnk%TYPE)  IS
    SELECT * FROM customer  where rnk=n_RNK
    FOR UPDATE  OF customer.rnk NOWAIT;
    l_in_acc_nbs accounts.nbs%TYPE:=in_acc_nbs;
  BEGIN
    --блокирую контрагента
   if l_in_acc_nbs is null then
     l_in_acc_nbs:='2625';
   end if;

   OPEN get_rnk(in_customer_id);

     --Визначаємо всі активні  рахунки клієнта (чтобы не создавать за зря, если приходит с BARS_OW)
    p_get_all_cust_acc(p_customer_id => in_customer_id
                      ,p_nbs         => l_in_acc_nbs
                      ,out_acc_list  => l_all_acc_list);
    p_get_deal_id(p_customer_id => in_customer_id, out_deal_id => deal_id);
    if  l_all_acc_list.count>=1 then
          IF deal_id = -999 THEN
            raise_application_error(-20005
                                   ,'У клієнта з РНК ' || in_customer_id ||
                                    ' знайдено кілька договорів ДКБО.Необхідно вказати номер ДКБО до якого потрібно приєднати рахунки');
          ELSIF deal_id IS NULL THEN
            deal_number  := f_set_new_deal_numb(in_customer_id, in_dkbo_date_from);
            deal_type_id := f_get_deal_type(NULL);
            deal_id      := bars.deal_utl.create_deal(p_deal_type_id => deal_type_id
                                                     ,p_deal_number  => deal_number
                                                     ,p_customer_id  => in_customer_id
                                                     ,p_product_id   => NULL
                                                     ,p_start_date   => in_dkbo_date_from);
            -- Присвоюємо договору статус
            deal_state_id := f_get_deal_state(NULL);
            IF deal_state_id IS NOT NULL THEN
              bars.deal_utl.set_object_state_id(p_deal_id  => deal_id
                                               ,p_state_id => deal_state_id);

            END IF;
          ELSIF deal_id IS NOT NULL
                AND deal_id <> -999 THEN
            p_get_deal_close_date(p_deal_id           => deal_id
                                 ,out_deal_close_date => deal_date_to);
            IF deal_date_to IS NOT NULL THEN
              bars.deal_utl.set_deal_close_date(p_deal_id    => deal_id
                                               ,p_close_date => NULL);
            END IF;
          END IF;
    end if;
      IF deal_id IS NOT NULL
                AND deal_id <> -999 THEN
          p_acc_ins(p_customer_id => in_customer_id
                   ,p_deal_id     => deal_id
                   ,p_acc_list    => in_acc_list
                   ,p_acc_nbs     => l_in_acc_nbs);
      END IF;
          out_deal_id := deal_id;

  exception when resourse_busy then
    raise_application_error(-20006 ,'Недопустимо одночасно декільком користувачам приєднувати один і той самий рахунок до ДКБО! Оновіть сторітку та повторіть спробу.');
  END p_acc_map_to_dkbo;
  /**********************************************
    FUNCTION f_get_attribute_type_name
  *********************************************/
  FUNCTION f_get_attr_type_name(in_attribute_code VARCHAR2) RETURN VARCHAR2 IS
    p_attribute_type VARCHAR2(255);
  BEGIN
    BEGIN
      SELECT q.quest_type
        INTO p_attribute_type
        FROM v_dkbo_questionnaire q
       WHERE q.quest_code = in_attribute_code;
    EXCEPTION
      WHEN no_data_found THEN
        NULL;
    END;
    RETURN p_attribute_type;
  END f_get_attr_type_name;
  /**********************************************
    FUNCTION f_get_list_item_id
  *********************************************/
  FUNCTION f_get_list_item_id
  (
    in_attribute_code  VARCHAR2
   ,in_attribute_value VARCHAR2
  ) RETURN VARCHAR2 IS
    p_list_id list_item.list_item_id%TYPE;
  BEGIN
    BEGIN
      SELECT li.list_item_id
        INTO p_list_id
        FROM list_item li
        JOIN list_type lt
          ON lt.id = li.list_type_id
        JOIN attribute_kind a
          ON a.list_type_id = lt.id
         AND a.attribute_code = in_attribute_code
       WHERE li.list_item_code = in_attribute_value;
    EXCEPTION
      WHEN no_data_found THEN
        NULL;
    END;
    RETURN p_list_id;
  END f_get_list_item_id;
  /**********************************************
    PROCEDURE p_questionnaire_answer_insert
  *********************************************/
  PROCEDURE p_quest_answ_ins
  (
    in_object_id       IN NUMBER
   ,in_attribute_code  IN attribute_kind.attribute_code%TYPE
   ,in_attribute_value IN VARCHAR2
  ) IS
    p_attribute_type VARCHAR2(10);
    p_list_id        list_item.list_item_id%TYPE;
    p_flag           INTEGER;
  BEGIN

    bars_audit.info('p_quest_answ_ins call');

    BEGIN
      SELECT COUNT(1)
        INTO p_flag
        FROM v_dkbo_questionnaire q
       WHERE q.quest_code = in_attribute_code;
    END;
    IF p_flag > 0 THEN
      p_attribute_type := f_get_attr_type_name(in_attribute_code => in_attribute_code);
    END IF;
    -- Приводимо дані до необхідного типу
    IF in_attribute_value IS NOT NULL THEN
      IF p_attribute_type = 'DATE' THEN
        BEGIN
          attribute_utl.set_value(p_object_id      => in_object_id
                                 ,p_attribute_code => in_attribute_code
                                 ,p_value          => to_date(in_attribute_value
                                                             ,lc_date_format));

        END;
      ELSIF p_attribute_type = 'NUMBER' THEN
        BEGIN
          attribute_utl.set_value(p_object_id      => in_object_id
                                 ,p_attribute_code => in_attribute_code
                                 ,p_value          => to_number(in_attribute_value));

        END;
      ELSIF p_attribute_type = 'LIST' THEN
        p_list_id := f_get_list_item_id(in_attribute_code  => in_attribute_code
                                       ,in_attribute_value => in_attribute_value);
        BEGIN
          attribute_utl.set_value(p_object_id      => in_object_id
                                 ,p_attribute_code => in_attribute_code
                                 ,p_value          => p_list_id);
        END;
      ELSE
        BEGIN
          attribute_utl.set_value(p_object_id      => in_object_id
                                 ,p_attribute_code => in_attribute_code
                                 ,p_value          => in_attribute_value);
        END;
      END IF;

    END IF;
  END p_quest_answ_ins;
  /*****************************************************************************
    FUNCTION    f_dkbo_list_print
    DESCRIPTION використовується для друку договорів
  ******************************************************************************/
  FUNCTION f_dkbo_list_print
  (
    p_acc  accounts.acc%TYPE
   ,p_attr attribute_kind.attribute_code%TYPE
  ) RETURN VARCHAR2 IS
    l_answer_id attribute_kind.attribute_code%TYPE;
    l_str       VARCHAR2(4000);
  BEGIN
    BEGIN
      SELECT attribute_utl.get_number_value(v1.deal_id, p_attr)
        INTO l_answer_id
        FROM w4_dkbo_web v1
       WHERE v1.acc_acc = p_acc;
    EXCEPTION
      WHEN no_data_found THEN
        l_answer_id := NULL;
    END;

    FOR i IN (SELECT t.list_item_id, t.list_item_name
                FROM attribute_kind k, list_item t
               WHERE t.list_type_id = k.list_type_id
                 AND k.attribute_code = p_attr)
    LOOP
      l_str := l_str || CASE
                 WHEN i.list_item_id = l_answer_id THEN
                  ' _X_ '
                 ELSE
                  ' ___ '
               END || i.list_item_name || ' ';
    END LOOP;

    RETURN TRIM(l_str);
  END f_dkbo_list_print;
END;
/
 show err;
 
PROMPT *** Create  grants  PKG_DKBO_UTL ***
grant EXECUTE                                                                on PKG_DKBO_UTL    to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/pkg_dkbo_utl.sql =========*** End **
 PROMPT ===================================================================================== 
 