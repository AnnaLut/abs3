using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Areas.ValuePapers.Models;
using BarsWeb.Areas.ValuePapers.Infrastructure.DI.Abstract;
using BarsWeb.Models;
using Kendo.Mvc.UI;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Kernel.Models;
using Oracle.DataAccess.Client;
using System.Data;
using Bars.Classes;

namespace BarsWeb.Areas.ValuePapers.Infrastructure.DI.Implementation
{
    public class GeneralFolderRepository : IGeneralFolderRepository
    {
        private readonly ValuePapersModel _entity;
        private readonly IKendoSqlTransformer _sqlTransformer;
        private readonly IKendoSqlCounter _kendoSqlCounter;

        public GeneralFolderRepository(IKendoSqlTransformer sqlTransformer, IKendoSqlCounter kendoSqlCounter)
        {
            var connectionStr = EntitiesConnection.ConnectionString("ValuePapersModel", "ValuePapers");
            _entity = new ValuePapersModel(connectionStr);
            _sqlTransformer = sqlTransformer;
            _kendoSqlCounter = kendoSqlCounter;
        }

        public IEnumerable<CP_V> CpV(InitParams initParams)
        {
            string sqlText = @"select * from table(value_paper.get_cp(:nMode, :nGrp, :strPar01, :strPar02, :p_date, :p_active))";
            #region params
            object[] parametrs = {
                new OracleParameter(){
                    ParameterName = "nMode",
                    Direction = ParameterDirection.Input,
                    OracleDbType = OracleDbType.Decimal,
                    Value = initParams.nMode
                },
                new OracleParameter(){
                    ParameterName = "nGrp",
                    Direction = ParameterDirection.Input,
                    OracleDbType = OracleDbType.Decimal,
                    Value = initParams.nGrp
                },
                new OracleParameter(){
                    ParameterName = "strPar01",
                    Direction = ParameterDirection.Input,
                    OracleDbType = OracleDbType.Varchar2,
                    Value = initParams.strPar01
                },
                new OracleParameter(){
                    ParameterName = "strPar02",
                    Direction = ParameterDirection.Input,
                    OracleDbType = OracleDbType.Varchar2,
                    Value = initParams.strPar02
                },
                new OracleParameter(){
                    ParameterName = "p_date",
                    Direction = ParameterDirection.Input,
                    OracleDbType = OracleDbType.Date,
                    Value = initParams.P_DATE
                },
                new OracleParameter(){
                    ParameterName = "p_active",
                    Direction = ParameterDirection.Input,
                    OracleDbType = OracleDbType.Decimal,
                    Value = initParams.p_active
                }
            };
            #endregion
            return _entity.ExecuteStoreQuery<CP_V>(sqlText, parametrs);
        }
        public IList<MFGrid> MFGridData(decimal? REF, int? RB1, int? RB2, DateTime? DATE_ROZ)
        {
            string sqlText = @"select * from table(value_paper.populate_many_wnd (:p_ref, :rb1, :rb2, :DAT_ROZ))";
            #region params
            object[] parametrs = {
                new OracleParameter(){
                    ParameterName = "p_ref",
                    Direction = ParameterDirection.Input,
                    OracleDbType = OracleDbType.Decimal,
                    Value = REF
                },
                new OracleParameter(){
                    ParameterName = "rb1",
                    Direction = ParameterDirection.Input,
                    OracleDbType = OracleDbType.Decimal,
                    Value = RB1
                },
                new OracleParameter(){
                    ParameterName = "rb2",
                    Direction = ParameterDirection.Input,
                    OracleDbType = OracleDbType.Decimal,
                    Value = RB2
                },
                new OracleParameter(){
                    ParameterName = "DAT_ROZ",
                    Direction = ParameterDirection.Input,
                    OracleDbType = OracleDbType.Date,
                    Value = DATE_ROZ
                }
            };
            #endregion
            var data = _entity.ExecuteStoreQuery<MFGrid>(sqlText, parametrs).ToList();
            return data;
        }

        public IEnumerable<ChangeBillGrid> CP_OB_INITIATOR()
        {
            string sqlText = @"select code,txt  from CP_OB_INITIATOR  order by 1 ";
            return _entity.ExecuteStoreQuery<ChangeBillGrid>(sqlText);
        }

        public IEnumerable<ChangeBillGrid> CP_OB_MARKET()
        {
            string sqlText = @"select code,txt  from CP_OB_MARKET   order by 1 ";
            return _entity.ExecuteStoreQuery<ChangeBillGrid>(sqlText);
        }
        
        public IEnumerable<ChangeBillGrid> CP_OB_FORM_CALC()
        {
            string sqlText = @"select code,txt  from CP_OB_FORM_CALC   order by 1 ";
            return _entity.ExecuteStoreQuery<ChangeBillGrid>(sqlText);
        }
        /// <summary>
        /// Довідник видів договору 
        /// </summary>
        public IEnumerable<ChangeBillGrid> CP_VOPER()
        {
            string sqlText = @"select id as code, title as txt from CP_VOPER order by 1 ";
            return _entity.ExecuteStoreQuery<ChangeBillGrid>(sqlText);
        }
        /// <summary>
        /// Довідник Класифікації ЦП по типу емітента
        /// </summary>
        public IEnumerable<ChangeBillGrid> CP_KLCPE()
        {
            string sqlText = @"select TO_CHAR(id) as code, title as txt from CP_KLCPE order by 1 ";
            return _entity.ExecuteStoreQuery<ChangeBillGrid>(sqlText);
        }
        public IEnumerable<Params> GetContractSaleWindowFixedParams()
        {
            string sqlText = @"select p.par as param,p.val as value
       from params p where par in ('OUR_RNK','MFO','NAME','OKPO','BICCODE','1_PB','RNK_CP','BANKDATE','BASEVAL')";

            return _entity.ExecuteStoreQuery<Params>(sqlText);
        }


        public PrepareWndDealModel PrepareWndDeal(decimal? p_nOp, decimal? p_fl_END, decimal? p_nGrp, string p_strPar02)
        {
            string sqlText = @"select * from table(value_paper.prepare_wnd_deal(:p_nOp, :p_fl_END, :p_nGrp, :p_strPar02))";
            #region params
            object[] parametrs = {
                new OracleParameter(){
                    ParameterName = "p_nOp",
                    Direction = ParameterDirection.Input,
                    OracleDbType = OracleDbType.Decimal,
                    Value = p_nOp
                },
                new OracleParameter(){
                    ParameterName = "p_fl_END",
                    Direction = ParameterDirection.Input,
                    OracleDbType = OracleDbType.Decimal,
                    Value = p_fl_END
                },
                new OracleParameter(){
                    ParameterName = "nGrp",
                    Direction = ParameterDirection.Input,
                    OracleDbType = OracleDbType.Decimal,
                    Value = p_nGrp
                },
                new OracleParameter(){
                    ParameterName = "p_strPar02",
                    Direction = ParameterDirection.Input,
                    OracleDbType = OracleDbType.Varchar2,
                    Value = p_strPar02
                }
            };
            #endregion
            return _entity.ExecuteStoreQuery<PrepareWndDealModel>(sqlText, parametrs).Single();
        }

        public IrrWindowModel PrepareIrrWnd(decimal? NMODE1, decimal? REF, decimal? ID, string STRPAR01, string STRPAR02, DateTime? DAT_UG)
        {
            string sqlText = @"select * from table(value_paper.prepare_irr_wnd(:q, :w, :e, :r, :t, :y))";
            #region params
            object[] parametrs = {
                new OracleParameter(){
                    ParameterName = "p_nOp",
                    Direction = ParameterDirection.Input,
                    OracleDbType = OracleDbType.Decimal,
                    Value = NMODE1
                },
                new OracleParameter(){
                    ParameterName = "p_fl_END",
                    Direction = ParameterDirection.Input,
                    OracleDbType = OracleDbType.Decimal,
                    Value = REF
                },
                new OracleParameter(){
                    ParameterName = "nGrp",
                    Direction = ParameterDirection.Input,
                    OracleDbType = OracleDbType.Decimal,
                    Value = ID
                },
                new OracleParameter(){
                    ParameterName = "p_strPar02",
                    Direction = ParameterDirection.Input,
                    OracleDbType = OracleDbType.Varchar2,
                    Value = STRPAR01
                },
                new OracleParameter(){
                    ParameterName = "p_strPar02",
                    Direction = ParameterDirection.Input,
                    OracleDbType = OracleDbType.Varchar2,
                    Value = STRPAR02
                },
                new OracleParameter(){
                    ParameterName = "p_strPar02",
                    Direction = ParameterDirection.Input,
                    OracleDbType = OracleDbType.Date,
                    Value = DAT_UG
                }
            };
            #endregion
            return _entity.ExecuteStoreQuery<IrrWindowModel>(sqlText, parametrs).Single();
        }

        public IEnumerable<IRR_GRID> PopulateIrrGrid(decimal? NMODE1, decimal? REF, decimal? ID, string STRPAR01, string STRPAR02, DateTime? DAT_UG)
        {
            string sqlText = @"select * from table(value_paper.populate_irr_grid(:q, :w, :e, :r, :t, :y))";
            #region params
            object[] parametrs = {
                new OracleParameter(){
                    ParameterName = "p_nOp",
                    Direction = ParameterDirection.Input,
                    OracleDbType = OracleDbType.Decimal,
                    Value = NMODE1
                },
                new OracleParameter(){
                    ParameterName = "p_fl_END",
                    Direction = ParameterDirection.Input,
                    OracleDbType = OracleDbType.Decimal,
                    Value = REF
                },
                new OracleParameter(){
                    ParameterName = "nGrp",
                    Direction = ParameterDirection.Input,
                    OracleDbType = OracleDbType.Decimal,
                    Value = ID
                },
                new OracleParameter(){
                    ParameterName = "p_strPar02",
                    Direction = ParameterDirection.Input,
                    OracleDbType = OracleDbType.Varchar2,
                    Value = STRPAR01
                },
                new OracleParameter(){
                    ParameterName = "p_strPar02",
                    Direction = ParameterDirection.Input,
                    OracleDbType = OracleDbType.Varchar2,
                    Value = STRPAR02
                },
                new OracleParameter(){
                    ParameterName = "p_strPar02",
                    Direction = ParameterDirection.Input,
                    OracleDbType = OracleDbType.Date,
                    Value = DAT_UG
                }
            };
            #endregion
            return _entity.ExecuteStoreQuery<IRR_GRID>(sqlText, parametrs);
        }

        public IList<DropDownModel> dataListFor_cbm_PF(decimal? p_DOX, decimal? p_nEMI)
        {
            string sqlText = @"SELECT p.PF as pf, v.VIDD as val, v.VIDD || '/' || regexp_replace (p.NAME, ' {2,}', ' ') as text
                                 FROM CP_PF p, CP_VIDD v
                                WHERE p.PF = v.PF
                                  AND v.DOX = :p_dox AND v.EMI = :p_emi";

            object[] parametrs = {
                new OracleParameter(){
                    ParameterName = "p_dox",
                    Direction = ParameterDirection.Input,
                    OracleDbType = OracleDbType.Decimal,
                    Value = p_DOX
                },
                new OracleParameter(){
                    ParameterName = "p_emi",
                    Direction = ParameterDirection.Input,
                    OracleDbType = OracleDbType.Decimal,
                    Value = p_nEMI
                },
            };

            return _entity.ExecuteStoreQuery<DropDownModel>(sqlText, parametrs).ToList();
        }

        public PrepareWndDealModel Get_NLS_A_and_SVIDD(decimal? NKV, decimal? NRYN, decimal? NVIDD, decimal? P_DOX, decimal? P_NEMI)
        {
            string sqlText = @"SELECT p.nlsA, v.name as SVIDD
  FROM cp_accc p, accounts a, cp_vidd v
 WHERE a.nls = p.nlsA AND a.kv = :nKv AND p.RYN = :nRYN AND p.vidd = :nVidd
 and v.DOX=:p_nDOX and v.EMI=:p_nEMI and 
  p.VIDD=v.vidd and p.EMI=v.emi and p.PF=v.pf";
            #region params
            object[] parametrs = {
                new OracleParameter(){
                    ParameterName = "p_dox",
                    Direction = ParameterDirection.Input,
                    OracleDbType = OracleDbType.Decimal,
                    Value = NKV
                },
                new OracleParameter(){
                    ParameterName = "p_emi",
                    Direction = ParameterDirection.Input,
                    OracleDbType = OracleDbType.Decimal,
                    Value = NRYN
                },
                new OracleParameter(){
                    ParameterName = "p_emi",
                    Direction = ParameterDirection.Input,
                    OracleDbType = OracleDbType.Decimal,
                    Value = NVIDD
                },
                new OracleParameter(){
                    ParameterName = "p_emi",
                    Direction = ParameterDirection.Input,
                    OracleDbType = OracleDbType.Decimal,
                    Value = P_DOX
                },
                new OracleParameter(){
                    ParameterName = "p_emi",
                    Direction = ParameterDirection.Input,
                    OracleDbType = OracleDbType.Decimal,
                    Value = P_NEMI
                }
            };
            #endregion
            return _entity.ExecuteStoreQuery<PrepareWndDealModel>(sqlText, parametrs).SingleOrDefault();
        }

        public MoneyFlowModel PrepareMoneyFlow(decimal? REF)
        {
            string sqlText = @"select * from table(value_paper.prepare_many_wnd (:ref))";

            object[] parametrs = {
                new OracleParameter(){
                    ParameterName = "p_dox",
                    Direction = ParameterDirection.Input,
                    OracleDbType = OracleDbType.Decimal,
                    Value = REF
                }
            };
            return _entity.ExecuteStoreQuery<MoneyFlowModel>(sqlText, parametrs).SingleOrDefault();
        }

        public PrepareWndDealModel GetPartnersFields(decimal? NKV, decimal? NRYN, decimal? NVIDD, decimal? P_DOX, decimal? P_NEMI)
        {
            string sqlText = @"SELECT p.nlsA, v.name as SVIDD
  FROM cp_accc p, accounts a, cp_vidd v
 WHERE a.nls = p.nlsA AND a.kv = :nKv AND p.RYN = :nRYN AND p.vidd = :nVidd
 and v.DOX=:p_nDOX and v.EMI=:p_nEMI and 
  p.VIDD=v.vidd and p.EMI=v.emi and p.PF=v.pf";
            #region params
            object[] parametrs = {
                new OracleParameter(){
                    ParameterName = "p_dox",
                    Direction = ParameterDirection.Input,
                    OracleDbType = OracleDbType.Decimal,
                    Value = NKV
                },
                new OracleParameter(){
                    ParameterName = "p_emi",
                    Direction = ParameterDirection.Input,
                    OracleDbType = OracleDbType.Decimal,
                    Value = NRYN
                },
                new OracleParameter(){
                    ParameterName = "p_emi",
                    Direction = ParameterDirection.Input,
                    OracleDbType = OracleDbType.Decimal,
                    Value = NVIDD
                },
                new OracleParameter(){
                    ParameterName = "p_emi",
                    Direction = ParameterDirection.Input,
                    OracleDbType = OracleDbType.Decimal,
                    Value = P_DOX
                },
                new OracleParameter(){
                    ParameterName = "p_emi",
                    Direction = ParameterDirection.Input,
                    OracleDbType = OracleDbType.Decimal,
                    Value = P_NEMI
                }
            };
            #endregion
            return _entity.ExecuteStoreQuery<PrepareWndDealModel>(sqlText, parametrs).SingleOrDefault();
        }

        public PartnerFieldSet GetPartnersFields(PartnerFieldSet data)
        {
            string sqlText = @"select * from v_cp_aliens where rownum = 1 ";
            List<object> parametrs = new List<object>();
            #region params
            if (!String.IsNullOrEmpty(data.MFOB))
            {
                sqlText += "and mfob = :mfob";
                parametrs.Add(new OracleParameter()
                {
                    ParameterName = "p_dox",
                    Direction = ParameterDirection.Input,
                    OracleDbType = OracleDbType.Varchar2,
                    Value = data.MFOB
                });
            }

            if (!String.IsNullOrEmpty(data.NBB))
            {
                sqlText += "and NBB = :NBB";
                parametrs.Add(new OracleParameter()
                {
                    ParameterName = "p_dox",
                    Direction = ParameterDirection.Input,
                    OracleDbType = OracleDbType.Varchar2,
                    Value = data.NBB
                });
            }

            if (!String.IsNullOrEmpty(data.NLSB))
            {
                sqlText += "and NLSB = :NLSB";
                parametrs.Add(new OracleParameter()
                {
                    ParameterName = "p_dox",
                    Direction = ParameterDirection.Input,
                    OracleDbType = OracleDbType.Varchar2,
                    Value = data.NLSB
                });
            }

            if (!String.IsNullOrEmpty(data.OKPOB))
            {
                sqlText += "and OKPOB = :OKPOB";
                parametrs.Add(new OracleParameter()
                {
                    ParameterName = "p_dox",
                    Direction = ParameterDirection.Input,
                    OracleDbType = OracleDbType.Varchar2,
                    Value = data.OKPOB
                });
            }
            #endregion
            return _entity.ExecuteStoreQuery<PartnerFieldSet>(sqlText, parametrs.ToArray()).SingleOrDefault();
        }

        public decimal? GetRR_(DateTime? DAT_ROZ, decimal? ID, decimal? SUMBN)
        {
            string sqlText = @"select value_paper.calc_R_kupon(:DAT_ROZ, :ID, :SUMBN) as RR_ from dual";
            #region params
            object[] parametrs = {
                new OracleParameter(){
                    ParameterName = "p_dox",
                    Direction = ParameterDirection.Input,
                    OracleDbType = OracleDbType.Date,
                    Value = DAT_ROZ
                },
                new OracleParameter(){
                    ParameterName = "p_emi",
                    Direction = ParameterDirection.Input,
                    OracleDbType = OracleDbType.Decimal,
                    Value = ID
                },
                new OracleParameter(){
                    ParameterName = "p_emi",
                    Direction = ParameterDirection.Input,
                    OracleDbType = OracleDbType.Decimal,
                    Value = SUMBN
                }
            };
            #endregion

            var data = _entity.ExecuteStoreQuery<PrepareWndDealModel>(sqlText, parametrs).SingleOrDefault();

            if (data != null)
                return data.RR_;
            else
                return null;
        }

        public FSaveModel FSave(FSaveModel data)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            try
            {
                OracleCommand command = new OracleCommand("value_paper.F_SAVE", connection);
                command.CommandType = System.Data.CommandType.StoredProcedure;

                #region command params
                command.Parameters.Add(new OracleParameter { ParameterName = "FL_END", Direction = ParameterDirection.Input, OracleDbType = OracleDbType.Decimal, Value = data.FL_END });
                command.Parameters.Add(new OracleParameter { ParameterName = "RB_K_P", Direction = ParameterDirection.Input, OracleDbType = OracleDbType.Decimal, Value = data.RB_K_P });
                command.Parameters.Add(new OracleParameter { ParameterName = "NOP", Direction = ParameterDirection.Input, OracleDbType = OracleDbType.Decimal, Value = data.NOP });
                command.Parameters.Add(new OracleParameter { ParameterName = "NTIK", Direction = ParameterDirection.Input, Size=4000, OracleDbType = OracleDbType.Varchar2, Value = data.NTIK });
                command.Parameters.Add(new OracleParameter { ParameterName = "NBB", Direction = ParameterDirection.Input, OracleDbType = OracleDbType.Varchar2, Value = data.NBB });
                command.Parameters.Add(new OracleParameter { ParameterName = "CB_ZO", Direction = ParameterDirection.Input, OracleDbType = OracleDbType.Decimal, Value = data.CB_ZO });
                command.Parameters.Add(new OracleParameter { ParameterName = "CP_AI", Direction = ParameterDirection.Input, OracleDbType = OracleDbType.Decimal, Value = data.CP_AI });
                command.Parameters.Add(new OracleParameter { ParameterName = "P_TIPD", Direction = ParameterDirection.Input, OracleDbType = OracleDbType.Decimal, Value = data.P_TIPD });
                command.Parameters.Add(new OracleParameter { ParameterName = "NGRP", Direction = ParameterDirection.Input, OracleDbType = OracleDbType.Decimal, Value = data.NGRP });
                command.Parameters.Add(new OracleParameter { ParameterName = "NID", Direction = ParameterDirection.Input, OracleDbType = OracleDbType.Decimal, Value = data.NID });
                command.Parameters.Add(new OracleParameter { ParameterName = "NVIDD", Direction = ParameterDirection.Input, OracleDbType = OracleDbType.Decimal, Value = data.NVIDD });
                command.Parameters.Add(new OracleParameter { ParameterName = "NRYN", Direction = ParameterDirection.Input, OracleDbType = OracleDbType.Decimal, Value = data.NRYN });
                command.Parameters.Add(new OracleParameter { ParameterName = "DAT_UG", Direction = ParameterDirection.Input, OracleDbType = OracleDbType.Date, Value = data.DAT_UG });
                command.Parameters.Add(new OracleParameter { ParameterName = "DAT_OPL", Direction = ParameterDirection.Input, OracleDbType = OracleDbType.Date, Value = data.DAT_OPL });
                command.Parameters.Add(new OracleParameter { ParameterName = "DAT_ROZ", Direction = ParameterDirection.Input, OracleDbType = OracleDbType.Date, Value = data.DAT_ROZ });
                command.Parameters.Add(new OracleParameter { ParameterName = "DAT_KOM", Direction = ParameterDirection.Input, OracleDbType = OracleDbType.Date, Value = data.DAT_KOM });
                command.Parameters.Add(new OracleParameter { ParameterName = "SUMBN", Direction = ParameterDirection.Input, OracleDbType = OracleDbType.Decimal, Value = data.SUMBN });
                command.Parameters.Add(new OracleParameter { ParameterName = "SUMB", Direction = ParameterDirection.Input, OracleDbType = OracleDbType.Decimal, Value = data.SUMB });
                command.Parameters.Add(new OracleParameter { ParameterName = "RR_", Direction = ParameterDirection.Input, OracleDbType = OracleDbType.Decimal, Value = data.RR_ });
                command.Parameters.Add(new OracleParameter { ParameterName = "SUMBK", Direction = ParameterDirection.Input, OracleDbType = OracleDbType.Decimal, Value = data.SUMBK });
                command.Parameters.Add(new OracleParameter { ParameterName = "SNAZN", Direction = ParameterDirection.Input, OracleDbType = OracleDbType.Varchar2, Value = data.SNAZN });
                command.Parameters.Add(new OracleParameter { ParameterName = "NLS9", Direction = ParameterDirection.Input, OracleDbType = OracleDbType.Varchar2, Value = data.NLS9 });
                command.Parameters.Add(new OracleParameter { ParameterName = "B_4621", Direction = ParameterDirection.Input, OracleDbType = OracleDbType.Varchar2, Value = data.B_4621 });
                command.Parameters.Add(new OracleParameter { ParameterName = "B_1819", Direction = ParameterDirection.Input, OracleDbType = OracleDbType.Varchar2, Value = data.B_1819 });
                command.Parameters.Add(new OracleParameter { ParameterName = "B_1919", Direction = ParameterDirection.Input, OracleDbType = OracleDbType.Varchar2, Value = data.B_1919 });
                command.Parameters.Add(new OracleParameter { ParameterName = "SREF", Direction = ParameterDirection.Output, Size = 4000, OracleDbType = OracleDbType.Varchar2, Value = data.SREF });
                command.Parameters.Add(new OracleParameter { ParameterName = "SERR", Direction = ParameterDirection.Output, Size = 4000, OracleDbType = OracleDbType.Varchar2, Value = data.SERR });
                command.Parameters.Add(new OracleParameter { ParameterName = "NAZN", Direction = ParameterDirection.Output, Size = 4000, OracleDbType = OracleDbType.Varchar2, Value = data.NAZN });
                command.Parameters.Add(new OracleParameter { ParameterName = "REF_MAIN", Direction = ParameterDirection.Output, Size = 4000, OracleDbType = OracleDbType.Varchar2, Value = data.REF_MAIN });
                command.Parameters.Add(new OracleParameter { ParameterName = "SK", Direction = ParameterDirection.Input, OracleDbType = OracleDbType.Decimal, Value = data.SK });
                command.Parameters.Add(new OracleParameter { ParameterName = "SKV", Direction = ParameterDirection.Input, OracleDbType = OracleDbType.Decimal, Value = data.SKV });
                command.Parameters.Add(new OracleParameter { ParameterName = "BICA", Direction = ParameterDirection.Input, OracleDbType = OracleDbType.Varchar2, Value = data.BICA });
                command.Parameters.Add(new OracleParameter { ParameterName = "BICKB_", Direction = ParameterDirection.Input, OracleDbType = OracleDbType.Varchar2, Value = data.BICKB_ });
                command.Parameters.Add(new OracleParameter { ParameterName = "CB_SWIFT", Direction = ParameterDirection.Input, OracleDbType = OracleDbType.Decimal, Value = data.CB_SWIFT });
                command.Parameters.Add(new OracleParameter { ParameterName = "SSA", Direction = ParameterDirection.Input, OracleDbType = OracleDbType.Varchar2, Value = data.SSA });
                command.Parameters.Add(new OracleParameter { ParameterName = "SSB_", Direction = ParameterDirection.Input, OracleDbType = OracleDbType.Varchar2, Value = data.SSB_ });
                command.Parameters.Add(new OracleParameter { ParameterName = "CB_NO_PAY", Direction = ParameterDirection.Input, OracleDbType = OracleDbType.Decimal, Value = data.CB_NO_PAY });
                command.Parameters.Add(new OracleParameter { ParameterName = "CB_KS", Direction = ParameterDirection.Input, OracleDbType = OracleDbType.Decimal, Value = data.CB_KS });
                command.Parameters.Add(new OracleParameter { ParameterName = "NDCP", Direction = ParameterDirection.Input, OracleDbType = OracleDbType.Decimal, Value = data.NDCP });
                command.Parameters.Add(new OracleParameter { ParameterName = "MFOB_", Direction = ParameterDirection.Input, OracleDbType = OracleDbType.Varchar2, Value = data.MFOB_ });
                command.Parameters.Add(new OracleParameter { ParameterName = "OKPOB_", Direction = ParameterDirection.Input, OracleDbType = OracleDbType.Varchar2, Value = data.OKPOB_ });
                command.Parameters.Add(new OracleParameter { ParameterName = "NLSB_", Direction = ParameterDirection.Input, OracleDbType = OracleDbType.Varchar2, Value = data.NLSB_ });
                command.Parameters.Add(new OracleParameter { ParameterName = "NBB_", Direction = ParameterDirection.Input, OracleDbType = OracleDbType.Varchar2, Value = data.NBB_ });
                command.Parameters.Add(new OracleParameter { ParameterName = "KOD_BB", Direction = ParameterDirection.Input, OracleDbType = OracleDbType.Varchar2, Value = data.KOD_BB });
                command.Parameters.Add(new OracleParameter { ParameterName = "KOD_GB", Direction = ParameterDirection.Input, OracleDbType = OracleDbType.Varchar2, Value = data.KOD_GB });
                command.Parameters.Add(new OracleParameter { ParameterName = "KOD_NB", Direction = ParameterDirection.Input, OracleDbType = OracleDbType.Varchar2, Value = data.KOD_NB });
                command.Parameters.Add(new OracleParameter { ParameterName = "SNLS_FXC", Direction = ParameterDirection.Input, OracleDbType = OracleDbType.Varchar2, Value = data.SNLS_FXC });
                command.Parameters.Add(new OracleParameter { ParameterName = "SNMS_FXC", Direction = ParameterDirection.Input, OracleDbType = OracleDbType.Varchar2, Value = data.SNMS_FXC });
                command.Parameters.Add(new OracleParameter { ParameterName = "P_REPO", Direction = ParameterDirection.Input, OracleDbType = OracleDbType.Decimal, Value = data.P_REPO });
                command.Parameters.Add(new OracleParameter { ParameterName = "p_ifrs", Direction = ParameterDirection.Input, OracleDbType = OracleDbType.Varchar2, Value = data.IFRS });
                command.Parameters.Add(new OracleParameter { ParameterName = "p_bus_mod", Direction = ParameterDirection.Input, OracleDbType = OracleDbType.Decimal, Value = data.BUS_MOD });
                command.Parameters.Add(new OracleParameter { ParameterName = "p_sppi", Direction = ParameterDirection.Input, OracleDbType = OracleDbType.Byte, Value = data.SPPI });


                #endregion

                command.ExecuteNonQuery();

                return new FSaveModel()
                {
                    SERR = command.Parameters[26].Value.ToString(),
                    SREF = command.Parameters[25].Value.ToString(),
                    NAZN = command.Parameters[27].Value.ToString(),
                    REF_MAIN = command.Parameters[28].Value.ToString()
                };
            }
            finally
            {
                connection.Close();
            }

        }

        public string Diu_many(IRR_GRID data)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            try
            {
                OracleCommand command = new OracleCommand("cp.diu_many", connection);
                command.CommandType = System.Data.CommandType.StoredProcedure;

                #region command params
                command.Parameters.Add(new OracleParameter { ParameterName = "FL_END", Direction = ParameterDirection.Input, OracleDbType = OracleDbType.Decimal, Value = data.Action });
                command.Parameters.Add(new OracleParameter { ParameterName = "RB_K_P", Direction = ParameterDirection.Input, OracleDbType = OracleDbType.Decimal, Value = data.REF });
                command.Parameters.Add(new OracleParameter { ParameterName = "NOP", Direction = ParameterDirection.Input, OracleDbType = OracleDbType.Date, Value = data.P_FDAT });
                command.Parameters.Add(new OracleParameter { ParameterName = "NTIK", Direction = ParameterDirection.Input, OracleDbType = OracleDbType.Decimal, Value = data.P_SS1 });
                command.Parameters.Add(new OracleParameter { ParameterName = "NTIK", Direction = ParameterDirection.Input, OracleDbType = OracleDbType.Decimal, Value = data.P_SDP });
                command.Parameters.Add(new OracleParameter { ParameterName = "NTIK", Direction = ParameterDirection.Input, OracleDbType = OracleDbType.Decimal, Value = data.P_SN2 });
                #endregion
                command.ExecuteNonQuery();

                return "OK";
            }
            finally
            {
                connection.Close();
            }

        }
        public void DelIir(decimal? REF)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            try
            {
                OracleCommand command = new OracleCommand("value_paper.del_iir", connection);
                command.CommandType = System.Data.CommandType.StoredProcedure;

                #region command params
                command.Parameters.Add(new OracleParameter { ParameterName = "FL_END", Direction = ParameterDirection.Input, OracleDbType = OracleDbType.Decimal, Value = REF });
                #endregion

                command.ExecuteNonQuery();

            }
            finally
            {
                connection.Close();
            }

        }

        public string CP_AMOR(string REF, decimal? ID, decimal? NGRP, DateTime? ADAT)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            try
            {
                OracleCommand command = new OracleCommand("CP.CP_AMOR", connection);
                command.CommandType = System.Data.CommandType.StoredProcedure;

                #region command params
                command.Parameters.Add(new OracleParameter { ParameterName = "FL_END", Direction = ParameterDirection.Input, OracleDbType = OracleDbType.Varchar2, Value = REF });
                command.Parameters.Add(new OracleParameter { ParameterName = "RB_K_P", Direction = ParameterDirection.Input, OracleDbType = OracleDbType.Decimal, Value = ID });
                command.Parameters.Add(new OracleParameter { ParameterName = "NOP", Direction = ParameterDirection.Input, OracleDbType = OracleDbType.Decimal, Value = NGRP });
                command.Parameters.Add(new OracleParameter { ParameterName = "NTIK", Direction = ParameterDirection.Input, OracleDbType = OracleDbType.Date, Value = ADAT });
                command.Parameters.Add(new OracleParameter { ParameterName = "NTIK", Direction = ParameterDirection.Output, Size = 4000, OracleDbType = OracleDbType.Varchar2 });

                #endregion

                command.ExecuteNonQuery();

                return command.Parameters[4].Value.ToString();
            }
            finally
            {
                connection.Close();
            }
        }

        public string MakeAmort(decimal? NGRP, string FILTER, DateTime? ADAT)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            try
            {
                OracleCommand command = new OracleCommand("value_paper.make_amort", connection);
                command.CommandType = System.Data.CommandType.StoredProcedure;

                #region command params
                command.Parameters.Add(new OracleParameter { ParameterName = "FL_END", Direction = ParameterDirection.Input, OracleDbType = OracleDbType.Decimal, Value = NGRP });
                command.Parameters.Add(new OracleParameter { ParameterName = "RB_K_P", Direction = ParameterDirection.Input, OracleDbType = OracleDbType.Varchar2, Value = FILTER });
                command.Parameters.Add(new OracleParameter { ParameterName = "NOP", Direction = ParameterDirection.Input, OracleDbType = OracleDbType.Date, Value = ADAT });
                command.Parameters.Add(new OracleParameter { ParameterName = "NOP", Direction = ParameterDirection.Output, Size=4000, OracleDbType = OracleDbType.Varchar2 });

                #endregion

                command.ExecuteNonQuery();
                return command.Parameters[3].Value.ToString();

            }
            finally
            {
                connection.Close();
            }

        }

        public string SetSpecparam(string REF_MAIN, string COD_I, string COD_M, string COD_F, string COD_V, string COD_O)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            try
            {
                OracleCommand command = new OracleCommand("value_paper.setSpecparam", connection);
                command.CommandType = System.Data.CommandType.StoredProcedure;

                #region command params
                command.Parameters.Add(new OracleParameter { ParameterName = "FL_END", Direction = ParameterDirection.Input, OracleDbType = OracleDbType.Decimal, Value = REF_MAIN });
                command.Parameters.Add(new OracleParameter { ParameterName = "RB_K_P", Direction = ParameterDirection.Input, OracleDbType = OracleDbType.Decimal, Value = COD_I });
                command.Parameters.Add(new OracleParameter { ParameterName = "NOP", Direction = ParameterDirection.Input, OracleDbType = OracleDbType.Decimal, Value = COD_M });
                command.Parameters.Add(new OracleParameter { ParameterName = "COD_F", Direction = ParameterDirection.Input, OracleDbType = OracleDbType.Decimal, Value = COD_F });
                command.Parameters.Add(new OracleParameter { ParameterName = "COD_V", Direction = ParameterDirection.Input, OracleDbType = OracleDbType.Decimal, Value = COD_V });
                command.Parameters.Add(new OracleParameter { ParameterName = "COD_O", Direction = ParameterDirection.Input, OracleDbType = OracleDbType.Decimal, Value = COD_O });
                command.Parameters.Add(new OracleParameter { ParameterName = "SERR", Direction = ParameterDirection.Output, Size = 4000, OracleDbType = OracleDbType.Varchar2});
               
                #endregion

                command.ExecuteNonQuery();

                return command.Parameters[6].Value.ToString();
            }
            finally
            {
                connection.Close();
            }

        }
        public string SetNazn(FSaveModel data)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            try
            {
                OracleCommand command = new OracleCommand("value_paper.setNazn", connection);
                command.CommandType = System.Data.CommandType.StoredProcedure;

                #region command params
                command.Parameters.Add(new OracleParameter { ParameterName = "REF_MAIN", Direction = ParameterDirection.Input, OracleDbType = OracleDbType.Varchar2, Value = data.REF_MAIN });
                command.Parameters.Add(new OracleParameter { ParameterName = "NAZN", Direction = ParameterDirection.Input, OracleDbType = OracleDbType.Varchar2, Value = data.NAZN });
                command.Parameters.Add(new OracleParameter { ParameterName = "SERR", Direction = ParameterDirection.Output, Size=4000, OracleDbType = OracleDbType.Varchar2, Value = data.SERR });

                #endregion

                command.ExecuteNonQuery();

                return command.Parameters[2].Value.ToString();

            }
            finally
            {
                connection.Close();
            }

        }

        public bool CheckMFOB(string MFOB)
        {
            string sqlText = @"select 1 as CB_STP  from banks where mfo = :mfob";

            object[] parametrs = {
                new OracleParameter(){
                    ParameterName = "p_dox",
                    Direction = ParameterDirection.Input,
                    OracleDbType = OracleDbType.Varchar2,
                    Value = MFOB
                }
            };

            var data = _entity.ExecuteStoreQuery<PrepareWndDealModel>(sqlText, parametrs).SingleOrDefault();
            if (data == null)
                return false;
            return
                data.CB_STP == 1;
        }

        public IList<DropDownModel> dataListFor_cbm_RYN(decimal? p_Vidd, decimal? p_Kv, decimal? p_Tipd)
        {
            string sqlText = @"select RYN as VAL, regexp_replace (Name, ' {2,}', ' ') as TEXT from CP_RYN
                                WHERE RYN in (select ryn from cp_accc where vidd = :p_Vidd) 
                                  and (KV is null OR KV = :p_kv ) 
                                  and TIPD= :p_tipd and d_close is null 
                                ORDER BY RYN";

            object[] parametrs = {
                new OracleParameter(){
                    ParameterName = "p_Vidd",
                    Direction = ParameterDirection.Input,
                    OracleDbType = OracleDbType.Decimal,
                    Value = p_Vidd
                },
                new OracleParameter(){
                    ParameterName = "p_kv",
                    Direction = ParameterDirection.Input,
                    OracleDbType = OracleDbType.Decimal,
                    Value = p_Kv
                },
                new OracleParameter(){
                    ParameterName = "p_tipd",
                    Direction = ParameterDirection.Input,
                    OracleDbType = OracleDbType.Decimal,
                    Value = p_Tipd
                }
            };
            var data = _entity.ExecuteStoreQuery<DropDownModel>(sqlText, parametrs).ToList();
            return data;
        }

        public void CalcFlows(decimal? reference)
        {
            string sqlText = "value_paper.calc_many";
            using (OracleConnection connection = OraConnector.Handler.UserConnection)
            {
                using (OracleCommand com = new OracleCommand(sqlText, connection))
                {
                    com.CommandType = System.Data.CommandType.StoredProcedure;
                    com.Parameters.Add(new OracleParameter { ParameterName = "p_ref", Direction = ParameterDirection.Input, OracleDbType = OracleDbType.Decimal, Value = reference });
                    com.ExecuteNonQuery();
                }
            }
        }

        public IList<DropDownModel> GetDataListForBusMod()
        {
            string sqlText = @"select bus_mod_id as val, 
                               bus_mod_id_ifrs || '. ' || bus_mod_name as text 
                               from BUS_MOD";
            return _entity.ExecuteStoreQuery<DropDownModel>(sqlText).ToList();
        }

        public IList<DropDownModel> GetDataListForSppi()
        {
            string sqlText = @"select sppi_value as val, 
                               sppi_id  as text 
                               from SPPI";
            return _entity.ExecuteStoreQuery<DropDownModel>(sqlText).ToList();
        }

        public string GetIFRS(decimal vidd)
        {
            string sqlText = @"select value_paper.get_ifrs(:p_nbs) from dual";
            object[] param = {
                new OracleParameter("p_nbs", OracleDbType.Varchar2, vidd.ToString(), ParameterDirection.Input)
            };
           return _entity.ExecuteStoreQuery<string>(sqlText, param).FirstOrDefault();

        }

    }
}
