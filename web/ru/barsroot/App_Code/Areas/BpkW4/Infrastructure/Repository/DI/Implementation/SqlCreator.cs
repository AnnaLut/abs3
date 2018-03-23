using BarsWeb.Areas.BpkW4.Models;
using BarsWeb.Areas.Kernel.Models;
using Oracle.DataAccess.Client;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;


namespace BarsWeb.Areas.BpkW4.Infrastructure.Repository.DI.Implementation
{
    public class SqlCreatorBPK
    {
        public static BarsSql BatchesMmsb()
        {
            return new BarsSql()
            {
                SqlText = @"select * from v_w4_batches_mmsb",
                SqlParams = new object[] { }
            };

        }

        public static BarsSql Product()
        {
            return new BarsSql()
            {
                SqlText = @"select unique t.product_code, t.product_name
                            from v_w4_product_mkk t
                            order by t.product_code",
                SqlParams = new object[] { }
            };

        }

        public static BarsSql CardType(string product_code)
        {
            return new BarsSql()
            {
                SqlText = @"select tt.sub_name, tt.card_code
                            from v_w4_product_mkk tt
                            where tt.product_code = :product_code
                            order by tt.card_code",
                SqlParams = new object[] 
                {
                    new OracleParameter("product_code", OracleDbType.Varchar2) { Value = product_code }
                }
            };
        }

        public static BarsSql CreateInstantCardsM(InstantCard obj)
        {
            return new BarsSql()
            {
                SqlText = @"begin
                        bars_ow.create_instant_cards_m(:p_cardcode, :p_delivery_br, :p_cardnum);
                    end;",
                SqlParams = new object[]
                {
                    new OracleParameter("p_cardcode", OracleDbType.Varchar2) { Value = obj.p_cardcode },
                    new OracleParameter("p_delivery_br", OracleDbType.Varchar2) { Value = obj.p_delivery_br },
                    new OracleParameter("p_cardnum", OracleDbType.Int32) { Value = obj.p_cardnum }
                }
            };
        }

        #region ActivationReservedAccounts
        public static BarsSql ActivationReservedAccounts()
        {
            return new BarsSql()
            {
                SqlText = @"select * from v_w4_not_confirm_acc",
                SqlParams = new object[] { }
            };
        }

        public static BarsSql Active(decimal?[] data, int confirm)
        {
            return new BarsSql()
            {
                SqlText = @"begin
                                bars_ow.confirm_acc(:p_acc, :p_confirm);
                            end;",
                SqlParams = new object[] 
                {
                    new OracleParameter("p_acc", OracleDbType.Array, data.Length, data, ParameterDirection.Input) { UdtTypeName = "NUMBER_LIST", Value = data},
                    new OracleParameter("p_confirm", OracleDbType.Int32) { Value = confirm }
                }
            };

        }
        #endregion
    }
}

