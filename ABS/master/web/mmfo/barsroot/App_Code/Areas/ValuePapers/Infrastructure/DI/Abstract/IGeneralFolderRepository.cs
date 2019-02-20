using System;
using System.Collections.Generic;
using System.Linq;
using Kendo.Mvc.UI;

namespace BarsWeb.Areas.ValuePapers.Infrastructure.DI.Abstract
{
    public interface IGeneralFolderRepository
    {
        IEnumerable<CP_V> CpV(InitParams initParams);
        IEnumerable<Areas.Kernel.Models.Params> GetContractSaleWindowFixedParams();
        PrepareWndDealModel PrepareWndDeal(decimal? p_nOp, decimal? p_fl_END, decimal? p_nGrp, string p_strPar02);
        IList<DropDownModel> dataListFor_cbm_PF(decimal? p_DOX, decimal? p_nEMI);
        IList<DropDownModel> dataListFor_cbm_RYN(decimal? p_Vidd, decimal? p_Kv, decimal? p_Tipd);
        PrepareWndDealModel Get_NLS_A_and_SVIDD(decimal? NKV, decimal? NRYN, decimal? NVIDD, decimal? P_DOX, decimal? P_NEMI);
        decimal? GetRR_(DateTime? DAT_ROZ, decimal? ID, decimal? SUMBN);
        bool CheckMFOB(string MFOB);
        PartnerFieldSet GetPartnersFields(PartnerFieldSet data);
        FSaveModel FSave(FSaveModel data);
        string SetNazn(FSaveModel data);
        IEnumerable<ChangeBillGrid> CP_OB_MARKET();
        IEnumerable<ChangeBillGrid> CP_OB_INITIATOR();
        IEnumerable<ChangeBillGrid> CP_OB_FORM_CALC();
        IEnumerable<ChangeBillGrid> CP_VOPER();
        IEnumerable<ChangeBillGrid> CP_KLCPE();
        string SetSpecparam(string REF_MAIN, string COD_I, string COD_M, string COD_F, string COD_V, string COD_O);
        MoneyFlowModel PrepareMoneyFlow(decimal? REF);
        IList<MFGrid> MFGridData(decimal? REF, int? RB1, int? RB2, DateTime? DATE_ROZ);
        string CP_AMOR(string REF, decimal? ID, decimal? NGRP, DateTime? ADAT);
        string MakeAmort(decimal? NGRP, string FILTER, DateTime? ADAT);
        IrrWindowModel PrepareIrrWnd(decimal? NMODE1, decimal? REF, decimal? ID, string STRPAR01, string STRPAR02, DateTime? DAT_UG);
        IEnumerable<IRR_GRID> PopulateIrrGrid(decimal? NMODE1, decimal? REF, decimal? ID, string STRPAR01, string STRPAR02, DateTime? DAT_UG);
        void DelIir(decimal? REF);
        string Diu_many(IRR_GRID data);
        void CalcFlows(decimal? reference);
        IList<DropDownModel> GetDataListForBusMod();
        IList<DropDownModel> GetDataListForSppi();
        string GetIFRS(decimal vidd);


    }
}