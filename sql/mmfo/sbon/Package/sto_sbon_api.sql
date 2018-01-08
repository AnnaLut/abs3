
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/SBON/package/sto_sbon_api.sql =========*** Run **
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE SBON.STO_SBON_API is

    procedure add_provider(
        p_id_dog in integer,
        p_nomdog in varchar2,
        p_rozrah in varchar2,
        p_nazva in varchar2,
        p_tranzrah in varchar2,
        p_kodorg in varchar2,
        p_mfo in varchar2,
        p_nazva_plat in varchar2,
        p_work_mode in integer,
        p_extra_attributes_metadata in clob);

    procedure alter_provider(
        p_id_dog in integer,
        p_rozrah in varchar2,
        p_nazva in varchar2,
        p_tranzrah in varchar2,
        p_kodorg in varchar2,
        p_mfo in varchar2,
        p_nazva_plat in varchar2,
        p_work_mode in integer,
        p_extra_attributes_metadata in clob);

    procedure block_provider(
        p_id_dog in integer);

    procedure unblock_provider(
        p_id_dog in integer);

    procedure close_provider(
        p_id_dog in integer);

    procedure refuse_payment(
        p_id_plat in integer,
        p_description in varchar2);

    procedure set_payment_amount(
        p_id_plat in integer,
        p_suma_borg in number,
        p_suma_op in number,
        p_suma_kom in number);

    procedure set_fee_amount(
        p_id_plat in integer,
        p_suma_kom in number);

    procedure set_payment_purpose(
        p_id_plat in integer,
        p_payment_purpose in varchar2);

    procedure close_payment(
        p_id_plat in integer,
        p_mfo in varchar2 default null,
        p_rozrah in varchar2 default null,
        p_kodorg in varchar2 default null,
        p_provider_purpose in varchar2 default null);

    procedure set_payment_status(
        p_payment_id in integer,
        p_state in integer);
end;
/
CREATE OR REPLACE PACKAGE BODY SBON.STO_SBON_API as

    procedure add_provider(
        p_id_dog in integer,
        p_nomdog in varchar2,
        p_rozrah in varchar2,
        p_nazva in varchar2,
        p_tranzrah in varchar2,
        p_kodorg in varchar2,
        p_mfo in varchar2,
        p_nazva_plat in varchar2,
        p_work_mode in integer,
        p_extra_attributes_metadata in clob)
    is
        l_product_id integer;
    begin
        l_product_id := bars.sto_sbon_utl.add_sbon_provider(p_id_dog,
                                                            p_nomdog,
                                                            p_work_mode,
                                                            p_mfo,
                                                            p_rozrah,
                                                            p_nazva,
                                                            p_kodorg,
                                                            p_nazva_plat,
                                                            p_tranzrah,
                                                            p_extra_attributes_metadata);
    end;

    procedure alter_provider(
        p_id_dog in integer,
        p_rozrah in varchar2,
        p_nazva in varchar2,
        p_tranzrah in varchar2,
        p_kodorg in varchar2,
        p_mfo in varchar2,
        p_nazva_plat in varchar2,
        p_work_mode in integer,
        p_extra_attributes_metadata in clob)
    is
    begin
        bars.sto_sbon_utl.alter_sbon_provider(p_id_dog,
                                         p_work_mode,
                                         p_mfo,
                                         p_rozrah,
                                         p_nazva,
                                         p_kodorg,
                                         p_nazva_plat,
                                         p_tranzrah,
                                         p_extra_attributes_metadata);
    end;

    procedure block_provider(
        p_id_dog in integer)
    is
    begin
        bars.sto_sbon_utl.block_sbon_provider(p_id_dog);
    end;

    procedure unblock_provider(
        p_id_dog in integer)
    is
    begin
        bars.sto_sbon_utl.unblock_sbon_provider(p_id_dog);
    end;

    procedure close_provider(
        p_id_dog in integer)
    is
    begin
        bars.sto_sbon_utl.close_sbon_provider(p_id_dog);
    end;

    procedure refuse_payment(
        p_id_plat in integer,
        p_description in varchar2)
    is
    begin
        bars.sto_payment_utl.decline_payment_by_sbon(p_id_plat, p_description);
    end;

    procedure set_payment_amount(
        p_id_plat in integer,
        p_suma_borg in number,
        p_suma_op in number,
        p_suma_kom in number)
    is
    begin
        bars.sto_payment_utl.set_payment_amount_by_sbon(p_id_plat, p_suma_borg, p_suma_op, p_suma_kom);
    end;

    procedure set_fee_amount(
        p_id_plat in integer,
        p_suma_kom in number)
    is
    begin
        bars.sto_payment_utl.set_fee_amount_by_sbon(p_id_plat, p_suma_kom);
    end;

    procedure set_payment_purpose(
        p_id_plat in integer,
        p_payment_purpose in varchar2)
    is
    begin
        bars.sto_payment_utl.set_payment_purpose_by_sbon(p_id_plat, p_payment_purpose);
    end;

    procedure close_payment(
        p_id_plat in integer,
        p_mfo in varchar2 default null,
        p_rozrah in varchar2 default null,
        p_kodorg in varchar2 default null,
        p_provider_purpose in varchar2 default null)
    is
    begin
        bars.sto_payment_utl.close_payment_by_sbon(p_id_plat, p_mfo, p_rozrah, p_kodorg, p_provider_purpose);
    end;

    procedure set_payment_status(
        p_payment_id in integer,
        p_state in integer)
    is
    begin
        bars.sto_payment_utl.set_payment_state(p_payment_id, p_state, 'Ручна зміна статусу системою СБОН+');
    end;
end;
/
 show err;
 
PROMPT *** Create  grants  STO_SBON_API ***
grant EXECUTE                                                                on STO_SBON_API    to SBON06;
grant EXECUTE                                                                on STO_SBON_API    to SBON11;
grant EXECUTE                                                                on STO_SBON_API    to SBON13;
grant EXECUTE                                                                on STO_SBON_API    to SBON21;
grant EXECUTE                                                                on STO_SBON_API    to SBON_ROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/SBON/package/sto_sbon_api.sql =========*** End **
 PROMPT ===================================================================================== 
 